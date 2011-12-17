#
#  crawl.rb
#  
require 'rubygems'
require 'open-uri'
require 'strscan'
require 'hpricot'
require 'csv'
load '/home/filemind/rails_apps/mscrawl/region_list.rb'
load '/home/filemind/rails_apps/mscrawl/post_list.rb'
load '/home/filemind/rails_apps/mscrawl/post_fmp.rb'

class Crawl
  def initialize
    $list = RegionList.load("/home/filemind/rails_apps/mscrawl/regions_y.yml")
    $post_list = PostList.load("/home/filemind/rails_apps/mscrawl/posts_y.yml")
    puts $post_list
  end

  # Prereq: clist url of target
  def peel (url)
    #url.each_index do |i|
      if(data = open(url).read)
        s = StringScanner.new(data)
	continue = 1
        while (s.scan_until(/(http:\/\/)\S+.(craigslist.org)(\/\S{3})?(\/...\/)\d{10}.(html)/) && continue)
			#puts "found " << s.matched)
		#	@post = Post.new(s.matched())
	    if($post_list[s.matched()])
	      #puts "  exists"
	      continue = 0
            else
              @post = Post.new(s.matched())   #  @post = Post.new(:url => s.matched())
	      puts "  adding " << s.matched()
              read(@post)
            end
        end
         # $post_list << @post
	 # $post_list.save
      else 
        @errors.push(s.matched())
      end
      rescue
    #end
  end
  
  def read(post)
    @post = post
	doc = open(@post.url) { |f| Hpricot(f) }
	@post.title = doc.search('/html/body/h2').inner_html.gsub(/&#x[0-1]?[0-9a-eA-E];/, ' ')
	@post.reply_to = doc.search('/html/body/a').inner_html
        r = Regexp.compile('(Date:).*(P|M|C|E)(ST|DT)')
        r.match(doc.search('/html/body').inner_html) 
        @post.date = Regexp.last_match()
	$post_list << @post
        $post_list.save
	rescue
  end
end

  #Illegal XML character filter
  def gsx(str)
    str.gsub(/&#x[0-1]?[0-9a-eA-E];/, ' ')
  end

@crawler = Crawl.new
  


#if(not $post_list.empty?)
  $post_list.posts.each do |p|
	  @crawler.read(p)
  end
#end

  #Write rows to 'xmlout'
  fxw = PostFmp.new
  fxw.xml


