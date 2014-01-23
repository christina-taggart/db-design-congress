require_relative '../config'

class CreateCongressMember < ActiveRecord::Migration
  def change
    create_table :congress_members do |col|
      col.string :title
      col.string :first_name
      col.string :middle_name
      col.string :last_name
      col.string :name_suffix
      col.string :nickname
      col.string :party
      col.string :state
      col.integer :district
      col.binary :in_office
      col.string :gender
      col.string :phone
      col.string :fax
      col.string :website
      col.string :webform
      col.string :twitter_id
      col.string :phone
      col.string :fax
      col.string :website
      col.string :webform
      col.string :twitter_id
      col.date :birthdate

    end
  end
end
