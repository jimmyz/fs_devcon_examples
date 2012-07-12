$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'
require 'logger'
  
FamilyTreeV2 = Org::Familysearch::Ws::Familytree::V2::Schema
pedigree = Marshal.load(File.read('pedigree_marshalled.txt'))

full_pedigree = FamilyTreeV2::Pedigree.new

com = FsCommunicator.new :domain => 'https://api.familysearch.org', :handle_throttling => true

if authenticate_me(com)
  com.logger = Logger.new STDOUT
  
  persons = com.familytree_v2.person pedigree.person_ids, :parents => 'summary'
  persons.each do |person|
    full_pedigree << person
  end
end

File.open('full_pedigree_marshalled.txt','w') do |f|
  f.print Marshal.dump(full_pedigree)
end

