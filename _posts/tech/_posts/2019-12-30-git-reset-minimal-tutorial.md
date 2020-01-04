---
title: Git reset in simple english
date: 2019-12-27 00:00:00 Z
layout: post
tags:
- git
category:
- tech
---

Before getting ahead lets clear these three fundamental things in git.

1. HEAD: It is a symbolic reference pointing to wherever you are in your commit history.

2. Index: The index, also known as the staging area, is the set of files that will become the next commit. It is also the commit that will become HEAD’s parent.

3. Working Copy: This is the term for the current set of files you’re working on in your file system.


![git-working-directory](/static/img/tech/git-reset/git-working-directory.png)

Few more simple concept:

Note:
>  Git branches are just an alias to git sha-commit. In git all things are tracked by sha2 hash. Hashes are long and tedius to use,hence we use some name/pointer and updated those name to new hashes to move ahead.


So normal workflow is like:

1. When you first checkout a branch, HEAD points to the most recent commit in the branch. 
2. The files in the HEAD (they aren’t technically files, they’re blobs but for the purposes of this discussion we can think of them as straight files) match that of the files in the index, and the files checked out in your working copy match HEAD and the index as well.
3. If All 3(index, HEAD, working-copy) are in an equal state _git_ is happy.
4. When you perform a modification to a file, Git notices and says “oh, hey, something has changed. Your working copy no longer matches the index and HEAD.” 
    * So it marks the file as changed.
5. When you do a git add, it stages the file in the index, and Git says “oh, okay, now your working copy and index match, but those are both different than HEAD.”
6. When you then perform a git commit, Git creates a new commit that HEAD now points to and the status of the index and working copy match it so Git’s happy once more.


> But suddenly we came to know while commiting that we have one extra file which we added in index is not required to push in git repository. It means we don't want that file in index. Now the question is how to remove that file from git index, Since we used git add to put them in the index it would be logical to use git rm? Wrong! git rm will simply delete the file and add the deletion to the index. So what to do now:

Use : `git reset`

> git-reset - Reset current HEAD to the specified state

Default option clears INDEX, leaves your working directory untouched. (simply unstaging everything).

It can be used with number of options with it. Three main options to use with git reset: 
* --hard
* --soft 
* --mixed

* `git reset --soft <ref>`:
    * It reset the current commit to specified `<ref>`
    * If nothing is specified in `<ref>`, it takes as HEAD.
    * --soft doesn't touch the index file or the working tree at all (but resets the head to <commit>.
    * `git reset --soft` or `git reset --soft HEAD`: It does nothing, because is checks out HEAD to HEAD again.
    * `git reset --soft @~1`: It would reset the HEAD of current pointed branch to parent of current branch, it won't touch staging/index area or working directory.
    * This guy just moves branch-pointer to where you want it to, and does nothing else


* `git reset --mixed <ref>` or `git reset <ref>`: 
    * This is default option
    * This does what --soft does, additional to it, it also reset index (not working-copy) to match with commit at specified reference, it no `<ref>` is given, it just resets index as last commit(i.e. HEAD).
        *  Any differences between the original commit and the one you reset to will show up as local modifications (or untracked files) with git status


* `git reset --hard` or `git reset --hard <ref>`: 
    * This does what `--mixed` does but also cleans the working copy.
    * It will clean all local changes, any staged changes and bring everything to `<ref>` if specified or else to last commit.
    * **This will clear all you local change which aren't committed, use this option carefully**

---

Reference:
* [https://git-scm.com/docs/git-reset](https://git-scm.com/docs/git-reset
)
* [https://stackoverflow.com/questions/2530060/in-plain-english-what-does-git-reset-do](https://stackoverflow.com/questions/2530060/in-plain-english-what-does-git-reset-do
)
* [https://stackoverflow.com/a/54934887/2735833](https://stackoverflow.com/a/54934887/2735833)
