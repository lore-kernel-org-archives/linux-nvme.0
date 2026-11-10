Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A303606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qkH3x2sp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZJA+k4jF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HcRXRAYOuW3Mg9I3hu0cD8PLY2YH/pH7TktBJyJSNx8=; b=qkH3x2sp9giQP+
	KOIiNxvejBtstKZzZ8/q9OmUR47+Pq/gPy4FrI4IB+jv5ZtFPhe5HxB3VUaxFr32WWvky+T9Ukugv
	pdDMWrDg3qS0PlJ/JdI6tvf7pgVIWAJNvMZ9LHdqljZZA9iotEgBaFQRh+4IEoJUpaIIki99jqqi6
	f0ioJcQJdR23TMjMHUzg6WWJWYsELlyGYzC3/vwBEzfk5RfRruv0aztfX2+INkNDiAyTPfpXP+JiR
	zgYbBJe0Im87tpJBsnO9HWjmWSeGTqU0/Wd6AgjY9copi2jyg+ex/p1TlKfGOfr3ZeytTX8CnvYld
	8CfeQ3bI+8Un/n7/k5og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhR-00000007kOv-0Iiy;
	Wed, 11 Nov 2026 21:17:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi1u-00000003F5V-42Yh
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:20:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FF426382C;
	Tue, 10 Nov 2026 09:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D341A1F008A2;
	Tue, 10 Nov 2026 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302438;
	bh=HcRXRAYOuW3Mg9I3hu0cD8PLY2YH/pH7TktBJyJSNx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZJA+k4jFVB7QcXl0KFVo6FAm8XI4UkHhmuHM+xAo6A08HhRmiH/wYZOdlnlgLrh/9
	 rcM+5k5rzdiLJi52fkaGO8lhYCA13C2aDo9CFXO/uzKhnDpIZ5rI/vU3Ljq7x3I7Bm
	 MkhWlzcBR2LGti6K8n98z2uTbwDhWQPDuXr4DHrqemvTOVN3Tx4nNOe+6eX4Ml7Fyp
	 9Vko9fTHjCHZ5NBoWCSVWvJBcx8Fv6eWP7XqdB6tuOAdRQweUL01pdhN1qREgq1HLW
	 tKInp2gJ5HWhSiFiMhTw2dXTpS/ltNMOEyHElB6ILu033FIsaRQKmc4sbsA3Bxf7u6
	 4uHy8e3VDnRvw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:57 +0100
Subject: [PATCH RFC 41/41] selftests/filesystems: add backing file tests
 for pseudo files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-41-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
In-Reply-To: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-mm@kvack.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WrNqWZ7KkNp+RAbIFwB8NnBVD99KxYHQRcnlviAxa6g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9enD4WbX5pPn5ziIC13kaPmfytEQmM0ZuPbw7WXPnm
 gSxsqe1HSUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ8ZHhf973fTs7218EO58x
 7P0e6Ze9+P+LjPP3fh7Xiy851MXwVZ/hx12Ja4+3MNaXiaTntPJ9281nGrssMtLdPjC4ZaFVjDA
 DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add tests that files on pseudo filesystems can't be used as storage:

- a procfs file attached read-only to a loop device
- sysfs files attached read-only and read-write to a loop device
- a sysfs file behind a lower-only overlayfs attached to a loop device
- a sysfs file as the backing file of a usb mass storage gadget LUN
- a sysfs file as the source of a file-backed erofs mount

And make sure that a memfd and another loop device still work as loop
backing files and that loop refuses a backing file that isn't open for
reading.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 tools/testing/selftests/filesystems/config         |   9 +
 .../selftests/filesystems/pseudo_backing_test.c    | 274 +++++++++++++++++++++
 4 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index cf79000e4092..8df38eabb125 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -7,3 +7,4 @@ kernfs_test
 idmapped_tmpfile
 ustat_test
 rw_hint_test
+pseudo_backing_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index fbd5c27505ef..0ebb9005bcd2 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -2,7 +2,7 @@
 
 CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := devpts_pts anon_inode_test kernfs_test fclog ustat_test rw_hint_test
-TEST_GEN_PROGS += idmapped_tmpfile
+TEST_GEN_PROGS += idmapped_tmpfile pseudo_backing_test
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/config b/tools/testing/selftests/filesystems/config
index 9f45bc493a30..228196160d29 100644
--- a/tools/testing/selftests/filesystems/config
+++ b/tools/testing/selftests/filesystems/config
@@ -6,3 +6,12 @@ CONFIG_NET=y
 CONFIG_NET_NS=y
 CONFIG_INET=y
 CONFIG_SYSFS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_OVERLAY_FS=y
+CONFIG_TMPFS=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_EROFS_FS=y
+CONFIG_EROFS_FS_BACKED_BY_FILE=y
diff --git a/tools/testing/selftests/filesystems/pseudo_backing_test.c b/tools/testing/selftests/filesystems/pseudo_backing_test.c
new file mode 100644
index 000000000000..bc8e17ab8e6e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/pseudo_backing_test.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/loop.h>
+#include <linux/magic.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+
+#include "kselftest_harness.h"
+#include "wrappers.h"
+
+/*
+ * Put @fd behind a free loop device. The device is set up with
+ * LO_FLAGS_AUTOCLEAR and goes away again when it is closed here.
+ */
+static int loop_attach(int fd, bool rw, char *dev, size_t len)
+{
+	struct loop_config cfg = {};
+	int ctl, nr, lfd, ret = 0;
+
+	ctl = open("/dev/loop-control", O_RDWR | O_CLOEXEC);
+	if (ctl < 0)
+		return -errno;
+	nr = ioctl(ctl, LOOP_CTL_GET_FREE);
+	if (nr < 0)
+		ret = -errno;
+	close(ctl);
+	if (ret)
+		return ret;
+
+	snprintf(dev, len, "/dev/loop%d", nr);
+	lfd = open(dev, (rw ? O_RDWR : O_RDONLY) | O_CLOEXEC);
+	if (lfd < 0)
+		return -errno;
+
+	cfg.fd = fd;
+	cfg.info.lo_flags = LO_FLAGS_AUTOCLEAR;
+	if (!rw)
+		cfg.info.lo_flags |= LO_FLAGS_READ_ONLY;
+	if (ioctl(lfd, LOOP_CONFIGURE, &cfg)) {
+		ret = -errno;
+		close(lfd);
+	} else {
+		ret = lfd;
+	}
+	return ret;
+}
+
+static int attach_path(const char *path, bool rw)
+{
+	char dev[PATH_MAX];
+	int fd, ret;
+
+	fd = open(path, (rw ? O_RDWR : O_RDONLY) | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+	ret = loop_attach(fd, rw, dev, sizeof(dev));
+	close(fd);
+	if (ret >= 0) {
+		close(ret);
+		ret = 0;
+	}
+	return ret;
+}
+
+static bool can_use_loop(void)
+{
+	return geteuid() == 0 && access("/dev/loop-control", R_OK | W_OK) == 0;
+}
+
+TEST(memfd_backing_file)
+{
+	char dev[PATH_MAX];
+	int fd, lfd;
+
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	fd = memfd_create("pseudo_backing_test", MFD_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
+
+	lfd = loop_attach(fd, true, dev, sizeof(dev));
+	ASSERT_GE(lfd, 0);
+	EXPECT_EQ(close(lfd), 0);
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST(loop_device_backing_file)
+{
+	char dev[PATH_MAX], dev2[PATH_MAX];
+	int fd, lfd, bfd, lfd2;
+
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	fd = memfd_create("pseudo_backing_test", MFD_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
+	lfd = loop_attach(fd, true, dev, sizeof(dev));
+	ASSERT_GE(lfd, 0);
+
+	/* A block device stays fine as a backing file. */
+	bfd = open(dev, O_RDWR | O_CLOEXEC);
+	ASSERT_GE(bfd, 0);
+	lfd2 = loop_attach(bfd, true, dev2, sizeof(dev2));
+	ASSERT_GE(lfd2, 0);
+
+	EXPECT_EQ(close(lfd2), 0);
+	EXPECT_EQ(close(bfd), 0);
+	EXPECT_EQ(close(lfd), 0);
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST(write_only_backing_file)
+{
+	char dev[PATH_MAX], path[PATH_MAX];
+	int fd, wfd, lfd;
+
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	fd = memfd_create("pseudo_backing_test", MFD_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(ftruncate(fd, 1 << 20), 0);
+
+	/* Loop reads from its backing file so it must be open for reading. */
+	snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);
+	wfd = open(path, O_WRONLY | O_CLOEXEC);
+	ASSERT_GE(wfd, 0);
+
+	lfd = loop_attach(wfd, true, dev, sizeof(dev));
+	if (lfd >= 0)
+		close(lfd);
+	EXPECT_EQ(lfd, -EBADF);
+	EXPECT_EQ(close(wfd), 0);
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST(procfs_backing_file)
+{
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	ASSERT_EQ(attach_path("/proc/cpuinfo", false), -EINVAL);
+}
+
+TEST(sysfs_backing_file)
+{
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	ASSERT_EQ(attach_path("/sys/kernel/warn_count", false), -EINVAL);
+
+	if (access("/sys/kernel/reboot/mode", F_OK))
+		SKIP(return, "no /sys/kernel/reboot/mode");
+	ASSERT_EQ(attach_path("/sys/kernel/reboot/mode", true), -EINVAL);
+}
+
+TEST(overlayfs_on_sysfs_backing_file)
+{
+	if (!can_use_loop())
+		SKIP(return, "loop devices unavailable");
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("tmpfs", "/tmp", "tmpfs", 0, NULL), 0);
+	ASSERT_EQ(mkdir("/tmp/empty", 0755), 0);
+	ASSERT_EQ(mkdir("/tmp/merged", 0755), 0);
+
+	/* A lower-only overlayfs serves reads from sysfs. */
+	if (mount("overlay", "/tmp/merged", "overlay", MS_RDONLY,
+		  "lowerdir=/sys/kernel:/tmp/empty"))
+		SKIP(return, "no overlayfs on top of sysfs: %s", strerror(errno));
+
+	ASSERT_EQ(attach_path("/tmp/merged/warn_count", false), -EINVAL);
+}
+
+#define CONFIGFS_DIR "/sys/kernel/config"
+#define GADGET_DIR CONFIGFS_DIR "/usb_gadget/pseudo_backing_test"
+#define MASS_STORAGE_DIR GADGET_DIR "/functions/mass_storage.0"
+
+TEST(usb_mass_storage_backing_file)
+{
+	const char *path = "/sys/kernel/warn_count";
+	struct statfs sfs;
+	ssize_t ret;
+	int fd, err;
+
+	if (geteuid())
+		SKIP(return, "needs root");
+
+	/* Mounting configfs on top of itself fails with EBUSY. */
+	if (statfs(CONFIGFS_DIR, &sfs) || sfs.f_type != CONFIGFS_MAGIC) {
+		ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+		ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+		if (mount("configfs", CONFIGFS_DIR, "configfs", 0, NULL))
+			SKIP(return, "no configfs: %s", strerror(errno));
+	}
+
+	if (mkdir(GADGET_DIR, 0755))
+		SKIP(return, "no usb gadget configfs: %s", strerror(errno));
+	if (mkdir(MASS_STORAGE_DIR, 0755)) {
+		err = errno;
+		rmdir(GADGET_DIR);
+		SKIP(return, "no usb mass storage function: %s", strerror(err));
+	}
+
+	/* Writing the path opens the LUN's backing file right away. */
+	fd = open(MASS_STORAGE_DIR "/lun.0/file", O_WRONLY | O_CLOEXEC);
+	EXPECT_GE(fd, 0);
+	if (fd >= 0) {
+		ret = write(fd, path, strlen(path));
+		err = errno;
+		EXPECT_EQ(ret, -1);
+		EXPECT_EQ(err, EINVAL);
+		EXPECT_EQ(close(fd), 0);
+	}
+
+	EXPECT_EQ(rmdir(MASS_STORAGE_DIR), 0);
+	EXPECT_EQ(rmdir(GADGET_DIR), 0);
+}
+
+TEST(erofs_backing_file)
+{
+	bool refused = false;
+	char buf[256];
+	int fsfd, ret, err;
+	ssize_t n;
+
+	if (geteuid())
+		SKIP(return, "needs root");
+
+	fsfd = sys_fsopen("erofs", FSOPEN_CLOEXEC);
+	if (fsfd < 0)
+		SKIP(return, "no erofs: %s", strerror(errno));
+
+	ASSERT_EQ(sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source",
+			       "/sys/kernel/warn_count", 0), 0);
+	ret = sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+	err = errno;
+	if (ret && err == ENOTBLK) {
+		close(fsfd);
+		SKIP(return, "no file-backed erofs mounts");
+	}
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(err, EINVAL);
+
+	/*
+	 * Something that isn't an erofs image fails with EINVAL as well so
+	 * check that the source itself was refused.
+	 */
+	while ((n = read(fsfd, buf, sizeof(buf) - 1)) > 0) {
+		buf[n] = '\0';
+		if (strstr(buf, "pseudo filesystem"))
+			refused = true;
+	}
+	EXPECT_TRUE(refused);
+	EXPECT_EQ(close(fsfd), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0


