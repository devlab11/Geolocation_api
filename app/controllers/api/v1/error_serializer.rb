module Api
  module V1
    class ErrorSerializer < ActiveModel::Serializer
      attributes :success, :error, :code, :type, info
    end
  end
end
