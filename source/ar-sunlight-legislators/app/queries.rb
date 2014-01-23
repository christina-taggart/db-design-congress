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


def find_by_gender(gender)
  sen_count = CongressMember.where(gender: gender).where(in_office: 1).where(title: "Sen").count
  rep_count = CongressMember.where(gender: gender).where(in_office: 1).where(title: "Rep").count
  sen_percentage =  ((sen_count.to_f / 100) * 100).floor
  rep_percentage =  ((rep_count.to_f / CongressMember.where(title: "Rep").where(in_office: 1).count.to_f) * 100).floor
  if gender == "M"
    gender_string = "Male"
  elsif gender == "F"
    gender_string = "Female"
  end
  puts "\nThere are #{sen_count} (#{sen_percentage}%) #{gender_string} Senators"
  puts "There are #{rep_count} (#{rep_percentage}%) #{gender_string} Representatives"
end

def list_states
  state_reps = CongressMember.where(in_office: 1).where(title: "Rep").group(:state)
  state_sens = CongressMember.where(in_office: 1).where(title: "Sen").group(:state)
  state_reps = state_reps.count.to_a
  state_sens = state_sens.count.to_a
  state_num = 0
  puts
  while state_num < 50
    puts "#{state_reps[state_num][0]}: #{state_sens[state_num][1]} Senators, #{state_reps[state_num][1]} Representatives"
    state_num += 1
  end
end

def list_totals
  sen_count = CongressMember.where(title: "Sen").count
  rep_count = CongressMember.where(title: "Rep").count
  puts "\nSenators: #{sen_count}"
  puts "Representatives: #{rep_count}"
end

def destroy_out_of_office
  CongressMember.all.each do |congress_member|
    congress_member.destroy if congress_member.in_office != 1
  end
end

#-----DRIVERS-----
find_by_state("OH")
find_by_gender("F")
find_by_gender("M")
list_states
list_totals
destroy_out_of_office
list_totals

