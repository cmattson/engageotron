class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @newest = Contact.newest
  end
  
  # Upload a member roster for processing.
  def upload_roster
  end

  def process_roster
    newcsv = params[:roster_csv].tempfile
    #if 
      RosterImporter.new.process(newcsv)
    #  flash.now[:notice] = 'Import completed successfully!'
    #else
    #  flash.now[:notice] = 'Could not recognize file format.'
    #end
    redirect_to dashboard_index_path
  end
  
  # At-a-glance view of useful member statistics
  def at_a_glance
  end
  
  # Upload an event attendance report for processing.
  def upload_event
  end
end
