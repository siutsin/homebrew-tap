class 9up < Formula
  desc "Update many git repositories at once"
  homepage "https://github.com/siutsin/9up"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-apple-darwin.tar.xz"
      sha256 "b3fb8b01b08ff05228ba0b4963533c9753ea77614ceb6151f6b0bf5f46a3e5a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-apple-darwin.tar.xz"
      sha256 "8149537e806443fbf39d62ea9232ac4a8bf1c394a3150b704260f97ac2a8e5d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3da11ceda7490e83736a4dce325dc9d4474ac1b654b11ba0e7157224a7e8926b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7a4e45af83166bbdd6a2c4a30ebafb4c632248903530f1f2836b429e897dc55"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "9up"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "9up"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "9up"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "9up"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
