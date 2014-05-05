require 'spec_helper'

describe 'Encrypted Post' do

  before(:each) do
    @basics = {
      plaintext_description: "Hello #{SecureRandom.hex(12)}",
      body: SecureRandom.hex(24),
      subject: 'This is a test',
      url: 'http://rietta.com/blog/'
    }
  end

  it 'Can encrypt a message' do
    post = Post.new(@basics.merge(delete_at: Date.today + 2.years))
    post.should be_valid
  end

  it 'Cannot save a message that expires in the past' do
    post = Post.new(@basics.merge(delete_at: Date.today - 1.day))
    post.should be_invalid
  end
end