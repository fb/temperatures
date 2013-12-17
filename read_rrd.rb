#!/usr/bin/env ruby
Dir.chdir(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra'

class ReadRRD < Sinatra::Base
  get '/temperatures/:time.xml', :provides => :xml do
    time = params[:time].match(/^\d+([hwmy]|(minute|hour|day|week|month|year)s?)$/) ? params[:time] : "1day"
    # TODO use all RRDs
    defs = "DEF:a=rrd/10.F9C18D020800.rrd:temperature:AVERAGE XPORT:a:inside"
    %x(rrdtool xport -s now-#{time} -e now #{defs})
  end
end
