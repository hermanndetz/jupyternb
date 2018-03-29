# Copyright (C) 2018 Hermann Detz
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

module JupyterNB
	class Metadata
		@kernel = {}
		@langinfo = {}

		# Constructor
		# @param lang can be either :ruby or :python3
		def initialize(lang)
			case lang
			when :ruby then initialize_ruby
			when :python3 then initialize_python3
			end
		end

		# Returns a string containing the metadata of the IPython Notebook
		def generate_metadata
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

		def initialize_ruby
			@kernel[:language] = "ruby"
			@kernel[:name] = "ruby"
			@kernel[:displayname] = "Ruby #{RUBY_VERSION}"

			@langinfo[:name] = "ruby"
			@langinfo[:fileext] = ".rb"
			@langinfo[:mime] = "application/x-ruby"
			@langinfo[:version] = RUBY_VErSION
		end

		def initialize_python3
			@kernel[:language] = "python"
			@kernel[:name] = "python3"
			@kernel[:displayname] = "Python 3"

			@langinfo[:name] = "python"
			@langinfo[:fileext] = ".py"
			@langinfo[:mime] = "text/x-python"
			@langinfo[:version] = `python3 -V`.split(' ').last
		end
	end
end

