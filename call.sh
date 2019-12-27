#!/bin/bash

curl -X POST -H "Authorization: token $GITHUB_TOKEN" \
             -H "Accept: application/vnd.github.everest-preview+json"  \
             -H "Content-Type: application/json" \
             https://api.github.com/repos/$GITHUB_REPOSITORY/dispatches \
             --data '{"event_type":"test_trigger"}'
