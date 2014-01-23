require_relative 'models/congress_member'


# Given any state, first print out the senators for that state (sorted by last
# name), then print out the representatives (also sorted by last name).
# Include the party affiliation next to the name.

def find_by_state(state)
  results = CongressMember.where(state: state).order(:last_name)
  puts "#{state} Senators:"
  results.each do |congress_member|
    if congress_member.title == "Sen"
      puts "#{congress_member.first_name} #{congress_member.last_name} (#{congress_member.party})"
    end
  end
  puts "\n#{state} Representatives:"
  results.each do |congress_member|
    if congress_member.title == "Rep"
      puts "#{congress_member.first_name} #{congress_member.last_name} (#{congress_member.party})"
    end
  end
end

#-----DRIVERS-----
find_by_state("OH")