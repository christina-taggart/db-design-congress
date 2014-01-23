require 'csv'
require_relative '../app/models/congress_member'

class SunlightLegislatorsImporter
  def self.import(filename= File.dirname(__FILE__) + "/../db/data/legislators.csv")
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      data = row.to_a
      data_hash = Hash[data]
      # Scrub out fields not used in congress_member model:
      data_hash.delete_if do |key, value|
        key == "bioguide_id" ||
        key == "votesmart_id" ||
        key == "fec_id" ||
        key == "govtrack_id" ||
        key == "crp_id" ||
        key == "congresspedia_url" ||
        key == "youtube_url" ||
        key == "facebook_id" ||
        key == "official_rss" ||
        key == "congress_office" ||
        key == "senate_class"
      end
      congress_member = CongressMember.create!(data_hash)
      congress_member.save
    end
  end
end

SunlightLegislatorsImporter.import

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
