#!/usr/bin/env ruby
#
#  Title:         xml2csv.rb
#  Description:   Converts XML data from singular XML files located within various
#                 subdirectories into a CSV file.
#  Author:        Guy Dalziel
#  Date:          20150102
#  Version:       0.1
#  Notes:         If tags exist but the data is missing, the resulting data for that
#                 tag will be 'Unspecified'.
#

require 'csv'
require 'rexml/document'
require 'fileutils'
include REXML

product = []

CSV.open("xml2csv.csv","w") do |csv|
  csv << ["UID", "Title", "Actor", "Director", "Country", "File Path", "Bit Rate", "FPS", "Aspect Ratio"]
  Dir.glob("**/data-*.xml").each do |file|      #Search recusively from root of ScriptTest
    doc = Document.new(File.read(file))
    doc.elements.each do |element|              #Begin breakdown of XML tags
      product[0] = element.attributes['uid']
      element.elements.each do |value|
        tag = value.name
        data = value.text
        if data == ""
          data = "Unspecified"
        end
        case tag
          when "title"
            product[1] = data
          when "actor"
            product[2] = data
          when "director"
            product[3] = data
          when "country"
            product[4] = data
          when "asset"
            value.elements.each do |asset|
              tag = asset.name
              data = asset.text
              if data == ""
                data = "Unspecified"
              end
              case tag
                when "format"
                  product[5] = File.expand_path(File.dirname(file)) + "/" + product[0] + "/" + data
                when "bitrate"
                  product[6] = data
                when "fps"
                  product[7] = data
                when "aspect"
                  product[8] = data
                when "width"
                  # Do nothing
              end	
          end
        end
      end
    end
    csv << product         #Write array to CSV file
  end
end
