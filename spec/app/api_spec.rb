require_relative '../spec_helper'

describe "GraphQL API" do
  it "should allow accessing the home page" do
    get '/'
    # Rspec 2.x
    expect(last_response).to be_ok
  end

  it "render users" do
    get '/users.json'
    expect(last_response).to be_ok
  end
end
