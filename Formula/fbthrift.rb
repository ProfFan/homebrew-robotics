class Fbthrift < Formula
  desc "Facebook's branch of Apache Thrift, including a new C++ server."
  homepage "https://github.com/facebook/fbthrift"
  url "https://github.com/facebook/fbthrift/archive/v2018.06.18.00.tar.gz"
  sha256 "97dff8938ae87261305d9558e2164d2061e571c84f16610f74796fc3aabb7d48"
  head "https://github.com/facebook/fbthrift.git"

  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "double-conversion"
  depends_on "glog"
  depends_on "gflags"
  depends_on "boost"
  depends_on "libevent"
  depends_on "xz"
  depends_on "snappy"
  depends_on "lz4"
  depends_on "openssl"
  depends_on "folly"
  depends_on "wangle"
  depends_on "zstd"

  depends_on :macos => :el_capitan

  needs :cxx11

  def install
    ENV.cxx11
  
    cd "build" do
      system "cmake", "..", "-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
