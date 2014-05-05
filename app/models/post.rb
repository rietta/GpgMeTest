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

# © 2014 Rietta Inc. All Rights Reserved.

class Post < EncryptedMessage

  attr_accessor :subject, :body, :url

  validates :subject, presence: true
  validates :body, presence: true

  #############################################################
  # Data that the encrypted message needs to encode.
  def structured_plaintext
    {
      subject: subject,
      body: body,
      url: url,
    }
  end

  def body_plaintext
"
Subject:
#{subject}

URL:
#{url}

Message:
#{body}
"
  end
end # Post
