Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF159606A88C
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HsZPCIIc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCtSTQX/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=; b=HsZPCIIcDk5ALp3ihxNjwB7Cja
	dJI4Ohcl1sSH8Ex3V7XQYuL394zuqsCko5hx5CO+XSE31rNT3vX2XusieBAA1xN2lchoS4aBiFE8F
	SRgqFS3uDy3DuAm5+Wpd+DOUDsy5pd1YyNfV/3IMIAXXvHzItOFJWkoUgDv7OzTY0Mt3T70Ra2oCs
	QHMGPCKVztIeMhaccTPUut1eZw9HEVRYiMvzQFOJREP5AtkKCVajNrgaeWyum+gWc9LhCQh93ysUq
	oVk/mNO7x7pK9VKco3XUMnXAoS15D+93sV2v81/LWju09Ob0QMK7iONQQ0cU4WpLKLFybZR+V9kHa
	BQqU75rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTBjt-00000004bTl-3reH;
	Tue, 17 Nov 2026 05:28:17 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTBjp-00000004bSt-1wrz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 05:28:15 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-3712b6d9843so3500582eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 21:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794893292; x=1795498092; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=;
        b=BCtSTQX/F208KULmYJ4Mvc5/09j6BLfDiEO3EPmkNcPDfqobJUmOcOO3lCWVFdYdjO
         LWBDoAFZ+rHVk/fvIFroS8jzwKprOhTLEhbxlgEiZPeIpyvY8uNQevFdmUMmpRBEVEGJ
         F1iGks1Kl/BS7I6z0SwDA8lXnCoME9bVlLJq7AGn8jbnsjtTnDRRb6sehRwRZmXK2Xz+
         gBsuVF+f7cgDR4/FIxCw9vXoYwywN3KMy0mwfsj2qCyjsGrmu3kjgjQJklzjQhMBHYaw
         FMqqQ+2VbEFggwdhBQz1ODUcLld11HF6VIDPObNKP/gN7RpX0v+BGg9RLxs+8lbjsiGl
         SIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893292; x=1795498092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLoQdF4EvfhL28QNvcz5mAbPrfEnrSCR6OB0l9IZmq8=;
        b=P8HQhbto4Q175Hrtp0kJ+JsuNbujtyCP2ypjcGUzPcqrOCgQjAD+IWKq791+AhQBAO
         1YWl7Wd64TsFifgKCYqXva5tlcKAvQAlbYraaebBXaknVUC0eRA3Qj/M8BQqWymBU1GC
         Za5P64S5aD4/4jFd2CuyFceS8jMKihE5uKlQfx6alc4CHRVHOvQiYIJRxuqNRBLYmULo
         CiQcfdHIpuHXnnHTnyBUuROrLqsAz2tqchvWQpqFAADjtVLCAg7IkisbXlE6uYAzj4iw
         XF+ja7VoBhU4p/V9HWqRcjhCdj6N/OdIMWHaiE/MBkHmlAilN14BKijpdAea9udv5Bch
         Iryw==
X-Forwarded-Encrypted: i=1; AL+hErGjD5dssqxIfwIYAfjxCb6Klgabdu5x93WgYwW4/k3BPbsTUy2BrncsPR5tHQ+tSJH1/vB0zLU+Q9GG@lists.infradead.org
X-Gm-Message-State: APuU4Z/pQOP8nv3a4lT9/+po8KdhKq/Ph3X77DdAcmXp+Fccj8+m2fdb
	bu+CEvC1FmiZuVOY7aTZuI8RRHACQbVzBzj3iSY1fON1Mfz9WXO8Wzwu
X-Gm-Gg: AZFdTZesPJ4v6vogs0waNWTpdTCfSvEUioW7qIrJvTajxKoObjmZZ2az4K/khd/42lr
	Eo9lUSJrQQpjKRj7cBrKOC25uwCOaVuo/CWmM3fCS0WmwQqGB+QQf7i2nXaNGsGqpVykJSiCFdd
	U+O9KBdF1eMPMvYOcLYjFiHlqLbNelTOr1qcRwYR0SACr2jttu59uxlpH7RzgDWwdIdSD+rdt1v
	BJkSNlhCz7NfieYF36pwqr3YbXTyT1V66liRIaCvt2CVkDF3X3v8GERB4zbKh+ofwHmx1hy+G/I
	J91QHlGDrK1nLXFcvareIkLb1M0uEMzemw3lwSvQCQPnvXq//9TtQvyI+KuuIHsepYJxE+raVun
	Kt0utDLOazdvnIpBVnI6mEf/y/VIf1pY8GV7VtK9wjGzRJSzPBfaYnfabuuBd9DawkDXMgZxDNP
	9X/gPipkP0WmgbOLK36gEy9Xld1Pl38pOiJFDvBQ3GFTZ/3aNHtN2877JNIQfT9kOGsMAjDHZEv
	xaKFwB5bwLRrwR8gBVluyRIA/HliAkaguGTPe9XH2YTh2TYw0FsGKMWNnNQHXAFRn7yQNVQke1V
	q9Agk/+MzgqJkagL4UsCftKkc/Q6vinb/AhkJn9BVRJUMfKwiqzgvrhLrsTA9KM7lrY6qxY+OiR
	jGhFQWrXUmmcL9Nbu93eECvY=
X-Received: by 2002:a05:7301:4206:b0:369:535f:4d12 with SMTP id 5a478bee46e88-37963a53df5mr11478566eec.3.1794893292400;
        Mon, 16 Nov 2026 21:28:12 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4182:5788:1d84:2750:6580:bea9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm41068384eec.9.2026.11.16.21.28.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 21:28:11 -0800 (PST)
From: Ankit Gupta <ankit6791@gmail.com>
To: linux-block@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Ankit Gupta <ankit6791@gmail.com>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH blktests] nvme/080: test write zeroes larger than 65536 logical blocks
Date: Mon, 16 Nov 2026 21:26:10 -0800
Message-ID: <20261117052741.25471-1-ankit6791@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_212813_508480_F55C99AF 
X-CRM114-Status: GOOD (  19.95  )
X-Spam-Score: -1.9 (-)
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

The NVMe Write Zeroes command encodes the number of logical blocks in a
zero-based 16-bit field. When the controller reports neither MDTS nor
WZSL, as nvmet-tcp does by default, the host advertised an unbounded
write zeroes limit, truncated the block count when building the command
and completed the request successfully after zeroing only a prefix.

Add a regression test for the kernel patch "nvme: limit Write Zeroes to
65536 logical blocks" [1]. Fill 65536 logical blocks plus 1 MiB with a
non-zero pattern, zero that range with blkdiscard -z and check that the
whole range reads back as zeroes. The length scales with the logical
block size, so the test covers both 512-byte and 4096-byte namespaces.

[1] https://lore.kernel.org/linux-nvme/20261117011230.10288-1-ankit6791@gmail.com/

Signed-off-by: Ankit Gupta <ankit6791@gmail.com>
---
Tested on arm64 with v7.4-rc3 (aebb72744764), NVMET_TRTYPES="loop tcp"
and NVMET_BLKDEV_TYPES="device file". Without the kernel patch the test
fails for tcp with both block device types ("zeroed range still contains
non-zero data"). With the patch it passes for tcp and loop with both
types. The device type gives 512-byte logical blocks (33 MiB zeroed) and
the file type 4096-byte logical blocks (257 MiB zeroed). With
NVME_IMG_SIZE=64m the device type still runs and the file type is
skipped.

Claude and Codex assisted with writing and validating this test.

 tests/nvme/080     | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/080.out |  2 ++
 2 files changed, 92 insertions(+)
 create mode 100755 tests/nvme/080
 create mode 100644 tests/nvme/080.out

diff --git a/tests/nvme/080 b/tests/nvme/080
new file mode 100755
index 0000000..bbd3031
--- /dev/null
+++ b/tests/nvme/080
@@ -0,0 +1,90 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Ankit Gupta
+#
+# Test that a Write Zeroes request larger than a single NVMe Write Zeroes
+# command can describe zeroes the whole requested range. The command encodes
+# the number of logical blocks in a zero-based 16-bit field, so one command
+# covers at most 65536 logical blocks. When the controller reports neither
+# MDTS nor WZSL, as nvmet-tcp does by default, the host used to advertise an
+# unbounded write zeroes limit, truncate the block count when building the
+# command and complete the request successfully after zeroing only a prefix.
+#
+# Regression test for the patch "nvme: limit Write Zeroes to 65536 logical
+# blocks".
+
+. tests/nvme/rc
+
+DESCRIPTION="test write zeroes larger than 65536 logical blocks"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_program blkdiscard
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
+}
+
+test_write_zeroes() {
+	local ns dev bs size len_mb
+
+	if ! ns=$(_find_nvme_ns "${def_subsys_uuid}"); then
+		echo "FAIL: failed to find the namespace"
+		return 1
+	fi
+	dev="/dev/${ns}"
+
+	if ! bs=$(blockdev --getss "${dev}") ||
+			! size=$(blockdev --getsize64 "${dev}"); then
+		echo "FAIL: failed to get the namespace block size and capacity"
+		return 1
+	fi
+
+	# 65536 logical blocks plus 1 MiB: 33 MiB with 512-byte logical blocks
+	# and 257 MiB with 4096-byte logical blocks.
+	len_mb=$((bs * 65536 / 1024 / 1024 + 1))
+	if ((len_mb * 1024 * 1024 > size)); then
+		SKIP_REASONS+=("namespace is smaller than ${len_mb} MiB")
+		return 1
+	fi
+
+	# Fill the range with non-zero data so that stale data is detectable.
+	if ! head -c "${len_mb}M" /dev/zero | tr '\0' '\377' |
+			dd of="${dev}" bs=1M iflag=fullblock oflag=direct \
+			status=none; then
+		echo "FAIL: failed to fill ${len_mb} MiB with a pattern"
+	fi
+
+	if ! blkdiscard -z -o 0 -l "${len_mb}M" "${dev}"; then
+		echo "FAIL: blkdiscard -z failed"
+	fi
+
+	if ! dd if="${dev}" bs=1M count="${len_mb}" iflag=direct status=none |
+			cmp -s -n "$((len_mb * 1024 * 1024))" - /dev/zero; then
+		echo "FAIL: zeroed range still contains non-zero data"
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	if _nvme_connect_subsys; then
+		test_write_zeroes
+	else
+		echo "FAIL: failed to connect to the subsystem"
+	fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/080.out b/tests/nvme/080.out
new file mode 100644
index 0000000..15119b8
--- /dev/null
+++ b/tests/nvme/080.out
@@ -0,0 +1,2 @@
+Running nvme/080
+Test complete
-- 
2.50.1 (Apple Git-155)


