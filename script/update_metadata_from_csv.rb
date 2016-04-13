#!/usr/bin/env ruby

# CSV::Reader.parse(File.open(users.csv, 'rb'), '|') do |row|
#    User.create(:name => row[0], :username => row[1], :password => row[2])
# end

#Collection number,Title,Volume number,Issue number,Publication date,File name,Description,Notes
# Johns Hopkins University News-letter, Volume 69, Number 1 (1964 September 25)
require 'csv'
require 'date'
file = File.open('inventory.csv', 'rb')
CSV.foreach(file.path, headers: true) do |row|
  file_hash = row.to_hash
  GenericFile.where(title_sim: file_hash["File name"]).each do |gf|
    gf.title = ["#{file_hash['Alternate title']}, Volume #{file_hash['Volume number']}, Number #{file_hash['Issue number']} (#{file_hash['Publication date']})"]
    #datetime = DateTime.strptime(file_hash['Publication date'], '%Y %B %-d')
    gf.date_created = [DateTime.parse(file_hash['Publication date'])]
    gf.subject = ["Publication","Newsletter","Student life"]
    gf.tag = ["Publication","Newsletter","Student life"]
    gf.description = ["Digitized issue of the Johns Hopkins University Student News-Letter, Ferdinand Hamburger University Archivies, RG 14.050."]
    gf.publisher = ["Johns Hopkins University"]
    gf.save
    puts gf.title
  end
end
