class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :state
      t.string :title
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :party
      t.string :gender
      t.date :birthday
      t.string :twitter
      t.string :in_office
    end
  end
end
