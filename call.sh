#!/bin/bash

curl -X POST -H "Authorization: token $GITHUB_TOKEN" \
             -H "Accept: application/vnd.github.ant-man-preview+json"  \
             -H "Content-Type: application/json" \
             https://api.github.com/repos/:nat-chan/:hello_actions/dispatches \
             --data '{"event_type":"test_trigger"}'
