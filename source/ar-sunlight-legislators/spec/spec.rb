require_relative '../app/models/party'
require_relative '../app/models/representative'
require_relative '../app/models/senator'
require_relative '../app/models/state'


def line(msg)
  puts "\n------ #{msg} ------"
end

line "state"
attributes_state = {name: "Alabama"}
State.create!(attributes_state)
p State.all

line "party"
attributes_party = {name: "Green"}
Party.create!(attributes_party)
p Party.all

line "representative"
attributes_rep = {name: "Joe Shmo", phone: "530-333-6666", fax: "1234-123-1234",
 website: "www.whatever.com", webform: "this is a webform",
 gender: "male", birthday: Time.now, twitter_id: "@political",
 active: 1, party_id: 1, state_id: 1}
Representative.create!(attributes_rep)
p Representative.all

line "senator"
attributes_sen = {name: "Joe Shmo", phone: "530-333-6666", fax: "1234-123-1234",
 website: "www.whatever.com", webform: "this is a webform",
 gender: "male", birthday: Time.now, twitter_id: "@political",
 active: 1, party_id: 1, state_id: 1}
Senator.create!(attributes_sen)
p Senator.all