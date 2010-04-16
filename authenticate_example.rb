def authenticate_me(com)
  com.key = ''
  com.identity_v1.authenticate :username => '', :password => ''
end