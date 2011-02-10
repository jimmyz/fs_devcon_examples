require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'
require 'logger'

$visited_ids = []  
def print_pedigree(person,level = 0)
  puts ' '*level + person.full_name + " (#{person.id})"
  $visited_ids << person.id
  print_pedigree person.father, level+1 if person.father && !$visited_ids.include?(person.father.id)
  print_pedigree person.mother, level+1 if person.mother && !$visited_ids.include?(person.mother.id)
end

pedigree = Marshal.load(File.read('pedigree_marshalled.txt'))
print_pedigree(pedigree.root)

