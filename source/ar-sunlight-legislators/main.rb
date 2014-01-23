require_relative "app/models/representative"
require_relative "app/models/senator"

def get_state(state)
  ca_senators = Senator.where("state = ?", state)
  ca_reps = Representative.where("state = ?", state)
  puts "Senators:"
  ca_senators.each do |senator|
    puts "  #{senator.name} (#{senator.party})"
  end
  puts "Representative"
  ca_reps.each do |rep|
    puts "  #{rep.name} (#{rep.party})"
  end
end

def gender_ratio(gender)
  m_sen = Senator.where("gender = ? AND active = ?", "M", 1)
  f_sen = Senator.where("gender = ? AND active = ?", "F", 1)
  m_rep = Representative.where("gender = ? AND active = ?", "M", 1)
  f_rep = Representative.where("gender = ? AND active = ?", "F", 1)
  if gender == "male"
    rep_percentage = m_rep.length / 435.0
    puts "Male Senators: #{m_sen.length} (#{(m_sen.length)}%)"
    puts "Male Representatives: #{m_rep.length} (#{(rep_percentage * 100)}%)"
  else
    rep_percentage = f_rep.length / 435.0
    puts "Female Senators: #{f_sen.length} (#{(f_sen.length)}%)"
    puts "Female Representatives: #{f_rep.length} (#{(rep_percentage * 100)}%)"

  end
end

def group_by_num_of_reps
  active = Representative.where("active = ?", 1)
  active.group(:state).order('count_all desc').count('*').each do |state, reps|
    puts "#{state}: 2 Senators, #{reps} Representative(s)"
  end

end

def count_total
  puts "Senators: #{Senator.all.length}"
  puts "Representatives: #{Representative.all.length}"
end

def delete_inactive
  Senator.where(:active => 0).destroy_all
  Representative.where(:active => 0).destroy_all
end

get_state("CA")

gender_ratio("male")
gender_ratio("female")
delete_inactive
group_by_num_of_reps
count_total