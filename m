Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD93CD4857
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yXzLEZ5bz9vaEEDlWYyoB6/11NgwtSFlDVn1Em7Vjmw=; b=TWvEjCU+Me6hUvjyQDhVJmL0rO
	p/tjGNqk161dFhC0oBXahwiIjtp4mubW7rYQyrH8XHKUoOjBXzEEY/kPagmbUxV8Kts2VzAzFnTK0
	rKGlL3mcx0845g8d39gkC1Rath9Z38zbkIKv5T9Dy6OHkNflZwlB63RRvJR75tj0IBZPYULNVQVJC
	DAjGxttgxJVRR6he04r+jsqtN6FHPVz1EO2ltf4NagP74/YGJ5ry2DnVNONDLLaL2/BgM1PyRSOo2
	LoBA3Y5k1gwkjyuuOoH5KPn3okJoHDCTk15Aid+oBWeghT/aKaOQLlEXtlFGXDiiPmzqq4Jivnnhn
	OabQ2HTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slsum-00000005GoX-0rTU;
	Wed, 04 Sep 2024 16:31:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slrtk-00000004zOC-0YuS
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:21 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845F7WW022818
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=yXz
	LEZ5bz9vaEEDlWYyoB6/11NgwtSFlDVn1Em7Vjmw=; b=ixPsuGhOlG92dui+K6S
	74cl0wF2RgPBbqUHFyH86rlpwN/QLrkH8o1bCWzLfmDWuS0u/BQSHMoSelSI/pt2
	xNCvCukbAbwz5FFrqZFwNZue5xnBYOsyf53xHZNbGAlZiLNxz94mFJkFBZAenKhs
	MK5aDuz6SkCHUNj+UwnOLWwahiN4zd5MTc9ZC92+0jfgDZpZeoDpO4dEhEsrfCLU
	7a6sdlmpDLRxzJe8zY3sufYCGiYT1dPWH7NjijIn/ajlFF9xVgNVUkbevJUkahJY
	nhwCB/yVW5aZK/gigCR2xNfULEIx9ZebAXhdypRNuqkgQ1el5T+2KIRACMVo6a1Q
	fRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eh7v2vxw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:17 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9D67312A036E2; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 00/10] block integrity merging and counting
Date: Wed, 4 Sep 2024 08:25:55 -0700
Message-ID: <20240904152605.4055570-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zNSSXi1eEg8HIYwUFew6DvwnnnZXaT2D
X-Proofpoint-GUID: zNSSXi1eEg8HIYwUFew6DvwnnnZXaT2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082620_204082_E948123F 
X-CRM114-Status: GOOD (  10.43  )
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

Just some fixes and cleanups to counting integrity segments when
metadata is used. This fixes merging issues.

Changes from v2:

  Included all the follow up patches I mentioned in the v2 thread.

  Incorporated Christoph's suggestion to rename blk_rq_count_integrity_sg=
.

Keith Busch (10):
  blk-mq: set the nr_integrity_segments from bio
  block: provide helper for nr_integrity_segments
  scsi: use request helper to get integrity segments
  nvme-rdma: use request helper to get integrity segments
  block: unexport blk_rq_count_integrity_sg
  blk-integrity: simplify counting segments
  blk-integrity: simplify mapping sg
  blk-integrity: remove inappropriate limit checks
  blk-integrity: consider entire bio list for merging
  blk-merge: properly account for integrity segments

 block/bio-integrity.c         |  7 ----
 block/blk-integrity.c         | 78 +++++++----------------------------
 block/blk-merge.c             | 13 +++---
 block/blk-mq.c                |  4 ++
 block/blk.h                   | 34 ---------------
 drivers/nvme/host/rdma.c      |  6 +--
 drivers/scsi/scsi_lib.c       |  6 +--
 include/linux/blk-integrity.h | 11 ++---
 include/linux/blk-mq.h        | 12 ++++++
 9 files changed, 47 insertions(+), 124 deletions(-)

--=20
2.43.5


