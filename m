Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B4C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gMknTCyMtR5eQJO0ZE/YCFaXdOwVGp3IMM58XUSSZ1M=; b=UYmYY4vma62zcmMCHUGfps6qs2
	zjRcrukwPpganie048P6AJd6d2MZemTWtxZQhIQbCyzyOjiGK6PqdvoYCc4ji7P/rkamRfBf5Ogi2
	ePVBoBPAk5qYojfabn65Q26sCJ64SKbmDMIYvpYK6YLj3NDOIn6WWdYpUBTt3WN6eKiYow5VrVqLh
	HehtD2oKEzsgjVx/LjH3A9+RzDnojD4UqqNXHWR9XpyB83FZBHkEtRYbIxQeqePkXX3jO5BpIuP8g
	x16VeDWxJ8fNZ2GGy07+Dk6I1i4jHjBoeSHFhKnc+yzODEvHHuOetYfx7XoSZML5kfWiXeb+FV1z/
	uUNBNgPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg7P-0000000Bo3y-22D4;
	Tue, 16 Apr 2024 10:32:51 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6s-0000000BnZ6-2Kg0
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263538; x=1744799538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvJF2shEgndKaExsvjj2e8YuMaD5oXBayXp85FAgT6U=;
  b=ibmazu0y4fM5f6cE7kF0JXZLz62S7pO/e4f8jP43Jrngx08/dBvRB9Gh
   oj+i5BftWYN9ooECXKBDpLBWHacHK0P0g+GHB3JTCp3jH97lZvuaoFjxh
   t68CDPjIM9NQsCOa3xT94v4iObXO9kFMAYgJ/TNeYhKMxJB/x1MPUuumd
   Tv2LPjeLjwORl81HheqqQgrwZ7k9gc7UWPbx67i6yx/aRF3QWNUFfgs09
   qmWd7w4hbC4snmWae5F8DMJWt+TBcirIJH/XAsNx/f4FZGy3xYcatW97S
   85rr+KeRA69av5t7VgZKB1d02cirL7QzolI5Y3568wpefhrHCmGC1Vupk
   g==;
X-CSE-ConnectionGUID: lNmYmW/MSSGdusTHnuwOEg==
X-CSE-MsgGUID: EehzvgIFTMKmoYUWw7Tr8g==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796913"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:18 +0800
IronPort-SDR: HPxzPgLRkaa9OOncLmi+IZy4Acxllkr0mUrH4hFzbMyUbKARSzVQVUS6gHs3L7jSAf0dwSp6vo
 bCSZiqOsqryQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:57 -0700
IronPort-SDR: D0jN0SHQiXANwlRbbvdLzGBwQT40Qie4ItnrCPBJ1avBsYhg/uFh7AdeRDGM9JwtsS1MhunVqD
 vdSB3CLYkZDbB/4cgiDcQXzC0+G5/5plQxE2sMmAkRwrbSf8kxBcc27LoVyzyq5Hz213dKhUv1
 LbJt0zXAUHRMFJUMinXMswEaSgzkZuZaW1Z+JTlSSTGExwDNVhQFIA4HJ5dztbVYMekmuRoqWE
 /ckLZMuZzbZr3IOnFXAaxHFP5H2XOnMblDzUkz8K7hy+oiJ02L5xQMGWROvdkPu/shPwIXPZV9
 3PQ=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:17 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 10/11] nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type tests
Date: Tue, 16 Apr 2024 19:32:06 +0900
Message-ID: <20240416103207.2754778-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033218_801102_F24C380E 
X-CRM114-Status: GOOD (  17.06  )
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

There are various tests which only differ on the blkdev type of the
target. With the newly added feature which allows to control the target
blkdev type via the environment, these duplicate tests are not necessary
anymore and reduces the maintenance overhead.

The removed tests are covered by the other test cases nvme/006 ,008,
010, 012, 014, 019 and 023 using 'file' blkdev type.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/006     |  5 ++---
 tests/nvme/007     | 32 ----------------------------
 tests/nvme/007.out |  2 --
 tests/nvme/008     |  4 ++--
 tests/nvme/009     | 40 -----------------------------------
 tests/nvme/009.out |  3 ---
 tests/nvme/010     |  4 ++--
 tests/nvme/011     | 43 --------------------------------------
 tests/nvme/011.out |  3 ---
 tests/nvme/012     |  4 ++--
 tests/nvme/013     | 47 -----------------------------------------
 tests/nvme/013.out |  3 ---
 tests/nvme/014     |  4 ++--
 tests/nvme/015     | 52 ----------------------------------------------
 tests/nvme/015.out |  4 ----
 tests/nvme/019     |  4 ++--
 tests/nvme/020     | 44 ---------------------------------------
 tests/nvme/020.out |  4 ----
 tests/nvme/023     |  4 ++--
 tests/nvme/024     | 44 ---------------------------------------
 tests/nvme/024.out |  2 --
 21 files changed, 14 insertions(+), 338 deletions(-)
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

diff --git a/tests/nvme/006 b/tests/nvme/006
index 0e1f142..0ea679b 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF target creation with a block device backed ns.
+# Test NVMeOF target creation.
 
 . tests/nvme/rc
 
-DESCRIPTION="create an NVMeOF target with a block device-backed ns"
+DESCRIPTION="create an NVMeOF target"
 QUICK=1
 
 requires() {
@@ -24,7 +24,6 @@ test() {
 
 	_setup_nvmet
 
-
 	_nvmet_target_setup
 
 	_nvmet_target_cleanup
diff --git a/tests/nvme/007 b/tests/nvme/007
deleted file mode 100755
index 3b16d5f..0000000
--- a/tests/nvme/007
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF target creation with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="create an NVMeOF target with a file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-
-	_nvmet_target_setup --blkdev file
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/007.out b/tests/nvme/007.out
deleted file mode 100644
index fdb3472..0000000
--- a/tests/nvme/007.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running nvme/007
-Test complete
diff --git a/tests/nvme/008 b/tests/nvme/008
index b53ecdb..838eb07 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF host creation with a block device backed ns.
+# Test NVMeOF host creation.
 
 . tests/nvme/rc
 
-DESCRIPTION="create an NVMeOF host with a block device-backed ns"
+DESCRIPTION="create an NVMeOF host"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/009 b/tests/nvme/009
deleted file mode 100755
index d7b1307..0000000
--- a/tests/nvme/009
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF host creation with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="create an NVMeOF host with a file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local nvmedev
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
deleted file mode 100644
index 4d53a8e..0000000
--- a/tests/nvme/009.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/009
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/010 b/tests/nvme/010
index 0417daf..9ea2561 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# This is a data verification test for block device backed ns.
+# This is a data verification test.
 
 . tests/nvme/rc
 
-DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
+DESCRIPTION="run data verification fio job"
 TIMED=1
 
 requires() {
diff --git a/tests/nvme/011 b/tests/nvme/011
deleted file mode 100755
index bd29129..0000000
--- a/tests/nvme/011
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# This is a data verification test for file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="run data verification fio job on NVMeOF file-backed ns"
-TIMED=1
-
-requires() {
-	_nvme_requires
-	_have_fio
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${ns}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
deleted file mode 100644
index ebbb4f7..0000000
--- a/tests/nvme/011.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/011
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/012 b/tests/nvme/012
index 37b9056..d0eb487 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test mkfs with data verification for block device backed ns.
+# Test mkfs with data verification.
 
 . tests/nvme/rc
 . common/xfs
 
-DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
+DESCRIPTION="run mkfs and data verification fio"
 TIMED=1
 
 requires() {
diff --git a/tests/nvme/013 b/tests/nvme/013
deleted file mode 100755
index 91da498..0000000
--- a/tests/nvme/013
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test mkfs with data verification for file backed ns.
-
-. tests/nvme/rc
-. common/xfs
-
-DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
-TIMED=1
-
-requires() {
-	_nvme_requires
-	_have_xfs
-	_have_fio
-	_require_nvme_trtype_is_fabrics
-	_require_nvme_test_img_size 350m
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	if ! _xfs_run_fio_verify_io "/dev/${ns}"; then
-		echo "FAIL: fio verify failed"
-	fi
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
deleted file mode 100644
index a727170..0000000
--- a/tests/nvme/013.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/013
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/014 b/tests/nvme/014
index bcfbc87..1429180 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF flush command from host with a block device backed ns.
+# Test NVMeOF flush command from host.
 
 . tests/nvme/rc
 
-DESCRIPTION="flush a NVMeOF block device-backed ns"
+DESCRIPTION="flush a command from host"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/015 b/tests/nvme/015
deleted file mode 100755
index b5ec10c..0000000
--- a/tests/nvme/015
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF flush command from host with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="unit test for NVMe flush for file backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_have_loop
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-	local size
-	local bs
-	local count
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	size="$(blockdev --getsize64 "/dev/${ns}")"
-	bs="$(blockdev --getbsz "/dev/${ns}")"
-	count=$((size / bs))
-
-	dd if=/dev/urandom of="/dev/${ns}" \
-		count="${count}" bs="${bs}" status=none
-
-	nvme flush "/dev/${ns}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
deleted file mode 100644
index f854f0b..0000000
--- a/tests/nvme/015.out
+++ /dev/null
@@ -1,4 +0,0 @@
-Running nvme/015
-NVMe Flush: success
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/019 b/tests/nvme/019
index fb11d41..d4cb926 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe DSM Discard command on NVMeOF with a block-device ns.
+# Test NVMe DSM Discard command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe DSM Discard command on NVMeOF block-device ns"
+DESCRIPTION="test NVMe DSM Discard command"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/020 b/tests/nvme/020
deleted file mode 100755
index 4993e36..0000000
--- a/tests/nvme/020
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMe DSM Discard command on NVMeOF with a file-backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="test NVMe DSM Discard command on NVMeOF file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-	local nblk_range="10,10,10,10,10,10,10,10,10,10"
-	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	nvme dsm "/dev/${ns}" --ad \
-		--slbs "${sblk_range}" --blocks "${nblk_range}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
deleted file mode 100644
index 61be280..0000000
--- a/tests/nvme/020.out
+++ /dev/null
@@ -1,4 +0,0 @@
-Running nvme/020
-NVMe DSM: success
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/023 b/tests/nvme/023
index a723b73..78dfb9e 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe smart-log command on NVMeOF with a block-device ns.
+# Test NVMe smart-log command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe smart-log command on NVMeOF block-device ns"
+DESCRIPTION="test NVMe smart-log command"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/024 b/tests/nvme/024
deleted file mode 100755
index cab1818..0000000
--- a/tests/nvme/024
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMe smart-log command on NVMeOF with a file-backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="test NVMe smart-log command on NVMeOF file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_have_loop
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns ${def_subsys_uuid})
-
-	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
-		echo "ERROR: smart-log file-ns failed"
-	fi
-
-	_nvme_disconnect_subsys >> "$FULL" 2>&1
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/024.out b/tests/nvme/024.out
deleted file mode 100644
index 76c3e29..0000000
--- a/tests/nvme/024.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running nvme/024
-Test complete
-- 
2.44.0


