class RexGit < Formula
  desc "A git side pane for Rex: status, diffs, staging, commits drafted by Claude, and sync, with Axel integration."
  homepage "https://github.com/owlnai/rex-git"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.5.1/rex-git-aarch64-apple-darwin.tar.xz"
      sha256 "91bbbc3c771dd0c7d51a4df6b9dcbcfef0874f4b7a1e3acd123f0dc170efd226"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.5.1/rex-git-x86_64-apple-darwin.tar.xz"
      sha256 "67eba24cdae8c9fd4a5aac4cffbf5be3e12fea1d6755650210501c9395444521"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.5.1/rex-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "68326bacce5bb52808680abcc9c7eefb84d2fa2fc25e8c4dbe15bae16e40076d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.5.1/rex-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "630ba25ca5c96978a7617e231f1354575468c764e9d58c9ea7799c3b8daaa26b"
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
