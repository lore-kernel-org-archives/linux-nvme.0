Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CDFC3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PQoSEDjNYnhPsAdPWPHW8bovEQq/IoeQUWBcYniQhyY=; b=jKU2mwJEct8Nc/iQ+papYxcYoG
	6DCbQEqZBXny7L0PYUx4lR53OZkqZM+yWsoOsUNmI+FuIvIbKsHeu3g2ITJ/tVMZKUM5FRbsrW4mZ
	e28uwNagGl4SA33B7DycMRdKMcl0Mg0T2JSj4z3LRR3bzttHlOfmMMZnZ4+kMVl90f7z6wKz+Rn6L
	Gxw6Q40wQM+EZ2OfeQvcr77hCJuArI6YeroY//g2b6cS1rxnKQKhbmEaUeDhAB0SLigWWJwIelfF6
	1B7Y4wBlU2+zAf9Ookt0g39yUmYTIoqh2Qp0yOGkcYB7Lm30wT6UBuS3dl6VAVOZqOIQa0Jq09olM
	y9tJbktA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJd-00000004nQR-2IP2;
	Fri, 09 May 2025 20:27:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRtR-00000004UmX-1xIw
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 17:52:18 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549EjRoX031677;
	Fri, 9 May 2025 17:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PQoSEDjNYnhPsAdPWPHW8bovEQq/IoeQUWBcYniQh
	yY=; b=Q2gKyN8EivUpz8kPXwoD6DnosoiOp9YDtXclkzoGkSt+U439Ys5AItPkj
	PAAHNQU2Wz0sLJI9Y/GIhZt1YAExwOTJIDM3trLiLrg3P6wggJKNMWj5b+Q4HAFn
	0pPemv9ldrM/l3p0hCwwKklRTFNlv0Jg2mKalO+LMfoJWya7so5ujHwFgvAg8IwZ
	UFOdhWAFUIPVsgsDYRZzCFN6gEGeY5NOl/DuLa1NUj+Kbn5Ioaw3d6uAvvu6kPBR
	0NKoN5tLuQqh+S14v+YnRq2nbyok3DI3L4+A34A5A3i3fEKqvzkYjUp/LVartR70
	zNH4VwVK4aJG1c2pHxaX8dl26dPEw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwdcb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549F2Xrd001353;
	Fri, 9 May 2025 17:52:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftvwd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549Hq5Wu31916452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 17:52:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64B902013C;
	Fri,  9 May 2025 17:52:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389FD200C5;
	Fri,  9 May 2025 17:52:01 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.130.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 17:52:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv4 0/3] improve NVMe multipath handling
Date: Fri,  9 May 2025 23:21:47 +0530
Message-ID: <20250509175158.2753396-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e40c7 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=9r6QK0OtAAAA:8 a=VnNF1IyMAAAA:8 a=dAkqvE83TVYWYi81bWwA:9
 a=5NLhsHySBYhYDpG7:21 a=1CNFftbPRP8L7MoqJWF3:22 a=TxIH8fH_K59pr5-VUUuU:22
X-Proofpoint-GUID: Xg6Lq2ZcsHPYGuGZGcYil0pVHChvsb7F
X-Proofpoint-ORIG-GUID: Xg6Lq2ZcsHPYGuGZGcYil0pVHChvsb7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE3NSBTYWx0ZWRfX9vB5LZU+RHlz 6nh5oHSoaM0QofpymAvtWzVM1hGyRXfliV865pxBU+oTCXC79pUi8xcuk8XJqa8HIscJVU86eD6 LRa3CYN+G9vq4ANczKkWl6dhOOqHRn3YCV4N3oK9MMdfGZPDSPrInUwoXyAXdN7iJQCZcRsOYbh
 RLP/TP2zbE7XWujps54bBwOiUc6EFQf7El0J4Zkg/EiddNu5XJfeKbf+L2Hph1yCz08KWel8hWh HavvDevvex/Tw7NpivQ/zaL9qVQd4YCaCHlnQtLGI8dt4BZSU1KEO3ixGkFlPKLpE27v2DiR+o7 4MjB1qLTNQ0rLgG49khJtY0gROGTIgXRPYHv3oAEMBuD90vCuh51deody2e5+ySXCQ6kT5YGgsD
 VBqcKvwb4yhGaMoBUxoilegGpdgdutwyE3vFZqi/CNg0Z4XHt5A8MdcZZZ/LQUrmdkEj08Rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_105217_636051_617AD3D1 
X-CRM114-Status: GOOD (  19.81  )
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
 drivers/nvme/host/multipath.c | 206 ++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h      |  24 +++-
 drivers/nvme/host/sysfs.c     |   7 ++
 4 files changed, 220 insertions(+), 29 deletions(-)

-- 
2.49.0


