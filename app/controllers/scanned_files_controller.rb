class ScannedFilesController < ApplicationController

  respond_to :json, :xml

  def index
    @scanned_files = ScannedFile.all
    respond_with @scanned_files.to_a
  end

  def show
    @scanned_file = ScannedFile.criteria.id(params[:id]).to_a
    respond_with @scanned_file
  end
end
