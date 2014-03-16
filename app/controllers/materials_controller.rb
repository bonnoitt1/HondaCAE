class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all
    @testfiles = Testfile.all
  end


  # GET /materials/1
  # GET /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to @material, notice: 'Material was successfully created.' }
        format.json { render action: 'show', status: :created, location: @material }
      else
        format.html { render action: 'new' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    @testfiles = Testfile.find(:all, :conditions => [ "mat_name = ? AND mat_type = ?", @material.mat_name, @material.mat_type])
    @testfiles.each do |testfile|
	testfile.destroy
    end
    #find(:all, :conditions => ["name LIKE ? AND active = ?", "%#{search}%", 1])
   respond_to do |format|
      format.html { redirect_to materials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
      #@testfile = Testfile.find(params[:mat_name, :mat_type])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:mat_name, :mat_type, :density, :elastic_modulus, :shear_modulus, :poissons_ratio, :yield_strength, :ultimate_tensile_strength, :ultimate_total_elongation, :hardness_value, :melting_point, :thermal_expansion, :thermal_conductivity, :specific_heat, :electrical_resistivity, :chemical_composition)
    end
end