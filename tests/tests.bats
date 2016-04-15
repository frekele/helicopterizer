#!/bin/bash

SUT_IMAGE=bats-helicopterizer
SUT_CONTAINER=bats-helicopterizer

load test_helpers

@test "build image" {
  cd $BATS_TEST_DIRNAME/..
  docker build -t $SUT_IMAGE .
}