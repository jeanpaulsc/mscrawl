# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

   #$queries = [".craigslist.org/search/ggg?query=filemaker&catAbb=cpg&srchType=A&addThree=forpay",
   #                   ".craigslist.org/search/cpg?query=urgent&srchType=A&addThree=forpay",
   #                   ".craigslist.org/search/ggg?query=database&catAbb=cpg&srchType=A&addThree=forpay"]

  def crawl
    $list.regions.each do |r|
      url = "http://" << r.name << :query
      puts r.name
      peel(url)
    end
  end

  # Prereq: clist url of target
  def peel (url)
      if(data = open(url).read)
        s = StringScanner.new(data)
	continue = 1
        while (s.scan_until(/(http:\/\/)\S+.(craigslist.org)(\/\S{3})?(\/...\/)\d{10}.(html)/) && continue)
            if(@post = Post.new(:url => s.matched()).valid?)
              doc = open(@post.url) { |f| Hpricot(f) }
                @post.title = doc.search('/html/body/h2')
                @post.reply_to = doc.search('/html/body/a')
                @post.save

              end
            end
        end
	# $posts.save
      end
      
  end

  #Illegal XML character filter
  def gsx(str)
    str.gsub(/&#x[0-1]?[0-9a-eA-E];/, ' ')
  end
end

