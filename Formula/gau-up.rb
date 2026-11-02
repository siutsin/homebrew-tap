class GauUp < Formula
  desc "Update many git repositories at once"
  homepage "https://github.com/siutsin/9up"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-apple-darwin.tar.xz"
      sha256 "7244ee2b956d00fac667b7afe1cbd0236b506aba870e065f3700c7db5709a200"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-apple-darwin.tar.xz"
      sha256 "ef137368fcb6150dbc013fe57dc4467cdf919a55d3b64024f81a36ba09bbf88a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eee00167e6f68d49684a92bd65822638d62ac46a282d3420b9bd1227c7ceb28d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.1.0/nine-up-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95aedd505fad2b6c1917d9409029bed514d479960e22a5d92aa47df45ae5f400"
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
