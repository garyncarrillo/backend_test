class MyCustomStrategy
  def self.jwt_revoked?(payload, user)
    false
  end
end