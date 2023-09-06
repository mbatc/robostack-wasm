#!/usr/bin/env bash

INITIAL_DIR=$(cd)

cd $1

vinca -m

cd $INITIAL_DIR
