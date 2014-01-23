csv = File.open('legislators.csv', 'r') do |f|
  until f.eof?
    line f.readline


