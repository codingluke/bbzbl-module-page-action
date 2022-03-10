#!/bin/sh -l

cd /vuepress
cp -r /github/workspace remote
yarn run remote:build
ls -la ./remote/.vuepress/dist
