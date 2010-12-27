class ScannedFilesController < ApplicationController

  respond_to :json, :xml

  def index
    @scanned_files = ScannedFile.all
    respond_with @scanned_files.to_a
  end

  def show
    @scanned_file = ScannedFile.criteria.id(params[:id])
    respond_with @scanned_file.to_a
  end

  def create
    #TODO: Add some controls to merge with an existing file if it has the same hash or same host/directory
    #TODO: control the creation and generate an answer depending on the success of the operation. Sucess => send back the object in database. Error => Send back the error
    @scanned_file = ScannedFile.new(params[:scanned_file])
    @scanned_file.save
    respond_with @scanned_file.to_a
  end

end
