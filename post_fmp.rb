class PostFmp

  #Illegal XML character filter
  def gsx(str)
    str.gsub(/&#x[0-1]?[0-9a-eA-E];/, ' ')
  end

  #Write rows to 'xmlout' file.
  def reset
    @xhead = '<?xml version="1.0" encoding="UTF-8" ?><FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult"><ERRORCODE>0</ERRORCODE><PRODUCT BUILD="06-11-2010" NAME="FileMaker" VERSION="ProAdvanced 11.0v2"/><DATABASE DATEFORMAT="M/d/yyyy" LAYOUT="" NAME="post_y.fp7" RECORDS="" TIMEFORMAT="h:mm:ss a"/><METADATA><FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="url" TYPE="TEXT"/><FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="date" TYPE="TEXT"/><FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="reply_to" TYPE="TEXT"/><FIELD EMPTYOK="YES" MAXREPEAT="1" NAME="title" TYPE="TEXT"/></METADATA><RESULTSET FOUND="">'
    @rhead = '<ROW MODID="" RECORDID=""><COL><DATA>'
    @rdiv = '</DATA></COL><COL><DATA>'
    @rtail = '</DATA></COL></ROW>'
    @xtail = '</RESULTSET></FMPXMLRESULT>'
  end

  def xml
    reset
    outfile = File.new("/home/filemind/rails_apps/mscrawl/public/post_fmp.xml", "w+")
    outfile.puts(@xhead)
    #puts (@xhead)
    $post_list.posts.each do |p|
      reset
      outfile.puts(@rhead << p.url << @rdiv << p.date << @rdiv << p.reply_to << @rdiv << p.title.gsub("&"," ").gsub("<","") << @rtail)
      #puts (@rhead << p.url << @rdiv << p.reply_to << @rdiv << p.title << @rtail)
    end
    outfile.puts(@xtail)
    #puts (@xtail)
    puts "  post_fmp.xml written"
    outfile.close
  end

  #Write rows to 'csvout' file.
  def csv
    outfile = File.open('/home/filemind/rails_apps/mscrawl/public/post_list.csv', 'wb')
    CSV::Writer.generate(outfile) do |csv|

      $post_list.posts.each do |p|
        p.url << '", "' << p.reply_to << '", "' << p.title
        csv << [ p.url ]
      end
    end
    puts "  post_fmp.csv written"
    outfile.close
  end
end