#!/usr/bin/env ruby


require_relative './classes/simple_csv2_wav'

infile, col_nr, outfile, samples_per_sec, headerRowCount = *ARGV

TempFile = "/tmp/CSV.wav"
OutputSampleRate = 44100

File.open(infile, 'r') do |io_in|
  SimpleCsv2Wav.new.convert(io_in, col_nr.to_i, TempFile, samples_per_sec.to_i, headerRowCount.to_i)
end


# Now to resample. E.g. 128 Hz seems to be valid but unlikely to play well
`ffmpeg -i #{TempFile} -ar #{OutputSampleRate} #{outfile}`
