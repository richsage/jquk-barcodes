class Delegate < ActiveRecord::Base
  attr_accessor :delegate_id, :first_name, :last_name, :email_address, :company

  def full_name
    "#{first_name} #{last_name}".lstrip.rstrip
  end
end
