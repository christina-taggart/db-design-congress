require_relative '../app/models/tweet'
require 'csv'

module TweetsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/tweet_output.csv")
    field_names = nil
    Tweet.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          legislator = Tweet.create!(attribute_hash)
        end
      end
    end
  end
end