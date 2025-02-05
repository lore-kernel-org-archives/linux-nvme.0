Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB62C02192
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2025 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dRh4nd2xsmFBygPlPAaP36ykzVRSHPMIu0A94nivP+Q=; b=tUavSNABbYcc7v2SHYU3Jrzcl+
	QN9dXW0Gpc7EuiDxJQCfHbduP8EPzEnUAGqyXCidrLCxDXm5Sv+MYwu6s+5qcpAIUenM0iK/KCiky
	kVKmO6lom4yfbsGh9030SIA0SQLqoBqoUCns+XfXo8CA0tRUX9vUG9n+ruo1QD4ABdM2xnA5YA8xI
	OZLaHlDSuHsdskUcJL27YxBI7CwHBMbFVrHPQXIRvFPFtwfT+N+2An/Cze6djBCb7nqJ53cQcrt0K
	hjUpA1mFgJ7MRP8xavQBDEJWB7uXk05gG3tozAdEchZ0/DgNdulJKUojEPoNJd3iX+RmgCXgoCKmR
	S8O4eY2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfoPi-00000004n4q-2Tpk;
	Wed, 05 Feb 2025 23:02:34 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfoPe-00000004n3I-3TIx
	for linux-nvme@lists.infradead.org;
	Wed, 05 Feb 2025 23:02:32 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515N0v5t024998;
	Wed, 5 Feb 2025 23:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=dRh4nd2xsmFBygPlPAaP36ykzVRSH
	PMIu0A94nivP+Q=; b=li0bNL+s4L4o40LuK0ygrR5MOgAQsvf5efMxJQx7xQn8S
	GyepDHgDNWqfiqTI6kKyd9r59Ewt4JXOKax0f49CXOhKgMxrSQp3uK9QR8eiDBLI
	qmOMJbjm6dEHIRna5+eczEVhAA2Z7TnN/2FQZxOaAPl4e66UfMR4SoASIu12CDK+
	4O5td1LjYb5DuoBIPMlDAbfUWp7aIEhFqEI/SJkCQhyopgLHr9zWgkv/7r0ri17n
	PHn5OSWEbDeFf4XQX8wa2weSF+wWZzvIavCvaaZInGyNosUI8hRSh8lE9peWlY0V
	1SLDHvd2CRzP4HxYSCCTE/7CYOFn3jE/e83P/buMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtgb4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 23:02:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Lpdtn022710;
	Wed, 5 Feb 2025 23:02:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e9r5mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 23:02:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515N2Rfi040085;
	Wed, 5 Feb 2025 23:02:27 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44j8e9r5m8-1;
	Wed, 05 Feb 2025 23:02:27 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH v3 blktests 0/2] Add atomic write tests for scsi and nvme
Date: Wed,  5 Feb 2025 15:10:58 -0800
Message-ID: <20250205231100.391005-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050176
X-Proofpoint-GUID: CLt3PBuLAk9kAdk4Z09R_UrxRbfkphNI
X-Proofpoint-ORIG-GUID: CLt3PBuLAk9kAdk4Z09R_UrxRbfkphNI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_150231_375620_11BA9228 
X-CRM114-Status: GOOD (  12.45  )
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
 common/xfs         |  58 ++++++++++++
 tests/nvme/059     | 147 +++++++++++++++++++++++++++++
 tests/nvme/059.out |  10 ++
 tests/scsi/009     | 229 +++++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/009.out |  18 ++++
 6 files changed, 470 insertions(+)
 create mode 100755 tests/nvme/059
 create mode 100644 tests/nvme/059.out
 create mode 100755 tests/scsi/009
 create mode 100644 tests/scsi/009.out

-- 
2.43.5


