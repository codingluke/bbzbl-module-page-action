#!/bin/sh -l

cd /vuepress
cp -r /github/workspace/pages ./remote # TODO: Make pages folder configurable
cp -r ./.vuepress ./remote/.vuepress
ls -la ./remote
yarn run remote:build
ls -la ./remote/.vuepress/dist

cp -r ./remote/.vuepress/dist /github/workspace/page # TODO: Make dist folder configurable

cd /github/workspace
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
git init && \
git config user.name "bbzbl-page-action" && \
git config user.email "bbzbl-page-action@users.noreply.github.com" && \
git add . && \
git status && \
curr_branch="$(git rev-parse --abbrev-ref HEAD)" && \
commit_msg="${COMMIT_MSG:-'Vuepress Action Build'}" && \
git commit -m "${commit_msg}" 

if [ "$NO_FORCE_PUSH" = true ]
then 
  git push $remote_repo ${curr_branch}:${PUBLISH_TO_BRANCH}
else
  git push --force $remote_repo ${curr_branch}:${PUBLISH_TO_BRANCH}
fi
