#!/usr/bin/env ruby
#
# Title:        ciscobackup.rb
# Description:  Copies startup-config from cisco devices specified in
#               /etc/ciscodevices.yml into dated subdirectories in
#               /var/log/cisco_configs via TFTP.
# Author:       Guy Dalziel
# Date:         20150315
# Version:      0.1
# Notes:        Each device requires its startup-config to be made available
#               via TFTP:
#
#               (from global config)
#                 access-list 55 remark PERMIT access for backup via TFTP
#                 access-list 55 permit host 10.20.30.5
#                 tftp-server nvram:startup-config 55
#
#               startup-config will now be available to 10.20.30.5 via TFTP.
#
#               This script is rewritten in Ruby from Steve Cowles' Bash script.
#               This script provides a config file to specify devices from in
#               order to provide easier management in larger environments.
#

require "yaml"
require "date"
require "fileutils"

TFTPPROGRAM = "tftp"
FILENAME = "startup-config"
LOGDIR = "/var/log/cisco_configs/"
LOGTODAY = LOGDIR + Date.today.to_s
DEVCONF = "/etc/ciscodevices.yml"

def no_tftp_exec filename
  puts "Filename %s does not exist" % filename
end

def no_backup(host,ip)
  puts "Could not backup host %s at %s" % [host, ip]
end

def which(cmd)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{cmd}#{ext}")
      return exe if File.executable?(exe) && !File.directory?(exe)
    }
  end
  return nil
end

TFTPFULLPATH = which(TFTPPROGRAM)

if !File.exists?(TFTPFULLPATH)
  no_tftp_exec(TFTPPROGRAM)
end

if !Dir.exists?(LOGTODAY)
  FileUtils.mkdir_p LOGTODAY
end

conffile = File.read DEVCONF
devices = YAML::load conffile

devices.each do |device|
  deviceinfo = device.split ":", 3 
  hosttype = deviceinfo[0]
  hostname = deviceinfo[1]
  ipaddr = deviceinfo[2]
  fullpath = "#{LOGTODAY}/#{hosttype}/#{hostname}"
  if !Dir.exists?(fullpath)
    FileUtils.mkdir_p fullpath
  end
  if !system("#{TFTPPROGRAM} #{ipaddr} -c get #{FILENAME} #{fullpath}/#{FILENAME} 2>&1 > /dev/null")
    no_backup(hostname,ipaddr)
  end
end

if File.symlink?("#{LOGDIR}/router")
  File.delete("#{LOGDIR}/router") 
end
File.symlink("#{LOGTODAY}/router", "#{LOGDIR}/router")

if File.symlink?("#{LOGDIR}/switch")
  File.delete("#{LOGDIR}/switch") 
end
File.symlink("#{LOGTODAY}/switch", "#{LOGDIR}/switch")
