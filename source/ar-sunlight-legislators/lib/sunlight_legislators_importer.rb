require 'csv'
require_relative "../app/models/representative"
require_relative "../app/models/senator"

class SunlightLegislatorsImporter

  def self.generate_attr(row_hash)
    name = "#{row_hash[:firstname]}, #{row_hash[:middlename]}, #{row_hash[:lastname]}"
    birthday = Date.strptime(row_hash[:birthdate], "%m/%d/%Y")
    attributes = {name: name, phone: row_hash[:phone], fax: row_hash[:fax],
      website: row_hash[:website], webform: row_hash[:webform],
      gender: row_hash[:gender], birthday: birthday, twitter_id: row_hash[:twitter_id],
      active: row_hash[:in_office], party: row_hash[:party], state: row_hash[:state]}
    attributes
  end

  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      row_hash = {}
      row.each do |field, value|
        row_hash[field.to_sym] = value
      end
      if row_hash[:title] == "Rep"
        Representative.create!(generate_attr(row_hash))
      else
        Senator.create!(generate_attr(row_hash))
      end
    end
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
