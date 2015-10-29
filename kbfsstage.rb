class Kbfsstage < Formula
  desc "Keybase FS (Staging)"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/kbfs-beta/archive/v1.0.0-22.tar.gz"
  sha256 "59e6cecb28584e12e334d7b6b9895ebc0d3736084cd8bbf2fd1b1f209641766a"

  head "https://github.com/keybase/kbfs-beta.git"
  version "1.0.0-22"

  depends_on "go" => :build
  depends_on "kbstage"
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
    system "go", "build", "-a", "-tags", "staging brew", "-o", "kbfsstage", "github.com/keybase/kbfs/kbfsfuse"

    bin.install "kbfsstage"
  end

  def post_install
    mount_dir = "#{ENV['HOME']}/Keybase.stage"
    system "mkdir", "-p", mount_dir
    system "kbstage", "launchd", "install", "homebrew.mxcl.kbfs.staging", "#{opt_bin}/kbfsstage", mount_dir
  end

  test do
    system "#{bin}/kbfsstage", "--version"
  end
end
