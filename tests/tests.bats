#!/usr/bin/env bats

SUT_IMAGE=bats-helicopterizer
SUT_CONTAINER=bats-helicopterizer

load test_helpers

@test "Check that the docker is available" {
    command docker -v
}

@test "build image" {
  cd $BATS_TEST_DIRNAME/..
  docker build -t $SUT_IMAGE .
}