require 'httparty'
require 'json'
require_relative 'roadmap'
require_relative 'messages'

class Kele
  include HTTParty
  include Roadmap
  include Messages
  base_uri 'https://www.bloc.io/api/v1'
  
  def initialize(email, password)
    response = self.class.post(
        '/sessions', 
        body: { 
            email: email, 
            password: password 
        })
    raise 'Unable to start session' if response.code != 200
    @auth_token = response["auth_token"]
  end
  
  def get_me
    response = self.class.get(
      '/users/me', 
      headers: { "authorization" => @auth_token })
    raise 'Unable to get user info' if response.code != 200
    @user_data = JSON.parse(response.body)
  end
  
  def get_mentor_availability(mentor_id)
    response = self.class.get(
      "/mentors/#{mentor_id}/student_availability", 
      headers: { "authorization" => @auth_token })
    raise 'Unable to get mentor availability' if response.code != 200
    @mentor_availability = JSON.parse(response.body)
  end
  
end
