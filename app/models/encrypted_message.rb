# == Schema Information
#
# Table name: encrypted_messages
#
#  id                        :integer          not null, primary key
#  type                      :string(255)      not null
#  plaintext_description     :string(255)
#  delete_at                 :date             not null
#  encrypted_body            :text
#  encrypted_structured_body :text
#  created_at                :datetime
#  updated_at                :datetime
#

class EncryptedMessage < ActiveRecord::Base
  MUST_IMPLEMENT = 'Must be implemented by a subclass.'
  
  # The database does not let these fields be nil, so the presence is needed.
  validates :delete_at, presence: true
  validates :type, presence: true
  
  #############################
  protected
  
  def structured_plaintext
    raise MUST_IMPLEMENT
  end
  
  def body_plaintext
    raise MUST_IMPLEMENT
  end
end
