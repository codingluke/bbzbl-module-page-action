#!/bin/sh -l

rm -rf /github/workspace/docs # cleanup

# VuePress
cd /vuepress
cp -r /github/workspace/pages ./remote # TODO: Make pages folder configurable
cp -r ./.vuepress ./remote/.vuepress
ls -la ./remote
sed -i 's/\.\.\/slides/\.\/slides/g' ./remote/README.md
yarn run remote:build
ls -la ./remote/.vuepress/dist
cp -r ./remote/.vuepress/dist /github/workspace/docs # TODO: Make dist folder configurable

# MARP
mkdir -p /github/workspace/docs/slides
# find /github/workspace/slides -name '*.md' -exec marp --html --allow-local-files '{}' --output /github/workspace/docs/slides/ \;
marp --html --allow-local-files --input-dir /github/workspace/slides --output /github/workspace/docs/slides

# add .nojekill on the docs root
touch /github/workspace/docs/.nojekyll

# Git push back
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

