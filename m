Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD8C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7wWojaaBkygKeZ337bY2Db7prg7SCAUOfg9wF/CmUkQ=; b=trjygjQGiAHrtQeIzT7pTwIRmA
	Edo8PR2l6ZKVZFda7GnKkGv4CYlnan5J5+BsNRlkMDTWGYs+40i4fHLYGuycwDkP1x93e4oagzgbd
	RnD0X+BfILoAsijuul6aPJk8anhNSAdZwQwUQmvttPFU2JkU2o1G2C4yUeU8BmWinETgx02xK5BKk
	k2M9pT6RfCYY9tuysK/aseynEUwVdjiDq5Dg3KqUZ8BLFZh7pKzW8a4ktyIWJRHr4B76SYYDv4vVa
	2vEk6o2hsGn97fM8h0FycZrRhNyUjtwWpIQ4ZRhYaOkSijF6dRMqF5ZmW6m4YNSWaLR8SkB+vmA5V
	mLS9vesA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFq-000000094Rl-16Yy;
	Mon, 13 Jul 2026 11:55:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFm-000000094OP-1kQg
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:20 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g1P81731837;
	Mon, 13 Jul 2026 11:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7wWojaaBkygKeZ337bY2Db7prg7SCAUOfg9wF/CmU
	kQ=; b=At0AqREgWttV0YBkM4V6VN4Lmoy92PBXQa0jvLKARuGCaUPE9yOX0rI2X
	OCV9nSV1lojMgIfRaAlVdKVc8jZGB16rYFmt5JduZgdVY8FI2LPDgblkpxN5XE5O
	f/byXUaCANGDJs71WamN4yc7E05b9omJ5xFRC+7bTRxaxpvhVqlDjhucz3EBu+1+
	E/Pec4SgdpMOIMs9NRX9DGOSM6Yq+Wb0RQHFjhusYP8IX0gqCq6Lie70u373axma
	vL8urFGCejSm5q431SvfFhzoJlxzO4Jt4yccQ3tJ8jCIcSFsSkbITqKmFnd54t/Z
	eQDAJAaT2Zc8WUTjy2EOY16ajZcjw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbg3y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnk5n027156;
	Mon, 13 Jul 2026 11:55:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jnft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBsvVZ60490060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:54:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4CF20043;
	Mon, 13 Jul 2026 11:54:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4421920040;
	Mon, 13 Jul 2026 11:54:55 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:54:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 00/20] Support Clang context analysis for NVMe host drivers
Date: Mon, 13 Jul 2026 17:24:01 +0530
Message-ID: <20260713115444.465704-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54d216 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=c97MyOXIiAlq4y4atDYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX0m8sty0rH+sn
 4i07gKhIgIjE9L/ruHHijHa1n/nd6SXKh2xwv9QpUg2HWnrI8CHmyCf+opMNwWOe81W/J/qCM9e
 MefqA4CJhlpdz6rtbBe3fpjEbXzeGzAdq+idR8y6TPE2a2MWb5U7BUqtE+6NvXiHvZQ2vhKsC+W
 cqEhKe2+OCFHXfimhUlG4JAPpO1D6kmt+pyHptpqmGiOlHeOx6i2nVY7pe+rjpxt62ndvtXB98P
 AmygE4XNYMY+g1rEZHEW4I7mCn6Junonj/tsRNguHa+8E0EGUPGU7iNKsJMJkihl/PFKbXHoM6l
 S1K1sf1AO+JZ7leSxI8UtPds4aq1H6uGwzi/8WxCTQpVd9TKGnjpk7uPERVMSNS2eA8i6N66+Nz
 LbK1Bl1/gARV3OuVRgjqN5r8KoBDOY+AZQ5KHlYnf5STfyTmmEz0q13qBtdPtutWlcdnWGHullm
 Fkrl85ajlK29cgQcFWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX6zMrkgVgwDt7
 YSp8AnEYTQOqgprqjZd68iTCVHDiRzr/d3gzPudvfEiim+4ssRh5pvjMNrFgREc9WnXAJb6mkqF
 jljbGq7d2PfoeJvJ/pNP47lCrf+/0PU=
X-Proofpoint-GUID: lJBpQa5iSjIsO1EX7eK1mqZI_shpaesq
X-Proofpoint-ORIG-GUID: MQXGtObrNIvxBai8BJOQEdNpxf2L_1vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045518_668790_4F099B36 
X-CRM114-Status: GOOD (  20.35  )
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

This series adds support for Clang's context analysis to the NVMe host
drivers.

Recent work[1] by Marco Elver introduced infrastructure for lock context
analysis in the kernel, allowing Clang to verify locking requirements at
compile time through various annotations.

This series build on top of that infrastructure by annotating the NVMe
host drivers with the appropriate locking requirements and by addressing
warnings reported by the analyzer. 

The series was built and tested with LLVM/Clang 23.x and enables the
NVMe host drivers to build cleanly with CONFIG_CONTEXT_ANALYSIS enabled.

Support for the NVMe target drivers will be addressed separately.

As usual, comments/feedback/suggestions are most welcome!

Thanks!

[1] https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/

Changes from v3:

- Moved the infrastructure patches to the front of the series; the first two
  patches are now the infrastructure patches (hch).

- Annotated initialization functions, which typically initialize objects
  before they are published, with __context_unsafe instead of wrapping
  individual initialization statements in context_unsafe(...).

- Annotated nvme_next_ns() and nvme_available_path() with
  __must_hold_shared(&head->srcu) since both APIs require the caller to
  hold the SRCU read lock (Sashiko).

- Split the removal of the redundant initialization of
  nvme_ns_head::delayed_removal_secs into a separate patch (09/20)
  (hch).

- Split the removal of the redundant initialization of 
  nvme_ns_head::requeue_list into a separate patch (05/20)

Link to v3: https://lore.kernel.org/all/20260706141452.3008233-1-nilay@linux.ibm.com/

Changes from v2:
  
- removed "Clang" from each commit subject line (hch)

- for zero-initialized struct bio_list_init() is redundant and also to
  suppress false-positive context analysis warning for a list variable
  guarded by lock, remove bio_list_init(&head->requeue_list) from
  nvme_mpath_alloc_disk() (hch)
  
- get rid off wrapping rcu_access_pointer() using context_unsafe() as
  the access to __rcu_guarded pointer using helper rcu_access_pointer()
  should be implicitly safe (hch, Marco, Paul)
  
- wrap INIT_LIST_HEAD() under context_unsafe(...) instead of interleaving
  it under scoped_guard(...) to suppress context analysis warning while
  initializing subsys->nsheads  (hch)
  
- initializing head->delayed_removal_secs from nvme_mpath_alloc_disk() is
  redudnamt as struct nvme_ns_head is zero allocated. This also helps
  avoid false positive conext analysis warning (hch)
  
- introduce LIST_HEAD_GUARDED(_name, _lock) and use it for guarding a 
  list (hch)
  
- dropped context annotations for nvme_queue::cq_poll_lock as this
  requires a annotation which could support guarding multiple
  valid synchronization mechanisms for a single object, which is 
  ,as of today, not yet avalilable (hch)
  
- new patch in the series from Marco Elver <elver@google.com>, which
  annotates list_empty_careful() using __context_unsafe 
  
- context_unsafe() has a statement expression inside so group
  multiple scope guarded variables before those are publsihed
  under context_unsafe(...) where possible (Marco)

Link to v2: https://lore.kernel.org/all/20260614131541.2017845-1-nilay@linux.ibm.com/

Changes from v1:
  - replace guard() with scoped_guard() for guarding request_list (Bart)
  - annotate nvme_alloc_ns_head() using __must_hold(&ctrl->subsys->lock)
    (Sashiko)
  - guard nvme_queue::sq_cmds using nvme_queue::sq_lock
  - annotate nvme_cqe_pending() using context_unsafe in nvme_poll()
    (Keith)
  - Split patch #13 and #14 to separate the context annotation change
    from functionality change (Bart)

Marco Elver (1):
  list: Permit context-unguarded access with list_empty_careful()

Nilay Shroff (19):
  list: introduce LIST_HEAD_GUARDED
  nvme: update nvme_passthru_end() signature
  nvme: add context annotations for nvme_passthru_{start|stop}
  nvme: add context annotations for nvme_ns_head::srcu
  nvme: remove redundant initialization of nvme_ns_head::requeue_list
  nvme: add context annotations for nvme_ns_head::requeue_list
  nvme: add context annotations for nvme_ns_head::current_path
  nvme: add context annotations for nvme_dev::shutdown_lock
  nvme: remove redundant initialization of delayed_removal_secs
  nvme: add context annotations for nvme_subsystem::lock
  nvme: add context annotations for nvme_ctrl::ana_lock
  nvme: add context annotations for nvme_subsystems_lock
  nvme: add context annotations in fabric.c
  nvme: add context annotations for nvme_queue::sq_lock
  nvme: add context annotations in rdma.c
  nvme: fix context analysis warning in rdma.c
  nvme: add context annotations in tcp.c
  nvme: fix context analysis warning in tcp.c
  nvme: enable context analysis support for nvme host driver

 drivers/nvme/host/Makefile    |  1 +
 drivers/nvme/host/core.c      | 14 ++++++++---
 drivers/nvme/host/fabrics.c   |  4 ++--
 drivers/nvme/host/ioctl.c     |  2 +-
 drivers/nvme/host/multipath.c |  9 +++++--
 drivers/nvme/host/nvme.h      | 44 ++++++++++++++++++++++++-----------
 drivers/nvme/host/pci.c       | 22 ++++++++++++++----
 drivers/nvme/host/rdma.c      | 25 ++++++++++++--------
 drivers/nvme/host/tcp.c       | 15 ++++++++----
 include/linux/list.h          |  9 +++++++
 10 files changed, 104 insertions(+), 41 deletions(-)

-- 
2.53.0


