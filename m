Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09EAC54E68
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 02:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAWBFsJk1J8OX0oSrh67rMlS66oFHBxcTn5ZwY0IMX4=; b=NWCxTlHs4yO4Ajsv+alUbiCaHO
	CR6PUPcZOAy7yuaJ1ktWQc+exe4jNfnwZWgtsF72bnbK4VMb9jGnqTdR5z+n2P1svyxnuhD7LyUr6
	gg/t4JGkn7jrWk3jmO8unG4+Bu+204Q1Dn/6sgp4b+g+ufZkxmuCBcf/0afoNui0MaF2rKyLFetVB
	GsCCe+BwLPgs2ucwGBlmKyhTPvXkBIMGED4Je21FmVOR6ECMedfAMt7vuA4NYonEcUxuXi89YOl43
	MHqPJLGhFQ8bCnNjKZeMW2YVDaXV8O9UfrlYMF2lqDTpUbTfPYHKPqtyQpb3dei1ew0sykeSE3hsC
	mXNcnCRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlYP-0000000F2gL-0fjd;
	Wed, 20 Mar 2024 02:19:45 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlYN-0000000F2g2-0yqH;
	Wed, 20 Mar 2024 02:19:43 +0000
Date: Tue, 19 Mar 2024 19:19:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <ZfpHvyjT6kbQKrPF@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
 <Zfekbf0V5Dpsk_nf@infradead.org>
 <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
 <ZfjLyfptPVT7wa0_@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfjLyfptPVT7wa0_@infradead.org>
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

Can you try this patch instead?

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

