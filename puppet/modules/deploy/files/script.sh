#!/bin/bash
set -e # dont rsync if clone fails
echo "Deploy started at `date`"
dir=`mktemp -d`
trap "rm -rf ${dir}" EXIT
git clone --recurse-submodules https://github.com/theforeman/foreman-infra ${dir}/
mv ${dir}/puppet/forge_modules/* ${dir}/puppet/modules/
mv ${dir}/puppet/git_modules/* ${dir}/puppet/modules/
rsync -aqx --delete-after --exclude=.git ${dir}/puppet/modules/ /etc/puppetlabs/code/environments/production/modules/
echo "Deploy complete at `date`"
