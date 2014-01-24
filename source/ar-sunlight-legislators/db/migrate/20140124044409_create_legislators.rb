
class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :name, :party, :title, :phone, :fax, :website,
               :gender, :twitter_id, :in_office
      t.date :birthdate

    t.timestamps
  end
  end
end

