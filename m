Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5BDC10F16
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eh5zN6ouRZUr/UMAK0yr4yxlGKw0Yg+UHpLLxr32Z6I=; b=RVJNITwSAZ4nxRu+uqNOkj8YBx
	P8zfnEkssb3ZZjctkuTYLg+PK8DbDJEvVKwLRYKdcWYEpUkIOBS3WoiHLCut0Vxmh7YvcdEU7AQce
	cN5VcTvZCWggFMZrnP6KvNWSL3Ot8Ju+Ny5JS0EwdFRbHLV8SHwmrH5KI/2ltiZHqGmJRCx8ACHkU
	Y1Xenh//+EMIEBwH3VX5jLPpMSDhtzrdy5uiBIUrtlHLDliBX2wccSH9tLv9ijmChv2FxdcWuEhIy
	9pigLZKlEbMYkCQocaEx98fNmpjqWLoiaBfUmRk13CEX5fZ3uKL1JTUnHX6ermE5+T/BDktiTiYBs
	bILKrfaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXy-00000003BtB-3TiN;
	Wed, 24 Apr 2024 08:00:06 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXr-00000003Bnw-3k0i
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945599; x=1745481599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLlifhfpZJXP+J/JjbvB5VBhA8XjzFfCMvsSmzXLv0w=;
  b=gzM7NTbB5prKbx9PeyRSRI06u472vMyyJhisZShGEWKCBvPj+eqhMZ5+
   ERAsT/dxGsNHtQnD2dHflsueBofVZkH519uYplV+NuiiqpF4Gj072DiDu
   eBXMHKCNvbitCCfclvhHz92Dg8/vGzsXrnz6MS7RE3QMxhYyPI1jydA5l
   5JiPQ9NEv0p9kLHEi/CwLKuFhbimgUHDzUmhJTAlYL7FvVZdsQHy15v8q
   T/mr0fE5/uoKooLreeHEgCxAj2SjiaeVYCa1JxZ34kvtH2Gpp2retzbuc
   uW3XtzWSH9pjuCFODsmRaOT6U9Yvjrg95VWXbIdzYcX86kxBLfUxEA/nZ
   g==;
X-CSE-ConnectionGUID: G/hFIig6Tk2LBb7XbZGwCw==
X-CSE-MsgGUID: KfPaKRLLQqaKU0aaJB+KJQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738257"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 15:59:58 +0800
IronPort-SDR: wl0xN990R3eEcp+wqCkoehX5z10KdIt0eis+BkPylNkjRNf6gx1jrDIngePoTCjFN4AP1HyTq+
 05aPqlkynddMcuRF5b//aNefWJMTSmqop8aVzgnDDDEhDG7DLnhFpKvTHJcgk6BJrCnm00PWkr
 YR+r5VBWseV64F5UgPvb32s8TfHExJyOEJ787MGHGhquf+I2KGh0iR3gGWbCPpjZZW5KNsHqVI
 jFKP/6Zn/5/wlKqL4teWKpxrax3qqr02LUZTW5PN/LZ+5AZ5rJX1s7SJOE4/0LTFcUP8ZkAlkG
 kqw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:08 -0700
IronPort-SDR: X+EXbWWxdDYCPucFiaDKmCDEkn/EEXcZ9jsRsOTtlcXR4MmobsyJex6VEMpJMpw7XqJExWZoD9
 zDMd2NvTVTLJtRTYlpHh0u2ZNWS55qgrxqQMDlE44HeX7Sf+NMR29gtzQ7mdtdjd5NxwZ8lrT+
 q2EvnbzVhxRnt+pCH87G4oDN+llwKP2xVr+ycCI4a1QbcMTvnXaBiNRpjoautOFqZTBbZVDGeu
 r8IXC7NEJBBecarx6uRA5bjvstduR1Rm+tgz8kqaN0pWd7IS9hzwEI8keN7pMOUb7cRrKjEH+/
 e+s=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 00:59:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 02/15] check: support test case repeat by different conditions
Date: Wed, 24 Apr 2024 16:59:42 +0900
Message-ID: <20240424075955.3604997-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010000_044111_8E3997CB 
X-CRM114-Status: GOOD (  23.49  )
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

It is often required to run the same test with slightly different test
conditions. If we create each test case for each test condition, those
test cases are almost same and have code duplication. Such duplication
is seen in many of the nvme test cases that set up nvme transport.

To avoid the code duplication, introduce a new feature to support test
case repetition with different conditions. When a test case implements
the function set_conditions(), blktests repeat the test case. When
set_conditions() is called without an argument, it returns how many
times the test case is to be repeated. Before each test case run,
blktests calls set_conditions() with an argument number from 0 to the
number of repetitions minus 1. set_conditions() sets up the condition
for each test run referring to the argument as the index of the
condition to set up. set_conditions() also sets up a short string in
the COND_DESC variable. This string is printed to stdout to identify the
condition of each run. It is also used as the directory path name to
hold result files.

Document the usage of set_conditions() in the new script. Separate out
shellcheck command line for the new script to avoid a false-positive
warning unique to the file.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Makefile          |  3 ++-
 check             | 57 ++++++++++++++++++++++++++++++++++-------------
 common/shellcheck |  2 +-
 new               | 21 +++++++++++++++++
 4 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 43f2ab0..1c685fe 100644
--- a/Makefile
+++ b/Makefile
@@ -18,8 +18,9 @@ install:
 SHELLCHECK_EXCLUDE := SC2119
 
 check:
-	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check new common/* \
+	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check common/* \
 		tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
+	shellcheck --exclude=$(SHELLCHECK_EXCLUDE),SC2154 --format=gcc new
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 	! find -name '*.out' -perm /u=x+g=x+o=x -printf '%p is executable\n' | grep .
 
diff --git a/check b/check
index 7d09ec0..edc421d 100755
--- a/check
+++ b/check
@@ -17,7 +17,9 @@ _found_test() {
 	local test_name="$1"
 	local explicit="$2"
 
-	unset CAN_BE_ZONED DESCRIPTION QUICK TIMED requires device_requires test test_device fallback_device cleanup_fallback_device
+	unset CAN_BE_ZONED DESCRIPTION QUICK TIMED requires device_requires \
+	      test test_device fallback_device cleanup_fallback_device \
+	      set_conditions
 
 	# shellcheck disable=SC1090
 	if ! . "tests/${test_name}"; then
@@ -190,15 +192,12 @@ _write_test_run() {
 _output_status() {
 	local test="$1"
 	local status="$2"
-	local zoned=" "
+	local str="${test} "
 
-	if (( RUN_FOR_ZONED )); then zoned=" (zoned) "; fi
-
-	if [[ "${DESCRIPTION:-}" ]]; then
-		printf '%-60s' "${test}${zoned}($DESCRIPTION)"
-	else
-		printf '%-60s' "${test}${zoned}"
-	fi
+	(( RUN_FOR_ZONED )) && str="$str(zoned) "
+	[[ ${COND_DESC:-} ]] && str="$str(${COND_DESC}) "
+	[[ ${DESCRIPTION:-} ]] && str="$str(${DESCRIPTION})"
+	printf '%-60s' "${str}"
 	if [[ -z $status ]]; then
 		echo
 		return
@@ -464,17 +463,19 @@ _unload_modules() {
 }
 
 _check_and_call_test() {
+	local postfix
 	local ret
 
 	if declare -fF requires >/dev/null; then
 		requires
 	fi
 
-	RESULTS_DIR="$OUTPUT/nodev"
+	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
+	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
 	ret=$?
 	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
-		RESULTS_DIR="$OUTPUT/nodev_zoned"
+		RESULTS_DIR="$OUTPUT/nodev_zoned${postfix}"
 		RUN_FOR_ZONED=1
 		_call_test test
 		ret=$(( ret || $? ))
@@ -484,6 +485,7 @@ _check_and_call_test() {
 }
 
 _check_and_call_test_device() {
+	local postfix
 	local unset_skip_reason
 	local ret
 
@@ -491,6 +493,7 @@ _check_and_call_test_device() {
 		requires
 	fi
 
+	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	for TEST_DEV in "${TEST_DEVS[@]}"; do
 		TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
 		TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
@@ -504,7 +507,7 @@ _check_and_call_test_device() {
 				device_requires
 			fi
 		fi
-		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
+		RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")""$postfix"
 		if ! _call_test test_device; then
 			ret=1
 		fi
@@ -522,9 +525,11 @@ _run_test() {
 	CHECK_DMESG=1
 	DMESG_FILTER="cat"
 	RUN_FOR_ZONED=0
+	COND_DESC=""
 	FALLBACK_DEVICE=0
 	MODULES_TO_UNLOAD=()
 
+	local nr_conds cond_i
 	local ret=0
 
 	# Ensure job control monitor mode is off in the sub-shell for test case
@@ -535,8 +540,18 @@ _run_test() {
 	. "tests/${TEST_NAME}"
 
 	if declare -fF test >/dev/null; then
-		_check_and_call_test
-		ret=$?
+		if declare -fF set_conditions >/dev/null; then
+			nr_conds=$(set_conditions)
+			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
+				set_conditions $cond_i
+				_check_and_call_test
+				ret=$(( ret || $? ))
+				unset SKIP_REASONS
+			done
+		else
+			_check_and_call_test
+			ret=$?
+		fi
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]] && \
 			declare -fF fallback_device >/dev/null; then
@@ -558,8 +573,18 @@ _run_test() {
 			return 0
 		fi
 
-		_check_and_call_test_device
-		ret=$?
+		if declare -fF set_conditions >/dev/null; then
+			nr_conds=$(set_conditions)
+			for ((cond_i = 0; cond_i < nr_conds; cond_i++)); do
+				set_conditions $cond_i
+				_check_and_call_test_device
+				ret=$(( ret || $? ))
+				unset SKIP_REASONS
+			done
+		else
+			_check_and_call_test_device
+			ret=$?
+		fi
 
 		if (( FALLBACK_DEVICE )); then
 			cleanup_fallback_device
diff --git a/common/shellcheck b/common/shellcheck
index 8c324bd..ac0a51e 100644
--- a/common/shellcheck
+++ b/common/shellcheck
@@ -6,5 +6,5 @@
 
 # Suppress unused global variable warnings.
 _silence_sc2034() {
-	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
+	echo "$CAN_BE_ZONED $CGROUP2_DIR $CHECK_DMESG $COND_DESC $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASONS ${TEST_RUN[*]} $TIMED" > /dev/null
 }
diff --git a/new b/new
index 574d8b4..cb5fab2 100755
--- a/new
+++ b/new
@@ -180,6 +180,27 @@ DESCRIPTION=""
 # 	_require_test_dev_is_foo && _require_test_dev_supports_bar
 # }
 
+# TODO: if the test case can run the same test for different conditions, define
+# the helper function "set_condition". When no argument is specified, return the
+# number of condition variations. Blktests repeats the test case as many times
+# as the returned number. When its argument is specified, refer to it as the
+# condition variation index and set up the conditions for it. Also set the
+# global variable COND_DESC which is printed at the test case run and used for
+# the result directory name. Blktests calls set_condition() before each run of
+# the test case incrementing the argument index from 0.
+# set_conditions() {
+# 	local index=\$1
+# 
+# 	if [[ -z \$index ]]; then
+# 		echo 2  # return number of condition variations
+# 		return
+# 	fi
+# 
+# 	# Set test conditions based on the $index
+# 	...
+# 	COND_DESC="Describe the conditions shortly"
+# }
+
 # TODO: define the test. The output of this function (stdout and stderr) will
 # be compared to tests/\${TEST_NAME}.out. If it does not match, the test is
 # considered a failure. If the test runs a command which has unnecessary
-- 
2.44.0


