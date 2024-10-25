Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFFD149F3
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 21:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/GQfP/1bQVo+MIHxlX/7bWekCbFNLz0QJfbEivfPyp8=; b=HcRn/RyoLM0kPYdzou5D6QU4Ne
	K+zpIiUjERpWFvOD5BFyT7D4oDSPxqlq97KaPon7XLGhI5Il8yryiCpMVUdIG2jMLP8zMDYU/uc8z
	aSJLHpuoAYHcZUSpPbP3uvLHrfzPo2TT1aNscVXX0DvG0d8cBWbBZNLcHEHpERv8/OZsfnX3PUx+8
	31yqnLTfCZcya6Nnox4sajwMN+ti5Ldgv8oU3NQgZMCWNOIzXaWX9HXSGR3XIupLLvJHKlOxkSTrL
	MBly8/VOMgtMAmkBvJevBtFlbXEcgzt0It8wWTPd2TSS3t3VzOAJaIeRf7r+P1NLMuVBeL0W3Jm9k
	BnknWVTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S0a-00000005KLI-22s8;
	Fri, 25 Oct 2024 21:38:12 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Rzm-00000005K4A-3Qi1
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 21:37:24 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKcxlw024276
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:37:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=/GQfP/1bQVo+MIHxlX
	/7bWekCbFNLz0QJfbEivfPyp8=; b=b4Ljz4jbiYYgNE6E7pJJS61xYVIOwWwnIZ
	8bWHNKURSQBglgrN/fF3PasxbhGqOVFlXIsJfllFNojf/KldUjUn0wuC+D4+0UIT
	a4o8JMppCG2/qzxtExf4OVSc/LThDiDDZ0rmxndnrSKSCR6tj1fxi+t59JmGgij8
	sSfIQUQSa5K3BACjIatE7kw5hsU2voOHUwSuHcQnsRJL7FSU3jkN8+eGWfMH5L1h
	86ud3IUzEsKDFlfkdAu0/4TXulZpJ3WiYvMltx6DKAtEfXEiQGJx3eXKwprjPs6n
	8cMg4ICj0P3BGD3yfveg8MCUR86wCsUyEhmbtuDULGTKvvLMOP/A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42gjhxrbx8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:37:22 -0700 (PDT)
Received: from twshared13976.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:37:19 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6023F1476D735; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv9 0/7] write hints with nvme fdp, scsi streams
Date: Fri, 25 Oct 2024 14:36:38 -0700
Message-ID: <20241025213645.3464331-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XzG-cjs80bsCxdy7H9NbA4lwTG9IirU0
X-Proofpoint-ORIG-GUID: XzG-cjs80bsCxdy7H9NbA4lwTG9IirU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_143722_894628_C3F85468 
X-CRM114-Status: GOOD (  12.77  )
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

From: Keith Busch <kbusch@kernel.org>

A little something for everyone here.

Upfront, I really didn't get the feedback about setting different flags
for stream vs. temperature support. Who wants to use it, and where and
how is that information used?

Changes from v8:

  Added reviews.

  Removed an unused header.

  Changed "hint" to "streams" in the commit logs.

  Ability to split available hints that a partition can use.

  Dropped all the generic filesystem changes that were defaulting to the
  kiocb write_hint. They are unchanged, which having no functional
  change was really the intention anyway, so let's just not change them.

  The above means we don't need a special fop flag to indicate support
  for the kiocb write_hint. Those filesystems that don't support it
  simply don't read it.

  Added the SCSI support since I had to read the spec anyway, and it is
  just a one-line change.

Kanchan Joshi (2):
  io_uring: enable per-io hinting capability
  nvme: enable FDP support

Keith Busch (5):
  block: use generic u16 for write hints
  block: introduce max_write_hints queue limit
  block: allow ability to limit partition write hints
  block, fs: add write hint to kiocb
  scsi: set permanent stream count in block limits

 Documentation/ABI/stable/sysfs-block |  7 +++
 block/bdev.c                         | 15 +++++
 block/blk-settings.c                 |  3 +
 block/blk-sysfs.c                    |  3 +
 block/fops.c                         | 26 ++++++++-
 block/partitions/core.c              | 46 +++++++++++++++-
 drivers/nvme/host/core.c             | 82 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h             |  5 ++
 drivers/scsi/sd.c                    |  2 +
 include/linux/blk-mq.h               |  3 +-
 include/linux/blk_types.h            |  4 +-
 include/linux/blkdev.h               | 12 ++++
 include/linux/fs.h                   |  1 +
 include/linux/nvme.h                 | 19 +++++++
 include/uapi/linux/io_uring.h        |  4 ++
 io_uring/rw.c                        |  3 +-
 16 files changed, 225 insertions(+), 10 deletions(-)

--=20
2.43.5


