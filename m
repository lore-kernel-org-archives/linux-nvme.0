Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3FCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVopx+9L8O9VZaEaojCYg+eMrmJMuQ9Ena4M5tajR0w=; b=Hu6TZmUPipQ33UItn5otX0APZm
	04ktSwi4QfoQ5/kUa/ivJDa7w67BSo+gEHtwWpzs2/v/trPxVqk8NcIizxYEzJyuLKsRRs2CCrilL
	2Y/aRwNF11LqhSUnqvwrUeDue91Uoy88I0FIrgx+37J9mAoMEf20pTas8kUMst6z8xhiP2AfAHzoC
	hWB6gTJvYTwQiEPIrIryeMIVYIO8M1WWltg54elL2xvE5aXpBiPzP316MJ/374yF+Ue3T6plMc8UB
	Z0sqZ/4aVvFrL0HPlmfXLi78Kf8Y1wEheA3okhKHCoXUOUSud1KztyfUxLV9iwSdZfio7td5U4XW5
	Ds0d0B9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKKEy-0078mK-F2; Wed, 16 Feb 2022 13:21:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKKEu-0078jO-Nx
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 13:21:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 342FC68B05; Wed, 16 Feb 2022 14:20:56 +0100 (CET)
Date: Wed, 16 Feb 2022 14:20:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
Message-ID: <20220216132056.GA15649@lst.de>
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com> <20220216081148.GA10851@lst.de>
 <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
 <20220216125731.6juezl4kshv7ovbp@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216125731.6juezl4kshv7ovbp@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_052101_126419_713870F9 
X-CRM114-Status: GOOD (  20.61  )
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

On Wed, Feb 16, 2022 at 01:57:31PM +0100, Daniel Wagner wrote:
> > In nvme_update_zone_info, but nvme_configure_metadata is also possible.
> > Moved setting the flag before both these.
> 
> But the NS is not ready at this point. nvme_update_disk_info() needs run
> before the NS can be marked as ready. Commit message e7d65803e2bb
> ("nvme-multipath: revalidate paths during rescan") explains why.

Yeah.  So the only error return from nvme_configure_metadata is a can not
happen case which doesn't really need the error return.  So we only
need to check nvme_update_zone_info and can set the ns life for the
-ENODEV case there.  Something like the patch below:


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79005ea1a33e3..7814df10b5199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1723,7 +1723,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return 0;
 }
 
-static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
@@ -1739,7 +1739,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return 0;
+		return;
+
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
 		 * The NVMe over Fabrics specification only supports metadata as
@@ -1747,7 +1748,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return -EINVAL;
+			return;
 
 		ns->features |= NVME_NS_EXT_LBAS;
 
@@ -1774,8 +1775,6 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		else
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
-
-	return 0;
 }
 
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
@@ -1916,9 +1915,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns, id);
-	if (ret)
-		goto out_unfreeze;
+	nvme_configure_metadata(ns, id);
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 
@@ -1934,7 +1931,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (blk_queue_is_zoned(ns->queue)) {
 		ret = nvme_revalidate_zones(ns);
 		if (ret && !nvme_first_scan(ns->disk))
-			goto out;
+			return ret;
 	}
 
 	if (nvme_ns_head_multipath(ns->head)) {
@@ -1949,16 +1946,16 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return 0;
 
 out_unfreeze:
-	blk_mq_unfreeze_queue(ns->disk->queue);
-out:
 	/*
 	 * If probing fails due an unsupported feature, hide the block device,
 	 * but still allow other access.
 	 */
 	if (ret == -ENODEV) {
 		ns->disk->flags |= GENHD_FL_HIDDEN;
+		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
+	blk_mq_unfreeze_queue(ns->disk->queue);
 	return ret;
 }
 

