require_relative '../../db/config'

class CongressMember < ActiveRecord::Base
  validates :title, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone, uniqueness: true
  validates :fax, uniqueness: true
  validates :twitter_id, uniqueness: true
  validates :website, uniqueness: true
  belongs_to :state
  belongs_to :party

end