# SvnParallel

If you have an app in subversion with many externals, it may take a bit too long to update it, as updates happen one after another. This gem updates the root and each external in parallel, making it much faster.

NOTE: After adding/changing externals or external properties, you'll need to run the standard `svn up` once before running this script again

Original Script From: kch on http://codesnippets.joyent.com/posts/show/548

## Installation

Add this line to your application's Gemfile:

    gem 'svn_parallel', :git => 'git://github.com/tleish/svn_parallel.git'

And then execute:

    $ bundle install

Or install it yourself as:

    $ git clone git://github.com/tleish/svn_parallel.git  
    $ cd svn_parallel
    $ rake gem


## Usage

$ cd [svn root directory...]
$ svnup
