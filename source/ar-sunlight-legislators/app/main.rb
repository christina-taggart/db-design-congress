require_relative 'models/congress_member'

#p legislator = CongressMember.first

def congress_people_for_state(state)
  puts "Senators:"
  CongressMember.find_all_by_state(state).each { |person| puts person.firstname + " " + person.lastname + "(#{person.party})" if person.title == "Sen"}
  puts "\nRepresentatives:"
  CongressMember.find_all_by_state(state).each { |person| puts person.firstname + " " + person.lastname + "(#{person.party})" if person.title == "Rep"}
end

def gender_bias(gender)
  gender_senators = 0
  gender_reps = 0
  total_sen = 0
  total_rep = 0

  CongressMember.find_all_by_gender(gender).each do |person|
    if person.gender == gender
      if person.title == "Sen"
        gender_senators += 1
      else
        gender_reps += 1
      end
    end
  end

  CongressMember.all.each do |person|
    if person.title == "Sen"
      total_sen += 1
    elsif person.title = "Rep"
      total_rep += 1
    end
  end

  gender == "M" ? male_or_female = "Male" : male_or_female = "Female"
  sen_percent = (gender_senators.to_f / total_sen) * 100
  rep_percent = (gender_reps.to_f / total_rep) * 100

  puts "#{male_or_female} Senators: #{gender_senators} (#{sen_percent}%)"
  puts "#{male_or_female} Representatives: #{gender_reps} (#{rep_percent}%)"
end

def count_congress_members
  senators = CongressMember.where(title: "Sen").count
  representatives = CongressMember.where(title: "Rep").count
  puts "Senators: #{senators}"
  puts "Representatives: #{representatives}"
end

def destroy_old_congress_people
  CongressMember.all.each do |person|
    person.destroy if person.in_office == 0
  end
end










congress_people_for_state("AK")
gender_bias("M")
count_congress_members
destroy_old_congress_people