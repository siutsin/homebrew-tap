class GauUp < Formula
  desc "Update many git repositories at once"
  homepage "https://github.com/siutsin/9up"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-apple-darwin.tar.xz"
      sha256 "e2800747b5df41bda2ee7feae4ab8d691da403323890db12fe799fc065907ebc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-apple-darwin.tar.xz"
      sha256 "ad67eb14cc118ab6392150426537f9e8d0f2c7e49d482328423f3c8c26b379f9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d86c8b3f8be39a6d57e53f524449a91e884e87124d304ab9c532e6b25c9223ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "877cc8d1c05df8870c7e93224252dcb09f2a01beecc6b4e76510f40f3b1059e7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
