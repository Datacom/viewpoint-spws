#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
module Viewpoint
  module SPWS
    module Parser

      def initialize(response)
        # Unwrap SOAP Envelope
        @response = (response/'//soap:Body/*').first
        @response_type = @response.native_element.name
      end

      def parse(opts)
        resp_method = ruby_case(@response_type)
        if(method_exists?(resp_method))
          method(resp_method).call(opts)
        else
          @response
        end
      end

      private
      
      # CamelCase to ruby_case
      # This is used to turn the response message into the correct ruby method for parsing
      def ruby_case(string)
        string.split(/(?=[A-Z])/).join('_').downcase
      end
      
      def method_exists?(method_name)
        return self.methods.include?(method_name)
      end

    end # Parser
  end # SPWS
end # Viewpoint

require 'parsers/list_parser'
require 'parsers/copy_parser'
require 'parsers/usergroup_parser'
