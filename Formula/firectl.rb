class Firectl < Formula
    desc "CLI tool for managing Fireworks deployments"
    homepage "https://readme.fireworks.ai/reference/firectl"
    url "https://storage.googleapis.com/fireworks-public/firectl/stable/linux-amd64.gz"
    sha256 "aa498424aa4c87d93243fabdfc4e22daa4e7f07c7329b388abc57bd34ada06c8" # Linux
  
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/fireworks-public/firectl/stable/darwin-amd64.gz"
      sha256 "706adf5daa099cb40e198c328b780920a68474f0a2c1abf21f9dc351d932a84d" # Darwin AMD64
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/fireworks-public/firectl/stable/darwin-arm64.gz"
      sha256 "eca46a993861076c0dcd75985de1826b5beb85d973afb7c4956da79b520a12e0" # Darwin ARM64
    end
  
    def install
      bin.mkpath

      gz_file = "#{cached_download}"

      File.open("#{bin}/firectl","wb") do |file|
        Zlib::GzipReader.open(gz_file) do |gz|
          file.write(gz.read)
        end
      end

      if OS.mac?
        system "chmod", "a+x", "#{bin}/firectl"
      elsif OS.linux?
        system "chmod", "0755", "#{bin}/firectl"
      end
    end
  
    test do
      shell_output("#{bin}/firectl version")
    end
  
  end
