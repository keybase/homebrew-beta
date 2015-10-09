class Keybase < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-32.tar.gz"
  sha256 "9d20eda3b3e4c4d6fa8e8ae9be26e3a7302cb93f66e7027b94fff1f12a31cd02"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-32"

  depends_on "go" => :build

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "c04b868ba22b8ce2742d3031c9b342cdaa4e5629915e9219e1fa3cb5938c2d07" => :yosemite
  #   root_url "https://github.com/keybase/client-beta/releases/download/v1.0.0-27"
  # end

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "build", "-a", "-tags", "release brew", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase", "service"
  end

  test do
    system "#{bin}/keybase", "version"
  end
end
