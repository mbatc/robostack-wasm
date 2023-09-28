#!/bin/bash -i

INITIAL_DIR=$(cd)

cd $1

vinca -m

cd $INITIAL_DIR
