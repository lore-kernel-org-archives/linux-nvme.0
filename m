Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9644C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dByfk1j1FJ5theFzNXdoepe0okfzAvuhPAbmsID9rds=; b=ObFmizybsFYR6Ko70qXu8chEs3
	D8cwgndK5+X5yyonwczI6fwp+NQvArG8qgANzR6wbIh0PxUrJu5RGsx50Er+MAOvlX+dMeG+yhXqm
	UdDy9Gn4ABozXGGDlnHw/mftKeL2NyE4jWm17KdHiEKBobyW/sTYal3YV23+THn+07djcPeNuIEXb
	A5kqIp5Tb6zbHE5Z5bPCbzt1aEkhYNo+A6oNJAp4N7wdJZ6yhiFBsRXY2kGtUjA1xYvj84lg69gQq
	JcM0Vh1Xtfy4C3f5QZe59kdSeTYdh5dN4PpNomVGmhzmZTmPlkP8OysjC/z/zruKXTFVQXncYAknF
	tygRWInw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmHvU-00Bfij-Er; Wed, 04 May 2022 16:32:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmHvS-00Bfha-D6
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 16:32:31 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244DvgtF029454
 for <linux-nvme@lists.infradead.org>; Wed, 4 May 2022 09:32:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=dByfk1j1FJ5theFzNXdoepe0okfzAvuhPAbmsID9rds=;
 b=fG+ghQxaN10xWqon0SfyQL+qScCY5cdw71AWRwfDtwOZVCDwKGemuiMEhPjhfc41MiEO
 ivtwrxWueHAsMwgQiiW0k0+kv/NSrydll2boDUGSR2Br74TTLfy2xC5qKSgylQ4pNdMV
 8aj1IuUolD9DuaZbE27ZcAFCJkk/3p8VSiQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fuf1y432e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 09:32:27 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 09:32:26 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
 id 919F7393967E; Wed,  4 May 2022 09:32:22 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@kernel.vger.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/4] partial sector read support
Date: Wed, 4 May 2022 09:32:03 -0700
Message-ID: <20220504163207.891761-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X6p3Vwx-nm8svclxBSyYaeReLMurT0j0
X-Proofpoint-ORIG-GUID: X6p3Vwx-nm8svclxBSyYaeReLMurT0j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_093230_635971_2D968F2C 
X-CRM114-Status: GOOD (  15.63  )
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

Don't you just hate that you must read a full sector when you only cared
about a few bytes? Well, good news! Standardized protocols provide a way
for the host to describe unwanted read data, allowing partial sector
access. This lets applications reduce allocated memory that was used to
hold the unwanted data, while also reducing link traffic.

This series enables this for the NVMe protocol through direct io. With
this, a userspace app can read a single contiguous byte range, subject
to hardware DMA constraints. An in-kernel user could theorectically
construct a bio to read multiple discontiguous ranges if desired.

Keith Busch (4):
  block: export dma_alignment attribute
  block: relax direct io memory alignment
  block: add bit bucket support
  nvme: add bit bucket support

 block/blk-core.c          |  5 ++++
 block/blk-merge.c         |  3 +-
 block/blk-mq.c            |  2 ++
 block/blk-sysfs.c         | 10 +++++++
 block/fops.c              | 61 +++++++++++++++++++++++++++++++++------
 drivers/nvme/host/core.c  |  3 ++
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/pci.c   | 17 +++++++++--
 fs/direct-io.c            | 11 ++++---
 fs/iomap/direct-io.c      |  3 +-
 include/linux/blk-mq.h    |  2 ++
 include/linux/blk_types.h |  1 +
 include/linux/blkdev.h    | 18 ++++++++++++
 include/linux/nvme.h      |  2 ++
 14 files changed, 127 insertions(+), 17 deletions(-)

--=20
2.30.2


