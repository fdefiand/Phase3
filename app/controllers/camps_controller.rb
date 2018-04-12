class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]

  # GET /camps
  # GET /camps.json
  def index
    @camps = Camp.all
    @active_camps = Camp.all.active.alphabetical.paginate(:page => params[:active_camps]).per_page(5)
    @inactive_camps = Camp.all.inactive.alphabetical.paginate(:page => params[:inactive_camps]).per_page(5)
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
    @camps = Camp.all.alphabetical
  end

  # GET /camps/new
  def new
    @camp = Camp.new
  end

  # GET /camps/1/edit
  def edit
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)
    
    if @camp.save
      redirect_to camp_path(@camp), notice: "#{@camp.name} was created. can't be blank"
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp.destroy
    redirect_to camps_url: "#{@camp.name} was destroyed"
    
    respond_to do |format|
      format.html { redirect_to camps_url, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active)
    end
end
