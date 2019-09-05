class Sophus < Formula
  desc "C++ implementation of Lie Groups using Eigen."
  homepage "https://github.com/strasdat/Sophus"
  url "https://github.com/strasdat/Sophus/archive/v1.0.0.tar.gz"
  sha256 "b4c8808344fe429ec026eca7eb921cef27fe9ff8326a48b72c53c4bf0804ad53"
  head "https://github.com/strasdat/Sophus.git"

  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "glog"
  depends_on "eigen"
  depends_on "suite-sparse"

  depends_on :macos => :el_capitan

  # needs :cxx11

  def install
    ENV.cxx11
  
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end