Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF5C04FF6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1bqOKlyrxuZViC0cS5/1k245uinxQKY8PVeh4zD5Xc=; b=tpHkI0Bji0bCOEAWnsnkjEbN0b
	31INHbh48eoUbnJylKpdBzsw+VwezbMOQ+XXnftu/IlCGF38CtDooTu7qCqt+BBZzd3/jRsGCDDdc
	pxAn7nfCGADm6Tq+d6jp0v45SNyhWLAWn9+iZFNkp6yPOJbUnKKwx7uxlKpH3qajed5SzQdZdvrkb
	lSGuu7dwwuj3hWuwgDP6BvuW04cv5SX+MzRe/gS815dDyICVbaXzVshVo+zoupTs/zz3uhabUjiVK
	Bvpc3/59/X/UfkCbnrddjFCipOOOyRctGBLDWRtpqew4ENRNTnNd+U03v23BQEjbUKzh1RmxXV3EO
	EGOAvjHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6y-0000000BniO-3auk;
	Tue, 16 Apr 2024 10:32:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6n-0000000BnZ7-3Q3p
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263533; x=1744799533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OULd77odMzihZqoRtAKAJByG8IrF0EFlmFWrGigNWSg=;
  b=LO/AREs76DS93vnIvjAo99HiEeaCf06iJmCNOzXj5dgZmY8d8ZJZa5lV
   ZY9LVX2zKbKMZKkl4jRDsjrJ5XKnngDrm58hlHPj44VtYNvYhVR2D83QL
   ESa4g3hk6lttzAYN2B29dVq56zNZMOK+9SvYltefrMI5tb2RYvWcHQPdX
   zkFpxVuh5GbxPBZK6cVYJWdvF19iZ82g0rlz67WJMV5oxtPcdfWSOdK/w
   KYrb00t9Ts9CFqkJZGnEQd+EK8pR9BQvSPdE3EVgCsgyYmvFkdsGlY8PF
   fausX5HklCoXMfgro+SRjHEftiRrl42xkUxIVR4UvRraiW8Y93enAp3bm
   w==;
X-CSE-ConnectionGUID: WSg3D0s3RPacAGlXoKnZwQ==
X-CSE-MsgGUID: ty1rwd2ITpuzE1r+kfrINg==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796898"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:11 +0800
IronPort-SDR: 3GeqihIXNWAftbZwaVaYKBBMhfp95Cc/GYXB8D8Tljq9kuEW/M3IAFM+LRgWaIvbDhXgPGKaLm
 uo7KvJ1KCMrQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:50 -0700
IronPort-SDR: OG1vlJXPg0nZfzFnr5t+P0MJNu7zY0MN9sHkwwcmMhvsjurQ6nF0hZKU8OxwH0yG8KrY8TzM9i
 whTBqJuB44od0II4cRIdAuvgBtTK138HWVC5lznWmOMor08QF1M1K1p0RdcoIH0W8lrltLrlL9
 ZchcUuPSbAiG1BLc7KzXCZI2hSNsia7wR2v9+/6PdlmkynMN8HtnMN/ZzMSLsB1Q4U+OXXEcaN
 2Pc3SeIjVXP5krRKcdlLIh5oGG0Za33bKQw4IaEXfTeyO/tIeUr+9nPZLY6S6pVXeJrZX5Ujdd
 5fs=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 03/11] check: use set_conditions() for the CAN_BE_ZONED test cases
Date: Tue, 16 Apr 2024 19:31:59 +0900
Message-ID: <20240416103207.2754778-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033213_910408_823D13A5 
X-CRM114-Status: GOOD (  17.14  )
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


