require_relative '../db/config'
require_relative 'models/contact'
require_relative 'models/party'
require_relative 'models/politician'
require_relative 'models/state'

#REVIEW: LOAD ORDER MATTERS

def find_politicians_by_state(state)
  state = State.where('state_abbr = ?', state).first
  senators = Politician.where('state_id = ? AND office_name = ?',
                                    state.id, "Sen")

  senators = senators.sort_by { |sen| sen.last_name }

  puts "Senators: "

  senators.each do |sen|
    puts "\t#{sen.first_name} #{sen.last_name} (#{sen.party.party_name})"
  end

  reps = Politician.where('state_id = ? AND office_name = ?',
                                    state.id, "Rep")

  puts ""
  puts "Representatives: "
  reps.each do |rep|
    puts "\t#{rep.first_name} #{rep.last_name} (#{rep.party.party_name})"
  end

end


def gender_percentages(gender)
  genders = { "M" => "Male", "F" => "Female" }

  senators = Politician.where('office_name = ? AND gender = ? AND is_active = 1', "Sen", gender).length
  total_senators = Politician.where('office_name = ? AND is_active = 1', "Sen").length
  puts "#{genders[gender]} Senators: #{senators} (#{  ((100.0*senators)/total_senators).round(2)  }%)"

  representatives = Politician.where('office_name = ? AND gender = ? AND is_active = 1', "Rep", gender).length
  total_representatives = Politician.where('office_name = ? AND is_active = 1', "Rep").length
  puts "#{genders[gender]} Representatives: #{representatives} (#{  ((100.0*representatives)/total_representatives).round(2)  }%)"
end

def print_congressmen_by_state
  states_congressmen = {}
  State.all.each do |state|
    sen_count = Politician.distinct.count(:conditions => "office_name = 'Sen' AND state_id = #{state.id}")
    rep_count = Politician.distinct.count(:conditions => "office_name = 'Rep' AND state_id = #{state.id}")

    states_congressmen[state.state_abbr] = [sen_count, rep_count]
  end

  states_congressmen = states_congressmen.sort_by { |state,counts| counts[0] + counts[1] }.reverse

  states_congressmen.each do |state,counts|
    puts "#{state} has: Sen: #{counts[0]} Reps: #{counts[1]}"
  end
end


def total_reps_sens
  senators = Politician.where('office_name = ?', "Sen").length
  representatives = Politician.where('office_name = ?', "Rep").length
  puts "Senators: #{senators}"
  puts "Representatives: #{representatives}"
end

def delete_inactive

  politicians = Politician.where('is_active = 0')
  politicians.each do |poli|
    Politician.delete(poli)
  end

end

find_politicians_by_state("MD")
gender_percentages('F')
print_congressmen_by_state
total_reps_sens
delete_inactive
total_reps_sens