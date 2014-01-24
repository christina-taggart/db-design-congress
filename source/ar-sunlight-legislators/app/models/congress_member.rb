require_relative '../../db/config'

class CongressMember < ActiveRecord::Base
  validates :title, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :state, presence: true
  validates :party, presence: true

end
