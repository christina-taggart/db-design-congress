class PhoneValidator < ActiveModel::Validator
  def validate(record)
    unless record.phone.match(/(\(?\d{3}\)?-?\s?\d{3}-?\s?\d{4}\s?)(x\d{4})?/)
      record.errors[:base] << "Yo phone number is wack"
    end
  end
end

class Contact < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :politician
  validates_with PhoneValidator
end


