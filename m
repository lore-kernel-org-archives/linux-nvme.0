Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83696C25B5C
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8zbqhJXyyPSGuI7eQW6+hHB3cgoUNzkqpOoA/WCp/0E=; b=0bZJqW+TpSX7uS/dMJLcv74fm4
	Lamc62INKy02hIisTIl+UaPxTPZvoXaLnPqFlyoIbFce81TgTHOqY7QDTe5kNOM20U/QEH24rA6zv
	Nj1/8vfm/NRR9k1lu61oZv/DeD3lwNro2N4f/dljEKHj6F8PDFOIMu9un7Mrgd2FNoN2tbvKxoU7A
	0So3L1FWRpZTzhErlMep7wXkAKbot14YIolGaHodoVjOQ8TuAykPqW/He16/bi+0Ik2nvWtGld+XK
	ezmZXDJYbpS5nzmvUT4cnx+QeCNCHl/++Jlysk890cUWZCy7UM2RH/YkCrJJDsxoJvPeVtTps/QjY
	H6Qpf4Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXw-00000001YtH-06ij;
	Sat, 04 May 2024 08:15:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXp-00000001YnR-2sFz
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:14:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810497; x=1746346497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lG5GYMuyEZNZtr3PgzkOH8KI6EYXvgXm7PdLubwRkjs=;
  b=MDwhHk9x3tfu7buwTlNLYDtlYXrFwWrdXZs+gWCaIGMueOKIDe9f6tka
   UAYOD+rXEHi+WemmMI07DlS1RRN04LSDyMVz3F+m9Qju3AqBPCyJCIY6i
   wosv2DKcsC4x2g0ResjOcxzI3oh77Lf5hrhDIz6dRTwLd9I7DDwwc85JO
   IaELFviFAmxh6rkpqWBMWVue9HzGy1qMrN86fyys6EGl5fXEQhgXiQ0hG
   cNfzc1W3q97LV+E5m7fB8kKnKlTKMjvvyI+Kd9vat0rWHNLMF3qmHb5N8
   V6Hl0qud7ymXGIoK30mvUL6c+00a8RvwUa2Qj3px9rkv5mWgGchPZuWSN
   w==;
X-CSE-ConnectionGUID: MZdyDcPYQuyoY6V8mNjOcA==
X-CSE-MsgGUID: gRm2KmbMSBunxEH/hEB9XQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540298"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:53 +0800
IronPort-SDR: HhLh7lBU3dUbZKINJGEolFNLWxadPVQAkw6TszpaS1rCG2o8rzs1mony4ixEjcdboxunzlsYnF
 nfbszCUufCU2GhOgGx6oNUezRneWHvHwkpi0k+OsruqIVp2fCygNj8Rxs3mHJDlzRcnLxejAWd
 fgSCKqVIy+m/goAaHe8e4SWoNeD+KUai5BX4KemYWL7b34jFsau0AYnB3nnjrEH9twNgM+kdOP
 FrjK/Vysp9xC7WVPSJ6+lzEm1p5IAPmLIguJQfJaatuyOVkHlg2ZdcvTMy2hn7ONBpHNyta1xi
 JBs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:51 -0700
IronPort-SDR: TnZsY5mQEhAvgfttTqVAfxDhETXfdWQBYyxSQ/pwzJPRDRWZp5yd3M99pw9qyt3ZFFYcY6Zx2e
 UVdjXON1gOVQzCueEqhl80cHxAbgtMTh8mVI/UOkIVN/yTKDY79PIGYkgdre69xARSuxWuqTy3
 j0vNy2mFqnSS/jPDqxgbkUELqaX+sKTI8K4ZDmxcnz5cS/qRuzrSyLtb2JERVyzkJS70UjvKQn
 /2M1rlBV6RmmdzdGrYvo16T1Z5gWvhkQad2OAiS5maazgEYLe81vTFtdwrLmiX1txwPpPWfP7m
 LeI=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:53 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 03/17] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Sat,  4 May 2024 17:14:34 +0900
Message-ID: <20240504081448.1107562-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011457_878922_A6E5418D 
X-CRM114-Status: GOOD (  18.73  )
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


