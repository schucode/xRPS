
module RPS
  class User
    attr_reader :username, :password_digest

    def initialize(username, password_digest=nil)
      @username = username
      @password_digest = password_digest
    end

    def update_password(password)
      @password_digest = Digest::SHA1.hexdigest(password)
    end

    def has_password?(password)
      if @password_digest != nil
        return true
      end
    end  
  end # class end
end # module end
