class RexGit < Formula
  desc "A git side pane for Rex: status, diffs, staging, commits drafted by Claude, and sync, with Axel integration."
  homepage "https://github.com/owlnai/rex-git"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.6.0/rex-git-aarch64-apple-darwin.tar.xz"
      sha256 "8e5b0c01066c6c587d2bf718af814d8fe24bf6e213ce7e0691b33abc53a267c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.6.0/rex-git-x86_64-apple-darwin.tar.xz"
      sha256 "0345032b2636f5c5c779326aba0659e13d97e0115cbb9c646189062c4d55143c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/owlnai/rex-git/releases/download/v0.6.0/rex-git-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "98205a2aa565b5b39c20aeeea612e818736a2d8a1b877ece1770f5c877accb66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/owlnai/rex-git/releases/download/v0.6.0/rex-git-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "041b0550f697d0b9e1fa08347522f1a8303ef9f1e66634c0370089fc742237cd"
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
