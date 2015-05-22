#!/bin/bash

IDOL_NAME="Idol 1";
IDOL_OS="Dragon OS";
IDOL_DATE="2015-05-18";
IDOL_AUTHOR="brent.mills";
IDOL_HASH="de53e25d9ad59e0aab9b2912a748663e";
IDOL_LOCATION="/home/user/system.idol";
SOURCE_REPO="Idol";
SOURCE_BRANCH="master";
SOURCE_COMMIT="dfe9452f5e0064b69e3660ff906e19cd313978ba";
ARTIFACT_TYPE="docker";
ARTIFACT_HASH="dfe9452f5e0064b69e3660ff906e1444444978ba";

echo "Inserting data...";
echo "INSERT INTO entries (idol_name,idol_os,idol_date,idol_author,idol_hash,idol_location,source_repo,source_branch,source_commit,artifact_type,artifact_hash) VALUES (\""${IDOL_NAME}"\", \""${IDOL_OS}"\", \""${IDOL_DATE}"\", \""${IDOL_AUTHOR}"\", \""${IDOL_HASH}"\", \""${IDOL_LOCATION}"\", \""${SOURCE_REPO}"\", \""${SOURCE_BRANCH}"\", \""${SOURCE_COMMIT}"\", \""${ARTIFACT_TYPE}"\", \""${ARTIFACT_HASH}"\");" | mysql idol;
echo "";
echo "";
echo "Outputting table...";
echo "SELECT * from entries;" | mysql idol;
echo "";
echo "";
echo "Outputting only data...";
echo "SELECT * from entries WHERE idol_name LIKE \"${IDOL_NAME}\";" | mysql idol --column-names=0;
