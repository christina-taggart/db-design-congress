class Politician < ActiveRecord::Base
  has_one :contact
  belongs_to :state
  belongs_to :party
  validates_presence_of :first_name, :last_name, :state, :party
end

