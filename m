Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76779C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFpYp3+OkR9JCayk/I6CRB2c6/zbA/soi+FFiPCqax4=; b=YrLrPTCMUGzDpo2/FmJ3cIjHpP
	6CvHdngnFZBwfbHHSYIKW1zU2GXS5gVrmiqKKs8stqTcwEiAelC6P1SsSvh/UYFKApccNH3Fi8lnD
	z4XNYhX5XeV7vOKWgM7ahtfiVkLK5WtijvCythuJz/OICp0nYeGRVsiCvzl9CSj4zcxiq1BsbY9Cc
	qwvfFM0DknPpRTVN+n9SZFh397fdj5Ymo8ImUaOWwEhmNEdHh2BoTvbpYox0XLnyK0Hlx14BkrPan
	xbSkj+/poNlt2L+zNsBw8onrHMJT3Ixx4oI07ksI8IrRirCDHYYkA3+cXJJzV3+cLFzVOGIM7WrwI
	aAUtkOIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYm-00000003CYN-3LSx;
	Wed, 24 Apr 2024 08:00:56 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXY1-00000003BnK-3B7y
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945609; x=1745481609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8xdHdVnq2DuNvi82OK9GytjO+E9jtZ70bPcGmaQ2f08=;
  b=ixxRHxWjFrTs+chO4yZ2KKnh/7Jgra9O2TTH4J539E4HMHMQRM4iEizJ
   rDnlnHZSaBMHWVPakWhI0eDQ1p3/WNNyxADNnT4wbuy5jECdOQ2xN+oII
   s4JofE/SE7NTLcPHQv+sLeX7wm74Q9GJWDyONk/ob+9DGIMZETQNwZlHL
   f1vvRfDuxOlesvcF61Xh0YAVKJYGVJPFdRFo/Osu/SaBXqEWtbIQyWoEf
   xtP7tMhhreKqxLWsofhEifqAZQgtZWaPV6k7zsRW9uMkNjjGBDGEJKdnk
   Yg4b0W9dIM3no+6ru1RZyAyGi6wBdDfRQ1FXy7WZgSEol7ObzbAYZ+SbH
   w==;
X-CSE-ConnectionGUID: vJXh+KVjSaivTELiByFmLA==
X-CSE-MsgGUID: 5mB84CUERGqNWXepFw1DwQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738277"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:09 +0800
IronPort-SDR: RI1k/9132q5gy+DnyNKsp5K1u2htemmVZ9a24CYXT6Vo2YRAZ4fVvATOkia74HkkyPRpDamjKU
 0dE//AGnPoeBLlHyVPMLB63dd+x5w9hRXPfDIsmNp2A9C69HvYZ0G1c0lrtBnDQQKLz0TYN6vJ
 tD0WiLvU1F82rfdXqsf5ILgNlM4WgpRdTJ1HtHa3ZMTqwDWPeGR5TgLqnwNlw2G97qt1/YXTEz
 szbxnDJZrHXMjzBnu5zTzDfJaONpHCcb8278pot2jnt3vgqR9Pf+bV87xqKmTltiCQ9Qz7COlr
 KOg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:19 -0700
IronPort-SDR: 3ZbTAafxwQ4Xu/YkdmnTyMImm4/52wWERPKIemNrZ9bUE4R4ka3f0bql00Umq6k74qFvAqo3z4
 V1h4epcXg3GgOmA9nnRmBAonPEfQHb7VWKgsMQTcNuM1lcHbBbL5nBkyNq1qBJKp8fTSTxe4Fl
 9fbWqToX5ANZLGgoJwIu4ZXmY9Ven7Qjab1k1aMw6SRTFI8ou1RCgd6meXvD0WsMwsNPBdM4ln
 t0n0AB9iUE5c6WWWgRmv/PTUpblIWx0NKxcc3Nx18Vxg386JJSf3luwFJJLS8dXr4a87kqOo++
 fEE=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 12/15] nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
Date: Wed, 24 Apr 2024 16:59:52 +0900
Message-ID: <20240424075955.3604997-13-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010009_999641_615AEA09 
X-CRM114-Status: GOOD (  11.93  )
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

From: Daniel Wagner <dwagner@suse.de>

There is no need to hardcode the target blkdev type. This allows
the user to select different blkdev types via the nvmet_blkdev_type
environment variable. Also modify set_conditions() hooks to call
_set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvme_trtype(),
so that the test cases are run for all blkdev types set in
NVMET_BLKDEV_TYPES.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: modify set_conditions()]
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/021 | 8 ++++----
 tests/nvme/022 | 8 ++++----
 tests/nvme/025 | 8 ++++----
 tests/nvme/026 | 8 ++++----
 tests/nvme/027 | 8 ++++----
 tests/nvme/028 | 8 ++++----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/nvme/021 b/tests/nvme/021
index 270d90e..d7add6f 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe list command on NVMeOF with a file-backed ns.
+# Test NVMe list command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe list command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe list command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index adaa765..0f2868c 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe reset command on NVMeOF with a file-backed ns.
+# Test NVMe reset command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe reset command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe reset command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 224492b..a171099 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe effects-log command on NVMeOF with a file-backed ns.
+# Test NVMe effects-log command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe effects-log command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe effects-log"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 6ee6a51..7196c60 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe ns-descs command on NVMeOF with a file-backed ns.
+# Test NVMe ns-descs command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe ns-descs"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index a63e42b..b117cc1 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe ns-rescan command on NVMeOF with a file-backed ns.
+# Test NVMe ns-rescan command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe ns-rescan command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe ns-rescan command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 65c52a9..d6ffdd6 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe list-subsys command on NVMeOF with a file-backed ns.
+# Test NVMe list-subsys command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe list-subsys command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe list-subsys"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -24,7 +24,7 @@ test() {
 
 	_setup_nvmet
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-- 
2.44.0


