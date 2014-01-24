require 'csv'
require_relative '../app/models/legislator.rb'


class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      attributes = row.to_hash
      attributes.delete_if{ |k,v| excluded_fields.include?(k)}
      bday_string = attributes['birthdate']
      attributes['birthdate'] = parse_birthday(bday_string)
      attributes['in_office'] = attributes['in_office'].to_i
      attributes['senate_class'] = nil if attributes['title'] != 'Sen'
      if attributes['title'] == 'Sen'
        Senator.create!(attributes)
      elsif attributes['title'] == 'Rep'
        Representative.create!(attributes)
      else
        Delegate.create!(attributes)
      end
    end
  end

  def self.parse_birthday(bday_string)
    bday = bday_string.split("\/")
    month = bday[0].to_i
    day = bday[1].to_i
    year = bday[2].to_i
    Date.new(year,month,day)
  end

  def self.excluded_fields
    excluded_fields = ["congresspedia_url", "youtube_url", "facebook_id", "official_rss", "bioguide_id","votesmart_id","fec_id","govtrack_id","crp_id"]
  end
end




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

# SunlightLegislatorsImporter.import('../db/data/legislators.csv')

# p SunlightLegislatorsImporter.parse_birthday("12/14/1956")