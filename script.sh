#!/bin/bash

gem install bundler
bundle install

ruby menu.rb $1 $2
