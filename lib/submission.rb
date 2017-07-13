module Submission
  def create_submission(checkpoint_id, assignment_branch=nil, assignment_commit_link=nil, comment=nil)
    enrollment_id = self.get_me["current_enrollment"]["id"]
    response = self.class.post(
        "/checkpoint_submissions",
        headers: { "authorization" => @auth_token },
        body: {"checkpoint_id": checkpoint_id,
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "comment": comment,
        "enrollment_id": enrollment_id
        })
    puts response
    raise 'Unable to post submission' if response.code != 200
  end
  
  def update_submission(id, checkpoint_id, assignment_branch=nil, assignment_commit_link=nil, comment=nil)
    enrollment_id = self.get_me["current_enrollment"]["id"]
    response = self.class.put(
        "/checkpoint_submissions/#{id}",
        headers: { "authorization" => @auth_token },
        body: {#"id": id,
        "checkpoint_id": checkpoint_id,
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "comment": comment,
        "enrollment_id": enrollment_id
        })
    puts response
    raise 'Unable to update submission' if response.code != 200
    @submissions = JSON.parse(response.body)
  end
  
end

