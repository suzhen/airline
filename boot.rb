require 'rubygems'

# Set rack environment
ENV['RACK_ENV'] ||= "development"

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default, ENV['RACK_ENV'])

require 'sinatra'
require 'sinatra/reloader' if development?
require "sinatra/activerecord"
require 'sinatra/cross_origin'
require 'nokogiri'
require "oj"


# Set project configuration
require File.expand_path("../app", __FILE__)