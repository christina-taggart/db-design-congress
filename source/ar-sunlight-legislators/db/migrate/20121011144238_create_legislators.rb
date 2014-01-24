require_relative '../config'

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title, :firstname, :middlename, :lastname, :name_suffix, :nickname, :gender, :party, :state, :district, :senate_class, :phone, :fax, :website, :twitter_id, :webform, :congress_office
      t.date :birthdate
      t.integer :in_office
      t.timestamps
    end
  end
end



# "title",
# "firstname",
# "middlename",
# "lastname",
# "name_suffix",
# "nickname",
# "birthdate",
# "gender",
# "party",
# "state",
# "district",
# "in_office", binary 1/0
# "senate_class",
# "phone",
# "fax",
# "website",
# "webform",
# "congress_office",