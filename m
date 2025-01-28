Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8163AC0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ym9D0z7cx2TXfcL5ctmbHGaD396mE3JeJnk1XpoPufI=; b=tl3s/tDq2pzsyIica4heg7izK9
	OreGrmOBZRDPoyeeqqVyFCwTkib3dcnMSJPvFqiSaOm5JchVuYYSbup8jbmX+n5qcnlwUj+sl/TLY
	nj2YmIDAPN0HWHrToAKTHpmh6XruvAfGaoXDYq0jdf9MwTRjBNaTKVx83hFFvMt1zKT9ZXn5C0M+/
	X4nRtaMZ2sXlmt/1j00jC/n7gSwhHSdWa6jKzTRxPD/muJP9xlTL7EtUGeFUdubgxpFN8dBTVIvhb
	QLWUovNgJ5mml5zpJKvsFRbxqEsu40FBRWvECP/CCwNX5ySZfc8rF+mWsoO80NMZTNlYF1HllMY4P
	+Sdrh0Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcvDg-000000062oK-1Prw;
	Tue, 28 Jan 2025 23:42:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcvDc-000000062n5-3Zxj
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 23:42:11 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SMfoOw032557;
	Tue, 28 Jan 2025 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Ym9D0
	z7cx2TXfcL5ctmbHGaD396mE3JeJnk1XpoPufI=; b=bub8h/baOHF8LQFHMFvps
	GyTYR3vEjkUIyjJQEuQ5YypaOfI+IhS2bgxTwYu/YVW/z0+zJwtP2nC1qZ5lcJ36
	VBhBRb5ThhBrAuBIbCSHeAzZIiR1qd563lUTv2dRIuksXd/wA0sfA0Nj3adj0NOL
	kt5BJQEkMWNkUxrDyMlmy8RzFcq6iYT0+GdQ7QWtynP+RMWkNUTYMu4OB1rHE6Qr
	UwyHIBBW9AU+8zm80vOX+ChpCKw3Oxo0QmvEUtNwrr8M9P/Gri1w14IgUMz5XGXz
	NV+UClMTepcxNOO7dNJ6bOPPDirk4S7lXtJ68Blz0VEV5ZwGelO4csxsacfELQvx
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f7a785k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SMJ6Q4035859;
	Tue, 28 Jan 2025 23:42:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdf2mx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 23:42:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50SNg3Wu019555;
	Tue, 28 Jan 2025 23:42:04 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44cpdf2mvx-2;
	Tue, 28 Jan 2025 23:42:04 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v2 blktests 1/2] scsi/009: add atomic write tests
Date: Tue, 28 Jan 2025 15:50:33 -0800
Message-ID: <20250128235034.307987-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250128235034.307987-1-alan.adamson@oracle.com>
References: <20250128235034.307987-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280172
X-Proofpoint-ORIG-GUID: MGXiIgFBbqU4FOxK2yrzHbn1gXmtQL0c
X-Proofpoint-GUID: MGXiIgFBbqU4FOxK2yrzHbn1gXmtQL0c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_154209_082764_CE0B8FB0 
X-CRM114-Status: GOOD (  22.22  )
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

Tests basic atomic write functionality. If no scsi test device is provided,
a scsi_debug device will be used. Testing areas include:

- Verify sysfs atomic write attributes are consistent with
  atomic write attributes advertised by scsi_debug.
- Verify the atomic write paramters of statx are correct using
  xfs_io.
- Perform a pwritev2() (with and without RWF_ATOMIC flag) using
  xfs_io:
    - maximum byte size (atomic_write_unit_max_bytes)
    - minimum byte size (atomic_write_unit_min_bytes)
    - a write larger than atomic_write_unit_max_bytes
    - a write smaller than atomic_write_unit_min_bytes

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 common/xfs         |  61 ++++++++++++
 tests/scsi/009     | 233 +++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/009.out |  18 ++++
 3 files changed, 312 insertions(+)
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out

diff --git a/common/xfs b/common/xfs
index 569770fecd53..5db052be7e1c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -6,6 +6,30 @@
 
 . common/shellcheck
 
+_have_xfs_io() {
+	if ! _have_program xfs_io; then
+		return 1
+	fi
+	return 0
+}
+
+# Check whether the version of xfs_io is greater than or equal to $1.$2.$3
+
+_have_xfs_io_atomic_write() {
+	local s
+
+	_have_xfs_io || return $?
+
+	# If the pwrite command supports the -A option then this version
+	# of xfs_io supports atomic writes.
+	s=$(xfs_io -c help | grep pwrite | awk '{ print $4}')
+	if [[ $s == *"A"* ]];
+	then
+		return 0
+	fi
+	return 1
+}
+
 _have_xfs() {
 	_have_fs xfs && _have_program mkfs.xfs
 }
@@ -52,3 +76,40 @@ _xfs_run_fio_verify_io() {
 
 	return "${rc}"
 }
+
+# Use xfs_io to perform a non-atomic write using pwritev2().
+# Args:    $1 - device to write to
+#          $2 - number of bytes to write
+# Returns: Number of bytes written
+run_xfs_io_pwritev2() {
+	local dev=$1
+	local bytes_to_write=$2
+	local bytes_written
+
+	# Perform write and extract out bytes written from xfs_io output
+	bytes_written=$(xfs_io -d -C "pwrite -b ${bytes_to_write} -V 1 -D 0 ${bytes_to_write}" "$dev" | grep "wrote" | sed 's/\// /g' | awk '{ print $2 }')
+	echo "$bytes_written"
+}
+
+# Use xfs_io to perform an atomic write using pwritev2().
+# Args:    $1 - device to write to
+#          $2 - number of bytes to write
+# Returns: Number of bytes written
+run_xfs_io_pwritev2_atomic() {
+	local dev=$1
+	local bytes_to_write=$2
+	local bytes_written
+
+	# Perform atomic write and extract out bytes written from xfs_io output
+	bytes_written=$(xfs_io -d -C "pwrite -b ${bytes_to_write} -V 1 -A -D 0 ${bytes_to_write}" "$dev" | grep "wrote" | sed 's/\// /g' | awk '{ print $2 }')
+	echo "$bytes_written"
+}
+
+run_xfs_io_xstat() {
+	local dev=$1
+	local field=$2
+	local statx_output
+
+	statx_output=$(xfs_io -c "statx -r -m 0x00010000" "$dev" | grep "$field" | awk '{ print $3 }')
+	echo "$statx_output"
+}
diff --git a/tests/scsi/009 b/tests/scsi/009
new file mode 100755
index 000000000000..7624447a6633
--- /dev/null
+++ b/tests/scsi/009
@@ -0,0 +1,233 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test SCSI Atomic Writes with scsi_debug
+
+. tests/scsi/rc
+. common/scsi_debug
+. common/xfs
+
+DESCRIPTION="test scsi atomic writes"
+QUICK=1
+
+requires() {
+	_have_driver scsi_debug
+	_have_xfs_io_atomic_write
+}
+
+device_requires() {
+	_require_test_dev_sysfs queue/atomic_write_max_bytes
+	if (( $(< "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes) == 0 )); then
+		SKIP_REASONS+=("${TEST_DEV} does not support atomic write")
+		return 1
+	fi
+}
+
+fallback_device() {
+	local scsi_debug_params=(
+		delay=0
+		atomic_wr=1
+	)
+	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
+		return 1
+		fi
+	echo "/dev/${SCSI_DEBUG_DEVICES[0]}"
+}
+
+cleanup_fallback_device() {
+	_exit_scsi_debug
+}
+
+test_device() {
+	local scsi_debug_atomic_wr_max_length
+	local scsi_debug_atomic_wr_gran
+	local scsi_atomic_max_bytes
+	local scsi_atomic_min_bytes
+	local sysfs_max_hw_sectors_kb
+	local max_hw_bytes
+	local sysfs_logical_block_size
+	local sysfs_atomic_max_bytes
+	local sysfs_atomic_unit_max_bytes
+	local sysfs_atomic_unit_min_bytes
+	local statx_atomic_min
+	local statx_atomic_max
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+
+	echo "Running ${TEST_NAME}"
+
+	sysfs_logical_block_size=$(< "${TEST_DEV_SYSFS}"/queue/logical_block_size)
+	sysfs_max_hw_sectors_kb=$(< "${TEST_DEV_SYSFS}"/queue/max_hw_sectors_kb)
+	max_hw_bytes=$(( "$sysfs_max_hw_sectors_kb" * 1024 ))
+	sysfs_atomic_max_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes)
+	sysfs_atomic_unit_max_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_max_bytes)
+	sysfs_atomic_unit_min_bytes=$(< "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_min_bytes)
+	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
+	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
+	scsi_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$sysfs_logical_block_size" ))
+	scsi_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$sysfs_logical_block_size" ))
+
+	test_desc="TEST 1 - Verify sysfs atomic attributes"
+	if [ "$max_hw_bytes" -ge "$sysfs_atomic_max_bytes" ] &&
+		[ "$sysfs_atomic_max_bytes" -ge "$sysfs_atomic_unit_max_bytes" ] &&
+		[ "$sysfs_atomic_unit_max_bytes" -ge "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $max_hw_bytes - $sysfs_max_hw_sectors_kb -" \
+			"$sysfs_atomic_max_bytes - $sysfs_atomic_unit_max_bytes -" \
+			"$sysfs_atomic_unit_min_bytes"
+	fi
+
+	test_desc="TEST 2 - check scsi_debug atomic_wr_max_length is the same as sysfs atomic_write_max_bytes"
+	if [ "$scsi_atomic_max_bytes" -le "$max_hw_bytes" ]
+	then
+		if [ "$scsi_atomic_max_bytes" = "$sysfs_atomic_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $scsi_atomic_max_bytes - $max_hw_bytes -" \
+				"$sysfs_atomic_max_bytes"
+		fi
+	else
+		if [ "$sysfs_atomic_max_bytes" = "$max_hw_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $scsi_atomic_max_bytes - $max_hw_bytes -" \
+				"$sysfs_atomic_max_bytes"
+		fi
+	fi
+
+	test_desc="TEST 3 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
+	if (("$sysfs_atomic_unit_max_bytes" <= "$scsi_atomic_max_bytes"))
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $sysfs_atomic_unit_max_bytes - $scsi_atomic_max_bytes"
+	fi
+
+	test_desc="TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
+	if [ "$sysfs_atomic_unit_min_bytes" = "$scsi_atomic_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $sysfs_atomic_unit_min_bytes - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 5 - check statx stx_atomic_write_unit_min"
+	statx_atomic_min=$(run_xfs_io_xstat "$TEST_DEV" "stat.atomic_write_unit_min")
+	if [ "$statx_atomic_min" = "$scsi_atomic_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_min - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 6 - check statx stx_atomic_write_unit_max"
+	statx_atomic_max=$(run_xfs_io_xstat "$TEST_DEV" "stat.atomic_write_unit_max")
+	if [ "$statx_atomic_max" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_max - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes "
+	test_desc+="with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "test_desc - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+	test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 9 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+	test_desc+="bytes with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_to_write=$(( "${sysfs_atomic_unit_max_bytes}" + "$sysfs_logical_block_size" ))
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$bytes_to_write")
+	if [ "$bytes_written" = "$bytes_to_write" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $bytes_to_write"
+	fi
+
+	test_desc="TEST 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+	test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$bytes_to_write")
+	if [ "$bytes_written" = "" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $bytes_to_write"
+	fi
+
+	test_desc="TEST 11 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+	test_desc+="with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$sysfs_atomic_unit_min_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 12 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+	test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$sysfs_atomic_unit_min_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $scsi_atomic_min_bytes"
+	fi
+
+	test_desc="TEST 13 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+	test_desc+="bytes with no RWF_ATOMIC flag - pwritev2 should be succesful"
+	bytes_to_write=$(( "${sysfs_atomic_unit_min_bytes}" - "${sysfs_logical_block_size}" ))
+	if [ "$bytes_to_write" = 0 ]
+	then
+		echo "$test_desc - pass"
+		echo "pwrite: Invalid argument"
+	else
+		bytes_written=$(run_xfs_io_pwritev2 "$TEST_DEV" "$bytes_to_write")
+		if [ "$bytes_written" = "$bytes_to_write" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+	fi
+	test_desc="TEST 14 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+	test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+	if [ "$bytes_to_write" = 0 ]
+	then
+		echo "$test_desc - pass"
+	else
+		bytes_written=$(run_xfs_io_pwritev2_atomic "$TEST_DEV" "$bytes_to_write")
+		if [ "$bytes_written" = "" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+	fi
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/scsi/009.out b/tests/scsi/009.out
new file mode 100644
index 000000000000..e31416b93515
--- /dev/null
+++ b/tests/scsi/009.out
@@ -0,0 +1,18 @@
+Running scsi/009
+TEST 1 - Verify sysfs atomic attributes - pass
+TEST 2 - check scsi_debug atomic_wr_max_length is the same as sysfs atomic_write_max_bytes - pass
+TEST 3 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 4 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 5 - check statx stx_atomic_write_unit_min - pass
+TEST 6 - check statx stx_atomic_write_unit_max - pass
+TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 8 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 9 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 11 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 12 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+TEST 13 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with no RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 14 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+Test complete
-- 
2.43.5


