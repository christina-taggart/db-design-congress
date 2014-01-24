require 'csv'
require_relative '../app/models/legislator.rb'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    attributes_to_import = [:title, :party, :state, :phone, :fax,
                            :website, :gender, :twitter_id, :birthdate,
                            :in_office, :lastname]
    csv.each do |row|
      attributes = {}
      attributes[:name] = "#{row.field("firstname")} #{row.field("lastname")}"
      row.each do |field, value|
        if attributes_to_import.include?(field.to_sym)
          attributes[field.to_sym] = value
        end
      end
      Legislator.create(attributes)
    end
  end
end

# Driver Code (You can delete me after you get this shit working
# SunlightLegislatorsImporter.import('../db/data/legislators.csv')
#     validates :name, :title, :party, :state, :phone, presence: true
    # validates :phone, :fax, length: {is: 10}

#       t.string :title, :name, :party, :state, :phone, :fax, :website,
               # :gender, :twitter_id
      # t.date :birthdate
      # t.boolean :in_office



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
