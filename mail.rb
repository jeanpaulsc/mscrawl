require 'net/smtp'

smtp = Net::SMTP.new('localhost', 25)
smtp.start('localhost', 'filemind', 't003ager')
smtp.send_message 'msgstr', 'jeanpaulsc@gmail.com', 'jeanpaulsc@gmail.com'
smtp.finish