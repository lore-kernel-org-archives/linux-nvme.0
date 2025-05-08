Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455E8C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ePXJi1HbDv4OCnhE6umDnI/28GnRnUNv53lQ3z+ZLqw=; b=Z+7h1NcqIrn2LgElJ9CILkdiJR
	LAahb+hiIsIp9gX03tNVOHN5HRZ/Tr45/fy/JoxAz9Nk/A1VYkROwPh/IM2yCN1Z2kelq3IT3npE8
	SRVbRg5mAOOvGbN7+VPTTf5d3EtN6fld+g1ti7toBDgLjL4LPKK+Z9pwjh1jl7tfRfvH8jGJVyrKf
	rFI47fU2QFDcOn2MPYXLOXYSqmel5vFTaZ/Z1MypYjFEX04eGjlA2aeqdiUZ5xIem5w2oIrjcCtTv
	hNknEn59lM/64rOY5btqrCCHtSjdZy8ci9C5b6urByWt/RVPrpfCesNciD69HLmn6ujLd9l5EOkW1
	khHjDVdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j7-00000001tyK-2czM;
	Thu, 08 May 2025 22:28:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j2-00000001twN-0yUs
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 22:28:21 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Ll5QT015148;
	Thu, 8 May 2025 22:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ePXJi1HbDv4OCnhE
	6umDnI/28GnRnUNv53lQ3z+ZLqw=; b=gDHpBqxqxB03GOl4e7SwLDI40+vcvO76
	C0ESHuDI8UNhzk+L71b0hRhR7/BRH8LnGMa3ChbP+snXRT1iZ3+0R2Z2ORwB1Qtr
	NiP/7wuMatF8gRV48DQs56RZZY7oPm0ajDimGWUnJE2fbr5zmH8kuL/z/n+nKTN+
	r6xonktcmmlC7Pc35PSwD7PEV5uvcw1bE9gsPo/bMpdSdQnqaNTHmDsFeqXwp/he
	PERt9RNr7XvrACxYZRtYe2vEYVbmK3FCZ3L5oTLFrKdoA6TsI7LbuURD9TVaA0PA
	b2mqmwI5OQpIbk0ToptmnAQYpGcS8nuMsPXoVrNW7e9w1mhKoPqJbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h4tyg234-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548MInFI002657;
	Thu, 8 May 2025 22:28:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmccaksf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548MS5hV030993;
	Thu, 8 May 2025 22:28:05 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46gmccaks4-1;
	Thu, 08 May 2025 22:28:05 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v3 0/2] NVMe Atomic Write fixes
Date: Thu,  8 May 2025 15:37:59 -0700
Message-ID: <20250508223802.277311-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNCBTYWx0ZWRfX1igI3URReHA8 BUuNThkqwQPufI/bhoQoDXCtMCp2v7fs30R/db9aiu3JRwamIBeHWKwDN2/gl026H4yExvV6LRJ fi7kP4CuVCAFXVMO9fLKbk9ThiGHu2EcBob0wBxhyBwfWQLVm9vgu4YSWHaXU8uUYrfavomc0qI
 R3jmKQRjq0QZCfYiOES1IuLo3qjReFNGqmSFZMgQLGt5ptKP9fT6Bnu9/VuEFaCbCw9xQDLBUmE NFdUwxamP5GR75mWBPmIaT+KNsoX/viU/NR2ZzruNQN5CFVkZvJALH1juXcSibvat3RpzT1NZgU yLdr4ppjvkr4OzLymHMFf+ZrVytUeUNk9Tnyj5nTbMVYaC2yFR6te0XySxkmJVRZMawcNg66XwR
 CZNteN5Pf/5jCAbj0gfKfzmzWTD3vb8gT/2nTbnYPFd2RDviQmxNbLi7wCCckcH1LxfVKLQD
X-Proofpoint-ORIG-GUID: AWOvpooXZYC3dNR0LWu_cQsqHS-w2Vfb
X-Proofpoint-GUID: AWOvpooXZYC3dNR0LWu_cQsqHS-w2Vfb
X-Authority-Analysis: v=2.4 cv=aJnwqa9m c=1 sm=1 tr=0 ts=681d2ff6 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=-t_EKD55RRY5nFo_hg8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_152820_388942_2E553DD1 
X-CRM114-Status: GOOD (  16.45  )
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

v3: 2/2 - Add comment.
        - Include "Namespace will not be added" to error message.

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
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep cmic
cmic      : 0x2
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# nvme id-ns /dev/nvme0n1 | grep nawupf
nawupf  : 0
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192

Console output:
[    2.848854] nvme0c1n2: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=8192 bytes, Controller/Namespace=16384 bytes

-- 
2.43.5


