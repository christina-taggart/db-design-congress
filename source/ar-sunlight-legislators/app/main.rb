# main.rb should contain the SQL Queries
# ActiveRecord Queries
require_relative 'models/legislator.rb'

# Given any state, first print out the senators 
# for that state (sorted by last name), then print out 
#   the representatives (also sorted by last name). 
#   Include the party affiliation next to the name. 
#   The output might look something like this:

def legislators_of_state(state_abbreviation)
  legislators = Legislator.where("state = ?", state_abbreviation)
  senators = legislators.select { |legislator| legislator.title == "Sen" }
  senators.sort_by! { |senator| senator.lastname }
  puts "Senators:"
  senators.each { |senator| puts "\t#{senator.name} (#{senator.party})" }
  representatives = legislators.select { |legislator| legislator.title.eql?("Rep") }
  representatives.sort_by! { |rep| rep.lastname }
  puts "Representatives:"
  representatives.each { |rep| puts "\t#{rep.name} (#{rep.party})" }
end



## Driver Code
legislators_of_state('FL')