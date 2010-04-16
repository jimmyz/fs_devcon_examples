require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'

com = FsCommunicator.new :domain => 'https://api.familysearch.org', :handle_throttling => true

def print_person(person)
  puts "#{person.full_name} (#{person.id})"
  puts "Gender: #{person.gender}"
  puts "Birth: #{person.birth.date.original}" if person.birth && person.birth.date
  puts "Death: #{person.death.date.original}" if person.death && person.death.date
end

def print_result(search_result)
  puts ""
  puts "Score: #{search_result.score}"
  print_person(search_result.person)
end

if authenticate_me(com)
  search = com.familytree_v2.search :givenName => "Parker", :familyName => "Felch"
  search.results.each do |result|
    print_result(result)
  end
end