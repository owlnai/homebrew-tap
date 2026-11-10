class RexGit < Formula
  desc "A git side pane for Rex: status, diffs, staging, commits drafted by Claude, and sync, with Axel integration."
  homepage "https://github.com/owlnai/rex-git"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.1.0/rex-git-aarch64-apple-darwin.tar.xz"
      sha256 "8c117f425dbf9f5076a34b9b3bca42964d3b93d654d9c32334171bdcfaf27f91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.1.0/rex-git-x86_64-apple-darwin.tar.xz"
      sha256 "1a78c7bf5356fa32930ee0b8635dae820cf068d457386a2d622c438711c56b4b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.1.0/rex-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "27fd92548ebf75eb04a572218f93990f871d4d9791242a6c6d52115e6598ea7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.1.0/rex-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc8e47371e8d0d79cee70d8c3bc89a8c075ddc4b052bbdc9d5dc79e64bf4dce9"
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
      bin.install "rex-git"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rex-git"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rex-git"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rex-git"
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
