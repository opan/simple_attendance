class User < Hanami::Entity
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  attributes do
    attribute :username, Types::Strict::String.constrained(max_size: 100, min_size: 3)
    attribute :email, Types::Strict::String.constrained(format: EMAIL_REGEX)
    attribute :password, Types::Strict::String
    attribute :password_confirmation, Types::Strict::String
    # attribute :signed_in, Types::Strict::Bool
    # attribute :created_at, Types::Strict::DateTime
    # attribute :updated_at, Types::Strict::DateTime
  end
end
