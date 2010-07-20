class Admin::TutorialsController < Admin::BaseController

  crudify :tutorial, :title_attribute => :title

end
