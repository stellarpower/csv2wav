#!/usr/bin/env ruby


require_relative './classes/simple_csv2_wav'

infile, col_nr, outfile, samples_per_sec, headerRowCount = *ARGV

TempFile = "/tmp/CSV.wav"

File.open(infile, 'r') do |io_in|
  SimpleCsv2Wav.new.convert(io_in, col_nr.to_i, TempFile, samples_per_sec.to_i, headerRowCount.to_i)
end


# Suggest using FLAC, as low sample rates will be better-interpolated, whils no data will be lost.
`ffmpeg -i #{TempFile} #{outfile}`

