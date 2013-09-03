class AccessToken < OAuth2::AccessToken
  attr_reader :token_bearer

  def initialize(oauth_client, token_bearer)
    @token_bearer = token_bearer
    super(oauth_client, token_bearer.token, refresh_token: token_bearer.refresh_token,
                                            expires_at: token_bearer.expires_at)
  end

  def access_token
    if expired?
      new_token = self.refresh!
      token_bearer.token = new_token.token
      token_bearer.refresh_token = new_token.refresh_token
      token_bearer.expires_at = new_token.expires_at
      token_bearer.save!
    end
    new_token || self
  end
end
