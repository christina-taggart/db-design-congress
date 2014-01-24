require_relative '../../db/config'

class Politician < ActiveRecord::Base
  I18n.enforce_available_locales = false
   validates :phone, uniqueness: true

end
