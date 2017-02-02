require 'spec_helper'

describe BitbucketClient do
  describe '.base_uri' do
    it 'returns https://api.bitbucket.org/2.0' do
      (described_class.base_uri).should eq('https://api.bitbucket.org/2.0')
    end
  end
end
