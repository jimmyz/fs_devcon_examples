require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'
require 'logger'

pedigree = Marshal.load(File.read('pedigree_marshalled.txt'))

surnames = pedigree.persons.collect do |p|
  (p.full_name.nil?) ? nil : p.full_name.split(' ').last
end

surnames.reject!{|s|s.nil?}
puts surnames.join(' ')