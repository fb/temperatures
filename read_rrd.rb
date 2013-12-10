#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'

class ReadRRD < Sinatra::Base
  get '/temperatures/:time.xml', :provides => :xml do
    time = params[:time].match(/^\d+([hwmy]|(minute|hour|day|week|month|year)s?)$/) ? params[:time] : "1day"
    # TODO use all RRDs
    defs = "DEF:a=/home/fb/temperatures/rrd/10.F9C18D020800.rrd:temperature:AVERAGE XPORT:a:Innen"
    %x(rrdtool xport -s now-#{time} -e now #{defs})
  end
end
