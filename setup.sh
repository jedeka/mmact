#!/usr/bin/env bash

# usage: bash setup.sh <LEROBOT ROOT DIR>
POLICIES_DIR="${1}/src/lerobot/policies/"
POLICIES_DIR="${1}/src/lerobot/datasets/"
echo "Copying to ${POLICIES_DIR}"

cp factory.py ${POLICIES_DIR}/
cp video_utils.py ${DATASETS_DIR}/
cp -r mmact ${POLICIES_DIR}/
cp mmact.sh ../