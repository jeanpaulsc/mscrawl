#
#  load_regions.rb
#  
require 'rubygems'
require 'open-uri'
require 'strscan'
require 'hpricot'
require 'yaml'
#require 'ActiveRecord'
#load '/home/filemind/rails_apps/mscrawl/config/regions_y.yml'
load '/home/filemind/rails_apps/mscrawl/config/region_list.rb'
#load '/home/filemind/rails_apps/mscrawl/app/controllers/posts_controller.rb'

$list = RegionList.load("/home/filemind/rails_apps/mscrawl/config/regions_y.yml")
