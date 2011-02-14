require 'spec_helper'

describe RailsBestPractices::Reviews::ReplaceInstanceVariableWithLocalVariableReview do
  before(:each) do
    @runner = RailsBestPractices::Core::Runner.new(RailsBestPractices::Reviews::ReplaceInstanceVariableWithLocalVariableReview.new)
  end

  it "should replace instance variable with local varialbe" do
    content = <<-EOF
    <%= @post.title %>
    EOF
    @runner.review('app/views/posts/_post.html.erb', content)
    errors = @runner.errors
    errors.should_not be_empty
    errors[0].to_s.should == "app/views/posts/_post.html.erb:1 - replace instance variable with local variable"
  end

  it "should replace instance variable with local varialbe in haml file" do
    content = <<-EOF
= @post.title
    EOF
    @runner.review('app/views/posts/_post.html.haml', content)
    errors = @runner.errors
    errors.should_not be_empty
    errors[0].to_s.should == "app/views/posts/_post.html.haml:1 - replace instance variable with local variable"
  end

  it "should not replace instance variable with local varialbe" do
    content = <<-EOF
    <%= post.title %>
    EOF
    @runner.review('app/views/posts/_post.html.erb', content)
    errors = @runner.errors
    errors.should be_empty
  end
end