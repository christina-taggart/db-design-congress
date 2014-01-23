require_relative '../app/models/legislator'
require 'csv'

# class SunlightLegislatorsImporter
#   def self.import(filename)
#     csv = CSV.new(File.open(filename), :headers => true)
#     csv.each do |row|
#       row.each do |field, value|
#         # TODO: begin
#         raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
#         # TODO: end
#       end
#     end
#   end
# end

module SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    field_names = nil
    Legislator.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          legislator = Legislator.create!(attribute_hash)
        end
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
