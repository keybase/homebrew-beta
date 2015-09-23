class KeybaseDisabled < Formula
  desc "Keybase"
  homepage "https://keybase.io/"

  url "https://github.com/keybase/client-beta/archive/v1.0.0-24.tar.gz"
  sha256 "a39aa3699e8a0c144d0eba630a03d008d5da21006e6cae7d8acd8c586a5d288b"

  head "https://github.com/keybase/client-beta.git"
  version "1.0.0-24"

  # bottle do
  #   cellar :any_skip_relocation
  #   root_url "https://github.com/keybase/client-beta/releases/download/v#{VERSION}/"
  #   sha256 "215b27eb171d15c70ce4c8b486ee5ed666a21d8d850b106c4928c05a3eafb8f4" => :yosemite
  # end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    system "mkdir", "-p", "src/github.com/keybase/"
    system "mv", "client", "src/github.com/keybase/"

    system "go", "get", "github.com/keybase/client/go/keybase"
    system "go", "build", "-a", "-tags", "release brew", "-o", "keybase", "github.com/keybase/client/go/keybase"

    bin.install "keybase"
  end

  def post_install
    system "#{opt_bin}/keybase", "launchd", "install", "homebrew.mxcl.keybase", "#{opt_bin}/keybase"
  end

  test do
    system "#{bin}/keybase", "version"
  end
end
