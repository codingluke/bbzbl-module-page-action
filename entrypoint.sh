#!/bin/sh -l

cd /vuepress
ln -sf /github/workspace ./remote 
yarn run remote:build
ls -la ./remote/
