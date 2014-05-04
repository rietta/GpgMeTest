class Post < EncryptedMessage
  
  attr_accessor :subject, :body, :url
  
  validates :subject, presence: true
  validates :body, presence: true
  
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
end