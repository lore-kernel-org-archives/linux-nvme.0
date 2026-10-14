Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A9BCC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4EOz8oNcujmRPotVW/3oA0Xk0tvmFoYm47gqUKw16U=; b=JFUKdY6fgVXCxjiQKCCg+zjXxv
	GH5rlzgxCf3UP0gXOhJWscmsGFZ9pMESrLosLeBXqguowJw2cYZGgPB4aA3Ud/DnOjiqXnvBDkciz
	VVNHOxmNcGXxnYDepVsEJ+8qqdK1bNsoHmsiqOf2r45YyDtqpJytpwqF5+oBgb+UA/pohtFCXQoiH
	Fnj6Uo57pbmbd0jyCOT+CPPhpS3xzrj5Gj5qK88LDrM5EXlAyKNIenTb9MTXFlwmqX3htmOeMXoM0
	MIKnklfrm+DjwyqBI6MYBRWXpZCIzqx4k7B4+EvEOEQWY8IN2NjbZztkpixoixraqYfrbzhBA/jre
	J4KXESuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Li-0000000G3Al-03AC;
	Wed, 14 Oct 2026 17:01:06 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Lf-0000000G39B-07D3
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:01:04 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a16c399641so42923555e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997261; x=1792602061; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4EOz8oNcujmRPotVW/3oA0Xk0tvmFoYm47gqUKw16U=;
        b=Vihln/Mmvgdwug+pyz+dWjAo7yCuTDWEy7CErwO6IA2o6RN2x66guKMPyGAsNx0ZzL
         oO9E+WRY5OQEKwc2EaBCVGr/UQWXElO3lIS5OP/fPQP7R/jrD9jyhSLtHpUzwNMGfph+
         nJUAOLDOwr1DWq4cfhtl7D2UBZZ25vCgMgriqNawqvi9f6k2TUzaWFQN3GVcutEmP57k
         4VlVQrKXcxfAPY0C4EtI9FomQl3yf2RWH5pVOZJkW8wHmWDnRqdikQe/FjEKhq9lqEdf
         L9MahJPsi07u8HN3Qw3YJyRncJE7sk6TJWgeKB+a6AKcWSOMcYtBWxI4/bvl10hUMH5F
         uKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997261; x=1792602061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4EOz8oNcujmRPotVW/3oA0Xk0tvmFoYm47gqUKw16U=;
        b=t8c80+1PFWP5aRWhuvwHzKzwMY/X7USA10YwrSjbUTXHHijAjgjct5cNhBV9RGJMXZ
         HSN+8yMSduvaFghfv3NMrqY5hUueavJn5HTlxeP1cFklmhor5EvNDNnJUdq2L+1nvz98
         06kD1Fuq5uAbqerWH1uWbrg9Io+ukWMa+KBWaSgsr3HnnDancVHtF28cs/7C5YK2OWia
         ErP+oQxJTXv3W0KFfvSBR6IFhDaPEK0mkidum5w6C6GiiFJWhwGWU47iFE5LTezMBzJ4
         GZchtXyZBdpKbpg8D9x7cDnQwVcJgSKx4i4iqQQjgyIwtD63bq1um0SYR1u9MfrqV8ya
         egDA==
X-Forwarded-Encrypted: i=1; AKwUvBxymixcvJ8qgtLNxv+GQJNK1j7tZ/1XfkErQo0jJrsKReZJfTSAFftHHbHmm9tKDgO/IZumSFQlR+V3@lists.infradead.org
X-Gm-Message-State: AFq9FYKh2/Rvow9jp7J5fJOF4Cc/bXlnSf2fYNAEyCPu4BwTWvmAuSAG
	Jk3DAGhZ2kBJZnBBaLv2w/jmzcspNuPBIzLNTP4luVfRnRA8tTO8xqYs
X-Gm-Gg: AYBFou2JvO3qRE7EuLBjyrdzzT28FTenWIrPOY7Oo7i9WSZeBsQPBEGYcGAAXzhPr3M
	cWam1j2npFzuDA7BoSrNs1CF1qEZE3vQTxoSM3B+1j6ZNJJOsnQknsM7l4+2pPHAyWcLRZoFOrB
	D1nz8/uT3/WnkVAHB+I14OV6HSBgBNf2gSrTjIpxnMSN5a9jVMZAc7K6ffk8yfUIryRIPZtB+1p
	jvrcMpwPAXd0LPQJrQaYY+uVjFuSuh0RUrTdZ4SGQeegG+4F+nuJJwOa9z5CPkOB2NAEwMe4W+G
	lgXjlb9/9OvhoPThKG1HresxUuZxS3MP0osapaMj7Y5RWw6XhApI6BI1evbtiffhkheucWAKZWK
	uVxzLBkq1Twfuc0W/mDAS9ofkWQ1r15XuLWZ8yqeyqKgmDa8K9GICkTOueVYfYqhKViYa9YGbor
	YOtnxvfG5y+RnYCxGYNpw2IFqBPZP/4lV0gW8xidXWDxrrCCQiJFfvdxXq030DZXIs4eFZdylOO
	xn6A1hgRyTFIBOLlbgrpJJ0j+qG06qm/XqqJ1QgjzbbyA==
X-Received: by 2002:a05:600c:4fcb:b0:4a1:811c:8083 with SMTP id 5b1f17b1804b1-4a18e4c3600mr330167855e9.33.1791997261055;
        Wed, 14 Oct 2026 10:01:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 2/4] nvme/071: test that nvmet sends no data for a failed read
Date: Wed, 14 Oct 2026 19:00:39 +0200
Message-ID: <20261014170046.2516-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100103_749044_9FBBD797 
X-CRM114-Status: GOOD (  28.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Issue a failing Identify into a buffer filled with a sentinel and verify
that the target transfers no data, with a successful Identify and a
namespace read as controls. The test runs on every configured transport;
only nvmet-fc failed it before the fix. Add a small helper because
nvme-cli cannot prefill the data buffer.

The test fails over fc on the unpatched kernel and passes with the fix
applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore           |  1 +
 src/Makefile             |  1 +
 src/nvme-sentinel-read.c | 89 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/071           | 80 ++++++++++++++++++++++++++++++++++++
 tests/nvme/071.out       |  2 +
 5 files changed, 173 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100755 tests/nvme/071
 create mode 100644 tests/nvme/071.out

diff --git a/src/.gitignore b/src/.gitignore
index e9869e172b20f..2429da9d9cf44 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -18,3 +18,4 @@
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
+/nvme-sentinel-read
diff --git a/src/Makefile b/src/Makefile
index dd646940fa25e..78433f0762b4a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -24,6 +24,7 @@ C_TARGETS := \
 	mount_clear_sock \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
+	nvme-sentinel-read \
 	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
diff --git a/src/nvme-sentinel-read.c b/src/nvme-sentinel-read.c
new file mode 100644
index 0000000000000..dd36f283f46e2
--- /dev/null
+++ b/src/nvme-sentinel-read.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Andrea Parri
+
+/*
+ * Issue an NVMe admin read command into a buffer filled with a sentinel and
+ * print the NVMe status and the number of bytes the command overwrote.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/nvme_ioctl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#define SENTINEL	0xa5
+
+static int parse_u32(const char *s, uint32_t *val)
+{
+	unsigned long v;
+	char *end;
+
+	errno = 0;
+	v = strtoul(s, &end, 0);
+	if (errno || end == s || *end || v > UINT32_MAX)
+		return -1;
+	*val = v;
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct nvme_passthru_cmd cmd = { };
+	uint32_t opcode, cdw10, len, i, changed = 0;
+	unsigned char *buf;
+	void *p;
+	int fd, ret;
+
+	if (argc != 5 || parse_u32(argv[2], &opcode) || opcode > 0xff ||
+	    parse_u32(argv[3], &cdw10) || parse_u32(argv[4], &len) || !len) {
+		fprintf(stderr, "usage: %s /dev/nvmeX opcode cdw10 data-len\n",
+			argv[0]);
+		return 2;
+	}
+
+	/*
+	 * Page-align the buffer so that the kernel maps it for the transfer
+	 * instead of bouncing it: a bounce buffer is zero-filled and copied
+	 * back even when the command fails, which would hide the sentinel.
+	 */
+	ret = posix_memalign(&p, 4096, len);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(ret));
+		return 2;
+	}
+	buf = p;
+	memset(buf, SENTINEL, len);
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		free(buf);
+		return 2;
+	}
+
+	cmd.opcode = opcode;
+	cmd.addr = (uintptr_t)buf;
+	cmd.data_len = len;
+	cmd.cdw10 = cdw10;
+
+	ret = ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	close(fd);
+	if (ret < 0) {
+		perror("NVME_IOCTL_ADMIN_CMD");
+		free(buf);
+		return 2;
+	}
+
+	for (i = 0; i < len; i++)
+		if (buf[i] != SENTINEL)
+			changed++;
+
+	printf("%#x %u\n", ret, changed);
+	free(buf);
+	return 0;
+}
diff --git a/tests/nvme/071 b/tests/nvme/071
new file mode 100755
index 0000000000000..5333bfac8db53
--- /dev/null
+++ b/tests/nvme/071
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target transfers no read data for a failed command.
+# The host buffer is filled with a sentinel, so any data the target sends
+# shows up as changed bytes.
+#
+# Regression test for patch "nvmet-fc: only send read data for successful
+# commands".
+
+. tests/nvme/rc
+
+DESCRIPTION="verify nvmet does not transfer data for failed reads"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_src_program nvme-sentinel-read
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# Issue an Identify with CNS $2 to controller $1 and print the NVMe status
+# and the number of changed bytes in the 4096-byte data buffer.
+_identify() {
+	src/nvme-sentinel-read "$1" 0x06 "$2" 4096 2>>"$FULL"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local changed ctrl ns status
+
+	_setup_nvmet
+	# File backing: the namespace read below fails over loop with the
+	# default loop device backing, for reasons unrelated to this test.
+	_nvmet_target_setup --blkdev file
+	_nvme_connect_subsys
+
+	ctrl=$(_find_nvme_dev "$def_subsysnqn")
+	ns="/dev/${ctrl}n1"
+
+	# Identify Controller succeeds and must overwrite the sentinel.
+	if ! read -r status changed < <(_identify "/dev/$ctrl" 0x01); then
+		echo "successful Identify could not be issued"
+	else
+		echo "cns=0x01 status=$status changed=$changed" >>"$FULL"
+		if ((status != 0 || changed == 0)); then
+			echo "successful Identify returned status $status with $changed bytes"
+		fi
+	fi
+
+	# An unsupported CNS fails and must leave the sentinel intact.
+	if ! read -r status changed < <(_identify "/dev/$ctrl" 0xff); then
+		echo "failed Identify could not be issued"
+	else
+		echo "cns=0xff status=$status changed=$changed" >>"$FULL"
+		if (((status & 0x7ff) != 2)); then
+			echo "failed Identify returned status $status, expected 0x2"
+		fi
+		if ((changed != 0)); then
+			echo "failed Identify transferred data: $changed bytes changed"
+		fi
+	fi
+
+	if ! dd if="$ns" of=/dev/null bs=4096 count=256 iflag=direct \
+	     status=none >>"$FULL" 2>&1; then
+		echo "namespace read failed"
+	fi
+
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/071.out b/tests/nvme/071.out
new file mode 100644
index 0000000000000..146809b91e0a3
--- /dev/null
+++ b/tests/nvme/071.out
@@ -0,0 +1,2 @@
+Running nvme/071
+Test complete
-- 
2.53.0


