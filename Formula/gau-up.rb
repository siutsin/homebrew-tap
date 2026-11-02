class GauUp < Formula
  desc "Update many git repositories at once"
  homepage "https://github.com/siutsin/9up"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.2.0/nine-up-aarch64-apple-darwin.tar.xz"
      sha256 "45cf5f4d239d8e56796e0ffee71d4398d0da840b161801cf820094d7749c1466"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.2.0/nine-up-x86_64-apple-darwin.tar.xz"
      sha256 "372e6c6f1de3a95e1dbb9e92d1c255d14fca89b2bb3e5286fa3fab44bb5dab32"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/siutsin/9up/releases/download/v0.2.0/nine-up-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3407edfd4beaeba7bbc588f77e7cfd86b43b6280e0ed1454dbdbdd45fc380276"
    end
    if Hardware::CPU.intel?
      url "https://github.com/siutsin/9up/releases/download/v0.2.0/nine-up-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07b3cf900e67a78f5f1ba5ead4bdb155d4a6d8f2b66dbddd57abbedaef6a2647"
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
