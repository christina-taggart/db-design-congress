require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  I18n.enforce_available_locales = false
  validates :name, :party, :title, :phone, :in_office, presence: true
  validates :phone, :fax, length: { is: 10 }
end

horace = Legislator.new(name: "Horace", party: "Republican", title: "Rep.", phone: "212-922-8357", fax:"2129223456", in_office: "t")
cheryl = Legislator.new(name: "Cheryl", party: "Republican", title: "Rep.", phone: "2129228357", fax:"2129223456", in_office: "t")
p horace.valid?
p cheryl.valid?