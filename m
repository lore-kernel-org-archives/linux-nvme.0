Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B95C07E8E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XB8CqyS5jwJzczB8cNhrvXAXssf76AdkM6/QwXu05dY=; b=kWw5dCFZJ/J/3BgZiyIRLEu4zY
	I89tMHCBX+kfu5hfVi7nj4+mx9noQsSe6mHrU5r92Fy4U84KJp9KBJFu4KXSQ7rIis/yCXj1OCmEE
	F4ytDTxvB6A18vZ74dabOlQssMnjNZOJf6OVH9uKNDC5pOSD5973prKiC75hUX9oaSoUFA6cTeNIz
	uOKlkz4EKnLrYc8p5JxGWdCPqNVT22SGbr3mcD23UCrvJNVQXH5Z5Kvo5jkYO00U/VTZAeiZ4oSTm
	Uljlm6fpJD799mYNFr1Dts7YXD5BIh6gJsgK51L0gcbrToC47el4rSMvQZrDWmxqPfI0hUhSxZP1i
	e2nzNofA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXw-00000003Brl-1hyO;
	Wed, 24 Apr 2024 08:00:04 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXs-00000003BnK-1NO2
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945600; x=1745481600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29N5U6N1y9BlM6ECK69L6XwHI/nK7ulbD7kVCqyaSx0=;
  b=DiaMvqXCxVq+e+qlDrNCFVPnfBLgwESXOqweKq/bsAsWL2zg9ZDcMNxU
   CEQQEA+d7khluitN7LrRxDEGrSIJrVObvtotF3zELxzwl0g7I02kU2X1F
   BpLPyU0As0g8IzrKye0LW+oBENUHv6dt7GcfQN2lPHgijFuv4KqY3y5nw
   i4FJxaJ6jZc0AAJWqYzs1hfg+R8LW1o8MMKdS0Xmbb+wlKqUaQuR/oCx4
   N5exVd7wUOf/jTRPTswvI1Z/l/iv/WsQ3LisRd7pdv9wfVF5Se7fTutTQ
   63F05KiAPmBHly4xoHqWNZMt/JW24UJS5zXrATV4BcEQsa5zXTJbeCY/2
   A==;
X-CSE-ConnectionGUID: wI1sRCugT4q1mPT2IM3aKQ==
X-CSE-MsgGUID: oXlahMXpTwaLDtoaGmyz/A==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738256"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:57 +0800
IronPort-SDR: EkLbA5H+hfAbyzKG+IiLXt4R22DDpo3aqTKkXl5iJlDBgYDfD4zcjrth4iV0CDpPVTTfUC3zl5
 dQr2EM8OqiowCNAgMVl91UQRDIJaRaN/E5jF2vpooYwKjh4+9MwJgBmGppb9p7K4Mxir3HcGSu
 a26cdgDgR/TAsyWwz9cnNS/gGqk71WNuWYn8JqM609CmMB0WgE8YfqFRZ0HQutRF1BbKtlaccw
 vKrNmrQRNfSNMJJ+cwgktnzvSVMZvFzHYWMFlr2iwaevUhf+OCasgVN8+5dpC7/pu6MENvCMda
 HFQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:07 -0700
IronPort-SDR: nBmiefH4CHw2SsOQtpcUduyjB5QQNs1gVt3JDxhSep7wcQpdN67xR+XN/0hGvJgXgTcXmHatPS
 GuHwaVsVtwfY+9CpRvDd/V8EUOC2hhIOvssoU45K0CmygkmBkE5NiO7SUc0/oBDYx59zme8m+L
 1WcQq53Al1jl6vwxfRrMg7VeU3c7pNdYDXTtBQLbSonSvJ8oPYPReB/tNX5LOPGmVa+GzbVxof
 7bihKXNlLp18USScw3PPRz/LeBkYhWB7N/ldZ9HLYFWrIMixtD9BPNGzwXjXcbwbzJzIBmMk3j
 jxU=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 01/15] check: factor out _run_test()
Date: Wed, 24 Apr 2024 16:59:41 +0900
Message-ID: <20240424075955.3604997-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010000_934085_5FC6C173 
X-CRM114-Status: GOOD (  11.96  )
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


