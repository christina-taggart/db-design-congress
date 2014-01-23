require_relative '../../db/config'

class Party < ActiveRecord::Base
  validates :party, presence: true
  has_many :congress_members
end