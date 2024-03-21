Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77676C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eYJQMmzLeCFQty3aFeNaVnl6KZBobJubZHncAwAF3IY=; b=xNJvP7yllsA7bfPkkhTNSR6llF
	q05ewgPKj+0lP8WyboERL7WmraRc7oxvZy1j9M2KppkwY1+iRUTO+IqpcDmlA/miAfLsivN6aSfdA
	B7e7vk1PDwXUnWDxmQPMdxDUcf22GLBy+Ax/K/ewUSIaYIrmeN60v2I9LwtD9/aYE3tcb7aH7oEId
	NbtB2xGT8KICQ54FhllNBXKwnpXtwnvywJps7zmABQz5z/cGegC/UU6VbEjwIcIV/OpKGxVFFi3zr
	fBIJNHTMj1B8PTc7HFJ9eK743qVQu+LCC9kQO9kW0xcWAmE2KSitmYqgOkNG87bOjje1ahyCD/QLY
	0JwNv0xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPeG-00000004dC4-1AHY;
	Thu, 21 Mar 2024 21:08:28 +0000
Received: from [119.234.4.46] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPeE-00000004dB0-36Ic;
	Thu, 21 Mar 2024 21:08:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-multipath: don't inherit LBA-related fields for the multipath node
Date: Fri, 22 Mar 2024 07:08:19 +1000
Message-Id: <20240321210819.1246749-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

Linux 6.9 made the nvme multipath nodes not properly pick up changes when
the LBA size goes smaller after an nvme format.  This is because we now
try to inherit the queue settings for the multipath node entirely from
the individual paths.  That is the right thing to do for I/O size
limitations, which make up most of the queue limits, but it is wrong for
changes to the namespace configuration, where we do want to pick up the
new format, which will eventually show up on all paths once they are
re-queried.

Fix this by not inheriting the block size and related fields and always
for updating them.

Fixes: 8f03cfa117e0 ("nvme: don't use nvme_update_disk_info for the multipath disk")
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00864a63447099..4bac54d4e0015b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2204,6 +2204,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	if (!ret && nvme_ns_head_multipath(ns->head)) {
+		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
 
 		blk_mq_freeze_queue(ns->head->disk->queue);
@@ -2215,7 +2216,26 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 
+		/*
+		 * queue_limits mixes values that are the hardware limitations
+		 * for bio splitting with what is the device configuration.
+		 *
+		 * For NVMe the device configuration can change after e.g. a
+		 * Format command, and we really want to pick up the new format
+		 * value here.  But we must still stack the queue limits to the
+		 * least common denominator for multipathing to split the bios
+		 * properly.
+		 *
+		 * To work around this, we explicitly set the device
+		 * configuration to those that we just queried, but only stack
+		 * the splitting limits in to make sure we still obey possibly
+		 * lower limitations of other controllers.
+		 */
 		lim = queue_limits_start_update(ns->head->disk->queue);
+		lim.logical_block_size = ns_lim->logical_block_size;
+		lim.physical_block_size = ns_lim->physical_block_size;
+		lim.io_min = ns_lim->io_min;
+		lim.io_opt = ns_lim->io_opt;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
-- 
2.39.2


