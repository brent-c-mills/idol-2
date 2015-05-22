#!/bin/bash

IDOL_NAME="Idol 1";

VALUE=$(echo "SELECT idol_name,idol_hash FROM entries;" | mysql idol);

echo $VALUE;

