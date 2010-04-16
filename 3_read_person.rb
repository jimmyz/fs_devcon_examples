require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'

com = FsCommunicator.new :domain => 'https://api.familysearch.org', :handle_throttling => true

def print_person(person)
  puts "Names: #{person.full_names.join(', ')} (#{person.id})"
  puts "Gender: #{person.gender}"
  puts "Birth: #{person.birth.date.original}" if person.birth && person.birth.date
  puts "Death: #{person.death.date.original}" if person.death && person.death.date
  contributors = person.assertions.names.collect{|n|n.contributors}.flatten.collect{|contrib|contrib.id}
  puts "Contributors: #{contributors.join(', ')}"
end

if authenticate_me(com)
  person = com.familytree_v2.person 'L78M-RLN', :names => 'all', :contributors => 'all'
  print_person(person)
end