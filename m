Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB6CD128A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 11:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUkwZXnRPytLjE3beIswNpUNF2RSfQLoce/gxwmZE1g=; b=Qfay6XPeYT5HBjUkpTGgLygA0v
	nd7u7PKak8sPp290ioAtAzL8aA6fO8CAbddFZv8WWFEWFltKYynrH/JG+sXpRtIKDrzatKCJLtBVG
	g6ZpsBhI6goTO/7AJADAp5duOXKyRowINv0ObjELbB8BI6onc8eie0zjfyjIaeM8oXhsmDsGX3icZ
	qJF1bwHDkXWn9nwaIZg6UkMlpWTO2GrGCDx00j+RppzBtyjXNsch+rynvpDZ8IpfXtaT2Diaq+ZcN
	1drynqnsDlDfSeQtoVhVuxAyEacllBlkThX1behDBeuIgE5iv9cbRbAch7Ax+4pgpm/PYeNPRHMI5
	OdIGI9+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMK-0000000BfeZ-3p5u;
	Thu, 11 Apr 2024 11:12:48 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rusMA-0000000BfWS-2yz3
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 11:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833958; x=1744369958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gvq2kP8QGe4kZ9iHWlwYHHp657BYUaSrEtjR03kuTkM=;
  b=kKZopSpN2/q/61xk/f3LB4zB+vp65qmRMSpEOQT5V/mYHjjtFpxf+L/c
   EYIBYNGxWV+vlZNehSdZXe3JYcNBE395FRXKfG0pcTEIGrfOeqkNg4vj/
   kod3aLZi7fP/HwlgNdNSOT9VJJ0Iy++NdjdlyGWr3z3RbvgPYN/NQ1D6+
   5604W79qFKIiQklPzTRFgUVrZXKVjPNFmOd/Y+bHMoFKgCJgvSpfEX2bV
   RXwWP5f+iCe21HDxZnfHpEIqUjgqc1S6y9acpC6/22K5NH0g+QnnBUtju
   CPw2oRElKYWi4tkJhbwD9zOS2apdcLR8WcDzblgE6bjn95jLcun7hj2ZS
   g==;
X-CSE-ConnectionGUID: T1q7eXYeQt6MJuec2FBtWQ==
X-CSE-MsgGUID: jdli8C43T1WRhVpp5MSFBg==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="14005934"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:38 +0800
IronPort-SDR: 4Y6N0eiaibacCAq6oXZfBYjado+fZe7eR20RkZFPB8eYGP7Ne0uq55HKW543dz/v/xpK82HZQ3
 PnAdz9SHjfzw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:21:02 -0700
IronPort-SDR: TrqEZxDh+H+nP45uKrePgG9poAGhw3h7JflL9lqG/xkZ6hPd0I1obmHHW21IqUF6mDACDIAIDf
 Zw60n9vCHwOQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 03/11] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Thu, 11 Apr 2024 20:12:20 +0900
Message-ID: <20240411111228.2290407-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_041238_787407_32A8D19F 
X-CRM114-Status: GOOD (  16.96  )
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check        | 18 ++++++++----------
 common/zoned | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)
 create mode 100644 common/zoned

diff --git a/check b/check
index cef84ec..aeca894 100755
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
@@ -472,15 +476,6 @@ _check_and_call_test() {
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
@@ -538,6 +533,9 @@ _run_test() {
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


