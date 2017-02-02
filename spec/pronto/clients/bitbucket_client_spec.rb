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
        'username',
        'password'
      )
    end
    # let!(:slug){ 'team/repo' }
    # it 'returns BitbucketClient instance' do
    #   (subject).should be_a(BitbucketClient)
    # end
    # describe '#pull_requests' do
    #   it 'returns array of pull requests' do
    #     (valid_client.pull_requests(slug)).should be_a(Array)
    #   end
    # end
    # describe '#pull_comments' do
    #   it 'returns pull request comments' do
    #     (valid_client.pull_comments(slug, 15)).should be_a(Array)
    #   end
    # end
    # describe '#commit_comments' do
    #   it 'returns commit comments' do
    #     (valid_client.commit_comments(slug,'full_sha')).should be_a(Array)
    #   end
    # end
    # describe '#create_commit_comment' do
    #   it 'creates commit comment' do
    #     lambda { valid_client.create_commit_comment(slug, 'full_sha', 'message', 'path_to_file', 'line_number'.to_i)}.should_not raise_error
    #   end
    # end
    # describe '#create_pull_comment' do
    #   it 'creates pull request comment' do
    #     lambda {valid_client.create_pull_comment(slug, 'pull_request_id'.to_i, 'This is another sample comment', 'path_to_file', 'line_number'.to_i)}.should_not raise_error
    #   end
    # end
  end
  describe '.base_uri' do
    it 'returns https://api.bitbucket.org/2.0' do
      (described_class.base_uri).should eq('https://api.bitbucket.org/2.0')
    end
  end
  describe '.base_uri_v1' do
    it 'returns https://api.bitbucket.org/1.0' do
      (described_class.base_uri_v1).should eq('https://api.bitbucket.org/1.0')
    end
  end
end
