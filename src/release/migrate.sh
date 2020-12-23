#!/bin/sh

set -e

migrate \
  -source "${SOURCE:-file://migrations}" \
  -database "${DATABASE_URL:?}" \
  up
