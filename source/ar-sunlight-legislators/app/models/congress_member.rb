require_relative '../../db/config'

class CongressMember < ActiveRecord::Base
  has_one: :contact
end
