Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DDFCD1284
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EqjA/f+uuRFTwow4IaF34bp9SKIf2WSzlBRk53ugexA=; b=MQuCysTjO2tCiK873u577DznO2
	jdCNbhQ+ovexNr1aSEqjO6q4oQTaSrFf/j/VRxfR6CA2q69b9BUfbmK9j9Saxi34HpYY8w4mDvWLX
	hV67AJmIW+rO+FRDTlK6In/GXenvlQMY+AIRCzPFRlt4YrMi65ouyHpOUQEa/H0iZMX/1kI1e2PEz
	BBc4IJtukEkCSML2N+ThyqQrp0+80p0moSWs43qro1dNGy3ArCYbJMqOfpOG8Xhb72ygrHiQAckYw
	Jc1B0XSWt8y6xfhvMWHocm8aHYlIGqU/YcmBjY/+juZmGzxxENHn/lBo2zerDxdagG9g1KoCLyEmf
	JVJJdyhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMU-0000000Bfnp-0ywH;
	Thu, 11 Apr 2024 11:12:58 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMD-0000000BfWS-0AbA
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833960; x=1744369960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rzcMOsqH0Im5ddUaeNbwuyBxslay/s5Hc/qroNU+kX4=;
  b=AJZtHYw/fsKjRBA5ayRdxRxqz6kwjeOU2TNoajDWAAosj5X5p25gtFpP
   HoKq5lcmvm4KD47CxPa1cA28WycJ33ggHPvUH2b+QDjQ/ED5HtZTt1lqY
   ggyYhhlqzLWZv+zn7k4QuulG//yIWz6G5uiJRiJPMYPWfIoh+mTIWJONo
   xyDHeiNVUgLWSYwIkD/JrfGk4NWON5n6MRgveEKMlsyPGft70RC8spNiC
   W7pahPuLgBaOkcu8FvxzEQN2z+5inr8Pj0WZBVhMp9RUKnFJ1aceJvDMm
   D2p9VeCHxwmp5OBXLnyZlFrTYl0Z8e8HIWeI9eNd1Ay5+8tneQBNv86Z8
   g==;
X-CSE-ConnectionGUID: oGpWn4qORISYpcVOtA4yHQ==
X-CSE-MsgGUID: u8noCsVlSwmmxqetxxeOxw==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="14005949"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:39 +0800
IronPort-SDR: WDgzrmzgV/M4JE/i56NBZzDtRaMPpXmnqJzo3/GnVZM9jY9It2xj9+/pOxpfUtAYQE1z6CIpLA
 9v9sQgJM+dKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:21:05 -0700
IronPort-SDR: w/zvdokllRG3IQ/t8GLr6ZxyQmQjxVix1TTXCZZRY/OOWLRo0n26YBRIBTb5zpsf+XUxhPwPF7
 2GVy72YuDStw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:39 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 11/11] nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
Date: Thu, 11 Apr 2024 20:12:28 +0900
Message-ID: <20240411111228.2290407-12-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041241_267845_99F024F1 
X-CRM114-Status: GOOD (  11.55  )
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


