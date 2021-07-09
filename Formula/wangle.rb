class Wangle < Formula
  desc "Is a framework providing a set of common client/server abstractions"
  homepage "https://github.com/facebook/wangle"
  url "https://github.com/facebook/wangle/archive/v2018.06.04.00.tar.gz"
  sha256 "9d02d298ed1d062b4fab1b0e51d3d9677b4f848246462ee8ef7e17fbd0582af3"
  head "https://github.com/facebook/wangle.git"

  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "double-conversion"
  depends_on "gflags"
  depends_on "glog"
  depends_on "libevent"
  depends_on "lz4"
  depends_on macos: :el_capitan
  depends_on "openssl"
  depends_on "proffan/robotics/folly"
  depends_on "snappy"
  depends_on "xz"

  # needs :cxx11

  def install
    ENV.cxx11

    cd "wangle" do
      system "cmake", ".", "-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
