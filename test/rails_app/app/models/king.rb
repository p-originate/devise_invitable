# This model has additional construction requirements, namely that
# approved field must be set for validations to pass.
class King < PARENT_MODEL_CLASS
  if DEVISE_ORM == :mongoid
    include Mongoid::Document
    ## Database authenticatable
    field :email,              :type => String, :null => false, :default => ""
    field :encrypted_password, :type => String, :null => false, :default => ""

    ## Confirmable
    field :confirmation_token,   :type => String
    field :confirmed_at,         :type => Time
    field :confirmation_sent_at, :type => Time
    field :unconfirmed_email,    :type => String # Only if using reconfirmable

  end

  devise :database_authenticatable, :validatable, :registerable
  include DeviseInvitable::Inviter
  
  # Note that approved attribute is intentionally not attr_accessible.
  # It is supposed to be set by the application code only, not by users.
  attr_accessor :approved
  validates_presence_of :approved
  
  # This is a user-settable attribute that triggers approval processing
  # in the application code.
  attr_accessor :approval_requested
end
