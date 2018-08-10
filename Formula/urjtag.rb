class Urjtag < Formula
  desc "Collection of reusable C++ library artifacts developed at Facebook"
  homepage "https://git.code.sf.net/p/urjtag"
  url "https://downloads.sourceforge.net/project/urjtag/urjtag/2018.06/urjtag-2018.06.tar.xz"
  sha256 "7a2d49118f50a67e971b5bcb152ddf30a15582298d3b9b39ad7be0a54966e82e"
  head "https://git.code.sf.net/p/urjtag/git.git"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "bison"
  depends_on "readline"
  depends_on "libtool"
  depends_on "libusb"
  depends_on "libftdi"

  patch :p1, :DATA

  def install
    if build.head?
      repo_path = "urjtag"
    else
      repo_path = "."
    end
    cd repo_path do
      ENV.prepend_path "PATH", "#{Formula["libtool"].opt_bin}"
      ENV.prepend_path "PATH", "#{Formula["gettext"].opt_bin}"
      ENV.prepend_path "PATH", "#{Formula["bison"].opt_bin}"
      ENV.prepend_path "PATH", "#{Formula["readline"].opt_bin}"

      inreplace "bindings/python/setup.py.in", /\@LIBINTL\@/, "-lintl"

      if build.head?
        system "./autogen.sh"
      end
      system "./configure --prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    
    system "true"
  end
end
__END__
diff --git a/urjtag/bindings/python/py_urjtag.h b/urjtag/bindings/python/py_urjtag.h
index 38582ebb..16b120d8 100644
--- a/urjtag/bindings/python/py_urjtag.h
+++ b/urjtag/bindings/python/py_urjtag.h
@@ -35,7 +35,7 @@ struct urj_pyregister
 extern PyTypeObject urj_pyregister_Type;
 
 extern PyObject *urj_py_chkret (int rc);
-PyObject *UrjtagError;
+extern PyObject *UrjtagError;
 
 extern int urj_pyc_precheck (urj_chain_t *urc, int checks_needed);
 #define UPRC_CBL 1
diff --git a/urjtag/bindings/python/register.c b/urjtag/bindings/python/register.c
index 063ad181..1b13197e 100644
--- a/urjtag/bindings/python/register.c
+++ b/urjtag/bindings/python/register.c
@@ -34,8 +34,6 @@
 
 #include "py_urjtag.h"
 
-extern PyObject *UrjtagError;
-
 static void
 urj_pyr_dealloc (urj_pyregister_t *self)
 {
diff --git a/urjtag/src/tap/usbconn/libusb.c b/urjtag/src/tap/usbconn/libusb.c
index 1318e684..92f4fd14 100644
--- a/urjtag/src/tap/usbconn/libusb.c
+++ b/urjtag/src/tap/usbconn/libusb.c
@@ -42,6 +42,8 @@
 
 /* ---------------------------------------------------------------------- */
 
+extern const urj_usbconn_driver_t urj_tap_usbconn_libusb_driver;
+
 /* @return 1 when found, 0 when not */
 static int
 libusb_match_desc (libusb_device_handle *handle, unsigned int id, const char *desc)
