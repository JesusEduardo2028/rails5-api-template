module Helpers
  #parse hash to json 
  def json(body)
    JSON.parse(body,symbolize_names: true)
  end

  #login and return access token
  def login_user(user)
    user_params = { params: {email: user.email, password: "12345678" } }
    post "/auth/sign_in", user_params
    response.header['access-token']
  end
end