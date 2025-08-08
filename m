Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956AAC87FD2
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Aug 2025 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jFORdkuYpnBcFvG1gOx/i+B5cKvoQ9+xtADPU12ZRbM=; b=WIHmg4ZeVsK7+U8bR4Xd713oaa
	trPXlSuVMD8bOun4asNWRJrOu5lUuR0LBJhCWsnbAkIY+e+rdTcK24w8JTkIIQbs3fwk5T9EtSu7r
	RvP4h+aDuMV/fEynOMZE7EWG7zJ8LN3Gp1ipK8TJ8yA8vp07aCOclelvnuzFJ8fTvLUthsif5M8Db
	Y+JHAL2F8FG0dUAsJLeYsD1jTQxFVmWLrd+ouaXFMeUirhRO5MSecWClQTyx42jWTtfeFYMiMfIc1
	d4++iEzrZ4JEx+8KTUhyy0aVlJxmVxMprTDjS58WsXyqX+eQIjiQ/yRZxgtC9w74FMu0PgS+P5Hhw
	KKHEbWCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPWh-00000003GBW-0CxA;
	Fri, 08 Aug 2025 16:01:03 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukPUX-00000003Fi2-2hM4
	for linux-nvme@lists.infradead.org;
	Fri, 08 Aug 2025 15:58:50 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 578FIqk0012510
	for <linux-nvme@lists.infradead.org>; Fri, 8 Aug 2025 08:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=jFORdkuYpnBcFvG1gO
	x/i+B5cKvoQ9+xtADPU12ZRbM=; b=R1m+MrbxW/Iv0KVBdZiLhIFe4dX7FglyQp
	mrsoKDwYyGtuzyJ4xUrgDcmoMeAfoGWOsQoMPaInleEshwsgZ1mGxu2himhhOHf5
	8XE+h67PNej2L4wl79C6UNhqfyezFUxSS4V+axYZlYAd/rbpgGfXnOvoFjVoleXC
	WdhLsqr5VOyVNpj6yBRCS2VNrFkUdUs+5/1uVxLhhny9M1YKtmNDXOx8HKYL6mwU
	prASPf+HAxJhtdPOQyqx/wX9Ki8101xhmGveBFjoXxic2hy6yB2cAOdBeoes/yXY
	aiPpU0jyuqmaGIYjtA048YHegB6Zwefzr0C05FLzIwV0iCLQDtWQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48d1x5xjtu-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Aug 2025 08:58:48 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 8 Aug 2025 15:58:39 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 19B556C76BB; Fri,  8 Aug 2025 08:58:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 0/8] blk dma iter for integrity metadata
Date: Fri, 8 Aug 2025 08:58:18 -0700
Message-ID: <20250808155826.1864803-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX9drtnJhkH37S 6p5j4Y33Q5cSdpmrdUGdtZGvdk98vfuknE1KvCwl26gO2Z/4eZJzq4kehbTpMXvH9lqssm1S9kB /rrUsJz9kHlKsU0HyfyqLzieSe0sfbSMoR8s6LQWtz3XQp6AEmWJpup5M/3xglwAfW4o0IJAySO
 +HwTl4e4Mv5wyTOA9d/QToA/L3HxAsUe214YvHBZg1KDBEBFHyHmgWkpGcqazR07efpELaTYUgr 2D1E1SPd2a4m4TAvtTbBtY5NUBucP2oQMpcKvRCYOir2d+IKDlPy/EpsyxS+flP64KUnR+5A/x0 I2VjRYY6mHSzskkCJ7alybovu2gXf0MkzAAOPw4TQ/uCgsx0QZh4ovlYxwqOxrgfB+nHlZ9NxX8
 qC0/wYglDsIfHr3oMxHslccQsgAbGIm4u5/O21ri0KjdAQcuRNkqwzf+jGp+AoDurQeFSvRG
X-Proofpoint-GUID: XFVK_7WxhfeZH6qb1aVhC9CNq8GfpFYI
X-Proofpoint-ORIG-GUID: XFVK_7WxhfeZH6qb1aVhC9CNq8GfpFYI
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=68961eb8 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=QyXUC8HyAAAA:8 a=agJ6Vr9HkWBsIA0g1xEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_085849_797643_8C9F056C 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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

Previous version:

  https://lore.kernel.org/linux-block/20250731150513.220395-1-kbusch@meta=
.com/

Changes since v4:

 - Fixed nvme initialization for metadata total length (Kanchan)

 - Removed the now unused __REQ_FLAG_P2PDMA (Kanchan)

 - Fixed checks with CONFIG_BLK_DEV_INTEGRITY is not set (lkp@intel.com)

Keith Busch (8):
  blk-mq-dma: introduce blk_map_iter
  blk-mq-dma: provide the bio_vec list being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 239 +++++++++++++++++++++-------------
 drivers/nvme/host/pci.c       | 197 +++++++++++++++-------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  18 ++-
 include/linux/blk_types.h     |   2 -
 6 files changed, 287 insertions(+), 188 deletions(-)

--=20
2.47.3


