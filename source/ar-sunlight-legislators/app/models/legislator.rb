require_relative '../../db/config'

class Legislator < ActiveRecord::Base

  def self.get_legislators(state, title)
    state_legislators = self.where('state = ?', state)
    state_leg = state_legislators.where('title = ?', "#{title}").order('lastname')
    state_legs = state_leg.select("firstname, lastname, party")
    puts "#{title}s:"
    state_legs.each do |leg|
      puts "#{leg[:firstname]} #{leg[:lastname]} (#{leg[:party]})"
    end
  end

  def self.get_all_legislators(state)
    self.get_legislators(state, 'Sen')
    self.get_legislators(state, 'Rep')
  end

  def self.get_leg_gender_percentage(gender, title)
    legs = self.where('title = ?', "#{title}")
    active = legs.where('in_office = 1')
    male = active.where('gender = ?', "M").length
    total = active.select('firstname').length
    percentage = male.to_f/total * 100
    puts "#{gender} #{title}s: #{male} (#{percentage}%)" if gender == "Male"
    puts "#{gender} #{title}s: #{total - male} (#{(100 - percentage)}%)" if gender == "Female"
  end

  def self.get_legislator_gender_percentage(gender)
    self.get_leg_gender_percentage(gender, "Sen")
    self.get_rep_gender_percentage(gender, "Rep")
  end

  def self.get_legislator_count
    actives = self.where('in_office = 1')
    rep_count = self.where('title = ?' "Rep")
    state_reps = self.all(:select => "count(*) as count, state", :group => :state)
    state_reps.each do |state|
      puts "#{state[:state]}: 2 Senators, #{state[:count]} Reps"
    end
  end

  def self.get_actives
    actives = self.where('in_office = 1')
    sen = actives.where('title = ?', "Sen").length
    rep = actives.where('title = ?', "Rep").length
    puts "Senators: #{sen}"
    puts "Representatives: #{rep}"
  end

  def self.get_all
    sen = self.where('title = ?', "Sen").length
    rep = self.where('title = ?', "Rep").length
    puts "Senators: #{sen}"
    puts "Representatives: #{rep}"
  end

  def self.delete_inactives
    self.where(:in_office => 0).destroy_all
  end
end