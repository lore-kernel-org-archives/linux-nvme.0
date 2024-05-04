Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1612C4345F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XB8CqyS5jwJzczB8cNhrvXAXssf76AdkM6/QwXu05dY=; b=5F1ih8YvBddILwdSaeUg9xY7Tl
	Tf9aN4yZfuzExRHp3kgNXSgUBiB8gdTnJPxKFmpfTS6j1ietISQZva4Vhr/NtvXEPhs8D7viUSgRf
	I5kc098PG/TXxGibWKOuAjnLbTr1cVK+pEs+CtPKiuu1x5oM16L4MIqFKmZ/xvy2Wbe9h1uwhMaji
	a4WNZxecoE9I0Cw+cM++s1x3ClpyJ61/kTQmdfV/9V2DPMyqnyiijl38+sKQYYCfueLRcCyoyb7JB
	ACDuI+7u2WCBesTMqS2z5DAMlYYzkOoiKhkuDt7VjDtOFgjyIfzCr8cj1WaZF7ZaZEahzZNkMSR1R
	QMeQLMaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXs-00000001Yqb-0ziH;
	Sat, 04 May 2024 08:15:00 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXn-00000001YnR-2ifo
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:14:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810495; x=1746346495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
  b=N9lseCfdSZHkNV5xuxbPctOGamHrUIFYcx/OYsT9YPSR3xbZ8Ak5bY+j
   EJm4ld+6H3hNz1WUcN2T4pXwG61ivmOA/dpgY8Bs+SFHrn7KkRVQ7Ostj
   mGIalyP5nApuo0hL8VpnvUxeWQoLjS4rX1y+gLJIIU5TSAxRGt3luCWtz
   bmHfDtWjSI8D/9wrNg9jTMMKMQHZyE7p6QDzyyK4npaJBF9CVidKMN/LG
   V13IouWIAyGU3WkHm9OqTE3ul7svDb/4nFRMl7xxA5aion0htPttZdg6v
   YsSRpasKDq0FZDQjVaEcpgamEG1e5feT5Cbcq6LlLdWZ4Zna/YnzHSKsk
   g==;
X-CSE-ConnectionGUID: jakFRRBpQjK8JKHsA2Rq+g==
X-CSE-MsgGUID: oVvpde6UTLunbdWnhbbwHQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:51 +0800
IronPort-SDR: VvLudsW4U/AtxDupn/BOWri9Aa/D2RxuZW5GBnM4OPrGBrzcnlI01gsqdcxvOrr9EWaLvOlESS
 nvVuFUip3qT5nEO30ogRw8XciYbm5nKJXcByCMA3URR3HKuu5sT26ko1tVaQZ7fPF41C/QNxed
 1OyGyrX5lPOJb3VNp75zuNv+9kudjdj6Fa00WY+pbJ0HtMe4XQePd5m71mSSg1EfQLMMLPZ8ro
 DEzkCvnw3vst2wU7OxESEpxHCUfjWAJlvvQPoW3w9ML0kdstD9Qb7lKbJ1cw5iG0B34IZi4c++
 5NQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:49 -0700
IronPort-SDR: /r2o56pQMmpWDEcNJHGtuzhL8Mvi8YGgsUKZu21Ry/EzigCQypNhuLqdIe6WUVVmGeXsR5EqKc
 /f8E1+02sFb9HqsGvNJUzY7Zvh95BlcvnUaFvn5l7TbCUwB+YbZSpo17DK+d5UZUxrpIZOKNWY
 p4XdU5SE1aTPdIrJ6Uk26BykldZZHbGrJTgM9moOcyM8FEe3Z1H77imvJ1+lUKsx+BWz2LxiMA
 l4FuvZpYdilw6mBvOzrs5W6+/tUIldqIgktHpfNLPI/xAhquJGKNn71WDQZz/twQ8AdOWGEUOz
 H/0=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:50 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 01/17] check: factor out _run_test()
Date: Sat,  4 May 2024 17:14:32 +0900
Message-ID: <20240504081448.1107562-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011455_780752_DE2FD11D 
X-CRM114-Status: GOOD (  13.24  )
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

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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


