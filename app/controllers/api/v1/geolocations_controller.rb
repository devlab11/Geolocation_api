module Api::V1
  class GeolocationsController < ApplicationController
    respond_to? :json

    # GET /geolocations
    def index
      @message = Geolocation.all
      render json: @message
    end

    # POST /geolocations
    def create
      if (@message = Geolocation.where(ip: geo_params['ip']).first)
        render json: { status: 'SUCCESS', message: 'IP already exist in DB', data: @message }, status: 200
      else
        geo_location = get_geo_location(geo_params['ip'])
        @message = Geolocation.create
        @message.ip = geo_params['ip']
        @message.location_data = geo_location.body
        if @message.save
          render json: { status: 'SUCCESS', message: 'Saved IP', data: @message }, status: :created
        else
          render json: { errors: [{ title: 'ERROR',
                                    status: '400',
                                    detail: 'IP not saved',
                                    data: @message.errors }] }, status: 400
        end
      end
    end

    def get_geo_location(ip)
      geo_location = IpstackService::Api::V1::GetClient.get_request(ip)
    end

    # GET /geolocations/:id
    def show
      @message = Geolocation.find(params[:id])
      render json: @message
    end

    # DELETE /geolocations/:id
    def destroy
      @message = Geolocation.find(params[:id])
      if @message.destroy
        render json: { status: 'SUCCESS', message: 'IP successfully deleted', data: @message }, status: 200
      else
        render json: { errors: [{ title: 'ERROR',
                                  status: '400',
                                  detail: 'IP not deleted',
                                  data: @message.errors }] }, status: 400
      end
    end

    private

    def geo_params
      params.require('geolocation').permit(:ip)
    end
  end
end
