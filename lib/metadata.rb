# Copyright (C) 2018 Hermann Detz
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

module JupyterNB
	class Metadata
		# Defines the indent for output lines (used by Helpers module)
		@indent = 0
		@kernel = {}
		@langinfo = {}

		# Constructor
		# @param lang can be either :ruby or :python3
		def initialize(lang)
			@kernel = {}
			@langinfo = {}

			case lang
			when :ruby then initialize_ruby
			when :python3 then initialize_python3
			when :julia then initialize_julia
			end
		end

		# Returns a string containing the metadata of the IPython Notebook
		# @param [Integer] indent defines the indentation of the generated output.
		def generate(indent=0)
			@indent = indent

			result = ""
			result << open_group("metadata")
			result << open_group("kernelspec")
			result << add_field("display_name", @kernel[:displayname])
			result << add_field("language", @kernel[:language])
			result << add_field("name", @kernel[:name], true)
			result << close_group
			result << open_group("language_info")
			result << add_field("file_extension", @langinfo[:fileext])
			result << add_field("mimetype", @langinfo[:mime])
			result << add_field("name", @langinfo[:name])
			result << add_field("version", @langinfo[:version], true)
			result << close_group(true)
			result << close_group
			return result
		end


		private

		include JupyterNB::Helpers

		# Initialize metadata for Ruby kernel
		def initialize_ruby
			@kernel[:language] = "ruby"
			@kernel[:name] = "ruby"
			@kernel[:displayname] = "Ruby #{RUBY_VERSION}"

			@langinfo[:name] = "ruby"
			@langinfo[:fileext] = ".rb"
			@langinfo[:mime] = "application/x-ruby"
			@langinfo[:version] = RUBY_VERSION
		end

		# Initialize metadata for Python 3 kernel
		def initialize_python3
			@kernel[:language] = "python"
			@kernel[:name] = "python3"
			@kernel[:displayname] = "Python 3"

			@langinfo[:name] = "python"
			@langinfo[:fileext] = ".py"
			@langinfo[:mime] = "text/x-python"

			# Check for python3
			`which python3`
			if $?.success?
				@langinfo[:version] = `python3 -V`.split(' ').last
			else
				# Fall back to initial 3.0 release, if no python3 executable is found
				@langinfo[:version] = '3.0'
			end
		end

		# Initialize metadata for Julia kernel
		def initialize_julia
			@kernel[:language] = "julia"

			`which julia`
			if $?.success?
				# returns the first two version numbers e.g. 1.0,
				# also works for multiple digit version numbers
				@langinfo[:version] = `julia -v`.split(' ').last

			else
				@langinfo[:version] = '1.0'
			end

			@kernel[:language] = "julia"
			@kernel[:name] = "julia-#{@langinfo[:version][0..@langinfo[:version].rindex('.')-1]}"
			@kernel[:displayname] = "Julia #{@langinfo[:version]}"

			@langinfo[:name] = "julia"
			@langinfo[:fileext] = ".jl"
			@langinfo[:mime] = "application/julia"
		end

	end
end

