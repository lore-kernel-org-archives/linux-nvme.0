Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E826C0218B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2025 22:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2C0ALQKZ6eOxh3YBLPmz1HZppzENZFwajcXf8pFakmM=; b=tvTVEfVwzhvYU15+4NypS+TQEn
	06c1k+dJg3eQEgQrlJfcuvKMdlY2kXD+v51QzNLFRVhyLPvr3RiuiXy8I2b1tA2S/UtKIM4k7suoQ
	YfjcCmnmt2e0MlMw1mvv9AzKQgM+QcV5ihyu2dGifG7HNKpv/9FcIfP8F0Ra2bLlUtUdiFQrzf95/
	oIpphVfyMLmA15U33hy3ytJwgqJnDLCrH4yAAD0H5M/E5hJ4UC8HuR67L1xUCXLQyOm+5fasXXtA3
	WTRXdD7oxjRQTwQdf3ExThdFfq0uBmvP6mvf9ugX54pqbD8sVtaohMMCc9E6vWyHb3Wb7PzURIUpN
	CxNMCWkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taMYV-00000008spa-34lw;
	Tue, 21 Jan 2025 22:17:07 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taMYS-00000008sof-3msb
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jan 2025 22:17:06 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJKkhd022897;
	Tue, 21 Jan 2025 22:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=2C0AL
	QKZ6eOxh3YBLPmz1HZppzENZFwajcXf8pFakmM=; b=R54pOdoMSxj0rKCtbcUBV
	JJz80frmuqXuSRUkKCtwtvg4BpmqqIB3IkVrJKG0gJRLW3YB37hbwLVyqpgT0HjZ
	ZVb+dLBhhmDSSHrNfbbIGtGZiygoB7cHm6Ogdbmp5zjQ7ZoofnA7EQn3LzKxmEez
	wV1KESRhjMCtalciOhzCEwj3b4aVGsLhuHr0U1NyEh+JBYRV4qKFQkYeOaDvG9FZ
	HYXsV/Z7ZwuHvMGCVkWdpuB8QNLTWDQRDGaa1TAS/HYKOLckJu7tNr3lGccUqwic
	gJ/k71pa0b2Gjo1A5LP+w2MhVmidAVAFFolh4B3IFBNtJTf7G7mVUZv4Xg011YO4
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm6mvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 22:17:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LKjfUE036578;
	Tue, 21 Jan 2025 22:17:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44917q44wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 22:17:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50LMH1S3022589;
	Tue, 21 Jan 2025 22:17:02 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44917q44vy-3;
	Tue, 21 Jan 2025 22:17:02 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 2/2] nvme/059: add atomic write tests
Date: Tue, 21 Jan 2025 14:25:30 -0800
Message-ID: <20250121222530.2824516-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121222530.2824516-1-alan.adamson@oracle.com>
References: <20250121222530.2824516-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_09,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210177
X-Proofpoint-ORIG-GUID: C95hys0fC_aTArAL8QpCv6AGKT5fOuMZ
X-Proofpoint-GUID: C95hys0fC_aTArAL8QpCv6AGKT5fOuMZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_141705_110513_1ABC09CE 
X-CRM114-Status: GOOD (  16.10  )
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

Tests basic atomic write functionality using NVMe devices
that support the AWUN and AWUPF Controller Atomic Parameters 
and NAWUN and NAWUPF Namespace Atomic Parameters.

Testing areas include:

- Verify sysfs atomic write attributes are consistent with
  atomic write capablities advertised by the NVMe HW.

- Verify the atomic write paramters of statx are correct using
  xfs_io.

- Perform a pwritev2() (with and without RWF_ATOMIC flag) using
  xfs_io:
    - maximum byte size (atomic_write_unit_max_bytes)
    - a write larger than atomic_write_unit_max_bytes

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/059     | 138 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/059.out |  10 ++++
 2 files changed, 148 insertions(+)
 create mode 100755 tests/nvme/059
 create mode 100644 tests/nvme/059.out

diff --git a/tests/nvme/059 b/tests/nvme/059
new file mode 100755
index 000000000000..af4a4263329d
--- /dev/null
+++ b/tests/nvme/059
@@ -0,0 +1,138 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test NVMe Atomic Writes
+
+. tests/nvme/rc
+. common/xfs
+
+DESCRIPTION="test atomic writes"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_program nvme
+	_have_kver 6 11
+	_have_xfs_io_ver 6 12 0
+}
+
+test_device() {
+	local ns_dev
+	local ctrl_dev
+	local nvme_awupf
+	local nvme_nsfeat
+	local nvme_nsabp
+	local atomic_max_bytes
+	local statx_atomic_max
+	local sysfs_atomic_max_bytes
+	local sysfs_atomic_unit_max_bytes
+	local sysfs_logical_block_size
+	local bytes_written
+	local bytes_to_write
+
+	echo "Running ${TEST_NAME}"
+	ns_dev=${TEST_DEV##*/}
+	ctrl_dev=${ns_dev%n*}
+
+	# TEST 1 - Verify sysfs attributes
+	sysfs_logical_block_size=$(cat "${TEST_DEV_SYSFS}"/queue/logical_block_size)
+	sysfs_max_hw_sectors_kb=$(cat "${TEST_DEV_SYSFS}"/queue/max_hw_sectors_kb)
+	max_hw_bytes=$(( "$sysfs_max_hw_sectors_kb" * 1024 ))
+	sysfs_atomic_max_bytes=$(cat "${TEST_DEV_SYSFS}"/queue/atomic_write_max_bytes)
+	sysfs_atomic_unit_max_bytes=$(cat "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_max_bytes)
+	sysfs_atomic_unit_min_bytes=$(cat "${TEST_DEV_SYSFS}"/queue/atomic_write_unit_min_bytes)
+
+	if [ "$max_hw_bytes" -ge "$sysfs_atomic_max_bytes" ] &&
+		[ "$sysfs_atomic_max_bytes" -ge "$sysfs_atomic_unit_max_bytes" ] &&
+		[ "$sysfs_atomic_unit_max_bytes" -ge "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "TEST 1 - pass"
+	else
+		echo "TEST 1 - fail $max_hw_bytes - $sysfs_max_hw_sectors_kb -" \
+			"$sysfs_atomic_max_bytes - $sysfs_atomic_unit_max_bytes -" \
+			"$sysfs_atomic_unit_min_bytes"
+	fi
+
+	# TEST 2 - Verify sysfs atomic_write_unit_max_bytes is consistent with NVMe AWUPF/NAWUPF
+	nvme_nsfeat=$(nvme id-ns /dev/"${ns_dev}" | grep nsfeat | awk '{ print $3}')
+	nvme_nsabp=$((("$nvme_nsfeat" & 0x2) != 0))
+	if [ "$nvme_nsabp" = 1 ] # Check if NSABP is set
+	then
+		nvme_awupf=$(nvme id-ns /dev/"$ns_dev" | grep nawupf | awk '{ print $3}')
+		atomic_max_bytes=$(( ("$nvme_awupf" + 1) * "$sysfs_logical_block_size" ))
+	else
+		nvme_awupf=$(nvme id-ctrl /dev/"${ctrl_dev}" | grep awupf | awk '{ print $3}')
+		atomic_max_bytes=$(( ("$nvme_awupf" + 1) * "$sysfs_logical_block_size" ))
+	fi
+	if [ "$atomic_max_bytes" -le "$max_hw_bytes" ]
+	then
+		if [ "$atomic_max_bytes" = "$sysfs_atomic_max_bytes" ]
+		then
+			echo "TEST 2 - pass"
+		else
+			echo "TEST 2 - fail $nvme_nsabp - $atomic_max_bytes - $sysfs_atomic_max_bytes -" \
+				"$max_hw_bytes"
+		fi
+	else
+		if [ "$sysfs_atomic_max_bytes" = "$max_hw_bytes" ]
+		then
+			echo "TEST 2 - pass"
+		else
+			echo "TEST 2 - fail $nvme_nsabp - $atomic_max_bytes - $sysfs_atomic_max_bytes -" \
+				"$max_hw_bytes"
+		fi
+	fi
+
+	# TEST 3 - Verify statx is correctly reporting atomic_unit_max_bytes
+	statx_atomic_max=$(run_xfs_io_xstat /dev/"$ns_dev" "stat.atomic_write_unit_max")
+	if [ "$sysfs_atomic_unit_max_bytes" = "$statx_atomic_max" ]
+	then
+		echo "TEST 3 - pass"
+	else
+		echo "TEST 3 - fail $statx_atomic_max - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	# TEST 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with no RWF_ATOMIC
+	# flag - pwritev2 should be succesful.
+        bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns_dev" "$sysfs_atomic_unit_max_bytes")
+        if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+        then
+                echo "TEST 4 - pass"
+        else
+                echo "TEST 4 - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+        fi
+
+	# TEST 5 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC
+	# flag - pwritev2 should  be succesful.
+	bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$ns_dev" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "TEST 5 - pass"
+	else
+		echo "TEST 5 - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	# TEST 6 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 1 logical block with no
+	# RWF_ATOMIC flag - pwritev2 should be succesful.
+	bytes_to_write=$(( "$sysfs_atomic_unit_max_bytes" + "$sysfs_logical_block_size" ))
+	bytes_written=$(run_xfs_io_pwritev2 /dev/"$ns_dev" "$bytes_to_write")
+	if [ "$bytes_written" = "$bytes_to_write" ]
+	then
+		echo "TEST 6 - pass"
+	else
+		echo "TEST 6 - fail $bytes_written - $bytes_to_write"
+	fi
+
+	# TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + logical block with
+	# RWF_ATOMIC flag - pwritev2 should not be succesful.
+	bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$ns_dev" "$bytes_to_write")
+	if [ "$bytes_written" = "" ]
+	then
+		echo "TEST 7 - pass"
+	else
+		echo "TEST 7 - fail $bytes_written - $bytes_to_write"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/059.out b/tests/nvme/059.out
new file mode 100644
index 000000000000..45bc5d3566b4
--- /dev/null
+++ b/tests/nvme/059.out
@@ -0,0 +1,10 @@
+Running nvme/059
+TEST 1 - pass
+TEST 2 - pass
+TEST 3 - pass
+TEST 4 - pass
+TEST 5 - pass
+TEST 6 - pass
+pwrite: Invalid argument
+TEST 7 - pass
+Test complete
-- 
2.43.5


