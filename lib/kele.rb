require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  
  def initialize(email, password)
    response = self.class.post(
        '/sessions', 
        body: { 
            email: email, 
            password: password 
        })
    raise 'Unable to start sessoion' if response.code != 200
    @auth_token = response["auth_token"]
  end
  
  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    raise 'Unable to get info' if response.code != 200
    @user_data = JSON.parse(response.body)
  end
end
