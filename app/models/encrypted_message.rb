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
  
  def encrypt_text(text)
    crypto = GPGME::Crypto.new(armor: true)
    crypto.encrypt(text, recipients: recipient_keys)
  end
  
  #############################
  protected
  
  # The keys of the parties to receive this data
  # This could presumably be specified in a database, rather than hard coded.
  # The choice is left to the developer who is adopting this test to their own purposes.
  def recipient_keys
    ['frank@rietta.com']
  end
  
  def structured_plaintext
    raise MUST_IMPLEMENT
  end
  
  def body_plaintext
    raise MUST_IMPLEMENT
  end
end
