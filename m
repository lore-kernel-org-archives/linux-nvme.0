Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58DCD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=66EVvRR3RhUNV8g+Pv6LMoy23+luXqTuMLYvrYyGD20=; b=pBLipuiEDv5cvwVyQmfkBCJnIL
	TnvUBTodIKiyS+55MTNNQ3lONeVwd2R6ArvW7Hx7b46+KWmoFkZiOYdCkcqV3/wEn1R+aVK14yXAS
	g8jt3boY0XLwgoqUxrvnxXUadgwB6UBBn2sV5ZBb3RBWfkx7yMWweaaha2jSsKt9KD7iu3PpIZJXa
	WNbmmwSsQWB8Sn1FHshTCwL5JCGG7i+kp9+H/wsrBZO9boa1UAndRP8ZB8PsRKaMcJyT9HninvEb3
	FhiLDfE92tRDnjl0caQYsfVlkLU1a1qXh4AER8b9njSXCwz9IkGmU1W5XaRezxitfaLKG9Rp4ty+z
	2GSZZGng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhM-0000000D0mi-04n8;
	Sun, 14 Jun 2026 13:16:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhG-0000000D0lR-0hJT
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:19 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmHL63504075;
	Sun, 14 Jun 2026 13:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=66EVvRR3RhUNV8g+Pv6LMoy23+luXqTuMLYvrYyGD
	20=; b=bQHQshTZf+Nrr9VRYxK5wetaZ46gxTwy89qHRw1UMqUt4Qg8dUQodAVBz
	TY8q/Mty0W49drdiS3XL5Xz/3X8uwtqaN9OPndfZb9U5b0VrUW8zfumTEfggOLoY
	7tFZYdGUu/U/y/zNdgMHeQOpQCCW+0rsYIHSk/Y/6l+i9Zt298xKeXCqT/Ld6UPN
	YeRQhbJIHHzuzqT20GqEjca3AFG4Ox/ud8cr9T6/HLxLT0gJHgL4XMibmAPDLteY
	mhXpXwqhR60vYt+pnOt6e7NFZ+RkjrbjD59fDI18JfafO1es8hje1PhKCV3pmqXx
	nYmKhdLdNa09XqsGshIHjqzxt36Rw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v239ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:15:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4dHV013157;
	Sun, 14 Jun 2026 13:15:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7xsdkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:15:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDFoOa49938792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:15:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8576C2004E;
	Sun, 14 Jun 2026 13:15:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E638220040;
	Sun, 14 Jun 2026 13:15:47 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:15:47 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 00/17] Support Clang context analysis for NVMe host drivers
Date: Sun, 14 Jun 2026 18:45:15 +0530
Message-ID: <20260614131541.2017845-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX6+orrJzXOblP
 QQVgdQkG11rcfN5XvCU6eXLbZ6UL9DMQkSqDVxE7QQmzhENhb/+vjADX/tf5pZvnvATg5KNUjLS
 32et5UmrLyfiOZisDyFJcqAC6ijhct4=
X-Proofpoint-GUID: DrtkZhMG2WkB6vWx8yjXAXcQh5DkNBql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX8IVSLOwbVRKt
 SzifLFtFm5cEwBPoyWqurXtqN6rHFneiE2oWPi0akLc8lh0gmt8jSNF1fYZo87Q0dsqe6WHL1jf
 Ck0CBFpqGAUNphv/P93TWXD84kj0Y9ceFHw0XM3okXzlNNZZ8/gw+TXiH9eQKXUg/OrOvQqLNi8
 jpOZ4zKgjHAyGCO6YfQQDISZKd2nJG9sIr57RRk9TBoTC7q8SxHTOobWXmgkZk5tYlr8mT5YsGr
 cFP1H6yFbgAgFHqUgJeHehQqEbLtXwh+o7+28EIGnCrw5Bew7chmTSgWTQkJ9yTkzrIfFWAOpY2
 dkSvEmSoJqMLdMHgM74efga9V2crCXL30NqXziwTGZ+D7TKz3h3gMC1X0YFJ+B+ClRHKBNZel8L
 CA5WiI6cQzu8/xdEpfeCMT2TO1w2shv5OfHkLEWjD8nJwRoTagZNAClmHJngIobLK2w41MWfdVI
 w2vX6wKSWD7iKqU/PIQ==
X-Proofpoint-ORIG-GUID: zupsGeTEuWeNvp2bAG_qMQP4806L203G
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2ea98b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=XSbIBq3ZAERtOhGDojsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061618_368129_17370CE4 
X-CRM114-Status: GOOD (  13.40  )
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

Changes from v1:
  - replace guard() with scoped_guard() for guarding request_list (Bart)
  - annotate nvme_alloc_ns_head() using __must_hold(&ctrl->subsys->lock)
    (Sashiko)
  - guard nvme_queue::sq_cmds using nvme_queue::sq_lock
  - annotate nvme_cqe_pending() using context_unsafe in nvme_poll()
    (Keith)
  - Split patch #13 and #14 to separate the context annotation change
    from functionality change (Bart)

Nilay Shroff (17):
  nvme: update nvme_passthru_end() signature
  nvme: add Clang context annotations for nvme_passthru_{start|stop}
  nvme: add Clang context annotations for nvme_ns_head::srcu
  nvme: add Clang context annotations for nvme_ns_head::requeue_list
  nvme: add Clang context annotations for nvme_ns_head::current_path
  nvme: add Clang context annotations for nvme_dev::shutdown_lock
  nvme: add Clang context annotations for nvme_subsystem::lock
  nvme: add Clang context annotations for nvme_ctrl::ana_lock
  nvme: add Clang context annotations for nvme_subsystems_lock
  nvme: add Clang context annotations in fabric.c
  nvme: add Clang context annotations for nvme_queue::sq_lock
  nvme: add Clang context annotations for nvme_queue::cq_poll_lock
  nvme: add Clang context annotations in rdma.c
  nvme: fix Clang context analysis warning in rdma.c
  nvme: add Clang context annotations in tcp.c
  nvme: fix Clang context analysis warning in tcp.c
  nvme: enable Clang context analysis support for nvme host driver

 drivers/nvme/host/Makefile    |  1 +
 drivers/nvme/host/core.c      | 24 +++++++++++++++------
 drivers/nvme/host/fabrics.c   |  4 ++--
 drivers/nvme/host/ioctl.c     |  2 +-
 drivers/nvme/host/multipath.c | 28 +++++++++++++++++++++----
 drivers/nvme/host/nvme.h      | 38 +++++++++++++++++++++-------------
 drivers/nvme/host/pci.c       | 39 ++++++++++++++++++++++++++++-------
 drivers/nvme/host/rdma.c      | 28 ++++++++++++++-----------
 drivers/nvme/host/tcp.c       | 19 ++++++++++-------
 9 files changed, 129 insertions(+), 54 deletions(-)

-- 
2.53.0


