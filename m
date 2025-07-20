Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD072C83F1A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jul 2025 18:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HyjXf3/nSEeB3THFU/B+KtgJn+xJwQJUZZbDs1Ls+ag=; b=k6/ovIZrmkNbLjUsoUWh1gWQnu
	ylwVEToDHFU5TMeYAchobTiNTMW/Dn+mHulgjSjGwUbcMHws6mX02DpJvje7JFPFQ7c1DqtIW5q2p
	gRQfou7AsOAEIXPsEfyqMC5E8JHiZedzUiNs+biKj+G6tO+OHzzqhToX5cTl2HBSz6C0eu5+kY8OL
	EZ367rEkIsw/wz5oj0WM1a9gppm2+tDTghs2vEzPhBRIJo2osUyj1zZBIkgk4OeTVw+6X5+xHLUlh
	CSI9rjGzofyZ/KSDAfPK4y+YHQBifviaHAjyT2oQWEwLjWIvEk0aybE498zCkmsTQkX30XTQvdcn4
	mheKAIeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ3S-0000000Fc6F-3sYO;
	Sun, 20 Jul 2025 18:46:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZ13-0000000Fbq8-2CO5
	for linux-nvme@lists.infradead.org;
	Sun, 20 Jul 2025 18:44:06 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KIDUif023780
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=HyjXf3/nSEeB3THFU/
	B+KtgJn+xJwQJUZZbDs1Ls+ag=; b=GRHQAaZ61A/NH2kpmX6X+KrEHqeFa3oAYM
	D34zPQvpvbt3yFoS6yCSKZuVs85YxInXZIveNjM16uUCF5wPMEZlVCXXs4/H68Qt
	EDD0zrqWJkZqNHB5xPYcUP9siigO4S5qNxfytAzekxywSBTlBAuWTce5qq2UBGVZ
	6fY71BpLxPcUQC9j06s7jM9Y7Ci0k1v54ms9W2yZCBez6/HgUq4wekdbxtJY6SBe
	kThBUn9klEUGZGDIeVx9XHEk4Z/U+RGKFLd/FZltvGvBCe7Eq7iVI0t+UyLxzMZf
	Whg7EtnVM8qBPvXIJ7kBa8J89GP1upc4elDyGy5zLbx+lz7bMLWw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4815hs02a1-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sun, 20 Jul 2025 11:44:05 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Sun, 20 Jul 2025 18:43:59 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id 747AB178C789; Sun, 20 Jul 2025 11:40:49 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>
CC: <axboe@kernel.dk>, <leonro@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] blk dma iter for metadata
Date: Sun, 20 Jul 2025 11:40:33 -0700
Message-ID: <20250720184040.2402790-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N8QpF39B c=1 sm=1 tr=0 ts=687d38f5 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=uDLVS1ffcISpbTSFWSIA:9
X-Proofpoint-GUID: iQ_tEca4drOP2QXjrUbOgK6Gy27ZyQYZ
X-Proofpoint-ORIG-GUID: iQ_tEca4drOP2QXjrUbOgK6Gy27ZyQYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX8C4IhTpfS4u5 +xU34UfJz4r3MuXt9UkYCeWaEzu5V6Q7M1rmb5AGxlJQ+2a2DTcwYP1ThHwo2wCbi4tbLlmkF/K a/keyUoPSB7iDEMWjnMMmh4dCHLfVm2ALwKxzIp15J7ctOjgWLz7hgeLfKaFErVnVZds1ZPmSJ/
 +GvEDAXtgImnf+iw5O8VHnUQmDi+bfHoUqBQhX3ybwlsnZgGJXI9MkuEOUGzUmCE7x7s9CVBIvm r9Amnv+edxks3w63fkGyVFgHLrNOpk+uksnR/zOgrWY5oGPwPBXhQDK9tVbZD8SE8cA75bO5ePR dtG+yycC9iH34jhhc6FCX7tOS+PnCZ7QXNxym7Ffbv2p05RzP3uFT5p+78A2Dj/cmoQybHlGD4Y
 FBU/Ghew+mMtHF9whhz/CGLefX1lZDkz77zNJSNCcX9uDzWyRe4z/dp4tSBG5RbnaVyr/+Oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_114405_565347_DD566E35 
X-CRM114-Status: GOOD (  10.79  )
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

Here's a new take on the dma iteration for integrity requests.

The current code still has the integrity payloads subscribe to the
"virt_boundary" queue limit when considering merging and coalescing in
iova space. This is an unnecessary limit for nvme-pci metadata SGLs, and
it currently makes testing merges a bit difficult.

Changes since v1:

  Provided a bunch of prep patches to make the current dma iteration
  more generic to reduce code duplication with integrity metadata.

  An nvme optimization for single or coalesced segments

Keith Busch (7):
  blk-mq-dma: move the bio and bvec_iter to blk_dma_iter
  blk-mq-dma: set the bvec being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add support for mapping integrity metadata
  nvme: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-mq-dma.c            | 173 ++++++++++++++++++++++------------
 drivers/nvme/host/pci.c       | 135 +++++++++++++-------------
 include/linux/blk-integrity.h |  17 ++++
 include/linux/blk-mq-dma.h    |  10 +-
 include/linux/blk_types.h     |   1 -
 6 files changed, 207 insertions(+), 131 deletions(-)

--=20
2.47.1


