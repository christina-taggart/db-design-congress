class RemoveColumnsFromPoliticians < ActiveRecord::Migration
  def change
    change_table :politicians do |t|
      t.remove :fax, :webform, :senate_class, :official_rss, :youtube_url,
               :congresspedia_url, :bioguide_id, :votesmart_id, :fec_id,
               :govtrack_id, :crp_id
    end
  end
end
