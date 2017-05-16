# Welcome to our Sample Chatbot App, powered by Chatbot
require 'HTTParty'

@header_xapix = {
  "Accept": "application/json",
  "Authorization": "chatbot:Cq2Og81xi48n3eZz6dQRWGuKVAsbwLj2"
}

# received_message_url = "https://xap.ix-io.net/api/v1/twilio/account_messages?filter%5Baccount_sid%5D=AC0d8bb04ed7587bb49fdccc8ca5cff8fc&fields%5Baccount_messages%5D=first_page_uri%2Cend%2Cprevious_page_uri%2Curi%2Cpage_size%2Cstart%2Cnext_page_uri%2Caccount_sid%2Cpage&include=messages&sort=account_sid&page%5Bnumber%5D=1&page%5Bsize%5D=100
# " 

# received_messages = HTTParty.get(received_message_url, headers: @header)

auth = {:username => "AC0d8bb04ed7587bb49fdccc8ca5cff8fc", :password => "e569547306a11b8771bba40159b46d6b"}

twilio_url = 'https://api.twilio.com/2010-04-01/Accounts/AC0d8bb04ed7587bb49fdccc8ca5cff8fc/Messages.json'

header = {
  "Accept": "application/json",
}

@received_messages = HTTParty.get(twilio_url, :basic_auth => auth, headers: header)['messages']

latest_message = @received_messages[0]["body"]

@achievement= [{action=>"speak", occasion=>"conference"}, {action=>"speak", occasion=>"conference"}, {action=>"speak", occasion=>"conference"}]

def send_message(message)

	send_message_url = "https://xap.ix-io.net/api/v1/twilio/message_creations"

	body={
	  "data": {
	    "account_sid": "AC0d8bb04ed7587bb49fdccc8ca5cff8fc",
	    "body": message,
	    "from_number": "+16176525519",
	    "to_number": "+16175832486"
	  }
	}.to_json

	send_message = HTTParty.post(send_message_url, body: body, headers: @header_xapix) 

end 

def get_new_message
	@received_messages[0]["from"]=="+16175832486"
end 


send_message("Hi! You just had a meeting. Who did you meet with?")
sleep(10) #until get_new_message # How do I tell the App to wait until it gets a new message?
send_message("What important things did you talk about?")
sleep(10) #until get_new_message 
send_message("Any follow-ups?")
sleep(10) #until get_new_message 

puts "You met with:" + @received_messages[4]['body']
puts "You have talked about:" + @received_messages[2]['body']
puts "You need to follow up with:" + @received_messages[0]['body']




