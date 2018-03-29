# Copyright (C) 2018 Hermann Detz
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

require "cell"
require "metadata"

module JupyterNB
	class Generator
		# Array of cells (markdown, code, ...) that should be generated within the notebook
		@cells = []

		# Defines the indent for output lines (used by Helpers module)
		@indent = 0

		# Stores a metadata object
		@metadata = nil

		# Default constructor
		# @param lang can be either :ruby or :python3
		def initialize(lang)
			@cells = Array.new
			
			if ((lang == :ruby) or (lang == :python3))
				@metadata = Metadata.new(lang)
			end
		end

		# Returns a string that contains an IPython Notebook
		def generate
			# start with 1 because everything is encapsulated within {} 
			# at indent 0
			@indent = 1
			result = ""
			result << "{\n"

			if (@cells.nil? == false) and (@cells.size > 0)
				result << open_array("cells")

				@cells.each do |c|
						last = false
						(c == @cells.last) ? last = true : last = false

						result << c.generate(@indent, last)
				end

				result << close_array
			end

			result << generate_metadata
			result << generate_versioninfo
			result << "}"

			return result
		end

		# Adds a content cell to the notebook to be generated
		# @param [String] type defines the type of the cell (markdown, code, ...)
		# @param metadata can be given as a string with linebreaks or as an array of strings
		# @param outputs can be given as a string with linebreaks or as an array of strings		def add_cell(type,metadata,outputs,source)
		# @param source can be given as a string with linebreaks or as an array of strings
		def add_cell(type,metadata,outputs,source)
			@cells << Cell.new(type,metadata,outputs,source)
		end

		private

		include JupyterNB::Helpers

		# Returns a string containing the metadata of the IPython Notebook
		def generate_metadata
			return @metadata.generate(@indent)
		end

		# Returns a string that contains the version information of the
		# IPython Notebook
		# The values are reverse engineered from a jupyterhub project.
		def generate_versioninfo
			result = ""
			result << add_field("nbformat", 4)
			result << add_field("nbformat_minor", 2, true)
			return result
		end
	end
end

