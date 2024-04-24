Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F3CC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKOPjG6KMj1YH0pEwHx037DLB7y1P/Cx39jcsk+lMLc=; b=mGlRh1FBzhTg+smfa/rS0u3lSw
	lGKD+3XLfCR1dhydEPKDCrU0er8kgajEb1CjYGypj9HaizZxameVicuPjj3smoV09q1IL0nqMixGM
	xMTu2EkueaMrPw5lN7ocV3c6mI0786vyaJixiGBDdBIvhuSxaRROVgVnvPT9sZVpVH0tkXgiSGw2H
	E4XmZ/Y0d8oxj4wSBNkbW9MEeFRSMlA9zZNLsJANgyYkQNYTon+J84lLqXr0MpU63MvvKf/iWHT3R
	y9CYFU7SToCCqrBzkOwELVTcYZJCFFC3XzKdF9IJ9JlHf77o6ls50zB8ZDwW4A3dIvYDVUsYu3GMP
	sd8ZmS8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY7-00000003C0q-2l3J;
	Wed, 24 Apr 2024 08:00:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXu-00000003BnK-23mg
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945602; x=1745481602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dx9il75eOILsBu5G1//4p+1/FA3YyekAV1bi+io5+Q=;
  b=fCbYz/MZcZ5H2yj019TTZqhOnBpcoy0wMCYiCaueZgposjZ1MAhskq2e
   LGjZQeryBQvVRKe3/SyA1ZNibKsnP7ROzmdPdPYA+kqSk8sWhDQVhNixB
   61PX/BLrwv+XL7Rxi44u5tuBVZHUGgltaOAwbrKc2jUj7lgd8GQWhq9E7
   ohETxl5qauaJZoXG75IA7aga2DMwGXdXswW9vfQad967UEPoFNYytPZxf
   kBN9tzACPTg00P5gVIinGA7RDF0zMpNPswWhk1Xo36YM3GhF/PgAU1Qha
   8vW5ZxUs6qC3xvtH3ZcHs/Fb3tGaHaHRB4dSj3rWCxUGRnoGS4r9fvJ5G
   w==;
X-CSE-ConnectionGUID: 5udsp1e1Qam4TtOI7KkI9Q==
X-CSE-MsgGUID: rlkPjgERQ72+t9t4TSbHTg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738261"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:01 +0800
IronPort-SDR: Pw1wVKerSa9P3D5xlTS71WMav1m3Bpc4t3yvviIqmRq+nF3x9AWNvBeOvg2oNJZNoFVjqJ4F+A
 QpkHX1k/YGI/MT+LlZZxUND7ouy9nKg4xCOsskOioirWiMJ16VZc+FYTovsbGSbv/VSQQZ3TOb
 VD5ttL7hI0SEqvlbE+4BAJDZ8UzI2/jhi63RPa/2Us/yqYnQXtySeHLVof55Qk1EDwURHVBUBm
 zR+tc7bexiVkrl9miysnMie/+RKR3y0HAfuKPACYnTddaQl5xxU4hucyNk1KjTUJlLJYhXyaH+
 PMI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:11 -0700
IronPort-SDR: 5eQpFKT9/T8nkJ8Clm2XKneTWPatvF+Rgcfg581snZinkRIpgrPpuomMpDtXGoKWr0AVyG6Q4O
 PULOvIqEsLQ+9RnttqUkUAEPcFgGe+dEXoyluVIlsy7m7hMkEUBdgO6oXLRqjYoN++GBznP5sK
 jMA9c4TLoYTASJY7OVK6Jd3dB53wVWm7SQPdvZ3lmzePFENpUzwwOGO3odrI+5i/5bMg4Phbqg
 AJm44hIFtLTgPuoEt1KMhMdE+KJ2m/pgkQomKLoC4TNDesqwHWwx+npsd8itwLdkjbafHFs9Q9
 IU0=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 04/15] meta/{016,017}: add test cases to check repeated test case runs
Date: Wed, 24 Apr 2024 16:59:44 +0900
Message-ID: <20240424075955.3604997-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010002_850805_BC9E5FB2 
X-CRM114-Status: GOOD (  13.86  )
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

Add test cases to confirm the feature to repeat test case runs with
different conditions is working.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/meta/016     | 29 +++++++++++++++++++++++++++++
 tests/meta/016.out |  2 ++
 tests/meta/017     | 29 +++++++++++++++++++++++++++++
 tests/meta/017.out |  2 ++
 4 files changed, 62 insertions(+)
 create mode 100755 tests/meta/016
 create mode 100644 tests/meta/016.out
 create mode 100755 tests/meta/017
 create mode 100644 tests/meta/017.out

diff --git a/tests/meta/016 b/tests/meta/016
new file mode 100755
index 0000000..caf876d
--- /dev/null
+++ b/tests/meta/016
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/016.out b/tests/meta/016.out
new file mode 100644
index 0000000..cccfec4
--- /dev/null
+++ b/tests/meta/016.out
@@ -0,0 +1,2 @@
+Running meta/016
+Test complete
diff --git a/tests/meta/017 b/tests/meta/017
new file mode 100755
index 0000000..03f92d6
--- /dev/null
+++ b/tests/meta/017
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+#
+# Test repeated test_device() run with set_conditions()
+
+. tests/meta/rc
+
+DESCRIPTION="repeat test_device()"
+
+declare cond_set_index
+
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	cond_set_index=$index
+	COND_DESC="condition set $index"
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	echo "condition set $cond_set_index" >> "$FULL"
+	echo "Test complete"
+}
diff --git a/tests/meta/017.out b/tests/meta/017.out
new file mode 100644
index 0000000..7fc55ff
--- /dev/null
+++ b/tests/meta/017.out
@@ -0,0 +1,2 @@
+Running meta/017
+Test complete
-- 
2.44.0


