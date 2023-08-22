class User < ApplicationRecord
    def password_digest=(password_digest)
        @password_digest = password_digest
        self.password_salt = SecureRandom.hex(10)
        self.password_hash = BCrypt::Password.create(password_digest, salt: password_salt)
      end
    # validates :username, presence: true, uniqueness: true 

    def authenticate(password)
        user = User.find_by(username: username)
        if user && user.password == password
            return user
        else
            return nil
        end
      end
end
