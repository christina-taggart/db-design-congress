require 'twitter'
require 'pry'
require 'pry-nav'

#secret tokens and keys have been removed for sake of privacy


tweets = File.read('restoftweets.csv').split("\n")[1..-1].map! do |tweet_id_pair|
  tweet_id_pair = tweet_id_pair.split(",")
end


tweets.map! do |tweet|
  p tweet[1]
  begin
  stuff = client.user_timeline(tweet[1])[0..10].map {|content| [tweet[0], content.text]}
  rescue
  end
  stuff
end

tweets.compact!

tweets.each do |two_dimen_array_oftweets|
  two_dimen_array_oftweets.compact!
  two_dimen_array_oftweets.each do |tweet_id_pair|
    File.open('tweet_output.csv', "a") do |f|
      f.puts "#{tweet_id_pair[0]},#{tweet_id_pair[1]}"
    end
  end
end
