Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF1DC3ABC3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gw7yyIhg84qGjeLuu65u14ip150zco9HXBFOLAL8Dn0=; b=ICxWmStQJwbYzzaMlW5F/aMVab
	kWYUX8uZddQiJaobjl0tmbKMw7Q8WVUd+yazg4Btuwj8rG5aFPew4MB25A4DJyWv5wmsQ1l27YwTL
	08E3+GpANl2Y9Ms81cVfCS9yM7lgs6QJVyIabvR5ytcPz8R8wzrCYyj3I4jFz+ahowjhmHUbxnGNQ
	92qusP9rr670WTsFS+V7K5waF3GrE/YlzLVFWwXykKepRmqQHSelKXokuvrG/Om9Z8Y+iF7eP4sJU
	n13xAKqKxt7ry5OVlVYAFytlAzE0+Lp4Dc1nVNhbZ/xy1NBNMsyIPdrr8oBPrdTM/Cqju8jUvUVGL
	kKf5qYGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoF1-0000000Gx9h-3Xf6;
	Wed, 07 May 2025 23:31:55 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCoEz-0000000Gx8p-2cTS
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 23:31:54 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547NS6bb003133;
	Wed, 7 May 2025 23:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=gw7yyIhg84qGjeLu
	u65u14ip150zco9HXBFOLAL8Dn0=; b=oWuu3+w0bh+FSZPT0TYyJBmYH/8oqBEo
	GtNg0hYUzCw64W2bma5hZWPrg28yOV8TxKvQevF7cS9i3U+M2fLrpA/PtfEhFEyq
	c1+2NSy0tv3TXwD3QLCS44GDeP1Pr9bH4UY0J2L4mIw/lonlG/sVEUb+b6ph94IT
	oJuNqZnPEXVe/U3DLXJt0ohy3kXwR8VfFvvUGEck+32RLxlOcJuiJfSVyCvNYXrT
	wyUcg+kthlkDr7PlAxQhecc9NMgMS9xuzi7+2i0oDkMoN1VxvC/A/ze5vfKm8MUR
	7vRiCu7sK3/ne/AE9796R6yykTHGAPb2HYFk143l/jyc04VbUKrZ0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gh6xr05d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547N2Fl2035564;
	Wed, 7 May 2025 23:31:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kbsh9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 23:31:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 547NVdmK037479;
	Wed, 7 May 2025 23:31:39 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46d9kbsh91-1;
	Wed, 07 May 2025 23:31:39 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v2 0/2] NVMe Atomic Write fixes
Date: Wed,  7 May 2025 16:41:33 -0700
Message-ID: <20250507234137.1609876-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_07,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070219
X-Proofpoint-GUID: raSApTkSKCG_IuZ10MPrLvF4Bw_SP3_S
X-Authority-Analysis: v=2.4 cv=MdRsu4/f c=1 sm=1 tr=0 ts=681bed5e cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=-t_EKD55RRY5nFo_hg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: raSApTkSKCG_IuZ10MPrLvF4Bw_SP3_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDIyMCBTYWx0ZWRfX1qilRDITwYRS /WoPKrnWeCWxLShb0dkBWi3vtmT9EAYfwPiVjCWL2kXlhVVQNzVMFavDBBATwjZbgSlISXmj4OQ iGI9RM/nrl+APWnv6mNphno9W8eyaa+84iX8gHW9GQQ9FB93DKPuHuejrlH6F/2goSNaoWcFEns
 st7oJL0z+T6mzkMzJGtNNbm/EdjTOQGEJx4ZJDz71l+c8Hrxl/dahL4tQ6SHfIjMc218HshaIxA qmRfVGin4Q6ocliA/uq+CrzszdwWKjoKiSqTcMWrKPHSvP2Pxsa2Li7rHal5Sy2bl6ztOS3pJl+ s0P2nbwxC5euxQBgpp2tylfUXNQmeaj2PCD6pzjeGKq1hZXLxf1rEoGvcaMVJwjvH/N2kpKIYdK
 9/jW4Vt6tiJrJQFRKkaCYDrw1XwJnjkvcTsKRRtNdietbd1S6z1tP96BAuryRATe3uM/ORcy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_163153_671207_EDECFEC7 
X-CRM114-Status: GOOD (  16.71  )
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

v2: 1/2 - Change wording of patch subject and description

    2/2 - Rather than setting a controllers atomic write size to 512b if it doesn't
          match the subsystem atomic write size, if a controllers atomic write size
          is greater than he subsystem atomic write size, reject to probe.


This patch set includes 2 fixes for NVMe Atomic Writes that are reproducable
when CMIC.MCTRS (multi-controller support) is set:

    PATCH 1/2 - nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
    PATCH 2/2 - nvme: all namespaces in a subsystem must adhere to a common atomic write size

QEMU v10.0 can be used to reproduce and validate the fixes.


nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
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
[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk 
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0   39G  0 part 
  └─ol-root 252:0    0   39G  0 lvm  /
sr0          11:0    1 1024M  0 rom  
nvme1n2     259:1    0  250G  0 disk 
[root@localhost ~]# sh testxx.sh nvme1n2
+ nvme id-ctrl /dev/nvme1n2
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n2
+ grep awupf
awupf     : 15
+ nvme id-ns /dev/nvme1n2
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme1n2/queue/atomic_write_max_bytes
8192

Console output:
[    2.849583] nvme1c0n1: Inconsistent Atomic Write Size: Subsystem=8192 bytes, Controller/Namespace=16384 bytes

-- 
2.43.5


