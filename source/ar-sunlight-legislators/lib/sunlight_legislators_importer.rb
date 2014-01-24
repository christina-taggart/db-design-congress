require 'csv'

class SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")

    state_abbr = ['AL','AK','AZ','AR','CA','CO','CT',
                  'DE','FL','GA','HI','ID','IL','IN',
                  'IA','KS','KY','LA','ME','MD','MA',
                  'MI','MN','MS','MO','MT','NE','NV',
                  'NH','NJ','NM','NY','NC','ND','OH',
                  'OK','OR','PA','RI','SC','SD','TN',
                  'TX','UT','VT','VA','WA','WV','WI',
                  'WY']

    party_abbr = ['D', 'R', 'I']

    state_abbr.each do |state|
      State.create(state_abbr: state)
    end

    party_abbr.each do |party|
      Party.create(party_name: party)
    end

    distinct_parties = Hash.new(0)

    p filename
    csv = CSV.new(File.open(filename), :headers => true)
     first_line = true
     CSV.foreach(File.open(filename)) do |line|
        if first_line
          first_line = false
        else
          new_politician =Politician.create(office_name: line[0], first_name: line[1], last_name: line[3],
                             state: State.where('state_abbr = ?', line[7])[0], gender: line[10],
                             party: Party.where('party_name = ?', line[6])[0], is_active: line[9] )
          Contact.create(politician: new_politician, phone: line[11], fax: line[12] , website: line[13], webform: line[14], twitter_name: line[21])

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
