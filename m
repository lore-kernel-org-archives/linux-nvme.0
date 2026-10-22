Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E2606A324
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BbqSyQpJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pGH5pWXL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=; b=BbqSyQpJR9SbmO
	8S+ui7uvGu2ZeqXZRa/mIe5TVvMaTz0wFsysUUbiLu+pLn6t/Lkxxk0k3jy+NJKGNrIrititUHC7z
	pZyp8vqWk++AZd2EUPTFzj4t11hKa7pnYyD6IfWjmw3KCXCTvRFM8BxJJC9Z8T+94s2z7iXn8RfY6
	1xZOpuyitR3Ux6v5Nn7WO0Ljxnw7qrrESWTs98QXesHdJaeU3w2vwY9Ik8Y8HYXSkrSVrq1UoLHkm
	8hX2WMqIZ36462Fby7hoLW/Eb2dZiBWDhRX4r+0MH7z9upwii8hT6FTADUPkaUFQwM3ZqqrZzfK01
	hfsvGeOq+r2zz2o8ipkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYI-0000000E8sd-0vym;
	Thu, 22 Oct 2026 13:09:50 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYF-0000000E8r4-31sZ
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:09:48 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso21340765e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674586; x=1793279386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=;
        b=pGH5pWXLdv6B2peNAfpeI4Nuo2m/og596kvHZexIZ3dJYoJlZab1935qrGIM0gqc11
         aDwDAcpnGmWbF4Q2VTJ+so/vwTzNSdW2q5H2qluCQ9xUjC2K2KSRW/lHAVn0xjmjlDM9
         dRibnMPq17rmInmzNXXuxKbhUAEUTYm5niJgFUSrvLX+vcXnni8w9xCSptwRh/4yG3I3
         4los+J0cxEDkTMO7clRBUySZmKBl7p/u528M6lf7HllWasOaM8kFf8NCf++zvAPJrsSo
         gMA8gHQbNELhofyX6+n0uxSjx1Rc5knMZr9mQ1J/QZ2Y4k2sprsu2Xyjz8ymzEjhfPfM
         WTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674586; x=1793279386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkBAWb8M/VmKX7IuVDiW1Jf257xwCls4UjhLRxqmku8=;
        b=rd62Bc1XgdzZmkHUM0beSjz8jNVs06jVqdKAnfwOceHNmrWMSWC+SrL35zfwm/5EUC
         9Ylm1ku/SAPS9d0jpZ7vUIiQDiXVzPcyUBPSVdOakHMXMMsj4uaUBFE//zvGvOQFucx1
         jE6o5fcBjg47+gE9blG08yJUNuRfHM0yw8AyvJOEr00YPG+3/GLO5VKJy5t/Ztun3x7j
         uMd7l/WytQpA+0E5OLQTwqAWRlcXxxvObwJuzGdYCiMnx6QgPfHajVG+7aQKpIVN6PqA
         fxySjKnM+l/DzaTL+pKbzzBhPJ3bISab6f7iXT9urPO8Y4WlAkE72atBY4qTO5oDi0l5
         QXoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+H6IOqoXLv7DtjUVAhHrLkoGdiHJABjdudYLNzJPf450csyrnfDGffNN9gCpCGOuVkjYcBr91V+0I@lists.infradead.org
X-Gm-Message-State: AFq9FYJqs0ZiHWdXoqLK6La0/16us6v72gfrlLJpaTB2k1Yfe0GNvL9h
	ACb7dkd7FwiEDEmOjDxTDmnfUHfD6LAwtOhk77h0pAzFwGOFvLm6IjPb
X-Gm-Gg: AYBFou2Uvgla7Tz6kvGj90wensUpC2GIYJm1JKRmpw1yCaujycXQ2WIdzjgkzZTjyl0
	Og8oAENdHY/2EQQ0aIKYlbqtSOhs3cZwWGFllBqEvQH+LGeHNxXkwONtPIiFV3Iqm5VOPxpH0qP
	6nye8QKQCYjn6aI9tO9oQacscos0ZHBRZLu4wBi9ZdnC6xXhIj4LLYCFeSbZ/w8fpFThVimzdtC
	fUD4z8+2tIpiHaEbh4RwEpZekXi4raHhPKUxBJ3dUWDzciWvkcsF6TXP9cPM9TUHblsdGBT3tya
	s9c3H4wP0ZllrkE8H+gNrdHIRWxnqLcYJfzwmGHn2ay3TiO9k1Pfvy9Ef1tbrU/YnYPJt1wneEr
	A5L0IAHOKDXqatXPvmj1CwOsl6S6RoZNgWeS1BV/p9XWtmJHTYPIrp84OcBx/6FWgZ93fOuaFfg
	4pFWCa4KvNuIzf0GGmHYmTZpvaVc15ioFokHSW34vAWcijs8bO7ul2Z+6hg8OqqKAXnr2xeNLm8
	ObLTh1VJ38Se0MIMS7z5A0InmbVbyxUSFsqoYr4jsZGEIwVV9c6dTjMLmP5Z5345D/xpW8kMFWz
	hJ7TA4MaBBwoV8peuMB6vPRr
X-Received: by 2002:a05:600c:3b0d:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4a200a9efc4mr99645355e9.19.1792674585354;
        Thu, 22 Oct 2026 06:09:45 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:41 -0700 (PDT)
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
Subject: [PATCH blktests v2 2/4] nvme/072: test that nvmet sends no data for a failed read
Date: Thu, 22 Oct 2026 15:09:22 +0200
Message-ID: <20261022130927.3583166-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_060947_802887_47D8EF84 
X-CRM114-Status: GOOD (  27.87  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Issue a failing Identify into a buffer filled with a sentinel and verify
that the target transfers no data, with a successful Identify as a
control. The test runs on every configured transport; only nvmet-fc
failed it before the fix. Add a small helper because nvme-cli cannot
prefill the data buffer.

The test fails over fc on the unpatched kernel and passes with the fix
applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore           |  1 +
 src/Makefile             |  1 +
 src/nvme-sentinel-read.c | 89 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/072           | 72 ++++++++++++++++++++++++++++++++
 tests/nvme/072.out       |  2 +
 5 files changed, 165 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out

diff --git a/src/.gitignore b/src/.gitignore
index f9a3916304c0f..57d14df3a2540 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -19,3 +19,4 @@
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
+/nvme-sentinel-read
diff --git a/src/Makefile b/src/Makefile
index 1e571c6b0b4eb..1133f34d7f07c 100644
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
diff --git a/tests/nvme/072 b/tests/nvme/072
new file mode 100755
index 0000000000000..a651fa0b0c672
--- /dev/null
+++ b/tests/nvme/072
@@ -0,0 +1,72 @@
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
+issue_identify() {
+	src/nvme-sentinel-read "$1" 0x06 "$2" 4096 2>>"$FULL"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local changed ctrl status
+
+	_setup_nvmet
+	_nvmet_target_setup
+	_nvme_connect_subsys
+
+	ctrl=$(_find_nvme_dev "$def_subsysnqn")
+
+	# Identify Controller succeeds and must overwrite the sentinel.
+	if ! read -r status changed < <(issue_identify "/dev/$ctrl" 0x01); then
+		echo "successful Identify could not be issued"
+	else
+		echo "cns=0x01 status=$status changed=$changed" >>"$FULL"
+		if ((status != 0 || changed == 0)); then
+			echo "successful Identify returned status $status with $changed bytes"
+		fi
+	fi
+
+	# An unsupported CNS fails and must leave the sentinel intact.
+	if ! read -r status changed < <(issue_identify "/dev/$ctrl" 0xff); then
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
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/072.out b/tests/nvme/072.out
new file mode 100644
index 0000000000000..3f765b30a22b0
--- /dev/null
+++ b/tests/nvme/072.out
@@ -0,0 +1,2 @@
+Running nvme/072
+Test complete
-- 
2.53.0


