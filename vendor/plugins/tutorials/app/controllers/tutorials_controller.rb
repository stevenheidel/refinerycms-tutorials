class TutorialsController < ApplicationController

  before_filter :find_all_tutorials, :except => [:tagged]
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @tutorial in the line below:
    present(@page)
  end

  def show
    @tutorial = Tutorial.live.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @tutorial in the line below:
    present(@page)
  end
  
  def tagged
    @tutorials = Tutorial.tagged_with(params[:tag]).live
    render :action => 'index'
  end

protected

  def find_all_tutorials
    @tutorials = Tutorial.live.find(:all, :order => "position ASC")
  end

  def find_page
    @page = Page.find_by_link_url("/tutorials")
  end

end
