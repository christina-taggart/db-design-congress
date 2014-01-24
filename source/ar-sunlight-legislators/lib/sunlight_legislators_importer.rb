require 'csv'
require_relative '../app/models/politician'


class SunlightLegislatorsImporter
  def self.import
    csv = CSV.new(File.open('db/data/legislators.csv'), :headers => true)
    csv.each do |row|
      politician_hash = row.to_hash.select { |field, value| Politician.column_names.include?(field) }

      # puts politician_hash.inspect

      politician = Politician.new(politician_hash)
      politician.save!

    end #ends do
  end #ends import
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
