#!/usr/bin/env ruby
Dir.chdir(File.dirname(__FILE__))

Dir.glob("/1wire/10.*/temperature").uniq.each do |f|
  sens = f.split("/")[-2]
  rrd = File.join("rrd","#{sens}.rrd")
  temp = (File.open(f, &:readline).strip!).to_f

  %x(rrdtool create #{rrd} \
    --step 120 \
    DS:temperature:GAUGE:360:-273:5000
    RRA:AVERAGE:0.3:1:2160
    RRA:AVERAGE:0.3:5:2160
    RRA:AVERAGE:0.3:45:5760
    RRA:AVERAGE:0.3:180:14600
    RRA:MIN:0.3:1:2160
    RRA:MIN:0.3:5:2160
    RRA:MIN:0.3:45:5760
    RRA:MIN:0.3:180:14600
    RRA:MAX:0.3:1:2160
    RRA:MAX:0.3:5:2160
    RRA:MAX:0.3:45:5760
    RRA:MAX:0.3:180:14600) unless File.exists?(rrd)

  %x(rrdtool update #{rrd} N:#{temp})
end
