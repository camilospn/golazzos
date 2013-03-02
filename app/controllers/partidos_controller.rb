class PartidosController < ApplicationController
  # GET /partidos
  # GET /partidos.json
  before_filter :require_login
  before_filter :require_admin_login , :only => [:new, :edit, :update, :destroy, :create, :repartir]
  def index
    @partidos = Partido.all
    
    @eliminatorias = Partido.where("torneo = ?", 2)
    @champions = Partido.where("torneo = ?", 1)
    @libertadores = Partido.where("torneo = ?", 3)
    @postobon = Partido.where("torneo = ?", 4)
    @bbva = Partido.where("torneo = ?", 5)
    @premier = Partido.where("torneo = ?", 6)

    @user_ranking = User.order("pezzos DESC").limit(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partidos }
    end
  end

  # GET /partidos/1
  # GET /partidos/1.json
  def show
    @partido = Partido.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partido }
    end
  end

  # GET /partidos/new
  # GET /partidos/new.json
  def new
    @partido = Partido.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partido }
    end
  end

  # GET /partidos/1/edit
  def edit
    @partido = Partido.find(params[:id])
  end

  # POST /partidos
  # POST /partidos.json
  def create
    @partido = Partido.new(params[:partido])

    respond_to do |format|
      if @partido.save
        format.html { redirect_to @partido, notice: 'Partido was successfully created.' }
        format.json { render json: @partido, status: :created, location: @partido }
      else
        format.html { render action: "new" }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partidos/1
  # PUT /partidos/1.json
  def update
    @partido = Partido.find(params[:id])

    respond_to do |format|
      if @partido.update_attributes(params[:partido])
        format.html { redirect_to @partido, notice: 'Partido was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partidos/1
  # DELETE /partidos/1.json
  def destroy
    @partido = Partido.find(params[:id])
    @partido.destroy

    respond_to do |format|
      format.html { redirect_to partidos_url }
      format.json { head :no_content }
    end
  end

  def repartir
    @partido = Partido.find(params[:id])
    if @partido.terminado && @partido.cerrado
      @partido.repartir_la_plata
      @partido.update_attributes(repartido: true)
      redirect_to partido_path(@partido), notice: "Se repartio la plata !"
    else
      redirect_to edit_partido_path(@partido), notice: "Asegurate de Cerrar la apuesta y de agregar el marcador"
    end
  end
end
