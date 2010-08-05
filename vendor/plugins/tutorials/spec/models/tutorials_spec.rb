require 'spec_helper'

describe Tutorial do
  it "should have tags" do
    @tutorial = Tutorial.create!({
      :title => 'My tutorial',
      :description => 'blah',
      :category => 'Beginner',
      :author => 'Joe Sak',
      :content => 'This is how to add tags to tutorials',
      :tag_list => 'tutorials, theming, help, extending, open source'
    })
    Tutorial.tagged_with('help').should include(@tutorial)
  end
end