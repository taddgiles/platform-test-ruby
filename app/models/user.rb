class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: :true, presence: :true

  def as_json(options={})
    super(
      except: [:password_digest]
    )
  end
end
