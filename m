Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43713CD4F23
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DHRSUMtSvMWkGpUJJ3RLx3chgBxfvx8/b7OCBP4o08A=; b=yAS7yjD3Uo9OaRpt83eiRoNUaX
	zQCGRYRCLEEavU4Xnvwak46Nx6pewh+vmpbvOJnGN1hP2VA7h8CUGDW2WTYrS3I33fnq39Poe8uPk
	ZIetIHxYM3vRjC3B2jeR1L1UOj5DCMDSMYBB/N0kEC5BDDZalkW5PmRPGzeL+V2DNDLiSHxRlJZuz
	zHNZE9aFvG0kkycghsuiNGbNHdFY/6nCbH++D2e0XeJWfKnUemLy6Zh9O/nq0ZXvkQ+ikuPY1xPdQ
	+jpfyTMFqRLS/3PUK71PloVHqM+JIKRdAIlIfoQ8E+j+ku7Mvjnu4vmPDUH2tbUYx5scnQ5vSKdYA
	EIhDFozA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slutm-00000005dRo-3mz0;
	Wed, 04 Sep 2024 18:38:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sluti-00000005dOJ-32ln
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 18:38:32 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484E1Zko010132
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 11:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=DHR
	SUMtSvMWkGpUJJ3RLx3chgBxfvx8/b7OCBP4o08A=; b=K7z6EXxHm4ID2a/aUy6
	qwPEWnATkJY99cDBST3AP6o9O09QB7QO3Ye25z/Jyy80OoxZVo7c1IIooAfZ56Hf
	3/p7chtvvbohDOoDpuag7/iXyy0WQXA3Cf/gHym5MDSutVqzAY0Wl4uykBQ7L5iC
	AsycE3EExtPi4q5luQjmn0CHOIZXDDCGG5v0fYbi5C7jB74ahBfhw5gXVHXDLfaA
	Fm5H9yQtFN256sm3rx97eegbcN7SmF2egiSrdTYIKpeuRFDaDjkcUqXg6H1kR6Dm
	ozxY7pZ7OQQydRd1Fs6/cWPlL5qkuolyOyskL9bgYtp61sFewEemEIZuF9f3auMJ
	OFg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41e8fvf122-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 11:38:30 -0700 (PDT)
Received: from twshared39016.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 18:38:26 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 04CF912A1F07C; Wed,  4 Sep 2024 11:38:18 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH-part-2 0/9] nvme support for sgl mptr, safe passthrough
Date: Wed, 4 Sep 2024 11:38:08 -0700
Message-ID: <20240904183818.713941-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xi8LKWTCYHoXOzzbQzjR3FQhRv-KMwFN
X-Proofpoint-GUID: xi8LKWTCYHoXOzzbQzjR3FQhRv-KMwFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_113830_909647_AB4DE0EB 
X-CRM114-Status: GOOD (  12.87  )
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

NVMe's implicit memory lengths is a danger to buffer overflows. It's
been know for a long time this vulnerability exists.

The nvme protocol provides sgl with explicit lengths, so if the hardware
is capable, let's use that.

This patch series sets up the driver to always prefer SGL
representations on user passthrough requests. An added bonus to using
SGL for MPTR is that we can support multi-segment integrity buffers,
allowing merging once again. Request merging with metadata, though, is
kind of broken, so that functionality depends on this block patchset
(hence the "part-2" subject prefix):

  https://lore.kernel.org/linux-nvme/20240904152605.4055570-1-kbusch@meta=
.com/

I currently don't have real hardware that supports sgl mptr, but I
believe that's coming to me soon. But in the meantime, if you're like
me, you can use the emulated device. Support for MPTR SGL is provided in
this currently unmerged (but very simple) patch to qemu:

  https://lists.nongnu.org/archive/html/qemu-block/2024-08/msg00332.html

Keith Busch (9):
  nvme-pci: use sgl capable helper function
  nvme-pci: provide prp selection helper
  nvme-pci: split out the simple dma mapping
  nvme-pci: remove "dma_len" from nvme_iod
  nvme-pci: simplify io setup function parameters
  nvme-pci: common dma pool alloc helper
  nvme-pci: provide a sgl mapping helper
  nvme-pci: add support for sgl metadata
  nvme: force sgls on user passthrough if possible

 drivers/nvme/host/core.c  |   4 +-
 drivers/nvme/host/ioctl.c |  17 ++
 drivers/nvme/host/nvme.h  |   7 +
 drivers/nvme/host/pci.c   | 319 ++++++++++++++++++++++++++------------
 include/linux/nvme.h      |   1 +
 5 files changed, 246 insertions(+), 102 deletions(-)

--=20
2.43.5


