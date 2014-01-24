require_relative 'models/politician'
require_relative '../db/config.rb'


#1
  def by_state(state)
    senators = Politician.select(:firstname, :lastname, :party, :in_office).where('state' => state.upcase, 'title' => 'Sen', 'in_office' => '1').order("lastname asc")
    reps = Politician.select(:firstname, :lastname, :party, :in_office).where('state' =>state.upcase, 'title' => 'Rep', 'in_office' => '1').order("lastname asc")

    puts "Senators:"
    senators.each do |sen|
      print "  #{sen.firstname} #{sen.lastname} #{sen.party}"
      puts ""
    end

    puts "Representatives:"
    reps.each do |reps|
      print "  #{reps.firstname} #{reps.lastname} #{reps.party}"
      puts ""
    end
  end


#2
  def by_gender(gender)
    senators = Politician.select(:title, :gender, :in_office).where('gender' => gender.upcase, 'title' => 'Sen', 'in_office' => '1')
    reps = Politician.select(:title, :gender, :in_office).where('gender' => gender.upcase, 'title' => 'Rep', 'in_office' => '1')
    total_rep = Politician.select("in_office").where('title' => 'Rep', 'in_office' => '1').length
    total_sen = 100

    gender.upcase == 'F' ? gender_prefix = 'Female' : gender_prefix = 'Male'

    senator_percentage = ((senators.length.to_f / total_sen) * 100).round
    rep_percentage = ((reps.length.to_f / total_rep.to_f) * 100).round

    print "#{gender_prefix} Senators: #{senators.length} (#{senator_percentage}%)"
    puts ""
    print "#{gender_prefix} Representatives: #{reps.length} (#{rep_percentage}%)"
    puts ""
  end

#3
  def list_state
    reps = Politician.select(:state).where('title' => 'Rep', 'in_office' => '1').group('state').count
    sorted = reps.sort_by{|key, value| value}.reverse

    sorted.each do |key, value|
      puts "#{key}: 2 Senators, #{value} Representative(s)"
    end
  end



#4

  def total
    senators = Politician.select(:title).where('title' => 'Sen').length
    reps = Politician.select(:title).where('title' => 'Rep').length

    puts "Senators: #{senators}"
    puts "Representatives: #{reps}"
  end


#5
  def delete
    Politician.where('in_office' => '0').destroy_all
  end



#test code
# by_state('ca')

by_gender('f')
by_gender('m')

total
# list_state
delete
p "------"
total
