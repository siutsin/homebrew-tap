class GauUp < Formula
  desc "Update many git repositories at once"
  homepage "https://github.com/siutsin/9up"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-apple-darwin.tar.xz"
      sha256 "9718f2370c6dc2ffcbaac3c1d2bfebcda3e4694d1b33f6449de73b94935f9aeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-apple-darwin.tar.xz"
      sha256 "8e5b825c2c8ed5b4ad28b7a0fde4fb374e4171f5d32530f6c98a29cfcb44ff78"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0bbee8cb4725c79f3540e1367dce673bbd5b29a83c6206963d7f25de21d19dfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07cdc1232635c8b539b53585e3d483f9c881ee9c78d26fd39b6d4883d29e100e"
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
  test do
    assert_match version.to_s, shell_output("#{bin}/9up --version")
  end
end
