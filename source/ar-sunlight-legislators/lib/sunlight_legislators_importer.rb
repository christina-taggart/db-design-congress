require 'csv'
require_relative '../app/models/politician'

class SunlightLegislatorsImporter
  def self.import(filename = '../db/data/legislators.csv')
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      politician_info = {}
      row.each do |column_name, value|

        politician_info[column_name.to_sym] = value

      #   # politician_attributes = {}
      #   # politician_attributes << {column_name:, value}
      # Politician.create(hash)
      #   #raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
      #   # TODO: end
      end
      Politician.create(politician_info)
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
