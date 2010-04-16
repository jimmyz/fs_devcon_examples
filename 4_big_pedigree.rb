require 'rubygems'
require 'ruby-fs-stack'
require 'authenticate'
require 'logger'


com = FsCommunicator.new :domain => 'https://api.familysearch.org', :handle_throttling => true


if authenticate_me(com)
  com.logger = Logger.new STDOUT
  my_pedigree = com.familytree_v2.pedigree :me
  
  my_pedigree.continue_ids.each_slice(2) do |ids|
    pedigrees = com.familytree_v2.pedigree ids
    pedigrees.each do |ped|
      my_pedigree.injest ped
    end
  end
  
  File.open('pedigree_marshalled.txt','w') do |f|
    f.print Marshal.dump(my_pedigree)
  end
  
end