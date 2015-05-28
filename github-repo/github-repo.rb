#!/usr/bin/env ruby
#
# Title:       github-repo.rb
# Description: Allows users to create, list, and delete repositories
#              on GitHub via the Linux command line.
# Author:      Guy Dalziel
# Date:        20150527
# Version:     0.1.1
# Notes:       This script requires github.user and github.token to be
#              set in Git. This can be done with the following commands:
#
#              git config --global github.user <username>
#              git config --global github.token <token>
#
#              A personal access token must be obtained from GitHub via
#              user settings and set with scopes 'repo', 'gist',
#              'delete_repo', and 'user'.
#
#              Always double check when using delete. This script will
#              not ask you to confirm your decision when using this
#              commend. If you are uncomfortable with this option, do
#              not add the 'delete_repo' scope to your access token.
#

require 'optparse'
require 'json'

def curworkdir   # Break down directory structure to retrieve dir name
  dirlist = []
  dir = Dir.pwd.split("/").count
  Dir.pwd.split("/").each {|element| dirlist.push element}
  return dirlist[dir -1]
end

def usage    
  puts "Usage: ./github-repo.rb <repository>
If no arguments are provided, the current directory name of '#{curworkdir()}' will be used."
end

# Handle command line options

options = {delete:false, list:false, listall:false}   # Set default values for conditional handling
OptionParser.new do |opts|
  opts.banner = "Usage: github-repo.rb [reponame] [options]"

  opts.on("-a", "--all", "List all (including forked repositories)") do |a|
    options[:listall] = a
  end
  opts.on("-d", "--delete REPO", "Delete a repository") do |d|
    options[:delete] = d
  end
  opts.on("-l", "--list", "List GitHub repositories") do |l|
    options[:list] = l
  end
end.parse!

if options[:delete] && (options[:list] || options[:listall])
  puts "Error: delete and list cannot be used together"
  exit
end

# Once all options are processed ARGV.count will be 0

if ARGV.count == 0
  repository = curworkdir()   # No arguments provided. The current directory name will be used
elsif ARGV.count == 1
  repository = ARGV[0]        # An argument has been provided. This will be the repository name
elsif ARGV.count > 1
  puts "Error: too many arguments\n\n"
  usage()
  exit
end 

gituser = `git config github.user`.chomp
gittoken = `git config github.token`.chomp

# I don't like running a script and finding an error, fixing it, running it, and
# finding that I have another error. If both config options are not set, notify
# the user.

if gituser == "" && gittoken == ""
  puts "Error: git.user is not set, run 'git config --global github.user <username>'"
  puts "Error: git.token is not set, run 'git config --global github.token <token>'"
  exit
elsif gituser == ""
  puts "Error: git.user is not set, run 'git config --global github.user <username>'"
  exit
elsif gittoken == ""
  puts "Error: git.token is not set, run 'git config --global github.token <token>'"
  exit
end

# Handle -l and --list options. Using list with --all will display all repos, including
# forked repositories

if options[:list] == true 
  JSON.parse(`curl -s -u \"#{gituser}:#{gittoken}\" https://api.github.com/user/repos`)
    .reject{|r| options[:listall] == false && r['fork'] == true}
    .each{|r| puts r['name']}
  exit
end

# Handle -d and --delete options. Checked against the default value of false to ensure
# that this isn't triggered without an argument

# This needs more work. The error condition will only be met if curl is unable to successfully execute.
# GitHub returns JSON data with 'message' = "Not Found" if unsuccessful. Therefore the command has executed
# correctly and will display "successfully deleted" even when "Not Found" is returned.

if options[:delete] != false
  if system("curl -s -u \"#{gituser}:#{gittoken}\" -X DELETE https://api.github.com/repos/#{gituser}/#{options[:delete]}")
    puts "Repository '#{options[:delete]}' successfully deleted"
  else
    puts "Error: something went wrong"
  end
  exit
end

# Default action when no options are provided: create a repo using the current directory
# name or using the name provided via ./github-repo.rb <reponame>

if system("curl -s -o /dev/null -u \"#{gituser}:#{gittoken}\" https://api.github.com/user/repos -d '{\"name\":\"'#{repository}'\"}'")
  puts "Repository '#{repository}' successfully created"
else
  puts "Error: something went wrong"
end
