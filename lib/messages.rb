module Messages
  def get_messages(page = nil)
    if page #returns specific page of messages entered
        response = self.class.get(
            "/message_threads/", 
            headers: { "authorization" => @auth_token },
            body: { "page": page })
    else #returns all messages if no page entered 
        response = self.class.get(
            "/message_threads/", 
            headers: { "authorization" => @auth_token })
    end
    raise 'Unable to get messages' if response.code != 200
    @messages = JSON.parse(response.body)
  end
  
  # create_message returns "success: true" from mock server though not in production.
  # Code 500 returned in production "message": "There was an error processing the message."
  # Code 500 is also returned from Bloc's own production example.
  # Bloc's example http://docs.blocapi.apiary.io/#reference/0/messages/create-message 
  def create_message(sender, recipient_id, subject, stripped_text, token=nil)
    response = self.class.post(
        "/messages", #mock-server "https://private-anon-cf59119fcc-blocapi.apiary-mock.com/api/v1/messages"
        headers: { "authorization" => @auth_token },
        body: {"sender": sender,
        "recipient_id": recipient_id,
        "subject": subject,
        "stripped-text": stripped_text,
        "token": token
        })
    puts response
    raise 'Unable to post message' if response.code != 200
    @message_confirmed = JSON.parse(response.body)
  end
  
end