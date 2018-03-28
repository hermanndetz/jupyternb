# Copyright (C) 2018 Hermann Detz
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

require "helpers"

module JupyterNB
	class Cell
		# Cell type e.g. "code" or "markdown"
		@type = ""

		# Array of strings (lines) for metadata
		@metadata = []

		# Array of strings (lines) for source
		@source = []
		
		# Used in generate function, defined here because 
		# needed by Helpers mixin
		@indent = 1

		# Execution count of code cell (hardcoded to 0 because it's just generated)
		@count = 0

		# Constructor
		# @param [String] type defines the type of the cell (markdown, code, ...)
		# @param metadata can be given as a string with linebreaks or as an array of strings
		# @param outputs can be given as a string with linebreaks or as an array of strings		def add_cell(type,metadata,outputs,source)
		# @param source can be given as a string with linebreaks or as an array of strings
		def initialize(type, metadata, outputs, source)
			@type = type
			@metadata = read_parameter(metadata)
			@source = read_parameter(source)
			@count = 0
		end

		# Returns a string that contains an IPython Notebook cell
		#
		# The outputs field is not implemented yet. Should actually not be
		# necessary for a pure generator.
		# Generation of metadata within the cell is also not yet implemented.
		#
		# @param [Integer] indent defines the indentation of the cell content
		# @param [Boolean] last if set to true, the trailing ',' is omitted
		def generate(indent=1,last=false)
			@indent = indent

			result = ""
			result << open_group
			result << add_field("cell_type", @type)
			result << add_field("execution_count", @count) if (@type == "code")
			result << open_group("metadata")
			# not implemented yet
			result << close_group

			result << open_array("source")
			@source.each do |l|
				result << add_string(l)

				(l == @source.last) ? result << "\n" : result << ",\n"
			end
			result << close_array(true)
			result << close_group(last)

			return result
		end

		private

		# Returns an array of strings for multi-line parameters like metadata or source
		# @param param can be given as a string with linebreaks or as an array of strings
		def read_parameter (param)
			result = []
			
			unless (param.nil? == true)
				if param.is_a?(String)
					param.each_line do |l|
						result << l.chomp
					end
				elsif param.is_a?(Array)
					param.each do |l|
						next unless l.is_a?(String)

						result << l
					end
				end
			end

			return result
		end

		include JupyterNB::Helpers
	end
end

