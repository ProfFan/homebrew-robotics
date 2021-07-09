class Rsocket < Formula
  desc "C++ implementation of RSocket"
  homepage "https://github.com/rsocket/rsocket-cpp"
  url "https://github.com/rsocket/rsocket-cpp/archive/v0.10.0.tar.gz"
  sha256 "47aa62c34654c3511fd014393b89491f81a828c53c2f89168e21145c9bb58ff0"
  head "https://github.com/rsocket/rsocket-cpp.git"

  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "libevent"
  depends_on "lz4"
  depends_on macos: :el_capitan
  depends_on "openssl"
  depends_on "proffan/robotics/folly"
  depends_on "snappy"
  depends_on "xz"

  # needs :cxx11

  patch :p1, :DATA

  def install
    ENV.cxx11

    mkdir "build" do
      system "cmake", "..", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_BENCHMARKS=false",
"-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4949863..6cef505 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -369,6 +369,9 @@ target_link_libraries(
   ReactiveSocket
   yarpl
   yarpl-test-utils
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GMOCK_LIBS}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})
@@ -391,6 +394,9 @@ target_link_libraries(
   frame_fuzzer
   ReactiveSocket
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -426,6 +432,9 @@ target_link_libraries(
   tckclient
   ReactiveSocket
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -441,6 +450,9 @@ target_link_libraries(
   tckserver
   ReactiveSocket
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GMOCK_LIBS}
   ${GLOG_LIBRARY}
@@ -472,6 +484,9 @@ target_link_libraries(
   reactivesocket_examples_util
   yarpl
   ReactiveSocket
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -487,6 +502,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -500,6 +518,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -515,6 +536,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -528,6 +552,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -544,6 +571,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -557,6 +587,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -572,6 +605,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -585,6 +621,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -600,6 +639,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -613,6 +655,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -632,6 +677,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -645,6 +693,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -660,6 +711,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -673,6 +727,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

@@ -686,6 +743,9 @@ target_link_libraries(
   ReactiveSocket
   reactivesocket_examples_util
   yarpl
+  folly
+  double-conversion
+  ${OPENSSL_LIBRARIES}
   ${GFLAGS_LIBRARY}
   ${GLOG_LIBRARY})

diff --git a/rsocket/test/transport/TcpDuplexConnectionTest.cpp b/rsocket/test/transport/TcpDuplexConnectionTest.cpp
index effce8d..cbea531 100644
--- a/rsocket/test/transport/TcpDuplexConnectionTest.cpp
+++ b/rsocket/test/transport/TcpDuplexConnectionTest.cpp
@@ -42,7 +42,7 @@ makeSingleClientServer(
   Promise<Unit> serverPromise;

   TcpConnectionAcceptor::Options options;
-  options.port = 0;
+  options.address = folly::SocketAddress{"0.0.0.0", 0};
   options.threads = 1;
   options.backlog = 0;

diff --git a/yarpl/CMakeLists.txt b/yarpl/CMakeLists.txt
index 14d1c5f..7409811 100644
--- a/yarpl/CMakeLists.txt
+++ b/yarpl/CMakeLists.txt
@@ -140,7 +140,7 @@ if (BUILD_TESTS)
     examples/FlowableExamples.cpp
     examples/FlowableExamples.h)

-  target_link_libraries(yarpl-playground yarpl)
+  target_link_libraries(yarpl-playground yarpl double-conversion )

   # Unit tests.
   add_executable(
@@ -160,9 +160,12 @@ if (BUILD_TESTS)
     yarpl-tests
     yarpl
     yarpl-test-utils
+    double-conversion
+    folly
     ${GLOG_LIBRARY}

     # Inherited from rsocket-cpp CMake.
+    ${GFLAGS_LIBRARY}
     ${GMOCK_LIBS})

   add_dependencies(yarpl-tests yarpl-test-utils gmock)
