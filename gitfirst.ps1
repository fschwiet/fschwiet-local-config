
git config --global --add diff.tool diffmerge
git config --global --add difftool.diffmerge.cmd 'diffmerge $LOCAL $REMOTE'
git config --global --add merge.tool diffmerge
git config --global --add mergetool.diffmerge.cmd 'diffmerge --merge --result=$MERGED $LOCAL $BASE $REMOTE'
git config --global --add mergetool.diffmerge.trustexitcode false
git config --global --add user.name fschwiet
git config --global --add user.email fschwiet@gmail.com

