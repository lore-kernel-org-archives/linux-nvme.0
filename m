Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FC0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=THq49pAzbCeyf9eg9GOqq+H04pZ1l4Hr7dpwEbPvgbg=; b=F+S/uToLCm2kkM20uj4cwBJQ98
	wMVBL4Au4DlFlaES6lXO7ZfdLYf9R+4ohn66qTwCEZFijyU9o7hnvBkVav7uUe9NynXXes4zi83C1
	mL5/DG6heJ6B/Rut+EC4UUT/9REnmeTCO7syxVF0q41KjWjfHBEM7p0eREp/dGKs3ZvP0Aw4Ru2+p
	GHAkrEGBi4WIEtYnnTvNtZ4ulUIUw48agV6no6d+sEcLKbagA1rJmxUANtfZguzln+uyv7gsI/m57
	lh/PpTV4FaH/SrZ7GsxE6dwCUPQmeRnRQQjzM1auz2+1Px1XBmDWtktg2xzWU7fZi7lXJJhbTFLJF
	0lSBzRtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKL2e-007JBA-UR; Wed, 16 Feb 2022 14:12:24 +0000
Received: from [2001:4bb8:184:543c:6e8c:bf25:364a:5dde] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKL2c-007JB0-Oz; Wed, 16 Feb 2022 14:12:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: dwagner@suse.de,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: don't return an error from nvme_configure_metadata
Date: Wed, 16 Feb 2022 15:12:19 +0100
Message-Id: <20220216141220.4162670-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

When a fabrics controller claims to support an invalidate metadata
configuration we already warn and disable metadata support.  No need to
also return an error during revalidation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79005ea1a33e3..cd6b1c5861f02 100644
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
 
-- 
2.30.2


