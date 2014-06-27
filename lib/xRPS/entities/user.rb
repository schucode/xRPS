

class User
  attr_reader :username, :password_digest

  def initialize(username, password_digest=nil)
    @username = username
    @password_digest = password_digest
  end
end