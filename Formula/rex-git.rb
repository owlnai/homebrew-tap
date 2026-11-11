class RexGit < Formula
  desc "A git side pane for Rex: status, diffs, staging, commits drafted by Claude, and sync, with Axel integration."
  homepage "https://github.com/owlnai/rex-git"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.4.0/rex-git-aarch64-apple-darwin.tar.xz"
      sha256 "fc2587bf249e229646878ede511c25676687e0f34bd046282703229678275394"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.4.0/rex-git-x86_64-apple-darwin.tar.xz"
      sha256 "8ecaf5a5f0d67cfdae22ceb072d095f435308f7bb1afc0efe9bdcdc6c913756c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.4.0/rex-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52308c44f06cee1c8f82631f72494407bbc74d2803f850f0a76d0dda3d964a5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.4.0/rex-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a081634d9e32ffd374ecee1f025fbc1adbab4ec68e87ac1678b97b45b164a30"
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
