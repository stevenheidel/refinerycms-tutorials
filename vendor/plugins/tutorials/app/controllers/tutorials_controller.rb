class TutorialsController < ApplicationController

  before_filter :find_all_tutorials
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @tutorial in the line below:
    present(@page)
  end

  def show
    @tutorial = Tutorial.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @tutorial in the line below:
    present(@page)
  end

protected

  def find_all_tutorials
    @tutorials = Tutorial.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/tutorials")
  end

end
