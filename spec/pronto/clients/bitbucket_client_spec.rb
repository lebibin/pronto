require 'spec_helper'

describe BitbucketClient do
  context 'initialized with invalid credentials' do
    it 'raises ArgumentError if no credentials are passed' do
      lambda { described_class.new }.should raise_error(ArgumentError)
    end
    it 'raises ArgumentError if blank credentials are passed' do
      lambda { described_class.new('', '') }.should raise_error(ArgumentError)
    end
    it 'raises ArgumentError if nil credentials are passed' do
      lambda { described_class.new(nil, nil) }.should raise_error(ArgumentError)
    end
  end
  context 'initialized with valid credentials' do
    subject(:valid_client) do
      BitbucketClient.new(
        ENV['PRONTO_BITBUCKET_USERNAME'],
        ENV['PRONTO_BITBUCKET_PASSWORD']
      )
    end
    it 'returns BitbucketClient instance' do
      (subject).should be_a(BitbucketClient)
    end
  end
  describe '.base_uri' do
    it 'returns https://api.bitbucket.org/2.0' do
      (described_class.base_uri).should eq('https://api.bitbucket.org/2.0')
    end
  end
end
