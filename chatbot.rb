# Welcome to our Sample Chatbot App, powered by Chatbot
require 'HTTParty'


@header = {
  "Accept": "application/json",
  "Authorization": "chatbot:Cq2Og81xi48n3eZz6dQRWGuKVAsbwLj2"
}

received_message_url = "https://xap.ix-io.net/api/v1/twilio/messages?filter%5Baccount_sid%5D=AC0d8bb04ed7587bb49fdccc8ca5cff8fc&fields%5Bmessages%5D=page_size&include=messages&sort=account_sid&page%5Bnumber%5D=1&page%5Bsize%5D=100" 



received_messages = HTTParty.get(received_message_url, headers: @header)

puts received_messages # why it doesn't have the second array?

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

	send_message = HTTParty.post(send_message_url, body: body, headers: @header) 

end 

send_message("Hi! You just had a meeting. Who did you meet with?")
sleep(1) until get_new_message # How do I tell the App to wait until it gets a new message?
latest_message = get_message
send_message("What important things did you talk about?")
send_message("Any follow-ups?")




