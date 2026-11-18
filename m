Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DC606A331
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wRyWXi9N;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Zb/w6mgL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Unsubscribe-Post:
	List-Owner; bh=3bKETn2tfT+VfzHpVzyvlFK7iO6ILBCK0F6DzWCM8Rc=; b=wRyWXi9NE6KLsV
	UArVluGgGRS1hchYYFPyaNh+K/fpxTkFxZ8Oo0wCmjEJ3aJxVEIINn3KjxE60oIqS3dx1CFlRwX7g
	ouH8B1sL4f3MEWT2L2gMwmlL6VB48LyoFrfLM42qIk5AXFL28Mfn2N6BZnwItLMI314O0R30Yoo5n
	9tzzq75BtLZkMZeqj4ZMI8ZESUwbLO2IjHhGIpZHYceOGZceGaQKX3gLTgEr9k0ebLSqIx1gnsQcH
	Jj1/gbrP7vzLybHmlEE0qwFiWNy14ce61BaApLZKBarb1c1fKvmcCMU69rQ/NyMAhODKGrb48M06e
	REz5+ooi0hwmEb42GreA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdsz-00000008iHJ-115r;
	Wed, 18 Nov 2026 11:31:33 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTdsq-00000008iEB-2Liu
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 11:31:31 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261118113112epoutp035862fe18184a53a2f09ec3c0a9f79a21~pIFRI3r2N1739317393epoutp03j
	for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 11:31:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261118113112epoutp035862fe18184a53a2f09ec3c0a9f79a21~pIFRI3r2N1739317393epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795001472;
	bh=3bKETn2tfT+VfzHpVzyvlFK7iO6ILBCK0F6DzWCM8Rc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Zb/w6mgLGo+l81rmhCdgEFNx4/tKjOxwPE/VFDT4CF3G0EnA9S0pRyWTDLkN0s1YX
	 tPUSM7WoZhR21C7XYQ1CSipxB2LP69pZa/bPt86hx7knkrn8IVMpqCGM4sh4/Mh2jD
	 QAvqsxhiVsQVRfDQA6IGJUltGjO9cODPXa2BHlCc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261118113112epcas5p165b10951a7c61e1233a0d7a04fe7de40~pIFQsdVpR0773307733epcas5p1r;
	Wed, 18 Nov 2026 11:31:12 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jTzv334Dgz6B9mD; Wed, 18 Nov
	2026 11:31:11 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261118103434epcas5p4ddef3806fafdb60f309fe882e354881c~pHT0IHpTs1275112751epcas5p4e;
	Wed, 18 Nov 2026 10:34:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261118103432epsmtip222a7237d25cab0527f14e37decda0c44~pHTycbO4V0208902089epsmtip20;
	Wed, 18 Nov 2026 10:34:32 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	jgg@ziepe.ca, leon@kernel.org, asml.silence@gmail.com
Cc: nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [RFC 0/4] nvme-rdma: dma-buf backed I/O
Date: Wed, 18 Nov 2026 16:03:23 +0530
Message-Id: <20261118103327.1788667-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261118103434epcas5p4ddef3806fafdb60f309fe882e354881c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261118103434epcas5p4ddef3806fafdb60f309fe882e354881c
References: <CGME20261118103434epcas5p4ddef3806fafdb60f309fe882e354881c@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_033125_977570_7F63D0CC 
X-CRM114-Status: GOOD (  11.35  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This series adds dma-buf support for NVMe over Fabrics using RDMA.

Patch 1 moves the NVMe dma-buf I/O context handling from nvme-pci to
nvme-core.

Patch 2 lets transports create and provide the dma-buf attachment.

Patch 3 adds an RDMA helper for attaching a dma-buf to the device used
for DMA.

Patch 4 adds dma-buf backed I/O support to nvme-rdma.

The series has been lightly tested with the liburing rw-dmabuf test
over NVMe/RDMA using Mellanox ConnectX-3 Pro adapters.

Anuj Gupta (1):
  RDMA/core: Add ib_dma_buf_dynamic_attach()

Nitesh Shetty (3):
  nvme: move dma-buf I/O context handling to nvme-core
  nvme: let transports provide the dma-buf attachment
  nvme-rdma: support dma-buf backed requests

 drivers/infiniband/core/verbs.c              |  28 +++
 drivers/nvme/host/Makefile                   |   2 +-
 drivers/nvme/host/{pci-dmabuf.c => dmabuf.c} |  93 ++++++++--
 drivers/nvme/host/{pci-dmabuf.h => dmabuf.h} |  46 ++++-
 drivers/nvme/host/pci.c                      |  14 +-
 drivers/nvme/host/rdma.c                     | 182 ++++++++++++++++++-
 include/rdma/ib_verbs.h                      |   7 +
 7 files changed, 334 insertions(+), 38 deletions(-)
 rename drivers/nvme/host/{pci-dmabuf.c => dmabuf.c} (58%)
 rename drivers/nvme/host/{pci-dmabuf.h => dmabuf.h} (51%)

-- 
2.25.1


