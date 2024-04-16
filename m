Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18903C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EqjA/f+uuRFTwow4IaF34bp9SKIf2WSzlBRk53ugexA=; b=jxbbqFbnKOlbargnjtuH6LEl2u
	h3yLno5L49+a0j0j6S1v/JlSev52+QH8tIt7iMLKwenPIxCbmYqnx/hbJ+LF2yq65u0h/cMSx4m/j
	jULVZDjsPPYAH/U0wQJtePJaNp6Kn0Vmd3r++RF5HicOHcvs1Ub+vnXFve45CLBjEuo9Zqt4gv9i4
	0E4OqoY7DoN37GRfx3FFstwv9SoFWpBxxL/Yx8umsOdQJeVzBmaQXxlzMOoQ7hu9H6jY0DpcHxYpg
	P0DVUyDoMARShPZb1+fmrQrvELR8mylrfbMX5sEBINUgcdSeJSU9IIoNa8NVZP5MUxywR/B//IXDG
	DhrinOBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg7V-0000000Bo9V-0yMb;
	Tue, 16 Apr 2024 10:32:57 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6t-0000000Bndn-2ILR
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263539; x=1744799539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rzcMOsqH0Im5ddUaeNbwuyBxslay/s5Hc/qroNU+kX4=;
  b=DD3mDwvkbka5zVfEzQuRD8uFwfQeRnjFi9eEtkBf8iXwDBNpiVXou40U
   AV6Ssbk9BSeLanbnP5ZmvqhwIFS3xbGcd9tpXbR5z7j5uuHbZHY5K+RQo
   h1hi5QEStW2atY8A+yDixmNJwfWYdZuTS0zn2L3zk7iQeBYiUyksPXxvY
   seXsQg0CzSiS2LyMlMmKD+wgOVvMWIhSyxuegmrtYCZ1QmTHMil12eGuy
   gFW5jc28J4btzEggMzLypA9U3nUE5DyeRA7DVqMgUtoa8KJ5hbxqf6EFs
   fIxs31vWFcoQgBilOBawvHaVLYnnXIXNLpBeuOy3ce13dz0LxEPdWCSsP
   g==;
X-CSE-ConnectionGUID: 7nzVRM6FS9GXQeWG76bl0Q==
X-CSE-MsgGUID: cGWdUXeBR1OEHNADh1HIIw==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796915"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:19 +0800
IronPort-SDR: AZm0U2fYqM8ycNccHcwVSvEoUwsqGPs98Yn4sFSOy9sdgAuTLP7Hy1Y9NRtB2T2pXVYK/d1Sjq
 zXx9xIytKaWQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:57 -0700
IronPort-SDR: naS9laMhEXCRkmL04inqCaO0MmpHVpGjt3Ob22a+DlTIf9Jh20h0qiTBl8GSxG+YH691BANjHq
 q0raRdx+6fsmhISbYfhA5XzSHM1LF2hoD8k1FaQimE+CDktr9hktJ5HqN+9FbOEYXdrI31Ax7Q
 KeSf7wFZhzag6LgUSQGNJY/BxcCvRxXJ6TN5Z9EDw8zcLoIjLuLHhvZYR3muyL1gfLXqXZjhqk
 nrhiAKotgTuNg/+hLZNFwIcUZ/XQGnW9S/L5iLY6FypVVYPm2IaS+my+23hX319Wm7tX6eucua
 yMQ=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:18 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 11/11] nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
Date: Tue, 16 Apr 2024 19:32:07 +0900
Message-ID: <20240416103207.2754778-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033219_754492_D0CDBB04 
X-CRM114-Status: GOOD (  11.52  )
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


