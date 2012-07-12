$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'

com = FsCommunicator.new :domain => 'https://api.familysearch.org', :handle_throttling => true

def print_pedigree(person,level = 0)
  puts ' '*level + person.full_name + " (#{person.id})"
  print_pedigree person.father, level+1 if person.father
  print_pedigree person.mother, level+1 if person.mother
end

if authenticate_me(com)
  my_pedigree = com.familytree_v2.pedigree 'KWZF-CFW'
  print_pedigree my_pedigree.root
end