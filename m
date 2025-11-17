Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90689CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uSvINqnoBtDLpt1DLsxx9vsrn2Vn2WmcBhTHeRrOKiQ=; b=pu6Q9KM7gj0CCaxU7Fy/4FpjPi
	Cq11UKXByC/yH9Ny1aShEkKEFhfpgZMkUOL5KocZpno+VYyyVFXYx86Y3b1je2YBuwgOGKS14JbJo
	j6qshbxuh3q3zYbhZaqyiVtsaP97/wV1oFjNZvkr+pNp35zkspN0/4DZPPCHIDOzE1mbfON0jLKw+
	xlJm62fR9MJuXRKnBzGFvBeZ647bELMPmXiyZN0tNufNZR2bw0dpv3REaPI8PIeMxluvBCghlYMjk
	n2Foa9/TzBv8pCkRk1I10yJD+dDZXq6ee6Iwbii276oJwXPl8g3xKWP1kGXVCDi+O0YRy8T+uRK37
	lq+wSNmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4oT-0000000Gk9U-0MPV;
	Mon, 17 Nov 2025 19:22:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4oR-0000000Gk9K-2fxX
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 19:22:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73EDA605CB;
	Mon, 17 Nov 2025 19:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637F1C2BCB2;
	Mon, 17 Nov 2025 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407374;
	bh=3ySbpAQyseH1RhiKvjgsi6fsV/pq2ZWK5we3mb8diHw=;
	h=From:To:Cc:Subject:Date:From;
	b=rVgaTdlhtHnMZSq5T5rdweysNMZHC8x98jK9Qp5CaK+I14LJdDbv5aLczqEytYmux
	 criGijr65saOewT7Zf/6+zFyVFONsFBCKp2uvDJUe74YyGnpWfMKqD0Fhze2jG/0s0
	 RFHQhoS0vrlsKAH57stZ+Vl1HWqCQPr5vPFN4kk/bTdcknStRaNX+vhkoDrpNFtiTZ
	 AZ9t6zT7BMibCxhG28wCqaPc+fp1UtHtA4PIWeefHhQy/15NNbhEGZY04qSYpt9oqe
	 fqw1/InvELLjOYHjfxOk8RgR0VZfnh0KRJ8WPvdniEoGSuXEKKAq2+dVuFZ5Fvxwiw
	 ti8Rs7/QKnl6Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 0/2] block: Generalize physical entry definition
Date: Mon, 17 Nov 2025 21:22:42 +0200
Message-ID: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251030-nvme-phys-types-988893249454
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit
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

Changelog:
v2:
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


