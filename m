Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A991C3ABDE
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JTuskCp1CKPq8O9S2670ABg3sydTDilDMiZmoFM/CyE=; b=Sf7A3lM9lBcbHwA37+1Krd+P6C
	tjozcGF+mAxED8PNfCr3qxRWe4cs6ddNBztPoT4QlFWN8tfBZfwL49cfN7xZc6P7rVZN2rozASMn8
	rrdeBIIdYvUJGBkqteMfpRBkWBiO5IUmNa66hmLDej+7i57leRf2zzwMV9c4a/AFQkDA+RJecMDFb
	KoePDly1wQs+50HtHLiUGHxXXaqGWy7Z3Gtsq591gzTaNtZ+nU+OX+1v7w7GjzeYrDao/eDLOx1z7
	Tr7ifG9YlSHtrqYe87WTfmSRP8DgwoMllkZtwjLQwvGWqiJIrJ8ZsyxjdPzBKH0P1uwRoeCCMw+ik
	D+6NsyZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZH-0000000FJdX-21iT;
	Wed, 14 May 2025 13:54:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBly-0000000F9gD-3CFX
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:03:48 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E43vMu026469;
	Wed, 14 May 2025 13:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JTuskCp1CKPq8O9S2670ABg3sydTDilDMiZmoFM/C
	yE=; b=Xa+SYZDOVDAtmOQQfGDC0uQYTpsLerrWC31v4OHJbMutt3YcrJmMHK0Qm
	m63qhUOJkzg2gmEqdqTyLOmPzQOuUUNqyTMc9uFh97SLuu/qL/0IspzgU4ik2K2L
	BX61dgwfDZGqrsNrVLYev2zOWcSLuD9L0tD6nASQemVwYBMRnEU3Gw4RWJ4nnHFH
	z2ByTBNPsKec/xXXl5Fe2Gh9SfUz0lb3Q6Nk+7N5nlAfH4pJLahtcbX6wpG2AK6Q
	7e2Fslb+Jk7PJxeMEIvD4oRa4KWqconAsXavQzs2CGqupfie6QKIz9eEXAugd7TH
	5SLKwhtifRhkJ1lCUiAaQ7NG1Cl/A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mbs6m8aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9prAL021396;
	Wed, 14 May 2025 13:03:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrm8rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ED3T9817105180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 13:03:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0FA82004D;
	Wed, 14 May 2025 13:03:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FA9220043;
	Wed, 14 May 2025 13:03:25 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.82.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 13:03:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 0/3] improve NVMe multipath handling
Date: Wed, 14 May 2025 18:33:14 +0530
Message-ID: <20250514130322.393656-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfXwii5yZ42WBDs aX9a/2AAixMho4BuiwPvDIdMwQI6OudxntCvFj5PxhNY8pjY0JhM0adE6duT43XCck6L0gF/Evo +46d4grQmTcy2XYLq4qql+d7gy8njf2j/hxBML9tDHyvupayRfkptfe7n0tV/MDXDaqcuXzq2QL
 iXYZclGr1/LcuUpvQYycjTL+784i2Dj4Mq0+xXt6z1dwuIw7mOAuWKSboti9xIVXJPs1axKuq+L 8cxJNVxZXvV8ulcofb6uG5HdSjwvTJvpcEy/agjV550OFl9ydEc4U2rq5t1cc+h/odF7Obl0PlZ SMUaQEk0Wrej60DTxzGzDmBNs2ie5eqeaI7HS0xaoipiYNUjLozt5qxddmXAPawfT7WpAWQjthj
 IgcnO/MERN5cwlTbyjc287Y+7Wu4pcaabhGLMEBU4Ix9LVC69+4oMwQHEX98zUP9TqrZMeMZ
X-Proofpoint-ORIG-GUID: w8ZWZlBIIK6CZQb0RJ26L1hiKB1TFGbR
X-Authority-Analysis: v=2.4 cv=d5f1yQjE c=1 sm=1 tr=0 ts=682494a4 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=dAkqvE83TVYWYi81bWwA:9
 a=6JJ4YhXztIFARRaa:21 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-GUID: w8ZWZlBIIK6CZQb0RJ26L1hiKB1TFGbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_060346_923604_4B13FECF 
X-CRM114-Status: GOOD (  19.93  )
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

Changes from v4:
    - Refrain from creating multipath head node for private namespaces 
      with non-unique NSID even when multipath_always_on is configured (hch)

Link to v4: https://lore.kernel.org/all/20250509175158.2753396-1-nilay@linux.ibm.com/

Changes from v3:
    - Removed special case for fabric handling and unified head node
      delayed removal behavior across PCIe and fabric controllers (hch)

Link to v3: https://lore.kernel.org/all/20250504175051.2208162-1-nilay@linux.ibm.com/

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

 drivers/nvme/host/core.c      |  12 +-
 drivers/nvme/host/multipath.c | 206 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  24 +++-
 drivers/nvme/host/sysfs.c     |   7 ++
 4 files changed, 221 insertions(+), 28 deletions(-)

-- 
2.49.0


