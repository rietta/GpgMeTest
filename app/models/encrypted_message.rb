# == Schema Information
#
# Table name: encrypted_messages
#
#  id              :integer          not null, primary key
#  type            :string(255)
#  body            :text
#  structured_body :text
#  created_at      :datetime
#  updated_at      :datetime
#

class EncryptedMessage < ActiveRecord::Base
  MUST_IMPLEMENT = 'Must be implemented by a subclass.'
  #############################
  protected
  
  def structured_plaintext
    raise MUST_IMPLEMENT
  end
  
  def body_plaintext
    raise MUST_IMPLEMENT
  end
end
