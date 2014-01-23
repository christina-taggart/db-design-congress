require_relative '../app/models/politician'
require_relative '../app/models/party'
require_relative '../app/models/state'
require_relative '../app/models/contact'
require 'pry'

module MockConsole
  def self.start
    binding.pry
  end
end