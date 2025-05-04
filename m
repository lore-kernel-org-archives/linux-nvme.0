Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD1CC369DC
	for <linux-nvme@archiver.kernel.org>; Sun,  4 May 2025 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yVLKQxjTCGCx6Qg9VklGSq0EUNVqUDLjlPZdtic647A=; b=N+N9CGm4Hljo05/ci1Wm98NXt3
	cs+TLWzQnBBLzxTTZD41l1U42DV9QmJCLAOi5hWip3Y77lWu/B2pheGE0DMvA8UjrjCvDnp3+bgvv
	/ZitUsTIeJ0VruGOt639EyfWg3YIv5EnLc7jFJFYdCOD2w+eI3Bg6GZit7HikKbIxE1GebR7ACe7A
	MtpmjUPZKNZVEw+iRWgmOrCG3I4Rw8ACXH+p2iDuMubLMnOZLTuMUgAYQ82SzDWDGABZRm+b194QF
	7gCCrSo4slmPssuhak+zU16Zwgc7G6ukTiwnnY/DrsxlgXVy50R8aKg/jucmsH+PCgbiZV2WB35NT
	UJL3j1nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdX6-00000005lzZ-2miz;
	Sun, 04 May 2025 17:53:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdUk-00000005llv-20Lv
	for linux-nvme@lists.infradead.org;
	Sun, 04 May 2025 17:51:19 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544AftV3021452;
	Sun, 4 May 2025 17:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yVLKQxjTCGCx6Qg9VklGSq0EUNVqUDLjlPZdtic64
	7A=; b=QMCj4MSB8BSkPalcr7Yj6hPdMmtT0akKd9raDJgjwaZx759EKMXrubY59
	H4RnnboXHFtUD0un1JMyaXIf+dsWmaeHZD5TKIHaTU2lckHwd9aIIFzHmet2v42a
	BmdkQX17VftG5IvoNgJPa6oy0CkPFrCPPn9dHUZ/Y+cWCk0VQ+AVOTRZ3NLjJ7jk
	/CdczS5P67QPJxduPNNq9ObVtDARdh4W5mHg5AeFUyagoiH1Xfb9uJ06MFSK+WcW
	44BEjPRyf/z3nc4OEecI+nOccuqRpnWpFe9rw4EbP9SQHWymBDaQ5Wc0OH00zeMG
	6Wgj1DxfI2Ig8mv+OZZzPjxaNQAwg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46e6pr8w36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:51:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 544E5MHJ013861;
	Sun, 4 May 2025 17:50:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e0622c0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:50:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 544Hov0S39911746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 May 2025 17:50:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF56E20043;
	Sun,  4 May 2025 17:50:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D021420040;
	Sun,  4 May 2025 17:50:53 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.80.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 May 2025 17:50:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 0/3] improve NVMe multipath handling
Date: Sun,  4 May 2025 23:20:38 +0530
Message-ID: <20250504175051.2208162-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cu2/cm4D c=1 sm=1 tr=0 ts=6817a904 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=dAkqvE83TVYWYi81bWwA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-GUID: PPk11J6N64WCddOvVSwRubTdeGEqK6rW
X-Proofpoint-ORIG-GUID: PPk11J6N64WCddOvVSwRubTdeGEqK6rW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDE2NiBTYWx0ZWRfX9ZudvqoNegga oAeFU2Qd0dlBFUutWFHSQPO/2XDLkpLz1vIPcBJ/DaM51iftKOP8fgPv2wWVygp3l+59ILqMRsA /LxDwgmoWGd1PaBb7+Faq2pHdmthrllkHgYqkCpmPEGaSfdKZZm7VfaTmSjymJaknV4fvE0pCPL
 j5oRz92G5M6GU9X0B0qelacLJ1hMLF2syvf4zkCUCqDIxUtHPnCu+FaqzH0kSVq44OJODmnANhL xGQXjy/RTegvHMqGT5xXeBgFByysiZT7GH+EJ9tEB/BaI5R3RK47XAH/5CJYd0Dm/MlWxkwUKkg 6jxc474fpb/2qoMnEyFEXEbPCIwmO9mYWer9cPuDyJqZ8vHhpukE2e8U+dAKFI77oInIcyScW2i
 I3lMoszC0L/it5RvBrH1bMAUI+h6F99UmUXNKTjRlkSyvKf22FqI06oXOLWflqBvw8G1dKyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_07,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505040166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_105118_649973_D7D3BBF1 
X-CRM114-Status: GOOD (  18.82  )
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

Hi,

This patch series introduces improvements to NVMe multipath handling by
refining the removal behavior of the multipath head node and simplifying
configuration options. The idea/POC for this change was originally
proposed by Christoph[1] and Keith[2]. I worked upon their original
idea/POC and implemented this series.

The first patch in the series addresses an issue where the multipath
head node of a PCIe NVMe disk is removed immediately when all disk paths
are lost. This can cause problems in scenarios such as:
- Hot removal and re-addition of a disk.
- Transient PCIe link failures that trigger re-enumeration,
  briefly removing and restoring the disk.

In such cases, premature removal of the head node may result in a device
node name change, requiring applications to reopen device handles if
they were performing I/O during the failure. To mitigate this, we
introduce a delayed removal mechanism. Instead of removing the head node
immediately, the system waits for a configurable timeout, allowing the
disk to recover. If the disk comes back online within this window, the
head node remains unchanged, ensuring uninterrupted workloads.

A new sysfs attribute, delayed_removal_secs, allows users to configure
this timeout. By default, it is set to 0 seconds, preserving the
existing behavior unless explicitly changed.

The second patch in the series introduced multipath_always_on module
param. When this option is set, it forces creating multipath head disk
node even for single ported NVMe disks or private namespaces and thus
allows delayed head node removal. This would help handle transient PCIe
link failures transparently even in case of single ported NVMe disk or a
private namespace.

The third patch in the series doesn't make any functional changes but
just renames few of the function name which improves code readability
and it better aligns function names with their actual roles.

These changes should help improve NVMe multipath reliability and simplify
configuration. Feedback and testing are welcome!

[1] https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
[2] https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

Changes from v2:
    - Rename multipath_head_always to multipath_always_on (Hannes Reinecke)
    - Map delayed_removal_secs to queue_if_no_path internally; if delayed_
      removal_secs is non-zero then queue_if_no_path is set otherwise its
      unset (Hannes Reinecke)
    - Few minor code readability improvements in the second patch while
      handling multipath_param_set and multipath_always_on_set (hch)
    - Avoid the race in shutdown namespace removal by deleting head->entry
      during the first critical section of the nvme_ns_remove for the case
      head delayed_removal is not configured (hch)
    - Use ctrl->ops->flags & NVME_F_FABRICS to determine whether the 
      ctrl uses fabric setup (Sagi)

Link to v2: https://lore.kernel.org/all/20250425103319.1185884-1-nilay@linux.ibm.com/

Changes from v1:
    - Renamed delayed_shutdown_sec to delayed_removal_secs as "shutdown"
      has a special meaning when used with NVMe device (Martin Petersen)
    - Instead of adding mpath head disk node always by default, added new
      module option nvme_core.multipath_head_always which when set creates
      mpath head disk node (even for a private namespace or a namespace
      backed by single ported nvme disk). This way we can preserve the
      default old behavior.(hch)
    - Renamed nvme_mpath_shutdown_disk function as shutdown as in the NVMe
      context, the term "shutdown" has a specific technical meaning. (hch)
    - Undo changes which removed multipath module param as this param is
      still useful and used for many different things.

Link to v1: https://lore.kernel.org/all/20250321063901.747605-1-nilay@linux.ibm.com/

Nilay Shroff (3):
  nvme-multipath: introduce delayed removal of the multipath head node
  nvme: introduce multipath_always_on module param
  nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk

 drivers/nvme/host/core.c      |  14 ++-
 drivers/nvme/host/multipath.c | 213 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  33 +++++-
 drivers/nvme/host/sysfs.c     |  13 +++
 4 files changed, 244 insertions(+), 29 deletions(-)

-- 
2.49.0


