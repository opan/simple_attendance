class UserRepository < Hanami::Repository
  def create_with_password(params)
    return nil if params[:password] != params[:password_confirmation]

    enc_password = BCrypt::Password.create(params[:password])
    create(
      username: params[:username],
      email: params[:email],
      encrypted_password: enc_password,
      last_signed_in: Time.now.utc
    )
  end

  def authenticate!(username, password)
    user = users.
      where(username: username).
      first

    return nil if user.nil?

    if BCrypt::Password.new(user.encrypted_password) == password
      user
    else
      nil
    end
  end
end
