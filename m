Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C78CA0EE6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/M1d/NZN2jGF4JwLAM4nQoOj13sBQ+gz8kyS9mWZedY=; b=IEElkNYlNlWDp5gYcCDqKUXr4C
	kHxxaDO5tgV7Bjp0pydDkaoSp+fh955CJVn48JK2NanB9XI2nt57ksAJbdR1PUR1zGAGa4S8UTa7D
	Brz6VCORllrOEOGRdtfv8WKgwGeGb3VNkftvSWxXoe7Em8cTZ0xMRWQAeeRRvc5Rz0hHlhlt2Wzsk
	GXW6iPTC6ai5A/KoUH3SKaZd01bJsHQV5/X5UbICDrRl2NFxVvI4PnP6F1jAIm87ax2Tmh/QnyIRJ
	4vEvGrwCzRAMx1AxGs+pNqjtpRUBRBSSN71MfMZ9NzjTe2kxaznb7TVagvzPYBKbJ20uBUCsd8i0H
	U+tociiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umEO6-0000000EOqb-0HTB;
	Wed, 13 Aug 2025 16:31:42 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDST-0000000ECKJ-10XB
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:32:10 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFBki7020949
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/M1d/NZN2jGF4JwLAM
	4nQoOj13sBQ+gz8kyS9mWZedY=; b=Wb1YNZwjbGmnIPHu6XXo8YbK6CPmKxEGQM
	Ube4SEWqqyT3qnji8CBuAwQiAn419oU2PyinuZV7wgH8bYvw5KuTzEr369844Rqx
	SxO7yjnHZEemjBlHgLxbBzGXGYg7n6D5zBa/oo7Wgh3IlwTgH1Fi9J+14idpwfkU
	mxfdGhVzG/0tYF0tKAGFq51itzkF/TsYqiVpAiMpUejsscooLkwCyQbOh1uM18bQ
	K8dtlhRIDZ/C6LEEocCt7moPhmI+qvP9uoexfzUuDfXRVXVlzWOEdpu+X2k4/aKK
	BsLtzQAE88NFtC6NT4YQ0bVJUoeA1o95b0i7R+aIcEpd82uu3EDw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48gt29hp7j-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 08:32:08 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 13 Aug 2025 15:32:04 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3C27D97CD7C; Wed, 13 Aug 2025 08:32:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv7 0/9] blk dma iter for integrity metadata
Date: Wed, 13 Aug 2025 08:31:44 -0700
Message-ID: <20250813153153.3260897-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NZkprq1DeaMLJWURBftUvsk5LBNC7F6L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0NiBTYWx0ZWRfX5vtT/ZZv3i4Q 1qJ+BrrwmIJB3re9huGdF1k2C4pqRP+3woHsoznLwYdIXnrWrCFL14QcIikC5MiP8ONz2E0EaEB tb3G2Q6J/0nqTIaPPq7Gwoiks0eb+ULdxS6bthToO72Pw7FH71WhGNofVB32krR8B3c6KxaQqc0
 7bKeLBcFobigSqqBVouAyxnWdF3R4er+RJlTNzdhSLCmZF/BcmEhv7H/BL6Pr5t36VR3E+pKRou eQjrlO9Efc8Sylqsi6iEXa4MCtrpvYqnO9BNf3xwIragOng0l1VLB4mZGwcSICQpc8w6O/8iQ6/ sphDIlPNU6Mwfo3QDvoVlGfIt9ulQtiobHLU78Ngv9cmFqAjGirDOsJm7QrPhrD6xXo3627zE7m
 K2Ff97Br7OpY+ZePeah55RJtbtCaej2noY5e/urmOtMO8BkyooV0hKiB/3Wy5u/0JWRju1F3
X-Proofpoint-ORIG-GUID: NZkprq1DeaMLJWURBftUvsk5LBNC7F6L
X-Authority-Analysis: v=2.4 cv=Oe+YDgTY c=1 sm=1 tr=0 ts=689caff8 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=zCnT93EQd0_OxjDQTxwA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_083209_324467_06BA7BD1 
X-CRM114-Status: GOOD (  10.91  )
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

  https://lore.kernel.org/linux-block/20250812135210.4172178-1-kbusch@met=
a.com/

Changes since v6 addressing review feeback from Christoph:

  - Moved the integrity sg conversion to its own patch

  - implemented it in blk-mq-dma.c instead of blk-integrity.c to avoid
    having to shuffling functions and common types around

  - fixed a mistake in v6 that missed using the iter_next helper
    function

  - improved changelog for the patch introducing the scatterless
    integrity mapping

  - nvme cleanups

Keith Busch (9):
  blk-mq-dma: create blk_map_iter type
  blk-mq-dma: provide the bio_vec array being iterated
  blk-mq-dma: require unmap caller provide p2p map type
  blk-mq: remove REQ_P2PDMA flag
  blk-mq-dma: move common dma start code to a helper
  blk-mq-dma: add scatter-less integrity data DMA mapping
  blk-integrity: use iterator for mapping sg
  nvme-pci: create common sgl unmapping helper
  nvme-pci: convert metadata mapping to dma iter

 block/bio.c                   |   2 +-
 block/blk-integrity.c         |  58 -------
 block/blk-mq-dma.c            | 278 ++++++++++++++++++++++++++--------
 drivers/nvme/host/pci.c       | 197 +++++++++++++-----------
 include/linux/blk-integrity.h |  17 +++
 include/linux/blk-mq-dma.h    |  14 +-
 include/linux/blk_types.h     |   2 -
 7 files changed, 350 insertions(+), 218 deletions(-)

--=20
2.47.3


