require 'bundler'
Bundler.require

Opal.append_path "./"
File.binwrite "main.js", Opal::Builder.build("app").to_s

# TODO:
#
#     if output ~= "An error occurred while compiling"
#
#       alert user:
#
#         t'ha shalao (autodetect dependencies)
