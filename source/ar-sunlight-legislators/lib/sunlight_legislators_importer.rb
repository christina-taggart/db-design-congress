require 'csv'
require_relative '../app/models/congress_member'

module SunlightLegislatorsImporter


  def self.import(filename=File.dirname(__FILE__) + "../db/data/legislators.csv")
    field_names = nil
    CongressMember.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          congress_member = CongressMember.create!(title: attribute_hash['title'], firstname: attribute_hash['firstname'], lastname: attribute_hash['lastname'], party: attribute_hash['party'],
                                                  state: attribute_hash['state'], phone: attribute_hash['phone'], fax: attribute_hash['fax'], website: attribute_hash['website'], webform: attribute_hash['webform'],
                                                  gender: attribute_hash['gender'], twitter_id: attribute_hash['twitter_id'], in_office: attribute_hash['in_office'])
        end
      end
    end
  end
end
  #   def format_attributes
  #   #phone numbers we need strip out "-"
  #   #strip time from dates within birthday
  # end


#SunlightLegislatorsImporter.import('../db/data/legislators.csv')

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
