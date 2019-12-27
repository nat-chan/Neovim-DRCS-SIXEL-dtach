#!/usr/bin/env bash

tag=$1
filename=./nvim.appimage

GH_API="https://api.github.com"
AUTH="Authorization: token $GITHUB_TOKEN"
GH_REPO="$GH_API/repos/$GITHUB_REPOSITORY"

curl -o /dev/null -sH "$AUTH" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

response=$(curl -sH "$AUTH" "$GH_REPO/releases/tags/$tag")
eval $(echo "$response" | grep -m 1 "id.:" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')

if [ "$id" ] ;then
    echo Delete existing release $id
    curl -sH "$AUTH" -X DELETE "$GH_REPO/releases/$id"
fi

echo Create release
response=$(curl -sH "$AUTH" \
                --data "{\"tag_name\": \"$tag\",\"name\": \"Release $tag\",\"body\": \"Neovim AppImage\"}" \
                "$GH_REPO/releases")
eval $(echo "$response" | grep -m 1 "id.:" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')

echo "Uploading asset... "
GH_ASSET="https://uploads.github.com/repos/$GITHUB_REPOSITORY/releases/$id/assets?name=$(basename $filename)"

curl --data-binary @"$filename" -H "$AUTH" -H "Content-Type: application/octet-stream" $GH_ASSET
echo 
