require_relative '../../db/config'

class State < ActiveRecord::Base
  validates :state, presence: true
  has_many :congress_members
end