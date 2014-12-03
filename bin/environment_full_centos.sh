#!/bin/bash

set -e

completion() {
    echo "environment_full_centos.sh has completed for idol "${IDOL_NAME} | tee -a ${LOG_OUT};
    echo "Bats Tests Generated: "$(grep -c "@test" ${OUTPUT_BATS});
    exit 0;
}

generate_environment_full_bats() {

    ENV_COMPONENT=( "/etc/crontab" "/etc/shells" "/etc/fstab" "/etc/mtab" "/etc/rpc" "/etc/services" "/etc/sestatus.conf" "/etc/nsswitch.conf" "/etc/profile" "/etc/protocols" "/etc/hosts" "/etc/hosts.allow" "/etc/hosts.deny" "/etc/inittab" "/etc/yum.conf" "/etc/ssh/ssh_config" "/etc/ssh/sshd_config" "/etc/sysconfig/authconfig" "/etc/sysconfig/grub" "/etc/sysconfig/system-config-firewall" "/etc/sudoers" "/etc/yum.repos.d"/* );

    for i in ${ENV_COMPONENT[@]}; do
        while read -r LINE || [[ -n $LINE ]]; do
            IFS=' ' read -a array <<< ${LINE};

            if [[ ${array[0]} ]] && [[ ! ${array[0]} =~ \# ]] && [[ ! ${LINE} =~ \[ ]]; then
                echo "@test \"ENVIRONMENT CHECK - "${array[0]}" Environment FULL\" {" >> ${OUTPUT_BATS};
                echo "grep '""${LINE}""' "${i} >> ${OUTPUT_BATS};
                echo "}" >> ${OUTPUT_BATS};
                echo " " >> ${OUTPUT_BATS};
            fi;
        done < ${i};
    done;

}

handoff() {
    echo "environment_full_centos.sh has been kicked off by idol_create.sh..." | tee -a ${LOG_OUT};
    echo "environment_full_centos.sh is initiating full environment BATS creation..." | tee -a ${LOG_OUT};
    echo "idol name.................."${IDOL_NAME} | tee -a ${LOG_OUT};
    echo "" | tee -a ${LOG_OUT};
}

initialize_bats() {
    echo "#!/usr/bin/env bats" >> ${OUTPUT_BATS};
    echo "" >> ${OUTPUT_BATS};
    echo "load test_helper" >> ${OUTPUT_BATS};
    echo "fixtures bats" >> ${OUTPUT_BATS};
    echo "" >> ${OUTPUT_BATS};
}

#################################
##     INPUT AND VARIABLES     ##
#################################
HASH_BATS=$1;
IDOL_NAME=$2;
LOG_OUT=$3;

OUTPUT_BATS=${HASH_BATS}/environment_full.bats;

#################################
##     ACKNOWLEDGE HANDOFF     ##
#################################
handoff;

#################################
##         CREATE BATS         ##
#################################
initialize_bats;
generate_environment_full_bats;

#################################
##   ACKNOWLEDGE COMPLETION    ##
#################################
completion;
