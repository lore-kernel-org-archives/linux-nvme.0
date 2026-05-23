Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE8DCD4F54
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRayta8UwcV8dzi6cswzoiVqf0L06wQLACt1viHd5Kw=; b=us+6UzFRWdySJ1zVUIQUEecLLD
	TcU7B+olgoGRa34sPAjXrqPBIqy0PJnE1lnSG3+wLRrDnUWTpBxmfw++/mhJ4qLkHZH6jSGwn42gq
	dNOgU/qOLpy3YYVS2+S0Bg7C59JCH41AHWpo/Mqger4StfSVsufHWWqZ6oxJjMqK5Gh2OvmKiDlLE
	IjP6IsgwEZ/188QWZrfgI9OiolBVA8GVifxkihUe/GtkfojCzGVp9602bUckXm3m6+C6WWorEAhYj
	x6fcaxNji4sTt66hnrm5zyZZb5HKOiSiaLqCopWcAVRY3gcd7+Uhk7ZGEovQJQYeFS3KbTzbKjfkm
	6Rtz+0ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQhiZ-0000000CwS0-2qV3;
	Sat, 23 May 2026 08:28:23 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQhiW-0000000CwRQ-22yO
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 08:28:21 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 13451240029
	for <linux-nvme@lists.infradead.org>; Sat, 23 May 2026 10:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1779524897; bh=nRayta8UwcV8dzi6cswzoiVqf0L06wQLACt1viHd5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=DZeQIvgbYY/BLX5SMZZbdnyhFUHzguX8ZT+Bb0Dxy+zZq60ppxX+GH7NJVJHDuLHN
	 7JhIribjruTJJQbjaIRUYeTSCACxgdWcEinCUsjhEs/PA+ILepTpd/KhE0570nmYkR
	 eg6RswFqAFUoUPqxvByQgQTcI9RRp4lngZ77Z2pt8mcXI9AWv6Jtx/oUn55ll4Kqx8
	 sOSqvC53b8bpMSxCqo/b+Gh0AE4y95cTyMf+iodBQjhE/qkX1pLUuU/+abr9hq4JeV
	 SjXXd9epng1PlcWUYrpPhDBQErcAysMMM4KitpRhmsnvLMt2jrPSftnCW0YWTFncpu
	 bU2kZvtgaprKA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gMwJb5fXVz9rxG;
	Sat, 23 May 2026 10:28:15 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Sung-woo Kim <iam@sung-woo.kim>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools
Date: Sat, 23 May 2026 08:28:16 +0000
Message-ID: <20260523082751.20453-1-mateusz.nowicki@posteo.net>
In-Reply-To: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
References: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_012820_667293_6C0DDAA7 
X-CRM114-Status: GOOD (  13.96  )
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

Reproduces on any NVMe controller probed by a CONFIG_NUMA=n kernel:

  BUG: unable to handle page fault for address: ffff889101603d38
  RIP: 0010:nvme_init_hctx_common+0x5a/0x190 [nvme]
  Call Trace:
   nvme_init_hctx+0x10/0x20 [nvme]
   nvme_alloc_ns+0x9e/0xa10 [nvme_core]
   nvme_scan_ns+0x301/0x3b0 [nvme_core]
   nvme_scan_ns_async+0x23/0x30 [nvme_core]

Switch the parameter to int and fall back to node 0 when it is
NUMA_NO_NODE; node 0 is always present.

Fixes: d977506f8863 ("nvme-pci: make PRP list DMA pools per-NUMA-node")
Reported-by: Sung-woo Kim <iam@sung-woo.kim>
Link: https://lore.kernel.org/r/20260309062840.2937858-2-iam@sung-woo.kim
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
v2:
 - drop the (numa_node >= nr_node_ids) check: cpu_to_node() never returns
   that in practice, so NUMA_NO_NODE is the only out-of-range value worth
   guarding against. (Caleb Sander)
 - test against NUMA_NO_NODE explicitly instead of (numa_node < 0)
 - add Fixes: tag, Reported-by/Link to Sung-woo Kim's earlier report.

 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..9815823c974e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -587,11 +587,16 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 }
 
 static struct nvme_descriptor_pools *
-nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
+nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
 {
-	struct nvme_descriptor_pools *pools = &dev->descriptor_pools[numa_node];
+	struct nvme_descriptor_pools *pools;
 	size_t small_align = NVME_SMALL_POOL_SIZE;
 
+	if (numa_node == NUMA_NO_NODE)
+		numa_node = 0;
+
+	pools = &dev->descriptor_pools[numa_node];
+
 	if (pools->small)
 		return pools; /* already initialized */
 
-- 
2.53.0


