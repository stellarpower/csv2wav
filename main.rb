#!/usr/bin/env ruby


require_relative './classes/simple_csv2_wav'

infile, col_nr, outfile, samples_per_sec, headerRowCount  = *ARGV

File.open(infile, 'r') do |io_in|
  SimpleCsv2Wav.new.convert(io_in, col_nr.to_i, samples_per_sec.to_i, headerRowCount.to_i)
end

