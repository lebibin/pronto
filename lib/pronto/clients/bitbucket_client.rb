class BitbucketClient
  include HTTParty

  class << self
    def base_uri_v1
      'https://api.bitbucket.org/1.0'
    end
  end

  base_uri 'https://api.bitbucket.org/2.0'

  def initialize(username, password)
    credentials = { username: username, password: password }
    validate! credentials
    @headers = { basic_auth: credentials }
  end

  def commit_comments(slug, sha)
    endpoint = "/changesets/#{sha}/comments"
    url = "#{self.class.base_uri_v1}/repositories/#{slug}#{endpoint}"
    response = self.class.get(url, @headers)
    openstruct(response.parsed_response)
  end

  def create_commit_comment(slug, sha, body, path, position)
    options = {
      body: {
        content: body,
        line_to: position,
        filename: path
      }
    }
    options.merge!(@headers)
    endpoint = "/changesets/#{sha}/comments"
    url = "#{self.class.base_uri_v1}/repositories/#{slug}#{endpoint}"
    self.class.post(url, options)
  end

  def pull_comments(slug, pr_id)
    endpoint = "/pullrequests/#{pr_id}/comments"
    url = "#{self.class.base_uri}/repositories/#{slug}#{endpoint}"
    response = self.class.get(url, @headers)
    values = parse(response)
    openstruct(values)
  end

  def pull_requests(slug)
    endpoint = '/pullrequests?state=OPEN'
    url = "#{self.class.base_uri}/repositories/#{slug}#{endpoint}"
    response = self.class.get(url, @headers)
    values = parse(response)
    openstruct(values)
  end

  def create_pull_comment(slug, pull_id, body, path, position)
    options = {
      body: {
        content: body,
        line_from: position,
        filename: path
      }
    }
    options.merge!(@headers)
    endpoint = "/pullrequests/#{pull_id}/comments"
    url = "#{self.class.base_uri_v1}/repositories/#{slug}#{endpoint}"
    self.class.post(url, options)
  end

  def openstruct(response)
    response.map { |r| OpenStruct.new(r) }
  end

  private
  def validate!(credentials)
    username = credentials[:username]
    password = credentials[:password]
    raise ArgumentError if [username, password].any?{|c| c.nil? || c.empty? }
  end

  def parse(response)
    if response.code == 200
      response.parsed_response['values']
    else
      raise Exception.new(response.response)
    end
  end
end
