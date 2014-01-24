require_relative 'models/politician'

class PoliticianQueries

  @@data_to_use = Politician.where("in_office = ?", "1")

  def self.find_people_in_this_state(state)
    all_state_reps = PoliticianQueries.find_people_in_this_state
    puts "Senators:"
    all_state_reps.each { |x| puts "   " + x[:firstname] + " " + x[:lastname] + " " + x[:party] if x[:title] == "Sen"}
    puts "Representatives:"
    all_state_reps.each { |x| puts "   " + x[:firstname] + " " + x[:lastname] + " " + x[:party] if x[:title] == "Rep"}
  end

  def self.gender_split(gender)
    amount_sen = Politician.where("gender = ?", gender).where("title = ?", "Sen").count
    amount_rep = Politician.where("gender = ?", gender).where("title = ?", "Rep").count
    percentage_sen = (amount_sen / 1.00).floor
    percentage_rep = (amount_rep / 4.35).floor
    puts "The Senate is " + percentage_sen.to_s + "% #{gender == "M" ? "Male" : "Female"}"
    puts "The House is " + percentage_rep.to_s + "% #{gender == "M" ? "Male" : "Female"}"
  end

  def self.find_all_states
    all_states = @@data_to_use.map {|politician| politician[:state]}
    all_states.uniq!
  end

  def self.find_people_in_this_state(state)
    Politician.where("state = ?", state)
  end

  def self.find_all_politicians
    politicians_by_state = []
    all_states = PoliticianQueries.find_all_states
    all_states.each do |state|
      politicians_by_state << state
      politicians_by_state << PoliticianQueries.find_people_in_this_state(state).count
    end
    states_reps = Hash[politicians_by_state.each_slice(2).to_a].sort_by {|k,v| v}.reverse
  end

  def self.print_all_politicians
    states_reps = PoliticianQueries.find_all_politicians
    counter = 0
    50.times do
       state_data = states_reps[counter]
       puts state_data[0] + " has 2 Senators and #{state_data[1] - 2} Representatives"
       counter +=1
    end
  end

  def self.count_totals
    sens = Politician.where("title = ?", "Sen").count
    reps = Politician.where("title = ?", "Rep").count
    puts "There are #{sens} Senators"
    puts "There are #{reps} Senators"
  end

  def self.delete_out_of_office
    Politician.delete_all("in_office = 0")
  end
end

# p PoliticianQueries.find_all_politicians
PoliticianQueries.count_totals
PoliticianQueries.delete_out_of_office
PoliticianQueries.count_totals


# Print out the list of states along with how many active senators and representatives are in each, in descending order (i.e., print out states with the most congresspeople first).

# CA: 2 Senators, 53 Representative(s)
# TX: 2 Senators, 32 Representative(s)
# NY: 2 Senators, 29 Representative(s)
# (... etc., etc., ...)
# WY: 2 Senators, 1 Representative(s)

