Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B65C3ABA9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pwFpNG8rsKw5A1aXwTo66HrAdH1zCXYAcwV7zBbg8X0=; b=2+laCqCctPPX3GxBwlpqjog3GP
	dVYLncVdw5eT0H/xMGLatcqJSgadr/PaCKKPvMWe2M3zJTzA53RJsVwNsP2bRiKoGqz+Ta8fBiu8k
	8a92duCi7BDaUWivRhSfpj6hMqcM9MEchWfa7grcfxRMDPg0j9zZYhevlNYF+FhowrDIlG8PQgOoi
	5XtFgl3NQuzCb6mcGFfp2XzY2O5ZlElpOGqft7ES4iHlXq//DH4oqA6c9Uudazcsd+0MMJWI894gN
	isZ9OyBXId+CL9sIYBMRmFc7MHNR33iVkz27xcjOJn2qVptsZ4hFKb2LpKyHALFh/IvlGxJCEuv+d
	+Bc9nCKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvR-0000000DWPq-0yLR;
	Wed, 30 Apr 2025 17:08:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAAvO-0000000DWOc-1ILt
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 17:08:47 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UFNK6H001613;
	Wed, 30 Apr 2025 17:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=pwFpNG8rsKw5A1aXwTo66HrAdH1zC
	XYAcwV7zBbg8X0=; b=iYA15hr4TPmlaw9sxDQE16/pi2Ce8GRgpIFf/cSzhwCcp
	1Ny8vGtTXzT+oGLJQ9Z5Go6X1LgSDI9winqZvj+qgfcSVpA1HKMbq4bHEa6vNX9H
	IC3Da3+jH3IIdHmcANY5qlXGSJV3CQgqRkIIq5+ykZpsOtqpGucEpL9iTQ+GOjK2
	qDYqlJx9X3MiNbkEKm97G6w2g0tmMW/UQm3NlSjEGiZEU+71uPzGipYkFfwVfL49
	FYvsjvyn6FHWbvKXBf3ENBHZBEDfal+6mA0m5Cz/w3+cXxPlhf6mtcwrp2qRuwF6
	CKj6Hl3I4noFBYDPAqpJC7pKt/YFVRoCbXsUqGuww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uksq2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGSZa0001309;
	Wed, 30 Apr 2025 17:08:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbk58r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 17:08:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53UH8Y2N039653;
	Wed, 30 Apr 2025 17:08:35 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxbk587-1;
	Wed, 30 Apr 2025 17:08:34 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH 0/2] NVMe Atomic Write fixes
Date: Wed, 30 Apr 2025 10:18:28 -0700
Message-ID: <20250430171830.1494033-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEyMyBTYWx0ZWRfX5ASb1OWCn7xo yoXB5tIPG6RvAOD0GjZg20z39wNmxMwX7wnK5Q7sAJgHn9viwsuQNVb1vdocklXRoZqbMQqObDz htd1wIWVj0eo4J+tj34FbyL+Djwvqtu0ZZwEEWoulJKK2jbLQ5DffXOR5pGT/QXD7iu269IuFW7
 /4sRIEI35ySt0aORg/U6iqo6FQlCACRco/o566mtCYcZbVP1RTcpd7sCokyTfJhfL+IoyvBBcgp PNWmKa1vdYHwl/s6mVMKdun8tj3TdIZ40OfQ2NpZBmNihQ81SI2xRXY6STxQCIDbxvy9GCtn01I 6tZ1Kxmz+JGbTZKnLQG9+OeLvAOALTwczdkEvSb6Jc1f29ZhOyUGZBZfcLBDqwuXU6neuRAZZfz
 UsEFsaaagyRDNkUOsRJi80HIEIVmwhHXQG4dfCdw9SoKKTXFvdoGwCzGU1xEa6e4i1ZngiQ7
X-Proofpoint-GUID: hCvd6nOcj8MrM-v8kEvXQ_SqDiuUoEPI
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68125914 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=XR8D0OoHHMoA:10 a=-t_EKD55RRY5nFo_hg8A:9 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: hCvd6nOcj8MrM-v8kEvXQ_SqDiuUoEPI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_100846_634852_9D69DC82 
X-CRM114-Status: GOOD (  10.90  )
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

This patch set includes 2 fixes for NVMe Atomic Writes that are reproducable
when CMIC.MCTRS (multi-controller support) is set:

    nvme: multipath: atomic queue limits need to be inherited for multipathing
    nvme: all namespaces in a subsystem must adhere to a common atomic write size

QEMU v10.0 can be used to reproduce and validate the fixes.


nvme: multipath: atomic queue limits need to be inherited for multipathing
--------------------------------------------------------------------------
- Include BLK_FEAT_ATOMIC_WRITES feature when allocating multipath disk (nvme_mpath_alloc_disk).


QEMU Config
===========
-device nvme,id=nvme-ctrl-0,serial=nvme-1,atomic.dn=off,atomic.awun=31,atomic.awupf=15 \
    -drive file=/dev/nullb2,if=none,id=nvm-1 \
    -device nvme-ns,drive=nvm-1,bus=nvme-ctrl-0,nsid=1 \
-device nvme,id=nvme-ctrl-1,serial=nvme-2,atomic.dn=off,atomic.awun=31,atomic.awupf=7 \
    -drive file=/dev/nullb3,if=none,id=nvm-2 \
    -device nvme-ns,drive=nvm-2,bus=nvme-ctrl-1,nsid=2 \
-device nvme,id=nvme-ctrl-2,serial=nvme-3,atomic.dn=off,atomic.awun=127,atomic.awupf=63 \
    -drive file=/dev/nullb4,if=none,id=nvm-3 \
    -device nvme-ns,drive=nvm-3,bus=nvme-ctrl-2 \


Before
======
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep cmic
cmic      : 0x2
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep awupf
awupf     : 63
[root@localhost ~]# nvme id-ns /dev/nvme1n1 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme1n1/queue/atomic_write_max_bytes
0
[root@localhost ~]# 

AFTER
=====
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep cmic
cmic      : 0x2
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep awupf
awupf     : 63
[root@localhost ~]# nvme id-ns /dev/nvme1n1 | grep nawupf
nawupf  : 0
[root@localhost ~]#  cat /sys/block/nvme1n1/queue/atomic_write_max_bytes
32768
[root@localhost ~]# 






nvme: all namespaces in a subsystem must adhere to a common atomic write size
------------------------------------------------------------------------------
- Replace awupf field in nvme_subsystem struct with atomic_bs.  The atomic_bs 
value with awupf or nawupf. (nvme_update_disk_info)
- When a namespace is added, the atomic write size (from awupf or nawupf) is
checked with subsys->atomic_bs.  If they don't match, the atomic write size is
set to 512 (1U << head->lba_shift) and a message in logged. (nvme_update_disk_info)


QEMU Config
===========
-device nvme-subsys,id=subsys0 \
    -device nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 \
        -drive id=ns1,file=/dev/nullb1,if=none \
        -device nvme-ns,drive=ns1,bus=nvme0,nsid=1,zoned=false,shared=false \
    -device nvme,serial=deadbeef,id=nvme1,subsys=subsys0,atomic.dn=off,atomic.awun=63,atomic.awupf=31 \
        -drive id=ns2,file=/dev/nullb2,if=none \
        -device nvme-ns,drive=ns2,bus=nvme1,nsid=2,zoned=false,shared=false \


BEFORE
======
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep cmic
cmic      : 0x2
[root@localhost ~]#  nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# nvme id-ns /dev/nvme0n1 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ctrl /dev/nvme0n2 | grep cmic
cmic      : 0x2
[root@localhost ~]# nvme id-ctrl /dev/nvme0n2 | grep awupf
awupf     : 31
[root@localhost ~]# nvme id-ns /dev/nvme0n2 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
8192
[root@localhost ~]# 

AFTER
=====
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep cmic
cmic      : 0x2
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# nvme id-ns /dev/nvme0n1 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]#  nvme id-ctrl /dev/nvme0n2 | grep cmic
cmic      : 0x2
[root@localhost ~]#  nvme id-ctrl /dev/nvme0n2 | grep awupf
awupf     : 31
[root@localhost ~]# nvme id-ns /dev/nvme0n2 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
512

Console Message:
[    2.852814] nvme0c1n2: Inconsistent Atomic Write Size: Subsystem=8192 bytes, Controller/Namespace=16384 bytes




Alan Adamson (2):
  nvme: multipath: atomic queue limits need to be inherited for
    multipathing
  nvme: all namespaces in a subsystem must adhere to a common atomic
    write size

 drivers/nvme/host/core.c       | 20 +++++++++++++++++---
 drivers/nvme/host/multipath.c  |  3 ++-
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/ras/amd/atl/internal.h |  3 +++
 drivers/ras/amd/atl/umc.c      | 19 +++++++++++++++++--
 drivers/ras/amd/fmpm.c         |  9 ++++++++-
 6 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.43.5


