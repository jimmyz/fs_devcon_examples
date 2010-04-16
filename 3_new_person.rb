require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate_sandbox'
require 'logger'

com = FsCommunicator.new :domain => 'http://www.dev.usys.org'

if authenticate_me(com)
  
  com.logger = Logger.new STDOUT
  FamilyTreeV2 = Org::Familysearch::Ws::Familytree::V2::Schema
  
  darth = FamilyTreeV2::Person.new
  darth.add_name "Darth /Vader/"
  darth.add_name "Anakin /Skywalker/"
  darth.add_gender "Male"
  darth.add_birth :date => "2000 BC", :place => "Tatooine"
  darth.add_death :date => "1945 BC", :place => "Death Star II"
  
  
  padme = FamilyTreeV2::Person.new
  padme.add_name "Padmé /Amidala/"
  padme.add_gender "Female"
  padme.add_birth :date => "2006 BC", :place => "Naboo"
  padme.add_death :date => "1980 BC", :place => "Polis Massa"
  
  
  luke = FamilyTreeV2::Person.new
  luke.add_name "Luke /Skywalker/"
  luke.add_gender "Male"
  luke.add_birth :date => "1980 BC", :place => "Polis Massa"
  
  leia = FamilyTreeV2::Person.new
  leia.add_name "Leia /Skywalker/"
  leia.add_gender "Female"
  leia.add_birth :date => "1980 BC", :place => "Polis Massa"
  
  darth = com.familytree_v2.save_person darth
  padme = com.familytree_v2.save_person padme
  luke = com.familytree_v2.save_person luke
  leia = com.familytree_v2.save_person leia
  
  com.familytree_v2.write_relationship luke.id, :parent => darth.id, :lineage => 'Biological'
  com.familytree_v2.write_relationship luke.id, :parent => padme.id, :lineage => 'Biological'
  
  com.familytree_v2.write_relationship leia.id, :parent => darth.id, :lineage => 'Biological'
  com.familytree_v2.write_relationship leia.id, :parent => padme.id, :lineage => 'Biological'
  
  com.familytree_v2.write_relationship padme.id, :spouse => darth.id, :event => {:type => 'Marriage', :date => '1982 BC', :place => 'Naboo'}
  
  puts "Darth: #{darth.id}"
  puts "Padme: #{padme.id}"
  puts "Luke: #{luke.id}"
  puts "Leia: #{leia.id}"
  
end