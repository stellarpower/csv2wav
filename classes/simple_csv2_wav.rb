require 'wavefile'

class SimpleCsv2Wav
  def initialize

  end

  def convert io_in, col_nr, outfile, samples_per_sec, headerRowCount
    
    WaveFile::Writer.new(outfile, WaveFile::Format.new(:mono, :pcm_16, samples_per_sec)) do |writer|
      read_format = WaveFile::Format.new(:mono, :float, samples_per_sec)
      
      allSamples = io_in.readlines[headerRowCount..-1].map {|row|
        col = row.split(',')[col_nr].chomp
        num = col.to_f
      }
      allSamples.each {|num|
        buffer = WaveFile::Buffer.new([num], read_format)
        writer.write(buffer)
      }
    end

  end
end
