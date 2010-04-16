require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'
require 'logger'
  
def print_pedigree(person,level = 0)
  puts ' '*level + person.full_name + " (#{person.id})"
  print_pedigree person.father, level+1 if person.father && person.father.id != person.id
  print_pedigree person.mother, level+1 if person.mother && person.mother.id != person.id
end

pedigree = Marshal.load(File.read('pedigree_marshalled.txt'))
print_pedigree(pedigree.root)

