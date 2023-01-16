module Api::V1  
  class GeolocationsController < ApplicationController
    respond_to? :json 
    
      #GET /geolocations
      def index    
          @message = Geolocation.all
          render json: @message    
      end
    
      #POST /geolocations
      def create      
        if @message = Geolocation.where(ip: geo_params['ip']).first       
          render json: {status:'SUCCESS', message: 'IP already exist in DB', data: @message}, status:200
        else
          #geo_location = IpToLocation.fetch(geo_params['ip']) 
          geo_location = IpstackService::Api::V1::GetClient.get_request(geo_params['ip'])   
          puts "geo_location #{geo_location}"  
          if geo_location["success"] == false  
            logger.error "Error with service provider #{ENV['SERVICE_PROVIDER_IPSTACK']} ip: #{geo_params['ip']}, responce: #{geo_location}"       
            render json: {status:'ERROR', message: "Error with service provider", data: geo_location["error"]["type"]}, status: 404  
          else          
            @message = Geolocation.create()
            @message.ip = geo_params['ip']
            @message.location_data = geo_location        
            if @message.save
              render json: {status:'SUCCESS', message: "Saved IP", data: @message}, status: 200
            else
              render json:{status:'ERROR', message: "IP not saved", data: @message.errors}, status: 400
            end     
          end
        end      
      end
    
      #GET /geolocations/:id
      def show
        @message = Geolocation.find(params[:id])
        render json: @message
      end
    
      # #PUT /geolocations/:id
      # def update
      #   @message = Geolocation.find(params[:id])       
      #   if @message.update_atttributes(geo_params)
      #     render json: {status:'SUCCESS', message: 'IP successfully updated', data: @message}, status:200
      #   else  
      #     render json: {status:'ERROR', message: 'IP not update ', data: @message.errors}, status:400
      #   end     
      # end
    
      #DELETE /geolocations/:id
      def destroy      
        @message = Geolocation.find(params[:id])        
        if @message.destroy
          render json: {status:'SUCCESS', message: 'IP successfully deleted', data: @message}, status:200 
        else  
          render json: {status:'ERROR', message: 'IP not deleted', data:@message.errors}, status:400
        end     
      end
      
      private  
    
      def geo_params
        params.require('geolocation').permit(:ip)
      end  

  end    
end
 
  