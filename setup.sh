#!/usr/bin/env bash

# usage: bash setup.sh <LEROBOT ROOT DIR>
POLICIES_DIR="${1}/src/lerobot/policies/"
echo "Copying to ${POLICIES_DIR}"

cp factory.py ${POLICIES_DIR}/
cp -r mmact ${POLICIES_DIR}/
cp mmact.sh ${POLICIES_DIR}/