# Copyright (C) 2018 Hermann Detz
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

module JupyterNB
	module Helpers
		# Returns a string that contains a single automatically indented string
		#
		# This is used to output source code within cells.
		# @param [String] str contains the string to be indented and contained in ""
		def add_string(str)
			line = ""
			@indent.times do line << " " end
			line << "\"#{str}\\n\""
			return line
		end

		# Returns a string that contains a single field for a notebook
		#
		# This is e.g. used to output the cell type:
		#   "cell_type": "code",
		#
		# @param [String] name Name of the field (e.g. cell_type)
		# @param value can be a String or Integer
		# @param [Boolean] last if set to true, the trailing ',' is omitted
		def add_field(name, value, last=false)
			line = ""
			@indent.times do line << " " end

			line << "\"#{name}\": "
			
			line << "\"#{value}\"" if value.is_a?(String)
			line << "#{value}" if value.is_a?(Integer)
			
			last ? line << "\n" : line << ",\n"

			return line
		end

		# Returns a string that opens a group within a notebook
		# The indentation is automatically increased by one.
		#
		# This is e.g. used to output the metadata:
		#   "metadata": {
		#
		# @param [String] name Name of the group (e.g. metadata)
		def open_group(name="")
			line = ""
			@indent.times do line << " " end

			if name != ""
				line << "\"#{name}\": {\n"
			else
				line << "{\n"
			end

			@indent += 1

			return line
		end

		# Returns a string that closes a group within a notebook
		# The indentation is automatically decreased by one.
		#
		# This is e.g. used to close the metadata:
		#   },
		#
		# @param [Boolean] last if set to true, the trailing ',' is omitted
		def close_group(last=false)
			# decrease indent first to bring closing bracked to the
			# same indent as opening bracket
			@indent -= 1

			line = ""
			@indent.times do line << " " end

			line << "}"
			last ? line << "\n" : line << ",\n"

			return line
		end

		# Returns a string that opens a group within a notebook
		# The indentation is automatically increased by one.
		#
		# This is e.g. used to output the cells:
		#   "cells": [
		#
		# @param [String] name Name of the array (e.g. cells)
		def open_array(name)
			line = ""
			@indent.times do line << " " end

			line << "\"#{name}\": [\n"

			@indent += 1

			return line
		end

		# Returns a string that closes a group within a notebook
		# The indentation is automatically decreased by one.
		#
		# This is e.g. used to close the metadata:
		#   ],
		#
		# @param [Boolean] last if set to true, the trailing ',' is omitted
		def close_array(last=false)
			# decrease indent first to bring closing bracked to the
			# same indent as opening bracket
			@indent -= 1

			line = ""
			@indent.times do line << " " end

			line << "]"
			last ? line << "\n" : line << ",\n"

			return line
		end
	end
end
