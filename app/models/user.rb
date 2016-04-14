class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :name, type: :string
  field :email, type: :string
  field :password_digest, type: :string

  index({ email: 1 }, { unique: true })

  has_secure_password

  validates :email, uniqueness: :true, presence: :true

  def as_json(options={})
    super(
      except: [:password_digest, :_id]
    ).merge(
      id: _id.to_s
    )
  end
end
