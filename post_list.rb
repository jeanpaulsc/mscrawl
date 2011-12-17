# require "test/unit" 
 require "yaml"
# require "region_list" 

class Post 
  attr_reader :date, :url, :title, :reply_to
  attr_writer :date, :url, :title, :reply_to
  
  def initialize(url) 
    @url = url 
    @date = {}
    @title = {} 
    @reply_to = {}
  end 
end

class PostList 
  attr_accessor :posts 
  def initialize(file)  
    @file = "posts_y.yml"
    @posts = [] 
  end 
  def <<(post)  
    @posts << post 
  end 
  def delete(url)                                 
    @posts.delete_if {|c| c.url == url } 
  end 
  def empty?         
    @posts.empty? 
  end 
  def size 
    @posts.size  
  end 
  def [](url)                                
    @posts.find {|c| c.url == url } 
  end 
  def save 
    File.open(@file, "w") do |fh| 
     fh.puts(@posts.to_yaml)
    end 
  end 
  def self.load(file)  
    list = new(file) 
    #print "loading " << file
    list.posts = YAML.load(File.read(file))
    list 
  end 
end 

