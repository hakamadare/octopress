---
layout: post
title: "You Had One Job"
date: 2014-04-02 20:06:13 -0400
comments: true
categories: cats programming tools
---
On the way home today I encountered one of our housemates, also homeward bound, and as we came in the front door I was chattering happily about my second day at work.  I have tasks!  Tasks that I can perform!  This is really exciting.

I was, however, interrupted mid-sentence by a crash from the hallway, where Elijah (one of our cats) had knocked a box of tissues from the shelf to the floor.  He was standing by it staring at me, and I got the distinct sense that this was a warning shot across my bows, indicating that I should shut up about trivialities and focus on the much more important topic of his dinner.

{% img center /images/one_job.jpg 746 550 "you had one job" %}

### Vim, Pathogen, and dirty submodules

Earlier today I had been adding Vim plugins to my dotfiles repository, pulling them in as [Git submodules](http://git-scm.com/docs/git-submodule) for use with [Pathogen](https://github.com/tpope/vim-pathogen).  I installed a couple of plugins and then generated the Vim help tags for them, which led to a minor unsightliness when the generated tags file showed up as untracked changes in my dotfiles directory.

[Tim Pope](https://github.com/tpope) suggests working around this problem by setting a [global excludes file](http://git-scm.com/docs/gitignore), but I am vaguely concerned that this will just create a landmine that I will step on at some future time when I want to be capturing some entirely unrelated file called `tags`.  Instead I discovered that [this fellow has the exact same problem](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules), and his solution works great for me.  Thanks, Nils!
