#!/usr/bin/env ruby
# coding: utf-8

require "jupyter_to_scrapbox"
require 'thor'

module JupyterToScrapbox
  class CLI < Thor
    class_option :help, type: :boolean, aliases: '-h', desc: 'help message.'
    class_option :version, type: :boolean, desc: 'version'
    default_task :help

    method_option :verbose, type: :boolean, aliases: '-v', desc: 'verbose message', :default => false
    method_option :image, type: :boolean, aliases: '-i', desc: 'register images', :default => false
    method_option :markdown, type: :boolean, aliases: '-m', desc: 'process markdown', :default => true
    desc 'converts FILES [options]', 'Convert jupyter-notebook files to scrapbox-json'

    def convert(*paths)
      JupyterToScrapbox::Converter.set_verbose(options[:verbose])
      JupyterToScrapbox::Converter.set_register_images(options[:image])
      JupyterToScrapbox::Converter.set_parse_markdown(options[:markdown])
      if paths.length > 0
        paths.each do |path|
          JupyterToScrapbox::Converter.add(path)
        end
      else
        while path=$stdin.gets
          JupyterToScrapbox::Converter.add(path.chomp)
        end
      end
      JupyterToScrapbox::Converter.perform()
    end

    desc 'version', 'version'
    def version
      p JupyterToScrapbox::VERSION
    end
  end
end
