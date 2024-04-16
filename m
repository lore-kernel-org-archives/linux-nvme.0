Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B0FC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zn5XRH6L1TrC5LqUpFIZ0AMs5Y4F+b5zeF3z1LpeIfM=; b=A8rOUX+NQ+8SZ/knFt4TbHlaT2
	Oveq/7aPhJANJMKUYnHuwovPzL+79aUtZldQ5iPz5ZkNsIzlz55+UzCEFrp24PY7q4Bo0dUIf/BTp
	DIDsyLxiJrJaeX5W2OsqaJuPXWoFec2s8GB0ADem67tU9bJaIp+PlkuEz+LEjf1cxr7RM1ewaIzyf
	4Fg/3c3vOKP7VhzV2SoVWY7XDyFGtyqtvJwxqwRyJKoT04Nh807/wkpC3JQMFJ/BCvM6VTK9TVG6K
	E3PGXrp/npTRu8dos62Y1Z9gh2G5GUNOJHYzponIHFC5rqQZJl5sHk8HpK/KsF5cUf8oI99XIMIvk
	Hpzurg9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6o-0000000BnaX-4144;
	Tue, 16 Apr 2024 10:32:14 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6m-0000000BnZ7-1bco
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263532; x=1744799532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OvgikZMeVjQImGamzRSuQl9g9/GvBeWvN5ptIDlf9UU=;
  b=f6iqNf4WRImD8KkpI9E7kcbN4HXp0lw0JlRhx2wJCZH7RGL0fbIPq7jH
   IZU2qdzNlIh3sH7sFGzVDRMMXgvwUoavx2USqjL201u6HWOD6pOMOamnO
   E87MayZEBUtBxKY7EHlDcNy5mu3VwNbUj+6PBLyKZ7R0w/IxoF7CHIYu2
   0UaOsYMpn8G4EUR1JGol0MjVK2bPl8yvFYpTWO2LyllfskstUge+x165+
   UUQns0JNIxJUTFu5EizUBx9x1+RmGZDHCxYgp0Eul7Q/aMoeUNzGCzy01
   9BqTPlBcE5yIpLJe/gD40wUHtB9yTu7wRACuuwB0ouXCad15opw6OL2Cg
   w==;
X-CSE-ConnectionGUID: Y7KAEDGfR6urhyBYQVetFg==
X-CSE-MsgGUID: cigpGweAQiWGpw7ziKD9AQ==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796895"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:10 +0800
IronPort-SDR: ynUHoZfgOtej5qCXoMGzJNLJt/CPKKHsCN5/HqBSukDbI3lC0zYc+O+CBSHIG1GGe3QJw8npsl
 hKm0oSjPMUKQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:48 -0700
IronPort-SDR: LZSI8JEanNsG3//X4HaccHNrCOh6BKGs1PjUho+9IXMZXa9AfI7oVgskBI4IJE7XuNd6WhdsNf
 8FAHL6pibhjp6VkQHFmjgqfKMzBb/FbST9aADYx3AghUnZE8nDlvoSk6rHJygpJnJidMO3TMks
 FZMmjJ9xIjTFwbmDq6hcFjZtfMmczOnR0mJUSsLd1dr0UZ9KuwI8JlbMldqepeTAYbevlp6epI
 5OTqp75x+8En0AxCzRPmIAKtQe1EqPhsMMPi7sQzK8wfp7W6hGlVpLYzomwm7TnxpbtVy08p9w
 DmM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 01/11] check: factor out _run_test()
Date: Tue, 16 Apr 2024 19:31:57 +0900
Message-ID: <20240416103207.2754778-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033212_569660_08C99E98 
X-CRM114-Status: GOOD (  11.34  )
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

The function _run_test() is rather complex and has deep nests. Before
modifying it for repeated test case runs, simplify it. Factor out some
part of the function to the new functions _check_and_call_test() and
_check_and_call_test_device().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 check | 93 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 37 deletions(-)

diff --git a/check b/check
index 55871b0..7d09ec0 100755
--- a/check
+++ b/check
@@ -463,6 +463,59 @@ _unload_modules() {
 	unset MODULES_TO_UNLOAD
 }
 
+_check_and_call_test() {
+	local ret
+
+	if declare -fF requires >/dev/null; then
+		requires
+	fi
+
+	RESULTS_DIR="$OUTPUT/nodev"
+	_call_test test
+	ret=$?
+	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
+		RESULTS_DIR="$OUTPUT/nodev_zoned"
+		RUN_FOR_ZONED=1
+		_call_test test
+		ret=$(( ret || $? ))
+	fi
+
+	return $ret
+}
+
+_check_and_call_test_device() {
+	local unset_skip_reason
+	local ret
+
+	if declare -fF requires >/dev/null; then
+		requires
+	fi
+
+	for TEST_DEV in "${TEST_DEVS[@]}"; do
+		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
+		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
+
+		unset_skip_reason=0
+		if [[ ! -v SKIP_REASONS ]]; then
+			unset_skip_reason=1
+			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
+				SKIP_REASONS+=("${TEST_DEV} is a zoned block device")
+			elif declare -fF device_requires >/dev/null; then
+				device_requires
+			fi
+		fi
+		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
+		if ! _call_test test_device; then
+			ret=1
+		fi
+		if (( unset_skip_reason )); then
+			unset SKIP_REASONS
+		fi
+	done
+
+	return $ret
+}
+
 _run_test() {
 	TEST_NAME="$1"
 	CAN_BE_ZONED=0
@@ -482,19 +535,8 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
-		if declare -fF requires >/dev/null; then
-			requires
-		fi
-
-		RESULTS_DIR="$OUTPUT/nodev"
-		_call_test test
+		_check_and_call_test
 		ret=$?
-		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-			RESULTS_DIR="$OUTPUT/nodev_zoned"
-			RUN_FOR_ZONED=1
-			_call_test test
-			ret=$(( ret || $? ))
-		fi
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
@@ -516,31 +558,8 @@ _run_test() {
 			return 0
 		fi
 
-		if declare -fF requires >/dev/null; then
-			requires
-		fi
-
-		for TEST_DEV in "${TEST_DEVS[@]}"; do
-			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
-			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
-
-			local unset_skip_reason=0
-			if [[ ! -v SKIP_REASONS ]]; then
-				unset_skip_reason=1
-				if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
-					SKIP_REASONS+=("${TEST_DEV} is a zoned block device")
-				elif declare -fF device_requires >/dev/null; then
-					device_requires
-				fi
-			fi
-			RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
-			if ! _call_test test_device; then
-				ret=1
-			fi
-			if (( unset_skip_reason )); then
-				unset SKIP_REASONS
-			fi
-		done
+		_check_and_call_test_device
+		ret=$?
 
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
-- 
2.44.0


