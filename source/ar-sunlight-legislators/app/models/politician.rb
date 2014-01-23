require_relative '../../db/config'
class Politician < ActiveRecord::Base
   validates :phone, uniqueness: true

end
