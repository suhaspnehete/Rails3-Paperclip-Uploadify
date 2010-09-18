class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.xml
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    @upload = Upload.find(params[:id], :include => :user)
    @total_uploads = Upload.find(:all, :conditions => { :user_id => @upload.user.id})
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.xml
  def create
      newparams = coerce(params)
      @upload = Upload.new(newparams[:upload])
      if @upload.save
        flash[:notice] = "Successfully created upload."
        respond_to do |format|
          format.html {redirect_to @upload.user}
          format.json {render :json => { :result => 'success', :upload => upload_path(@upload) } }
        end
      else
        render :action => 'new'
      end
    end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to(@upload, :notice => 'Upload was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to(uploads_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def coerce(params)
    if params[:upload].nil? 
      h = Hash.new 
      h[:upload] = Hash.new 
      h[:upload][:user_id] = params[:user_id] 
      h[:upload][:photo] = params[:Filedata] 
      h[:upload][:photo].content_type = MIME::Types.type_for(h[:upload][:photo].original_filename).to_s
      h
    else 
      params
    end 
  end
  
end
