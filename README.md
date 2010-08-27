#Flit

Flit contains super simple branch management extensions for Git. It aims to give quick repository functions to improve a typical Git workflow as described at [http://mattkirman.com/2010/08/27/my-git-workflow-introducing-flit/](http://mattkirman.com/2010/08/27/my-git-workflow-introducing-flit/).

_Flit is an extremely early alpha. Features may be broken or just plain missing, but getting this code out into the open-source community where people can start hacking away with it is much more important. If something’s missing just fork the code, add your fix and send me a pull request._


##Installation

The easiest way to install Flit is through RubyGems:

    gem install flit


##Usage

Flit is capable of being used with both existing and brand new Git repositories. You will also be asked a number of questions so that we can set up your repository as you would like. For the majority of installations it is perfectly safe to use the default, suggested, settings. To initialise a Flit powered Git repository simply run:

    flit init

_**Please note:** Flit commands can only be run from the top level directory of your Git repository. This will be rectified in future releases._


###Working with branches

Flit expects that you work on features and bugfixes in different, topic specific, branches. When switching branches Flit doesn't care whether the branch already exists, if it doesn't exist it will be created in the background. Currently you can only work in `feature` or `bugfix` branches.

When starting work on a new feature or bugfix use the following commands:

    flit start feature the_name_of_my_new_feature
    flit start bugfix the_issue_number_of_the_bug

You can now go ahead and committing your code as normal. Once you're ready to stop work for the day on your feature or bugfix, and want to return to your development branch, run:

    flit stop

_**Please note:** This will not automatically commit your code. You will have to do a `git commit` before running `flit stop`._

Once your code is finished and you're ready to merge it back into your development branch you'll need to use the `finish` command:

    flit finish feature the_name_of_my_new_feature
    flit finish bugfix the_issue_number_of_the_bug

This will pull down changes in master, rebase them into your feature branch and then merge your feature back into master.


##Contributing

You want to contribute? Great!

1. Fork Flit
2. Create a new feature branch (`flit start feature my_feature`)
3. Commit your changes (`git commit -am "Added my feature"`)
4. Push the branch (`git push origin feature/my_feature`)
5. Send me a pull request

I won't accept any pull requests if your feature is on the `master` branch as this makes it more difficult to cherry-pick your changes in. Also, please don't be offended if I don't pull your changes in immediately. I'll bring them in when I've got time.


##Licence

See LICENCE.
