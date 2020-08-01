class Archey < Formula
    desc "Graphical system information display for macOS"
    homepage "https://github.com/siutsin/archey-osx"
    license "GPL-2.0"
    revision 1
    head "https://github.com/siutsin/archey-osx.git"
  
    stable do
      url "https://github.com/siutsin/archey-osx/archive/1.6.1.tar.gz"
      sha256 "2f7a1be906f6ad9602afff82294766eb654125b574a1f0a3858a2000182befcc"
    end
  
    bottle :unneeded
    
    def install
      bin.install "bin/archey"
    end
  
    test do
      assert_match "Archey OS X 1", shell_output("#{bin}/archey --help")
    end
  end
