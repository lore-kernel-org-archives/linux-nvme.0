Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E3606A31B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XraMEAOf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V5d+V+wx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=; b=XraMEAOfn7e85a
	grSnc9GNTV1ux1p0wrFyH0nhpErLWtGLrraBQx19UL8p0whMyC8xAHWVx3+V8RM0sBkDyx9Q/ua9a
	TqwJvXpLGLlmZxhAygEPbUM5EtH1nRsoOzdbUKSdDpuXLn6IjzfVPWDkF5/FQXYqPnC7TmyArAyrj
	NgcS5JRlzmHV/nLPnTWUwHZzCy87Q4UwcV4E4ocU/7vLx8RNu2RadVy/i4K8Ag9wmGS828UzeMzHR
	Lx/ygw4+fQLXavQFWnxLnlawiNuzoyDyQTRa42fKV5p5+yEtisLDvSrXke1+ttCQfc31fAM4G3U1Y
	rA2SxcOAfhS2MH4x33UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYK-0000000E8tg-1VoF;
	Thu, 22 Oct 2026 13:09:52 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYI-0000000E8rq-0Af9
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:09:51 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1046862f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674588; x=1793279388; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=;
        b=V5d+V+wxO0MB1UB/In3N5/jdID0lR07fcNtfY2wvqto0+Z/elnTHCBAjU8/a97+hu+
         dXJH87r3oex9jKDnVRIEMjSVArNaWDvvtwgzVSjQuw90gUmqug+9GYHNeSfu4ntcPxGR
         RtnSoI507LE5cYkrDb9nDG8jN30CaqpZREVfLPlcnWAGGMGh0midfX80ojVWE1vqssMJ
         rBST6OzyNFvLkFLHPg8i0HHh/YJBt+AkIZHPmbNZwegpeL7mT6OS/7i/fzSbZKr6g1v5
         Z+ydbilO7b0Zuf/5b08JpJqBW7AM9lsVCQFELAWtE1BgzH39iE+LP7Y0s3r3wjcY4xq+
         vmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674588; x=1793279388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2BqGwuPW1LSqC01ykDlKxwwUb1RW6AH4YD+EZwCze/4=;
        b=WIgSRidNhsVG8ozeBgGjp72KxhXsRvI7gcIbjYvzh+fGgu+owWAFWubwy9eR3ViXZe
         c7sfn/LE4MUX0Kz8ZEPNsNDORvhp5a3w5AcgrfDpKw6Fh9yxYIF5MIYSROk9ASJYzjOm
         QYOkTN2ZBbLRxHXEKgDBXgB79qyKvqs/sNhTUObdxNqfM9bJyf4i61rYAHWpXgwBNREd
         c6j+2qKsxrYv5I5uLy93P86pX/0EB7EOw6VrJcij6/J2OEB9mefXrni1eMLL7kOXvYb0
         KaQyPgojjk+5iC4Y1jC1d5NBy/TKJ0cWmau4gvW1ijpuHOntEcMfhJChNQjIcmOIMM0a
         d4TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi1ARK7C/hZwvQfEZQyswANWXUJ0MmNBdJ4t/2QW3mrPTOmlyn5I9aRabmHx+pO/Zx1gOEQqaYmXeI@lists.infradead.org
X-Gm-Message-State: AFq9FYK1xaoFqZUWlmuE12YX43n0JUFccGmcHPRFkX3Uu947f8EsM2hz
	2k08HltiUzINje4wiaKE1wie6XzqdmToXN48eH4i7pW9EbC6jENWBVWf
X-Gm-Gg: AYBFou3mZvuw46Rtjl10CzWFqTCyHxGGZpahTfS6IGwB5c7A7HHxmK19pbTQ9rnn5n7
	MnAigJIdp3pssxzi23Cqoxy69eTq+E6DaYTQqYQmhaQFSrCSNCGc68tMtNMoJ0OaYM8ic8IVkjw
	w5FCsE8uhq79DyCGmjTL1SYsF8N7CqUEcWvHzRf/Ubq0iZz1vlpX8X0Lf7rJyCRRJRizkgmeNNb
	4YLIn+lzZ8ECmW/zlBEnqhad0GJObYFXjY+oByMm1vJ4d/GxEEUxZz43tqwTrM/C30EJMY3OjUt
	5cC90eKKBJU79b8OWC1lJXfgshdz6uJjKeoLkI4X5243CJ7AxfOkMN1NPy1ECAHD2WAD17OYyAz
	HiGGK53S5dpv3HdsGRM86fO5YgYlVtL3Pk2aPVeKomyrF8F9TPDllfTh3GvXBx83Q9u7ueiJmba
	8CIb3e/SPLGRA9vs2MXq7V7ooJJZJL7jMdcI6HEPARZXQx84LjMESTeODG/BeHrMZgZ2aQMIb5X
	DQ8ouXac6AJnnjC+oMtxWPGI6utNG5ASOqy+OPabijiKjJiB4JelVvcK2gp25wbf+t6CeN5Zr3J
	iAysupEG2x8Gp4e2L6IYTOfz
X-Received: by 2002:a05:600c:3e8e:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1fdaef48cmr106086885e9.6.1792674587622;
        Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:47 -0700 (PDT)
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
Subject: [PATCH blktests v2 3/4] nvme/073: test nvmet zone report initialization and length
Date: Thu, 22 Oct 2026 15:09:23 +0200
Message-ID: <20261022130927.3583166-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_060950_128068_E3BC84A0 
X-CRM114-Status: GOOD (  28.74  )
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

Export a zoned null_blk device through the NVMe target and verify that
Zone Management Receive zeroes reserved and unused report bytes and
rejects a transfer length inconsistent with NUMD. The test runs on every
configured transport, with RDMA restricted to 4 KiB page kernels so that
the preparatory write exceeds the default inline-data limit. Add a small
passthrough helper because nvme-cli does not expose the reserved report
bytes.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 src/.gitignore         |   1 +
 src/Makefile           |   1 +
 src/nvme-zone-report.c | 165 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/073         |  68 +++++++++++++++++
 tests/nvme/073.out     |   2 +
 5 files changed, 237 insertions(+)
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

diff --git a/src/.gitignore b/src/.gitignore
index 57d14df3a2540..7d9ffb45185e7 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -20,3 +20,4 @@
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
 /nvme-sentinel-read
+/nvme-zone-report
diff --git a/src/Makefile b/src/Makefile
index 1133f34d7f07c..9ff1166887851 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -25,6 +25,7 @@ C_TARGETS := \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
 	nvme-sentinel-read \
+	nvme-zone-report \
 	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
diff --git a/src/nvme-zone-report.c b/src/nvme-zone-report.c
new file mode 100644
index 0000000000000..438c91897e32e
--- /dev/null
+++ b/src/nvme-zone-report.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Andrea Parri
+
+/* Check that unused bytes in an NVMe zone report are zeroed. */
+#define _GNU_SOURCE
+#include <endian.h>
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
+#define REPORT_LEN		4096
+/*
+ * Larger than the default RDMA in-capsule data size on 4 KiB page kernels.
+ * nvme/073 skips RDMA on other page sizes, where this write could stay
+ * inline rather than use buffers allocated and freed per command.
+ */
+#define POISON_LEN		8192
+#define WRITE_OPCODE		0x01
+#define ZONE_REPORT_OPCODE	0x7a
+#define PARTIAL_REPORT		(1U << 16)
+#define ZONE_REPORT_HEADER	64
+#define ZONE_DESC_LEN		64
+#define ZONE_START_OFFSET	16
+#define NR_ATTEMPTS		64
+
+static int poison_target(int fd, unsigned int iteration)
+{
+	unsigned char data[POISON_LEN];
+	struct nvme_passthru_cmd cmd = {
+		.opcode = WRITE_OPCODE,
+		.nsid = 1,
+		.addr = (uintptr_t)data,
+		.data_len = sizeof(data),
+		.cdw10 = iteration * (POISON_LEN / 512),
+		.cdw12 = POISON_LEN / 512 - 1,
+	};
+
+	memset(data, 0x5a, sizeof(data));
+	return ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+}
+
+static uint64_t read_le64(const unsigned char *p)
+{
+	uint64_t value;
+
+	memcpy(&value, p, sizeof(value));
+	return le64toh(value);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned char *report;
+	unsigned long long slba;
+	char *end;
+	void *p;
+	int fd, i, j, ret, rc = 0;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY last-zone-slba\n",
+			argv[0]);
+		return 2;
+	}
+
+	errno = 0;
+	slba = strtoull(argv[2], &end, 0);
+	if (errno || *end) {
+		fprintf(stderr, "invalid SLBA: %s\n", argv[2]);
+		return 2;
+	}
+
+	/*
+	 * Page-align the report so that the kernel maps it for the transfer
+	 * instead of bouncing it: a bounce buffer is zero-filled, which would
+	 * hide the sentinel and any bytes the target left unwritten.
+	 */
+	ret = posix_memalign(&p, 4096, REPORT_LEN);
+	if (ret) {
+		fprintf(stderr, "posix_memalign: %s\n", strerror(ret));
+		return 2;
+	}
+	report = p;
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror(argv[1]);
+		free(report);
+		return 2;
+	}
+
+	for (i = 0; i < NR_ATTEMPTS; i++) {
+		struct nvme_passthru_cmd cmd = {
+			.opcode = ZONE_REPORT_OPCODE,
+			.nsid = 1,
+			.addr = (uintptr_t)report,
+			.data_len = REPORT_LEN,
+			.cdw10 = (uint32_t)slba,
+			.cdw11 = (uint32_t)(slba >> 32),
+			.cdw12 = REPORT_LEN / 4 - 1,
+			.cdw13 = PARTIAL_REPORT,
+		};
+		unsigned int nonzero = 0, stale = 0, poisoned = 0;
+		unsigned char sentinel = i & 1 ? 0xa5 : 0x3c;
+
+		ret = poison_target(fd, i);
+		if (ret) {
+			if (ret < 0)
+				perror("poison_target");
+			else
+				fprintf(stderr, "poison write status: %#x\n", ret);
+			rc = 2;
+			goto out;
+		}
+
+		memset(report, sentinel, REPORT_LEN);
+		ret = ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+		if (ret) {
+			if (ret < 0)
+				perror("NVME_IOCTL_IO_CMD");
+			else
+				fprintf(stderr, "NVMe status: %#x\n", ret);
+			rc = 2;
+			goto out;
+		}
+
+		if (read_le64(report) != 1 ||
+		    read_le64(report + ZONE_REPORT_HEADER +
+			      ZONE_START_OFFSET) != slba) {
+			fprintf(stderr, "unexpected zone report header or SLBA\n");
+			rc = 1;
+			goto out;
+		}
+
+		for (j = 8; j < REPORT_LEN; j++) {
+			if (j >= ZONE_REPORT_HEADER &&
+			    j < ZONE_REPORT_HEADER + ZONE_DESC_LEN)
+				continue;
+			if (!report[j])
+				continue;
+			nonzero++;
+			if (report[j] == sentinel)
+				stale++;
+			if (report[j] == 0x5a)
+				poisoned++;
+		}
+
+		fprintf(stderr, "attempt %d: %u nonzero bytes "
+			"(%u poison, %u sentinel)\n", i + 1, nonzero,
+			poisoned, stale);
+		if (nonzero) {
+			rc = 1;
+			goto out;
+		}
+	}
+
+out:
+	close(fd);
+	free(report);
+	return rc;
+}
diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 0000000000000..4416367fee67b
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that NVMe target zone reports are fully initialized and that their
+# transfer length matches NUMD.
+#
+# Regression test for patch "nvmet: zns: don't leak stale memory in zone
+# management receive".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="check NVMe target zone report initialization and length"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_null_blk
+	_have_kernel_options BLK_DEV_ZONED
+	_have_src_program nvme-zone-report
+
+	# RDMA defaults to PAGE_SIZE bytes of inline data. The helper's
+	# 8 KiB preparatory write must exceed that limit.
+	if [[ "$nvme_trtype" == "rdma" ]]; then
+		_page_size_equals 4096
+	fi
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local block_size dev last_sector ret sectors slba zone_sectors
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	sectors=$(cat /sys/block/nullb1/size)
+	zone_sectors=$(cat /sys/block/nullb1/queue/chunk_sectors)
+	block_size=$(cat /sys/block/nullb1/queue/logical_block_size)
+	last_sector=$(((sectors - 1) / zone_sectors * zone_sectors))
+	slba=$((last_sector * 512 / block_size))
+
+	src/nvme-zone-report "$dev" "$slba" >>"$FULL" 2>&1
+	ret=$?
+	case $ret in
+	0) ;;
+	1) echo "zone report contained stale data" ;;
+	*) echo "zone report checker failed" ;;
+	esac
+
+	_check_zone_report "$dev" 4096 1023 0
+	_check_zone_report "$dev" 8192 1023 15
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 0000000000000..ed6690e578688
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,2 @@
+Running nvme/073
+Test complete
-- 
2.53.0


