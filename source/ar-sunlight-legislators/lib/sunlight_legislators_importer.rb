require 'csv'
require_relative '../app/models/politician'
# require_relative '../db/legislators.csv'


class SunlightLegislatorsImporter
  def self.import(filename = '../db/legislators.csv')
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      politician_info = {}
      row.each do |column_name, value|
        value.gsub!(/\-/,"") if column_name.to_sym == :phone
        politician_info[column_name.to_sym] = value
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
      end
      Politician.create(politician_info)
    end
    RemoveColumnsFromPoliticians.change
  end
end

class RemoveColumnsFromPoliticians < ActiveRecord::Migration
  def self.change
    change_table :politicians do |t|
      t.remove :fax, :webform, :senate_class, :official_rss, :youtube_url,
               :congresspedia_url, :bioguide_id, :votesmart_id, :fec_id,
               :govtrack_id, :crp_id
    end
  end
end


 SunlightLegislatorsImporter.import


# SunlightLegislatorsImporter.import

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
