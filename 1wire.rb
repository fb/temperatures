#!/usr/bin/env ruby
Dir.glob("/1wire/10.*/temperature").uniq.each{|f| p (File.open(f, &:readline).strip!).to_f}
