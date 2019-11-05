Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3BEC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035B2217F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Up8FEgK7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aELdDZX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B2217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kYOZF0i4SVGvcXUpLSpLn0GdaeMXg5HlsipmFWM0oms=; b=Up8FEgK7v9IW3g
	GtL0vi5LCfg1b6OCTIj8RSYsnFgvX0WBizdS68VqOlxqSmgjJJrJwCsdEJjeoAfHjmZ7v9U2S518C
	GyRQHrNBLqZ2lwoOY3CwpdOxT5WdmZpPw3+fcfu8kYvKwhV8blkT++4vp+WeyhOAKUPQEaV01riay
	K9tg1w9P3UZSobOvZ5Nung/LOXcoCdpF4ajqC7Ayq8SwyjMQTNIQ+JQpNuVB0I2kFbTpdXD6MkG26
	i4cN0RXp8aKCOG3EcNyvHkbUriYCBrTlxOL0SwsIz6lBBQLFlzTupvDRlhaKBL8d+oR6/n4OVBXXf
	ZWDtekX6SABvtxtM2zWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS3em-0005RT-Cm; Tue, 05 Nov 2019 18:34:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS3ej-0005Qu-64
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 18:34:19 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D54F217F5;
 Tue,  5 Nov 2019 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572978856;
 bh=UzrmSenuYaitxdxHUuGNx3GcLfXDlbsIFnniLj/5QYw=;
 h=From:To:Cc:Subject:Date:From;
 b=aELdDZX5htquhQRZea7zlgcVin0IM1dNN4LXchE192YPxUWXp7s0Th7qI9oVF41Di
 nCb8/R9Uzf6Zix+iu2HwkM/S61lfeY/m7LjgQtPGqKJLBSO6UX2VA1mtj4Fz7zRv56
 rxzvDWlwtPQWy+UUMB/7+rjc3FTlrX3wSJMyTFd4=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC] nvme-cli: Support for hugetlbfs
Date: Wed,  6 Nov 2019 03:34:12 +0900
Message-Id: <20191105183412.333-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_103417_265073_1A16F5E1 
X-CRM114-Status: GOOD (  13.66  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some commands require exceptionally large data transfers, and the
kernel driver supports only a limited number of phyiscal segments per
command. To help support large transfers, try to allocate physically
contiguous space via hugetlbfs.

Rather than deal with the nuances of allocating huge pages, this patch
requires libhugetlbfs be installed on the host system.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Makefile |  7 ++++++
 nvme.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1dd8c0e..8bcf5a5 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,7 @@ CFLAGS ?= -O2 -g -Wall -Werror
 override CFLAGS += -std=gnu99 -I.
 override CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
 LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
+LIBHUGETLBFS = $(shell $(LD) -o /dev/null -lhugetlbfs >/dev/null 2>&1; echo $$?)
 HAVE_SYSTEMD = $(shell pkg-config --exists systemd  --atleast-version=232; echo $$?)
 NVME = nvme
 INSTALL ?= install
@@ -21,6 +22,12 @@ ifeq ($(LIBUUID),0)
 	override LIB_DEPENDS += uuid
 endif
 
+ifeq ($(LIBHUGETLBFS),0)
+	override LDFLAGS += -lhugetlbfs
+	override CFLAGS += -DLIBHUGETLBFS
+	override LIB_DEPENDS += hugetlbfs
+endif
+
 INC=-Iutil
 
 ifeq ($(HAVE_SYSTEMD),0)
diff --git a/nvme.c b/nvme.c
index 0823267..254bc7e 100644
--- a/nvme.c
+++ b/nvme.c
@@ -37,6 +37,10 @@
 #include <dirent.h>
 #include <libgen.h>
 
+#ifdef LIBHUGETLBFS
+#include <hugetlbfs.h>
+#endif
+
 #include <linux/fs.h>
 
 #include <sys/ioctl.h>
@@ -93,6 +97,55 @@ const char *conarg_host_traddr = "host_traddr";
 const char *dev = "/dev/";
 const char *subsys_dir = "/sys/class/nvme-subsystem/";
 
+static void *__nvme_alloc(size_t len, bool *huge)
+{
+	void *p;
+
+	if (!posix_memalign(&p, getpagesize(), len)) {
+		*huge = false;
+		memset(p, 0, len);
+		return p;
+	}
+	return NULL;
+}
+
+#ifdef LIBHUGETLBFS
+#define HUGE_MIN 0x80000
+
+static void nvme_free(void *p, bool huge)
+{
+	if (huge)
+		free_hugepage_region(p);
+	else
+		free(p);
+}
+
+static void *nvme_alloc(size_t len, bool *huge)
+{
+	void *p;
+
+	if (len < HUGE_MIN)
+		return __nvme_alloc(len, huge);
+
+	p = get_hugepage_region(len, GHP_DEFAULT);
+	if (!p)
+		return __nvme_alloc(len, huge);
+
+	*huge = true;
+	return p;
+}
+#else
+static void nvme_free(void *p, bool huge)
+{
+	free(p);
+}
+
+static void *nvme_alloc(size_t len, bool *huge)
+{
+	return __nvme_alloc(len, huge);
+}
+#endif
+
 static int open_dev(char *dev)
 {
 	int err, fd;
@@ -2362,6 +2415,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 	unsigned int fw_size;
 	struct stat sb;
 	void *fw_buf, *buf;
+	bool huge;
 
 	struct config {
 		char  *fw;
@@ -2409,7 +2463,9 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 		err = -EINVAL;
 		goto close_fw_fd;
 	}
-	if (posix_memalign(&fw_buf, getpagesize(), fw_size)) {
+
+	fw_buf = nvme_alloc(fw_size, &huge);
+	if (!fw_buf) {
 		fprintf(stderr, "No memory for f/w size:%d\n", fw_size);
 		err = -ENOMEM;
 		goto close_fw_fd;
@@ -2443,7 +2499,7 @@ static int fw_download(int argc, char **argv, struct command *cmd, struct plugin
 		printf("Firmware download success\n");
 
 free:
-	free(buf);
+	nvme_free(buf, huge);
 close_fw_fd:
 	close(fw_fd);
 close_fd:
@@ -4144,6 +4200,7 @@ static int submit_io(int opcode, char *command, const char *desc,
 	__u32 dsmgmt = 0;
 	int phys_sector_size = 0;
 	long long buffer_size = 0;
+	bool huge;
 
 	const char *start_block = "64-bit addr of first block to access";
 	const char *block_count = "number of blocks (zeroes based) on device to access";
@@ -4284,12 +4341,12 @@ static int submit_io(int opcode, char *command, const char *desc,
 		buffer_size = cfg.data_size;
 	}
 
-	if (posix_memalign(&buffer, getpagesize(), buffer_size)) {
+	buffer = nvme_alloc(buffer_size, &huge);
+	if (!buffer) {
 		fprintf(stderr, "can not allocate io payload\n");
 		err = -ENOMEM;
 		goto close_mfd;
 	}
-	memset(buffer, 0, buffer_size);
 
 	if (cfg.metadata_size) {
 		mbuffer = malloc(cfg.metadata_size);
@@ -4368,7 +4425,7 @@ free_mbuffer:
 	if (cfg.metadata_size)
 		free(mbuffer);
 free_buffer:
-	free(buffer);
+	nvme_free(buffer, huge);
 close_mfd:
 	if (strlen(cfg.metadata))
 		close(mfd);
@@ -4798,6 +4855,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 	void *data = NULL, *metadata = NULL;
 	int err = 0, wfd = STDIN_FILENO, fd;
 	__u32 result;
+	bool huge;
 
 	struct config {
 		__u8  opcode;
@@ -4920,7 +4978,8 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 		memset(metadata, cfg.prefill, cfg.metadata_len);
 	}
 	if (cfg.data_len) {
-		if (posix_memalign(&data, getpagesize(), cfg.data_len)) {
+		data = nvme_alloc(cfg.data_len, &huge);
+		if (!data) {
 			fprintf(stderr, "can not allocate data payload\n");
 			err = -ENOMEM;
 			goto free_metadata;
@@ -4983,7 +5042,7 @@ static int passthru(int argc, char **argv, int ioctl_cmd, const char *desc, stru
 
 free_data:
 	if (cfg.data_len)
-		free(data);
+		nvme_free(data, huge);
 free_metadata:
 	if (cfg.metadata_len)
 		free(metadata);
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
