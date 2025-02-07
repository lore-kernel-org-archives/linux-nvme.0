Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954F4C0219E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JWBrFBLsBDhEnf7rRYomevR2OhKdd7JThUukQ1rHuq0=; b=0zcG6AH0UH7DG2+8KYzeBmb9mo
	aaa7zTY8kqMRvgmy9U7qfeomE8ijVrHFLfPLHWDc9zQ+cSPGiUM6GsMCL7/GdkYojm1KIJiLFXx8P
	bylKUlCk7kptOoW4hx6PxmjxK8/WGaY13PebMO5rB6iDcRtLEFLbQdCbVbxdksFxKY94tGeX4Wffy
	UCbrCpTgmMS6QyX44Lx2KPyXYyVvZ1g0o9zAnz6DPJpRmd8Jzb9Qyo9BwjQNKJIFIhop7HRTQBEJs
	YnSFzElG8aW4UrBQkFuLr1SZeaEh7xvRyQoUgiYhREgbRRWroTRcBqoruUfvGvcBk8Ed7g6iHtvPo
	KBsGDzcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgY4I-0000000BYlO-1680;
	Fri, 07 Feb 2025 23:47:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgY4E-0000000BYia-3aA5
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 23:47:28 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517LfuN2001325;
	Fri, 7 Feb 2025 23:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=JWBrF
	BLsBDhEnf7rRYomevR2OhKdd7JThUukQ1rHuq0=; b=BuWDWLCD7LKO23D1LI8EU
	RgNkVDEuBChynyJZSEFRzaZa2sjbO0ZrI3o50NAh9DLvTcW0WUYUljfr4m+E/GMy
	C4rWrMlQlwe0rvihubJOFyXkj+HKD7wjlsb8E5QQYnTxWtGMcMJbVzMlLMinBWKX
	7WtOmUlQgQzt5cpaGKOdyQQBd/pzSM9ik9kKCjnHMhBkBj2QuIhIFu5olJvpFCcR
	BHtHCLHxd5kWtKFR+pXX25Id5zC+BtcZ/UI+baD3PhN1xWiRqbM5GKmQ7waA72gC
	69jPrST+0NToYMmaxhaGXe+KNitk3NS0QKjDI6GNOqILX4nTVAHQ/bWdfZw9q4sq
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4ypvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:47:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517LMmWW027906;
	Fri, 7 Feb 2025 23:47:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ds5wst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:47:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 517NlMLj001803;
	Fri, 7 Feb 2025 23:47:23 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44j8ds5ws8-3;
	Fri, 07 Feb 2025 23:47:23 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v4 blktests 2/2] nvme/059: add atomic write tests
Date: Fri,  7 Feb 2025 15:55:53 -0800
Message-ID: <20250207235553.322741-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250207235553.322741-1-alan.adamson@oracle.com>
References: <20250207235553.322741-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_11,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070180
X-Proofpoint-GUID: eiPXTjbCa0tqQEPxxNeMI-two_Vv71ZA
X-Proofpoint-ORIG-GUID: eiPXTjbCa0tqQEPxxNeMI-two_Vv71ZA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_154727_012147_BC0CEAA8 
X-CRM114-Status: GOOD (  15.68  )
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

- Perform a pwritev2() (with RWF_ATOMIC flag) using xfs_io:
    - maximum byte size (atomic_write_unit_max_bytes)
    - minimum byte size (atomic_write_unit_min_bytes)
    - a write larger than atomic_write_unit_max_bytes

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/059     | 146 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/059.out |   9 +++
 2 files changed, 155 insertions(+)
 create mode 100755 tests/nvme/059
 create mode 100644 tests/nvme/059.out

diff --git a/tests/nvme/059 b/tests/nvme/059
new file mode 100755
index 000000000000..79e0ae9b7034
--- /dev/null
+++ b/tests/nvme/059
@@ -0,0 +1,146 @@
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
+	_have_xfs_io_atomic_write
+}
+
+device_requires() {
+	_require_device_support_atomic_writes
+}
+
+test_device() {
+	local ns_dev
+	local ctrl_dev
+	local queue_path
+	local nvme_awupf
+	local nvme_nsfeat
+	local nvme_nsabp
+	local atomic_max_bytes
+	local statx_atomic_max
+	local statx_atomic_min
+	local sysfs_atomic_max_bytes
+	local sysfs_atomic_unit_max_bytes
+	local sysfs_atomic_unit_min_bytes
+	local sysfs_logical_block_size
+	local bytes_written
+	local bytes_to_write
+	local test_desc
+
+	echo "Running ${TEST_NAME}"
+	ns_dev=${TEST_DEV##*/}
+	ctrl_dev=${ns_dev%n*}
+	queue_path="${TEST_DEV_SYSFS}/queue/"
+
+	test_desc="TEST 1 - Verify sysfs attributes"
+
+	sysfs_logical_block_size=$(cat "$queue_path"/logical_block_size)
+	sysfs_max_hw_sectors_kb=$(cat "$queue_path"/max_hw_sectors_kb)
+	max_hw_bytes=$(( "$sysfs_max_hw_sectors_kb" * 1024 ))
+	sysfs_atomic_max_bytes=$(cat "$queue_path"/atomic_write_max_bytes)
+	sysfs_atomic_unit_max_bytes=$(cat "$queue_path"/atomic_write_unit_max_bytes)
+	sysfs_atomic_unit_min_bytes=$(cat "$queue_path"/atomic_write_unit_min_bytes)
+
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
+	test_desc="TEST 2 - Verify sysfs atomic_write_unit_max_bytes is consistent "
+	test_desc+="with NVMe AWUPF/NAWUPF"
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
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $nvme_nsabp - $atomic_max_bytes - $sysfs_atomic_max_bytes -" \
+				"$max_hw_bytes"
+		fi
+	else
+		if [ "$sysfs_atomic_max_bytes" = "$max_hw_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $nvme_nsabp - $atomic_max_bytes - $sysfs_atomic_max_bytes -" \
+				"$max_hw_bytes"
+		fi
+	fi
+
+	test_desc="TEST 3 - Verify statx is correctly reporting atomic_unit_max_bytes"
+	statx_atomic_max=$(run_xfs_io_xstat /dev/"$ns_dev" "stat.atomic_write_unit_max")
+	if [ "$sysfs_atomic_unit_max_bytes" = "$statx_atomic_max" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_max - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 4 - Verify statx is correctly reporting atomic_unit_min_bytes"
+	statx_atomic_max=$(run_xfs_io_xstat /dev/"$ns_dev" "stat.atomic_write_unit_min")
+	if [ "$sysfs_atomic_unit_min_bytes" = "$statx_atomic_max" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $statx_atomic_min - $sysfs_atomic_unit_min_bytes"
+	fi
+
+	test_desc="TEST 5 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with "
+	test_desc+="RWF_ATOMIC flag - pwritev2 should  be successful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$ns_dev" "$sysfs_atomic_unit_min_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_min_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $sysfs_atomic_unit_min_bytes"
+	fi
+
+	test_desc="TEST 6 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+	test_desc+="RWF_ATOMIC flag - pwritev2 should  be successful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$ns_dev" "$sysfs_atomic_unit_max_bytes")
+	if [ "$bytes_written" = "$sysfs_atomic_unit_max_bytes" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $sysfs_atomic_unit_max_bytes"
+	fi
+
+	test_desc="TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + logical "
+	test_desc+="block with RWF_ATOMIC flag - pwritev2 should not be successful"
+	bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$ns_dev" "$bytes_to_write")
+	if [ "$bytes_written" = "" ]
+	then
+		echo "$test_desc - pass"
+	else
+		echo "$test_desc - fail $bytes_written - $bytes_to_write"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/059.out b/tests/nvme/059.out
new file mode 100644
index 000000000000..d52a47a951dc
--- /dev/null
+++ b/tests/nvme/059.out
@@ -0,0 +1,9 @@
+Running nvme/059
+TEST 1 - Verify sysfs attributes - pass
+TEST 2 - Verify sysfs atomic_write_unit_max_bytes is consistent with NVMe AWUPF/NAWUPF - pass
+TEST 3 - Verify statx is correctly reporting atomic_unit_max_bytes - pass
+TEST 4 - Verify statx is correctly reporting atomic_unit_min_bytes - pass
+TEST 5 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should  be successful - pass
+TEST 6 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should  be successful - pass
+TEST 7 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + logical block with RWF_ATOMIC flag - pwritev2 should not be successful - pass
+Test complete
-- 
2.43.5


