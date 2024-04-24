Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78F7C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8zbqhJXyyPSGuI7eQW6+hHB3cgoUNzkqpOoA/WCp/0E=; b=XCfJQHAxrFloWRmCOvdXQppZqq
	FSkhTxgtCuBWtBHX/cJlrHaeKVYU++aYTMKPfE/IbYYwVz+lJR7pIo6VK9Ocqm4vPT3m5IpyWmjb7
	qWLrMo/YMz5pc2EFY01BR7dmTc+MUx28SospORKvKVRn9Tsyq4dpxjEM2r3DWIu0sM6EdEIa6rFaP
	tj3nbXkcpOr+sJguhtuc+9E1IcIKs941Z6N1m/EByrv8h9FpOKR/CP1N3SGeZdlmorJPm84M4ktwl
	IXC/j2yHfHHHCwU+SdSF11s0aZIQwLOwbHDiR1nhNtbK2AvL6QJ4Y52gma6+hdFNGpNmLCW5iKttx
	CvmNrMyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYB-00000003C48-19hT;
	Wed, 24 Apr 2024 08:00:19 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXu-00000003Bnw-1lZU
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945602; x=1745481602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
  b=k11mNJ0SGwtyFMMZRuf9HlqXtUBMzl5mfb20pN71chMYaPWLwWlCj6El
   VfFSCxtSu8+zbcuW2YItKf41b850LoeJ2mArTpuYsTWvzA1x0xjWGrMtQ
   lZBbdMlpGZVsvtOoyCF1gglgwn86/uNrqyjdDu2/xRoLltGr2Tv7NoR7H
   yGGPYKIedA/Ech994OmLpD2TQA4WMA3LkwPYvjykyF5r86jUO1nIx+kjj
   czTUwQ8xLXFkEz7rSBO4ssM1y47dpV0tndzfdd/P8Li+lPcVtuxh2CBWd
   w7Txj/0E8Ns7RRo9hoGVHTwUEPEGHrRUpo5T6dLyCsg94gQ2RlZJGPGSQ
   g==;
X-CSE-ConnectionGUID: BNVYaUTVS7KXjObHhJgrRw==
X-CSE-MsgGUID: iQq276NWQpC23T1c0XfVog==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:00 +0800
IronPort-SDR: KBbIwse27Z0OsjIZtwhpwPgiS3RacrPfhq+2fILT2XUMmWuUCvljsnJxNZVFY70Sr4GKb1JlJB
 OIZkriK/0Vfo008U8EFkaTsim+Cf2gDS0fx46i5UoibPS5hqVy2YNWfO8s5vTsnufwOtnBTGCe
 VT1P+ELSwR86DmY2Lt6AyZgnZwPAfD3QKj/tEBDBlshZ6Edfd5eMcoiamUrxMld43PNkFMFsAa
 tTgXbkhwfxuRi0LOO8FLSnIAwfBuxF7YRMQQOIYRPYl2/nDVxWRDHE4Mg4bqze1gUZ4nsXqTOw
 q0o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:09 -0700
IronPort-SDR: 7ZI83bO/6w3h1mphMJLq9putUiGHtXW82tRutl7d8uisL7r1SW7JsxGSx8qtfxXtCRl1zscLAR
 gA0+Q+4lua/hXXIYu2WVcyHD/ROKUBFLO1GNTCHrcVEMODcHdJS8i4oS0+YAs1SLyTrYnVFGfB
 WJJ7aMHPcstomIYQSj3AInQNbskfAbaOBKxqjB5kgtfNKafRh5N/KHoFeSCF04kCxdz/5A9Evy
 PBjo+7dTeuESjCmE9WtHL5y3Grm23RKr8VcwnLQgs+PVig9urxfczxfI7ridHoGHRsVcxVCs3/
 DCg=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 03/15] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Wed, 24 Apr 2024 16:59:43 +0900
Message-ID: <20240424075955.3604997-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010002_783629_A703D431 
X-CRM114-Status: GOOD (  17.44  )
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

When the test case with test() function is marked as CAN_BE_ZONED,
blktests runs the test case twice: once for non-zoned device, and the
second for zoned device. This is now implemented as a special logic in
the check script.

To simplify the implementation, use the feature to repeat test cases
with different conditions. Use set_conditions() and move out the special
logic from the check script to the common/zoned script file.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check        | 19 ++++++++-----------
 common/zoned | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 11 deletions(-)
 create mode 100644 common/zoned

diff --git a/check b/check
index edc421d..3ed4510 100755
--- a/check
+++ b/check
@@ -56,6 +56,11 @@ _found_test() {
 		return 1
 	fi
 
+	if [[ -n $CAN_BE_ZONED ]] && declare -fF test >/dev/null && declare -fF set_conditions >/dev/null; then
+		_warning "${test_name} defines both CAN_BE_ZONED and set_conditions()"
+		return 1
+	fi
+
 	if (( QUICK && TIMED )); then
 		_warning "${test_name} cannot be both QUICK and TIMED"
 		return 1
@@ -194,7 +199,6 @@ _output_status() {
 	local status="$2"
 	local str="${test} "
 
-	(( RUN_FOR_ZONED )) && str="$str(zoned) "
 	[[ ${COND_DESC:-} ]] && str="$str(${COND_DESC}) "
 	[[ ${DESCRIPTION:-} ]] && str="$str(${DESCRIPTION})"
 	printf '%-60s' "${str}"
@@ -464,7 +468,6 @@ _unload_modules() {
 
 _check_and_call_test() {
 	local postfix
-	local ret
 
 	if declare -fF requires >/dev/null; then
 		requires
@@ -473,15 +476,6 @@ _check_and_call_test() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
-	ret=$?
-	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-		RESULTS_DIR="$OUTPUT/nodev_zoned${postfix}"
-		RUN_FOR_ZONED=1
-		_call_test test
-		ret=$(( ret || $? ))
-	fi
-
-	return $ret
 }
 
 _check_and_call_test_device() {
@@ -540,6 +534,9 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
+		if ((RUN_ZONED_TESTS && CAN_BE_ZONED)); then
+			. "common/zoned"
+		fi
 		if declare -fF set_conditions >/dev/null; then
 			nr_conds=$(set_conditions)
 			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
diff --git a/common/zoned b/common/zoned
new file mode 100644
index 0000000..6a8f1e5
--- /dev/null
+++ b/common/zoned
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Western Digital Corporation or its affiliates.
+
+# The helper function for test cases with CAN_BE_ZONED flag and test()
+# function. Run the test case twice for non-zoned and zoned conditions.
+set_conditions() {
+	local index=$1
+
+	if [[ -z $index ]]; then
+		echo 2
+		return
+	fi
+
+	if ((index == 0)); then
+		export RUN_FOR_ZONED=0
+		export COND_DESC=
+	elif ((index == 1)); then
+		export RUN_FOR_ZONED=1
+		export COND_DESC="zoned"
+	fi
+}
-- 
2.44.0


