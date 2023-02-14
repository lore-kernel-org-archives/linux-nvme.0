Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B23C05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 04:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7h6k7oSN9eadyECxEAowwZG0lauAS5Wx7KvjPxAgTLk=; b=DbuL31//c8hMd8pB5RX1c6wzVI
	cGzJ0bRiv40oOiiXEV6ztN6NpNsFvAMaWLfjQFGpAeHB2pTseUoPbQZcq/y2auL9A1UxhXABbCdky
	f9xXWC3GAdYS+SvzGddlpaPzVMLXcwf5arXr4GY94+DrSL53saz+EPM7C34qS2e9C8AcclQHF3bSR
	DT2V53AoWFp0NonqnIHlkaR1TITUcnqHN7ZijH4gani+QtY9lDMmWy/OUlQSFJsjD9A6QFfzVJ3gl
	NXTpCAJAvadW0qoLZ0yM8zEV7VxMOLvmyrAYBzB1PFhWbPGGAz9Z5QDcpc5J2NvaSbp1HXNkgblML
	LeSyUG6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnET-00HRte-OQ; Tue, 14 Feb 2023 04:47:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnEG-00HRpx-HH
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 04:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350064; x=1707886064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPrKthtri+NB2gPqV0Nok8p/xom0Dfj8aMpLUeYGGhI=;
  b=qx03HbBxmb6n4dvxTGkshYitvJmDdqnLwl0kMI4YUO5b6gGwkfuxaLTT
   kSWzHkHXMOV2H47SH24wiCElwVIX6JtdVQdyJr3iCXtddaeGkGVBI4vAl
   PRUyfJGqwhFApQtVtxEhNSJ93HlXxrIV9hD0xxOsDi/cCXx4S/qMx9I25
   1XG46kBC1H3BPgI2kc92auqRvXKanHcX5L11ZEBoGnYny4FvgXVkGqFFx
   Ucust+KRglxo5VkkMGXTWocq26e5Fyt/BFIQJd6ZZXa0l1CerWAgS+EsH
   DKhJuCF2uJHt2pfJKRUX4Nd/NlZsz4mz7LHYJ5OIQM1vF5tLZaQX3tg/D
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223261590"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:44 +0800
IronPort-SDR: jqVIpuNWzFYS4nIJELDVMZgXhj6J7zK0LxkG2tjK66sg7Z6angV+txPiRd3rWaZBLZOuhnr3Dy
 TM661p0IzDHzgjY9tb3CQC9fWZJeHg7QIBrZGP7JJqJbwEEG+b762Zk+5TA9NRQg16qXOilVAu
 ocryz7mJf5HQA8OuinRgFRLwHQHgYnrRulP78pFC/IV5z6DnwejMcSdRIXYyws/9synv7uKABU
 zVEiEr/yhWn8iYhbftiJKqsFyXe/Cp3fzl64Oqu9xigmNGv+c55s9+tX7rhFFhWfYq2qDW8Lfs
 Ie0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:52 -0800
IronPort-SDR: w05zWcaTY4cKo0aB3CxHw1xTaU7GgRD2DWXNBz9ac5MSCfQR2Z1DHpvF8V0z/ptfj2Ppfxc0HS
 Plc32RL7cST9mjQ0m6LbXJjqCHbzVm+1ipHMr53bAfCrWRruqbdYK1LR7H4iuFMd06IrJixC/Q
 Q5j++so8J7Tfsevl/azwXc4hGGfdv3Z586ZApQWYpFm5el+F4R2hp/jdGfKVZFepFbjb2tpo7z
 5TfZVgu0VZVZR6nS4KfysJfg2oZycdelnDxQhSzCl9RfkA2hr7Qa8LVXejrPAnb4KVRvJHK0QM
 VvY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:44 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme/046: add test for unprivileged passthrough
Date: Tue, 14 Feb 2023 13:47:39 +0900
Message-Id: <20230214044739.1903364-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
References: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_204744_657120_6C10AEBC 
X-CRM114-Status: GOOD (  15.06  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

Alters permissions for char-device node (/dev/ngX) and runs few
passthrough commands as a normal user to exercise nvme_cmd_allowed().

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
[Shin'ichiro: adjusted to normal user helper functions]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/046     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100644 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100644
index 0000000..5689a2b
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test for unprivileged passthrough
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for unprivileged passthrough on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_require_normal_user
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local perm nsid
+
+	perm="$(stat -c "%a" "$ngdev")"
+	nsid="$(_test_dev_nvme_nsid)"
+
+	chmod g+r,o+r "$ngdev"
+
+	if ! _run_user "nvme io-passthru ${ngdev} -o 2 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru read failed"
+	fi
+
+	if _run_user "echo hello | nvme io-passthru ${ngdev} -o 1 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru write passed (unexpected)"
+	fi
+
+	if ! _run_user "nvme id-ns ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ns failed"
+	fi
+
+	if ! _run_user "nvme id-ctrl ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ctrl failed"
+	fi
+
+	if _run_user "nvme ns-descs ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: ns-descs passed (unexpected)"
+	fi
+
+	echo "Test complete"
+	chmod "$perm" "$ngdev"
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 0000000..2b5fa6a
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,2 @@
+Running nvme/046
+Test complete
-- 
2.38.1


