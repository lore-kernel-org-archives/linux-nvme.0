Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B994C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x50HAsiA3XtMMUoADGJon8UIxcTtMr1Xv9a2j0LKQg0=; b=MdSy6HAZbh8jvkdPOiLK+dxtt4
	Al9lw3ctymWjskFM/2GCyVTxqqJbX0adEWhaQjwHKRJXQU74upggKMok3Lc0eEH9kgc2aNMfOIxdn
	i4Pn8LacxF8bPDKCg25fX95RfxIRGerISEoWzuAYv8lseVFXB5wFpkd4OZYgXVMbXSUgZZjvX2Zf+
	XEOWQlFzZAdD3nt6UPyN588AE4fEbmyirrKeigGly1ufhKgmzJsCBVvP5WADcRm11Ppx50vhsOIyv
	NwImLQPhmPQqIkbO4/U8ZA+zPobX6M0Nfjpok2jdEpSdAtLbWUSobflWn9tA+y5g9AjLQHB3gilzP
	Y1b4CIRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6r-0000000Chmh-3ML2;
	Mon, 06 Jul 2026 14:15:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6o-0000000Chlw-2qrD
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:15:44 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIEoN318854;
	Mon, 6 Jul 2026 14:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=x50HAsiA3XtMMUoADGJon8UIxcTtMr1Xv9a2j0LKQ
	g0=; b=OjHCcB6fZnNf/QOmjdJHoqXm/ymJPUoN3mlxlduc9CTlIItggHf9lyQEK
	0N5G4eFaM74lIMPshOX/enlBc56MAjEiCbofjbqiHbQRt70zlKgvVEnxfakKWdcH
	Zo4p8VShlUOfNu9pKt2Owa+M0+b/zluDlQdZHBh+oNbfu13m3n9kLOzH8SYTJmff
	tkwP2qMaj+ML/4t74go2oL3M7dHKA9uMRx3dN3WTQOSyhKv+k6yiipur0+UHI8Kc
	aeWBY44PgNVI4Jq9Ol2QlWYF6JpH4zHBx1DWgCIjsw4TDfoEUO/wCJKpaHVCk4ut
	gPmU8Lh8gx418byoG6S1Ipj8Jtfhg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqhqr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4cIR018959;
	Mon, 6 Jul 2026 14:15:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpx41v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFInw51380488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9379420043;
	Mon,  6 Jul 2026 14:15:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5505920040;
	Mon,  6 Jul 2026 14:15:16 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:16 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 00/18] Support Clang context analysis for NVMe host drivers
Date: Mon,  6 Jul 2026 19:44:02 +0530
Message-ID: <20260706141452.3008233-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9uoG55BlACUy
 f8TavTfLKHfJ/H6SIhysW21sOVP6GFl46owPnwUwhog5p/TxlgqxXBYRLRIS8EU7+uplv135BaI
 jfyiD+xb9Ur8LJRco3UuX6loaPAt/wE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXzwOyAY9K9VW5
 QwfKfDdpDNMEYyBZkZplJaofxx4LE7Bm4XnLbUPjqudzIib2+gCHY5YfsZbToauWAh49YVGMNN4
 X1GFgG1AOOPug8jzJ9ueVzpZYMRsV5KLxc9iFCR/Jo17hHG1cMIg2Z3aaB+LOM2mxKaaQPDVW/o
 /3rjzyEcz8bkiHy7229DXGubuufjPPVYjlt8xohaih6HLnoYjbzTW+mWmXT0vCGHKFs25QRo7gs
 8b6GtjCehLVwJdH2Ojx3siPhZfApXcn9yiSg+Fh6YtOLgygdT5FFQNI0MFivEVv0D6xkf5xIfy4
 0mFJhwFteeuQ4D5mhMKStkmOXfl73qV6v55SsUtao5qI9xrkHp1IA3DKPPZ6z3Xja1JOCiPHxDP
 5bY4BuX5V1SBm1vt3cXQLDaasfAQUmTrSinHAq0HDhAQ4krpu73YyNiXbBp9NBWbM2DYpKJSXco
 vFgN/PABvWevEYGnQ+g==
X-Proofpoint-GUID: pmNCK-6tfWLD1uMy1CVuKN9yFJj7r20d
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4bb87b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=yJd4khT4T4pqtWizPYcA:9
X-Proofpoint-ORIG-GUID: 39AYPx1qNkN93-bnQ7GL5iXg24Xv1CJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071542_734221_6C579183 
X-CRM114-Status: GOOD (  17.36  )
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

Nilay Shroff (17):
  nvme: update nvme_passthru_end() signature
  nvme: add context annotations for nvme_passthru_{start|stop}
  nvme: add context annotations for nvme_ns_head::srcu
  nvme: add context annotations for nvme_ns_head::requeue_list
  nvme: add context annotations for nvme_ns_head::current_path
  nvme: add context annotations for nvme_dev::shutdown_lock
  nvme: add context annotations for nvme_subsystem::lock
  nvme: add context annotations for nvme_ctrl::ana_lock
  list: introduce LIST_HEAD_GUARDED
  nvme: add context annotations for nvme_subsystems_lock
  nvme: add context annotations in fabric.c
  nvme: add context annotations for nvme_queue::sq_lock
  nvme: add context annotations in rdma.c
  nvme: fix context analysis warning in rdma.c
  nvme: add context annotations in tcp.c
  nvme: fix context analysis warning in tcp.c
  nvme: enable context analysis support for nvme host driver

 drivers/nvme/host/Makefile    |  1 +
 drivers/nvme/host/core.c      | 20 ++++++++++++----
 drivers/nvme/host/fabrics.c   |  4 ++--
 drivers/nvme/host/ioctl.c     |  2 +-
 drivers/nvme/host/multipath.c |  7 ++++--
 drivers/nvme/host/nvme.h      | 44 ++++++++++++++++++++++++-----------
 drivers/nvme/host/pci.c       | 28 +++++++++++++++++-----
 drivers/nvme/host/rdma.c      | 25 ++++++++++++--------
 drivers/nvme/host/tcp.c       | 15 ++++++++----
 include/linux/list.h          |  9 +++++++
 10 files changed, 110 insertions(+), 45 deletions(-)

-- 
2.53.0


