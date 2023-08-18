class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :passowed_digest, :email
end
