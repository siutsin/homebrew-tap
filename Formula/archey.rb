class Archey < Formula
    desc "Graphical system information display for macOS"
    homepage "https://github.com/siutsin/archey-osx"
    license "GPL-2.0"
    revision 1
    head "https://github.com/siutsin/archey-osx.git"
  
    stable do
      url "https://github.com/siutsin/archey-osx/archive/1.6.2.tar.gz"
      sha256 "775fa9212306bbc6b84f8f4dc3da37e7ecada4c10a3df15b93ee9c877bf0dcb8"
    end
      
    def install
      bin.install "bin/archey"
    end
  
    test do
      assert_match "Archey OS X 1", shell_output("#{bin}/archey --help")
    end
  end
