require_relative '../config'

class CreatePolitician < ActiveRecord::Migration
  def change
    create_table :politicians do |x|
      x.string :title
      x.string :firstname
      x.string :middlename
      x.string :lastname
      x.string :name_suffix
      x.string :nickname
      x.string :party
      x.string :state
      x.string :district
      x.string :in_office
      x.string :gender
      x.string :phone
      x.string :fax
      x.string :website
      x.string :webform
      x.string :congress_office
      x.string :bioguide_id
      x.string :votesmart_id
      x.string :fec_id
      x.string :govtrack_id
      x.string :crp_id
      x.string :twitter_id
      x.string :congresspedia_url
      x.string :youtube_url
      x.string :facebook_id
      x.string :official_rss
      x.string :senate_class
      x.string :birthdate

    end
  end

end

      # :title
      #  :firstname
      #  :middlename
      #  :lastname
      #  :name_suffix
      #  :nickname
      #  :party
      #  :state
      #  :district
      #  :in_office
      #  :gender
      #  :phone
      #  :fax
      #  :website
      #  :webform
      #  :congress_office
      #  :bioguide_id
      #  :votesmart_id
      #  :fec_id
      #  :govtrack_id
      #  :crp_id
      #  :twitter_id
      #  :congresspedia_url
      #  :youtube_url
      #  :facebook_id
      #  :official_rss
      #  :senate_class
      #  :birthdate
