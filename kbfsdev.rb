class Kbfsdev < Formula
  desc "Keybase FS (Devel)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/kbfs-beta/archive/v1.0.0-23.tar.gz"
  sha256 "85c8a27247915f7c130f2712aaf238e0ad2ff77c97663ea36561b58ec34d6337"

  head "https://github.com/keybase/kbfs-beta.git"
  version "1.0.0-23"

  depends_on "go" => :build
  # Needed for third-party go dependencies that use hg, in particular
  # code.google.com/p/rsc/qr.
  depends_on "hg" => :build
  depends_on "keybase/beta/kbdev"
  #depends_on :osxfuse

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "d10ab44eb7153fb6041dbc5250eb4fdfe2e4e35e7f77a18e188675d8ab92865b" => :yosemite
  #   root_url "https://github.com/keybase/kbfs-beta/releases/download/v1.0.0-16"
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "0"
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"
    system "mv", "kbfs", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/kbfs/kbfsfuse"
    system "go", "build", "-a", "-tags", "brew", "-o", "kbfsdev", "github.com/keybase/kbfs/kbfsfuse"

    bin.install "kbfsdev"
  end

  def post_install
    mount_dir = "#{ENV['HOME']}/Keybase.devel"
    system "mkdir", "-p", mount_dir
    system "kbdev", "launchd", "install", "homebrew.mxcl.kbfs.staging", "#{opt_bin}/kbfsdev", mount_dir
  end

  test do
    system "#{bin}/kbfsdev", "--version"
  end
end
