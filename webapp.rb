#!/usr/bin/env ruby

require 'sinatra'

set :run, true
set :bind, '0.0.0.0'
set :port, 3000

get '/T:time' do
  time = params[:time].match(/^\d+(minute|hour|day|week|month|year)s?$/) ? params[:time] : "1day"
  %x(rrdtool xport -s now-#{time} -e now DEF:a=/home/fb/temperatures/rrd/10.F9C18D020800.rrd:temperature:AVERAGE XPORT:a:Innen)
end
