Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24D0CD5BB3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sg08rMUqXdrdIcoEudWa6vs3/YkB0tjUu7NFlKjrICE=; b=IjK3fK3gBl0vEchQMIYc3OMQx5
	i855V19wOhekX0MBNt3UHadRfuetPTRsyt6oJSoKN0uK4DpvLrnWMZyiaOow7Q9Zfgn7HFV3/rOia
	PI04cq2BB45o4EfJSL+h/t5WqHyRMCGD/jcf8KlHbO7Us0dVKhu1p/dq5LmCCxEb9L1SQ5VuMJbCk
	eqSjbqNecxZQ6CZqpAtgllQlrfG1zBGGc7L6kvvYtcL4vjMjZmh1tyYsNDoUCSE3+k+pQJEqW/mWi
	CFsDkSKVH7dUPTW6Xy05N5RDgTzcy7/ZOo2FMb4qu6fIfUI0Az91G4gupebXQHyP6CiYqXP2wLNV+
	yRff8eFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRSe-0000000BD1g-3w9Q;
	Fri, 22 May 2026 15:06:52 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRSc-0000000BD0h-3Eei
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:06:52 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8542C240104
	for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 17:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1779462402; bh=sg08rMUqXdrdIcoEudWa6vs3/YkB0tjUu7NFlKjrICE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=VTWyZG569nM+kfJnRKZB3aRej2s/iUmsxP+1xB4QEYKuFo58hwhFsShML0Gdovgkn
	 8CMe0oxoFFjnLCU0InT5+Nxz/abhKvS194DviIPDa8ug92fNU9RDelqQy8doX412l/
	 b0uDA4py2ScGh+KhY8PKrMSeLlBFtKEAhoZyfflhKh+pibhUCt5MN5ZxE1GeMgbPXP
	 KFl5JKu2rrk4mfa7aZsdmDs90elDkHvkSvROzQSKYkx+hvBKYKu4tnEoLTt9nNVnKJ
	 IzJmA1NZk/mpKgD5lKCk4RJV/rid/ftTU5xZ/ASiNmj4E5bHZe9ks6yGw7t9Qr/znC
	 cCL8XBLq49z8w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gMTBn0vFXz9rxL;
	Fri, 22 May 2026 17:06:40 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools
Date: Fri, 22 May 2026 15:06:42 +0000
Message-ID: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_080650_952893_167F956D 
X-CRM114-Status: GOOD (  13.47  )
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

nvme_setup_descriptor_pools() indexes dev->descriptor_pools[] using the
numa_node forwarded from hctx->numa_node by its single caller,
nvme_init_hctx_common().  On a non-NUMA kernel hctx->numa_node is
NUMA_NO_NODE (-1).  Because the parameter was declared 'unsigned', the
value becomes UINT_MAX and the index walks off the array (sized to
nr_node_ids), faulting during nvme_alloc_ns() and leaving the namespace
without a /dev node.

Reproduces on any NVMe controller probed by a CONFIG_NUMA=n kernel

  BUG: unable to handle page fault for address: ffff889101603d38
  RIP: 0010:nvme_init_hctx_common+0x5a/0x190 [nvme]
  Call Trace:
   nvme_init_hctx+0x10/0x20 [nvme]
   nvme_alloc_ns+0x9e/0xa10 [nvme_core]
   nvme_scan_ns+0x301/0x3b0 [nvme_core]
   nvme_scan_ns_async+0x23/0x30 [nvme_core]

Switch the parameter to int and fall back to node 0 for negative or
out-of-range values; node 0 is always present.

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 drivers/nvme/host/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..ecec0f9cff98 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -587,11 +587,17 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 }
 
 static struct nvme_descriptor_pools *
-nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
+nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
 {
-	struct nvme_descriptor_pools *pools = &dev->descriptor_pools[numa_node];
+	struct nvme_descriptor_pools *pools;
 	size_t small_align = NVME_SMALL_POOL_SIZE;
 
+	/* hctx->numa_node may be NUMA_NO_NODE; fall back to node 0. */
+	if (numa_node < 0 || numa_node >= nr_node_ids)
+		numa_node = 0;
+
+	pools = &dev->descriptor_pools[numa_node];
+
 	if (pools->small)
 		return pools; /* already initialized */
 
-- 
2.53.0


