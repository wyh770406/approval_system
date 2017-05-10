# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#

class User < ApplicationRecord
  has_secure_password
end
