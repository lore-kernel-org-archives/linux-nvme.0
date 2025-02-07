Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE7FC02199
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HU5ANisxh20MlKMA70imVgX1Zsd5TX2ZMIFbtyqokPo=; b=YgsezTxC1Bp1e86yC0wEL/5Hrz
	7J6mnkmzSPVZINu8qo1LcLloYOijJG1V78wzVGUtY2wy30Lvyh/h+Ry/mWuGfYm2XxFgyJQx0IoHv
	VUTSTgQwS8f7E6SX10NVHCTwoRHUq5C4iesCgwT76wfOTsix0AA/O/ytrDV+c44SGhzj8EazGb9xF
	yjQLAc1uDgC4iFzQH/sdxYpSxGZZQdBhaRbu19NodMzvST+ECTzzJkSIEgNOc/X65QNNSqKPoCWX1
	vQOUmV7QoLo26wkrX7LAL/w5YmmUMntlmY9qP6gyDAR4rCZxQALKRzY0gYSEwVTE8CysDrkYpi02P
	Qv+l8X/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgY4G-0000000BYkm-2pr9;
	Fri, 07 Feb 2025 23:47:28 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgY4E-0000000BYiI-11bT
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 23:47:27 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517Lfpr5026273;
	Fri, 7 Feb 2025 23:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=HU5ANisxh20MlKMA70imVgX1Zsd5T
	X2ZMIFbtyqokPo=; b=nvSulILxDkVwoqPv7LHTYm/zbiwq0JU1THjIxqoteRDrT
	w0me0+Xe8nxn26xYwqpst0SaiA1Sq7JdISI+x6V68FypuIXSiyj+itnW6+zE6amN
	dIn1yj9jeDmg8oplWetOVvKBAd2Sga1eGvqd+3VMKztxSc4wYd7l75ExbqRM6IWc
	G5H8xTskjvIOl1uKnKz2zO82fGRnTInxIT+agvfbeYX7UR8BrH725rmAUeQsQfbh
	dPP5e2dmnHex30bWWhSO1as9DwRdqq8u5szJGXCW3OVa1boNR2E9m3ND1PzpwdE3
	o9OnX146RsWvinZkjg8tKXT8gJKCoWbpEV3iH8xkg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m58cntes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:47:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517NUIP6028036;
	Fri, 7 Feb 2025 23:47:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ds5wse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 23:47:22 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 517NlMLf001803;
	Fri, 7 Feb 2025 23:47:22 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44j8ds5ws8-1;
	Fri, 07 Feb 2025 23:47:21 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v4 blktests 0/2] Add atomic write tests for scsi and nvme
Date: Fri,  7 Feb 2025 15:55:51 -0800
Message-ID: <20250207235553.322741-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_11,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070180
X-Proofpoint-ORIG-GUID: 5WDXrknFEkMOsiKZUSPyDHxiEtVdBbAk
X-Proofpoint-GUID: 5WDXrknFEkMOsiKZUSPyDHxiEtVdBbAk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_154726_286093_BDA5D3AC 
X-CRM114-Status: GOOD (  11.65  )
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

Changes in v4 (per John's comments):
- Verify sysfs_atomic_unit_min_byte attribute (nvme)
- Perform atomic write test using sysfs_atomic_unit_min_byte (nvme)
- fix spelling mis (nvme)
- Remove tests that don't use the RWF_ATOMIC flag (scsi+nvme)

Changes in v3:
- Remove _have_xfs_io routine and use _have_program.
- Comment cleanup in 0001
- Add SKIP_REASONS when xfs_io -A option is absent.
- Keep lines <=80 characters.
- Move device_requires logic in 0001 and 0002 to common/rc.

Changes in v2:
- Add additional comments in common/xfs
- Remove xfs_io and kernel version checking
- Simplify paths for sysfs attributes
- Fix failed case output (missing echo) in scsi/009
- Add local variable that sets Test # and description (test_desc) for scsi/009 and nvme/059
- Only use scsi_debug device if no scsi test device is provided.
- nvme testing done with qemu-nvme.
- scsi testing done with scsi_debug and qemu-scsi (no atomic write support).  No testing on
  atomic write capable scsi devices was done.
-------------------------------------------------------------------------------------------
Add tests for atomic write support.

Tests will be delivered for scsi (using scsi_debug) and nvme.  NVMe can use the qemu-nvme
emulated device that supports Controller-based Atomic Parameters (QEMU 9.2).

The xfs_io utility delivered with the xfsprogs-devel package (version 6.12) is required by
these tests.

The Linux Kernel 6.11 (and greater) supports Atomic Writes and is required by these tests.

Alan Adamson (2):
  scsi/009: add atomic write tests
  nvme/059: add atomic write tests

 common/rc          |   8 ++
 common/xfs         |  58 ++++++++++++++
 tests/nvme/059     | 146 ++++++++++++++++++++++++++++++++++++
 tests/nvme/059.out |   9 +++
 tests/scsi/009     | 183 +++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/009.out |  13 ++++
 6 files changed, 417 insertions(+)
 create mode 100755 tests/nvme/059
 create mode 100644 tests/nvme/059.out
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out

-- 
2.43.5


