class RexGit < Formula
  desc "A git side pane for Rex: status, diffs, staging, commits drafted by Claude, and sync, with Axel integration."
  homepage "https://github.com/owlnai/rex-git"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.3.0/rex-git-aarch64-apple-darwin.tar.xz"
      sha256 "0cb75a683361bd803de3fb704680fabe154ec2004843186199fd7c063ef6d250"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.3.0/rex-git-x86_64-apple-darwin.tar.xz"
      sha256 "5981a5c7cb6374a3184ccd156f7ac9c5f7a84af4e0c60a121ff128174610f0d9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.3.0/rex-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3bb86654baee3eff0cffac4cecedee1d62910da37bedbebdde65250f9dfe6056"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.3.0/rex-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c392338a4bd7c60b99646ceed19bf249bdfef5260dd08f6589bf463b5a9d6598"
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
