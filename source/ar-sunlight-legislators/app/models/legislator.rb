require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  def self.legislators_by_state(state)
    legislators = self.where(state: state, in_office: 1)
    print_state_legislators(legislators)
  end

  def self.print_state_legislators(legislators)
    senators = self.get_senators(legislators)
    senators.sort_by!{|sen| sen.lastname}

    representatives = self.get_representatives(legislators)
    representatives.sort_by!{|rep| rep.lastname}

    puts "Senators:"
    senators.each {|sen| puts "  #{sen.firstname} #{sen.lastname} (#{sen.party})"}
    puts "Representatives:"
    representatives.each {|rep| puts "  #{rep.firstname} #{rep.lastname} (#{rep.party})"}
  end

  def self.get_senators(legislators)
    legislators.select{|leg| leg.title == 'Sen'}
  end

  def self.get_representatives(legislators)
    legislators.select { |leg|  leg.title == 'Rep'}
  end

  def self.by_gender(gender)
    legislators_by_gender = self.where(gender: gender, in_office: 1)
    sen_by_gender = self.get_senators(legislators_by_gender)
    rep_by_gender = self.get_representatives(legislators_by_gender)

    gender_string = gender.upcase == "F" ? "Female" : "Male"
    puts "#{gender_string} Senators: #{sen_by_gender.length} (#{sen_by_gender.length}%)"
    puts "#{gender_string} Representatives: #{rep_by_gender.length} (#{(rep_by_gender.length/435.0*100).round(0)}%)"
  end

  def self.by_state_descending
    legislators = self.where(in_office: 1)
    reps = get_representatives(legislators)
    sens = get_senators(legislators)
    states = self.uniq.pluck(:state)
    state_array = []

    states.each do |state|
      state_count = Hash.new
      state_count[state] = [reps.count{ |rep| rep.state == state }, sens.count {|sen| sen.state == state}]
      state_array << state_count
    end

    state_array.sort_by! { |state_count| state_count.values[0] }.reverse!
    state_array.each { |state| puts "#{state.keys[0]}: #{state.values[0][1]} senators, #{state.values[0][0]} representatives"}
  end

  def self.number_of_reps
    reps = get_representatives(self.all).count
    sens = get_senators(self.all).count
    puts "Senators: #{sens}"
    puts "Representatives: #{reps}"
    puts "Delegates: #{self.where(title: 'Del').count}"
    puts "Commissioner: #{self.where(title: 'Com')}"
  end

  def self.delete_not_in_office
    self.delete_all(in_office: 0)
  end
end

Legislator.delete_not_in_office