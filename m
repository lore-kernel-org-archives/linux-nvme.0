From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Dec 2016 19:05:51 -0500
Subject: [PATCH] nvme-cli: fabrics: remove libudev dependency
Message-ID: <1481846751-2896-1-git-send-email-keith.busch@intel.com>

I am getting a lot of complaints about portability of the nvme-cli
regarding the libudev dependency. This patch removes the dependency from
the fabrics disconnect command when using the target nqn method. Tested
on nvme loop target.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
I hadn't tried any of the nvme fabrics or targets before today, and just
want to say that using the nvme loop device was incredibly pleasent to
test with nvmetcli.

Since I'm not involved with the fabrics work, I wanted to send this out
before pushing. It's a pretty straight foward conversion to get rid of
the libudev dependency, and I suspect testing on the loop is probably
good enough, but don't want to break anyone either.

 Makefile  |   7 ----
 fabrics.c | 116 +++++++++++++++++++++++++-------------------------------------
 2 files changed, 46 insertions(+), 77 deletions(-)

diff --git a/Makefile b/Makefile
index 33c7190..13da0b7 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,6 @@ DESTDIR =
 PREFIX ?= /usr/local
 SYSCONFDIR = /etc
 SBINDIR = $(PREFIX)/sbin
-LIBUDEV := $(shell ld -o /dev/null -ludev >/dev/null 2>&1; echo $$?)
 LIB_DEPENDS =
 
 RPMBUILD = rpmbuild
@@ -15,12 +14,6 @@ RM = rm -f
 
 AUTHOR=Keith Busch <keith.busch at intel.com>
 
-ifeq ($(LIBUDEV),0)
-	override LDFLAGS += -ludev
-	override CFLAGS  += -DLIBUDEV_EXISTS
-	override LIB_DEPENDS += udev
-endif
-
 default: $(NVME)
 
 NVME-VERSION-FILE: FORCE
diff --git a/fabrics.c b/fabrics.c
index 2b3caa1..577aa9d 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -26,13 +26,10 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <unistd.h>
+#include <dirent.h>
 #include <sys/ioctl.h>
 #include <asm/byteorder.h>
 #include <inttypes.h>
-#ifdef LIBUDEV_EXISTS
-#include <libudev.h>
-#endif
-
 #include <linux/types.h>
 
 #include "parser.h"
@@ -62,6 +59,7 @@ static struct config {
 #define PATH_NVME_FABRICS	"/dev/nvme-fabrics"
 #define PATH_NVMF_DISC		"/etc/nvme/discovery.conf"
 #define PATH_NVMF_HOSTNQN	"/etc/nvme/hostnqn"
+#define SYS_NVME		"/sys/class/nvme"
 #define MAX_DISC_ARGS		10
 
 enum {
@@ -801,85 +799,63 @@ int connect(const char *desc, int argc, char **argv)
 	return 0;
 }
 
-#ifdef LIBUDEV_EXISTS
-static int disconnect_subsys(struct udev_enumerate *enumerate, char *nqn)
+static int scan_sys_nvme_filter(const struct dirent *d)
 {
-	struct udev_list_entry *list_entry;
-	const char *subsysnqn;
-	char *sysfs_path;
-	int ret = 1;
-
-	udev_list_entry_foreach(list_entry,
-				udev_enumerate_get_list_entry(enumerate)) {
-		struct udev_device *device;
-
-		device = udev_device_new_from_syspath(
-				udev_enumerate_get_udev(enumerate),
-				udev_list_entry_get_name(list_entry));
-		if (device != NULL) {
-			subsysnqn = udev_device_get_sysattr_value(
-					device, "subsysnqn");
-			if (subsysnqn && !strcmp(subsysnqn, nqn)) {
-				if (asprintf(&sysfs_path,
-					"%s/delete_controller",
-					udev_device_get_syspath(device)) < 0) {
-					ret = errno;
-					udev_device_unref(device);
-					break;
-				}
-				udev_device_unref(device);
-				ret = remove_ctrl_by_path(sysfs_path);
-				free(sysfs_path);
-				break;
-			}
-			udev_device_unref(device);
-		}
-	}
-
-	return ret;
+	return !((strcmp(d->d_name, ".") == 0) ||
+		(strcmp(d->d_name, "..") == 0));
 }
 
+
 static int disconnect_by_nqn(char *nqn)
 {
-	struct udev *udev;
-	struct udev_enumerate *udev_enumerate;
-	int ret;
+	struct dirent ** devices = NULL;
+	int i, n, fd, ret = 0;
+	bool done = false;
+	char subsysnqn[NVMF_NQN_SIZE] = {};
 
-	if (strlen(nqn) > NVMF_NQN_SIZE) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (strlen(nqn) > NVMF_NQN_SIZE)
+		return -EINVAL;
 
-	udev = udev_new();
-	if (!udev) {
-		fprintf(stderr, "failed to create udev\n");
-		ret = -ENOMEM;
-		goto exit;
-	}
+	n = scandir(SYS_NVME, &devices, scan_sys_nvme_filter, alphasort);
+
+	for (i = 0; i < n; i++) {
+		char *sysfs_nqn_path;
 
-	udev_enumerate = udev_enumerate_new(udev);
-	if (udev_enumerate == NULL) {
-		ret = -ENOMEM;
-		goto free_udev;
+		asprintf(&sysfs_nqn_path, "%s/%s/subsysnqn",
+			SYS_NVME, devices[i]->d_name);
+
+		fd = open(sysfs_nqn_path, O_RDONLY);
+		if (fd > 0) {
+			char *sysfs_del_path;
+
+			if (read(fd, subsysnqn, NVMF_NQN_SIZE) < 0)
+				goto next;
+
+			subsysnqn[strcspn(subsysnqn, "\n")] = '\0';
+			if (strcmp(subsysnqn, nqn))
+				goto next;
+
+			asprintf(&sysfs_del_path, "%s/%s/delete_controller",
+				SYS_NVME, devices[i]->d_name);
+			ret = remove_ctrl_by_path(sysfs_del_path);
+
+			done = true;
+			free(sysfs_del_path);
+ next:
+			close(fd);
+		}
+
+		free(sysfs_nqn_path);
+		if (done)
+			break;
 	}
 
-	udev_enumerate_add_match_subsystem(udev_enumerate, "nvme");
-	udev_enumerate_scan_devices(udev_enumerate);
-	ret = disconnect_subsys(udev_enumerate, nqn);
-	udev_enumerate_unref(udev_enumerate);
+	for (i = 0; i < n; i++)
+		free(devices[i]);
+	free(devices);
 
-free_udev:
-	udev_unref(udev);
-exit:
 	return ret;
 }
-#else
-static int disconnect_by_nqn(char *nqn)
-{
-	fprintf(stderr, "libudev not detected, install and rebuild.\n");
-	return -1;
-}
-#endif
 
 static int disconnect_by_device(char *device)
 {
-- 
2.5.5
