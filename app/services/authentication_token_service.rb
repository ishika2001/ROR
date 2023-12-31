# frozen_string_literal: true

# app/services/authentication_token_service.rb
class AuthenticationTokenService
  def self.encode_token(user_id)
    exp = 24.hours.from_now.to_i
    payload = { user_id: user_id, exp: exp }
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    # return user if user&.authenticate(password)
    return user if user && user.valid_password?(password)
    nil
  end
end
