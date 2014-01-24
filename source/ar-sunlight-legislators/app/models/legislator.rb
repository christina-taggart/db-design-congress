require_relative '../../db/config'

class Legislator < ActiveRecord::Base
    validates :name, :title, :party, :state, :phone, :lastname, presence: true
    validates :phone, :fax, length: { is: 10 }
    I18n.enforce_available_locales = false

    def initialize(args)
      super
      strip_string_of_non_digits
    end

    def strip_string_of_non_digits
      self.phone ||= ""
      self.phone = self.phone.gsub(/\D/, "")
      self.fax ||= ""
      self.fax = self.fax.gsub(/\D/, "")
    end
end

# bill = Legislator.new(name: 'Bill')
# bill.save
# steve = Legislator.new(name: 'Steve', title: 'Rep.', party: 'Republican', state: 'KY', phone: 'hjhkjh1234kjhhj1234kjhkhjk13')
# p steve.valid?
# p steve.save
# steve.title = "Sen."
# p steve

# "202-225-1589"