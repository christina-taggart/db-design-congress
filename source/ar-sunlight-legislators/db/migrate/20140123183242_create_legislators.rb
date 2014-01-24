# require_relative '../config'

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title, :name, :party, :state, :phone, :fax, :website,
               :gender, :twitter_id
      t.date :birthdate
      t.boolean :in_office
      # t.string :fec_id
      t.timestamps
    end
  end
end


# "title","firstname","middlename","lastname","name_suffix","nickname",
# "party","state","district","in_office","gender","phone","fax","website",
# "webform","congress_office","bioguide_id","votesmart_id","fec_id","govtrack_id",
# "crp_id","twitter_id","congresspedia_url","youtube_url","facebook_id","official_rss",
# "senate_class","birthdate"
