class User < ActiveRecord::Base
  has_many :uploads, :dependent => :destroy
end
