Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB05D65522
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JzGgH8iE06I0ygPRnDR8AoeR/WkkY6sMVT7RCx8JrrA=; b=TzpRle+7Pci9ytnEWKnTZNwZoC
	XVz4dL+tjvfVQGEF/ctuWQ00Z2m+u3UqGYC6vYFLEcT7lAfX1VlZSK67O9lL9g+Xmu8LuTLtPz79e
	4h5midip4CHb5qTGDF9wep43hX3MHR4h4hFUoUwI/kWYcu/ehUva5b5hqt2vQ9b/Tsiq/IeC0yL8T
	z4hFk/A13OWHMw09af3adkqbRwRAfKenT9dDpahX5yXzILPWvA4JpK05NAEedlAOz4wxPOeFZ7NiK
	Uv7UDeNikk2dZ0MbygKaiFSLmG1qiJT88lc0uwmmXkyj0UZXLT1wGvANcAi5/E+JeDBHnfFhujVcZ
	Ho9SMJ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2M-00000006SLb-17h3;
	Wed, 17 Dec 2025 09:41:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2K-00000006SLE-2Apx
	for linux-nvme@lists.infradead.org;
	Wed, 17 Dec 2025 09:41:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F7C344047;
	Wed, 17 Dec 2025 09:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F098FC19421;
	Wed, 17 Dec 2025 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765964495;
	bh=M+QyWNDQCYDgysdq/2Xe+talz7B50t/KFj/EX0L7Nhc=;
	h=From:To:Cc:Subject:Date:From;
	b=N60MN1O3LP9MiL8GqhOOwgZbdaRovZ9/LTt/6jc1gVS4WRJ6n9/jP0Zugme6EpBhY
	 kFebNSVGojNIxXIgUK0EFzthiKRQg8/rSz6rGqZHZfvs+NctaNa+O7Uw3E3cwZT+ov
	 eWs5lAdhe4NNghoLl8Az5yB/yFXgxcZJom41OidjHPy2gDRKZvWCq124zG3i4DuWv1
	 +0PZkGs2FTGYocq2JxNi1U0z/EiIsDAyM8f2YBQq0kidiK+gARcsz0CwYq/M3xc84I
	 TLUMhKjIOVcbVsISHssayHhmQBktiyKraWs+6n/4eNB5F7sSXt9FJJREavKT4/Zw2T
	 sq9SAmMQG6cLQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 0/2] block: Generalize physical entry definition
Date: Wed, 17 Dec 2025 11:41:22 +0200
Message-ID: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251217-nvme-phys-types-5bf34e42b2df
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251217_014136_578002_009CE7CF 
X-CRM114-Status: GOOD (  12.05  )
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

Jens,

I would like to ask you to put these patches on some shared branch based
on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
and DMABUF code.

--------------------------------------------------------------------------------
Changelog:
v3:
 * Rebased on top v6.19-rc1
 * Added note that memory size is not changed despite change in the
   variable type.
v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
 * Added Chaitanya's Reviewed-by tags.
 * Removed explicit casting from size_t to unsigned int.
v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org

--------------------------------------------------------------------------------
The block layer code is declared "struct phys_vec" entry which describes
contiguous chunk of physical memory. That definition is useful for all
possible users of DMA physical address-based API.

This series changes NVMe code to support larger chunks of memory by changing
length field from u32 to be size_t, which will be u64 on 64-bits platforms,
and promotes "struct phys_vec" to general place.

This change doesn't change memory footprint because on 32-bits systems,
size_t will be u32 as before and on 64bits system previous uint32_t
variable was padded to be uint64_t anyway.

Thanks

---
Leon Romanovsky (2):
      nvme-pci: Use size_t for length fields to handle larger sizes
      types: move phys_vec definition to common header

 block/blk-mq-dma.c      | 11 +++++------
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/types.h   |  5 +++++
 3 files changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 5674abb82e2b74205a6a5cd1ffd79a3ba48a469d
change-id: 20251030-nvme-phys-types-988893249454

Best regards,
--
Leon Romanovsky <leonro@nvidia.com>

---
Leon Romanovsky (2):
      nvme-pci: Use size_t for length fields to handle larger sizes
      types: move phys_vec definition to common header

 block/blk-mq-dma.c      | 11 +++++------
 drivers/nvme/host/pci.c |  4 ++--
 include/linux/types.h   |  5 +++++
 3 files changed, 12 insertions(+), 8 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-nvme-phys-types-5bf34e42b2df

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


