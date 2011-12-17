 require "test/unit" 
 require "yaml" 
 #require "post_list"

class Region 
  attr_reader :name, :country, :most_recent_post
  attr_writer :name, :country, :most_recent_post
  
  def initialize(name) 
    @name = name 
    @country = {} 
    @most_recent_post = {} 
  end 
end

class RegionList 
  attr_accessor :regions 
  def initialize(file)  
    @file = "regions_y.yml"
    @regions = [] 
  end 
  def <<(region)  
    @regions << region 
  end 
  def delete(name)                                 
    @regions.delete_if {|c| c.name == name } 
  end 
  def empty?         
    @regions.empty? 
  end 
  def size 
    @regions.size  
  end 
  def [](name)                                
    @regions.find {|c| c.name == name } 
  end 
  def save 
    File.open(@file, "w") do |fh| 
     fh.puts(@regions.to_yaml)  
    end 
  end 
  def self.load(file)  
    list = new(file) 
    #print "loading " << file
    list.regions = YAML.load(File.read(file))
    list 
  end 
end 

