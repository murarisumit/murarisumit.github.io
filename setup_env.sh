#!/bin/bash -
#===============================================================================
#
#          FILE: setup_env.sh
#
#
#   DESCRIPTION:
#
#         NOTES: Not tested yet, will set basic gems needed for me
#        AUTHOR: Sumit Murari,
#       CREATED: 10/10/2017 19:43
#===============================================================================

set -o nounset                              # Treat unset variables as an error

gem install bundler --verbose
gem install jekyll --verbose
gem install jekyll-admin  --verbose
