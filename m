Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8A3CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xpOIwliMbime1ppBRvQMOHqbeP8PzhQ+O2/c/TiQxeI=; b=sjirAWCrQ2QpnwMGFgk3kAcidE
	IaUJxxf49EcpPmRLl8PQAAp/kpHmgKUIwkTa3whKLD/2HQrApTC/VDsYM667cRJSNten5e+ErCVwJ
	ja6OWrPayyEHlnFztJDXKGxbQ9KWv23lJ2FTMOH6hRU+RBDsT1tBFtUkZurBgsghgbYfngdl7Vnka
	GYq24IuyNSH8QhrGmyQHlhL52PT0tA+hRG3uIBlmBTmJiSpOygpluGGdBw7RLhprFoTfJ7fuvavUO
	BQD5NWC135m2NUmFzSpqCndZ/ULcZ+vq63TP2/TGHx24knWgRatQaFtX3WoXgKfbiHkcPgBIIb+hT
	k6LRBVdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulssw-0000000BbVA-0kgW;
	Tue, 12 Aug 2025 17:34:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulpRg-0000000AyxQ-36Dk
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 13:53:46 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57CDnkVE000472
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=xpOIwliMbime1ppBRv
	QMOHqbeP8PzhQ+O2/c/TiQxeI=; b=tgOKfAz1MkWBzaZMwhTvYbs2fDqRhvjpMR
	8yaa9zbWlpetAJ++rqasjCh4J8ds6mtJNgyJykXU/3FtvbEcnkPiNfmrjUzIAK7R
	MQnEmQvbIMuMTmKnoIhtJXBn0EIZon700eRusP65cwkOB907sSGuSaMXxHpBc+Iv
	ygWJLZK95VfalkcrJ4GgXDGRC3+q3boNvfCtQ/qOfNe0lPNVQYmOiP8RBtArta2J
	c6WOIS4ARI/RDjMyg/9RhPX2H3sG4lwYKHFL6aDc2M3TBgJhFjPlGDKZ0MQGHSpD
	0OJ2MIvLDOhPN2MtCnSm5p7eE5TO/Xc60O6RAoaoY1vS6TfV5Q+Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48g4fb9qu5-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Aug 2025 06:53:42 -0700 (PDT)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 12 Aug 2025 13:52:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 807268D4075; Tue, 12 Aug 2025 06:52:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv6 0/8] blk dma iter for integrity metadata
Date: Tue, 12 Aug 2025 06:52:02 -0700
Message-ID: <20250812135210.4172178-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pzAEHPjJaFfYv7d0fgOSEXeYqjXqGJg9
X-Authority-Analysis: v=2.4 cv=Y6z4sgeN c=1 sm=1 tr=0 ts=689b4766 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=WobvK_TCKI2ct00U_TsA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: pzAEHPjJaFfYv7d0fgOSEXeYqjXqGJg9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzNCBTYWx0ZWRfX+yo/5rugmEtn kITvKZXYGiIcq7Ws3ASjdzkj4Twq82T6sCXoj/D9caclOvjRpkaCIbym17utW6I7DlRX4TYrccf +SACZUsMhXhT+qWvn18wert8gdBZWcJv9zwGAG/nSd7VGrP7kQgU4Xr6KPCE3b7pY/Ae0Y1gOzj
 nfojqXQZIu+s+4ygySZrmy/beAdOXa24f7LBl+N9MBHvC//XpnLl/5pAYs9j9tHUt4ShHW4HJCZ yTmHT12xw2jWzI4R06ErnfjmOw2bk29rTYCdSzTNKMiWUnU8e5y5AwNUsQuNkQTUgTf49HH3GxN +wQ65+LXKYkCUeC5t7pSltfN1jGaUfve82PG0I0sVAWB9x3ZRNpFUv8GJCegN/Vf57k1yLnO8rt
 x2kUbS7JaozedgLrdNcz3wAZqtkFx740iPIna2rI0pKtMF/wcT26n4U+MqLulTDXmdWvxZjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_065344_903662_EC5C8C09 
X-CRM114-Status: GOOD (  11.50  )
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

  https://lore.kernel.org/linux-block/20250808155826.1864803-1-kbusch@met=
a.com/

Changes since v5, addressing review feedback from Christoph:

  - Keep the phys_vec, create a different iterator for the lower layer
    separated from the phys_vec

  - Commit log changes describing the bvec array being iterated.

  - Rename the blk_map_iter initialiation function; take a pointer
    instead of returning a copy; make it inline

  - Rename the bvec pointer being iterated to "bvecs"

  - Have bio-integrity legacy scatter-gather iteration subscribe to the
    new dma api. This required relocating some inline functions to
    header files.

  - Using 'bio_integrity()' to avoid needing "#ifdef CONFIG_" usage

  - Kernel doc for integrity dma mapping APIs

  - nvme comment explaining when we do or don't use MPTR format

  - Various nvme code cleanups

Keith Busch (8):
  blk-mq-dma: create blk_map_iter type
  blk-mq-dma: provide the bio_vec array being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-integrity.c         |  43 +++---
 block/blk-mq-dma.c            | 251 +++++++++++++++++++++++-----------
 block/blk-mq.h                |  26 ++++
 drivers/nvme/host/pci.c       | 213 +++++++++++++++++------------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  14 +-
 include/linux/blk_types.h     |   2 -
 8 files changed, 364 insertions(+), 204 deletions(-)

--=20
2.47.3


