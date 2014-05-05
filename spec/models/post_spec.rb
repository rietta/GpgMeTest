require 'spec_helper'

describe 'Encrypted Post' do
  it 'Can encrypt a message' do
    post = Post.new(
        plaintext_description: 'Hello message.',
        delete_at: Date.today + 2.years,
        body: 'Hello, world.',
        subject: 'This is a test',
        url: 'http://rietta.com/blog/'
      )
    post.should be_valid
  end
end