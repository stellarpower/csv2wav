require 'wavefile'

class SimpleCsv2Wav
  def initialize

  end

  def convert io_in, col_nr, outfile, samples_per_sec, headerRowCount
    
    WaveFile::Writer.new(outfile, WaveFile::Format.new(:mono, :pcm_16, samples_per_sec)) do |writer|
      read_format = WaveFile::Format.new(:mono, :float, samples_per_sec)

      ## We can't just write floats, as we go beyond the boundaries(?)
      ## So we need to get the maximum value, or a high/low limit (μV)
      ## and divide by this, so that the values are bounded between +1/-1

      allSamples = io_in.readlines[headerRowCount..-1].map{|row|
        col = row.split(',')[col_nr].chomp
        num = col.to_f
      }

      maximum = allSamples.map{|sample| sample.abs}.max # Include minimum by getting the absolute.

      allSamples.each { |num|
        buffer = WaveFile::Buffer.new([num / maximum], read_format)
        writer.write(buffer)
      }
    end

  end
end
