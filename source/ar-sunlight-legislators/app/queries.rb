require_relative 'models/congress_member'


# Given any state, first print out the senators for that state (sorted by last
# name), then print out the representatives (also sorted by last name).
# Include the party affiliation next to the name.

def find_by_state(state)
  results = CongressMember.where(state: state).order(:last_name)
  results.each { |congress_member| puts congress_member }
end

#-----DRIVERS-----
find_by_state("OH")