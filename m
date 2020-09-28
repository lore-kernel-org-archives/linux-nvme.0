Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC5AC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C172158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k4r9JhCv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDdXe/TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C172158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LTOE/dp/m134Ppfy+8i1dRTbMdWJ4Pc22VTgQLp48rE=; b=k4r9JhCvwabxMrP0CknS+Ak4w
	vn0YF8hb4E2tBiPpsrLH9tqSvg5eccFNS5IdFytvdcBXdm67OevfozIaa+4Ex2x/guIQLTNlUxvJN
	rgVzeTSmfYFBx4EQox3mPaIuCLPF/x8Svi7HhAqCNIg9nqREJ1QUfKpPe5mMn9/3n2tN4bF1SOYf3
	pTPcONHK4W1DyZl5v0PM3FBsGV/cmFAL1vGir5JpPFkgncGf8hXjCTqANT591BxJHrHxQaMPip7D8
	wnlJ0ny52yDIs0q8VVne59NeYRUsPPU1bTaPrW1Pmnd/YbkTL7uOnPgN0oauGwsxLCMxaHryLht8b
	RhImxwG1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNQ-0002TC-Fw; Mon, 28 Sep 2020 12:35:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNC-0002NI-28
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Ub89aoUiec2XQO5QMIQEH1gaN0ICtG74fpF35MCud/w=; b=VDdXe/TDrvp9XZxjv67e1/G1VD
 jIH3ZZpWDYCBp+7Ua8wO82azemZNeUBE4elUwa8iF3tKs7ytvMsXUP3+OgUBHw6R8E0xoCM0Y3w1P
 wqUMdxNI01g382Gp+GkpB4GVxNW+13BVtk9kDckPSe5BLL8MfUP+6FbG5gYW4R9HqH94zVfheIApv
 ppG9ZbqOR7XhoHqi402fRwK0puxuJ6PEXpPox2qci0r42XbzNu3IdP0PRueYJFkW0PYDdE1iP6Puo
 4ideHFTRnH2WZI717r5Ng+cQhqui9Kyz17HAxTcOlDFjggDAmfg0NxlQ8GdmQ3OVjJ3uiXQoVwmSx
 QM/D9mxA==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNA-0004k1-Db; Mon, 28 Sep 2020 12:35:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 09/20] nvme: factor out a nvme_configure_metadata helper
Date: Mon, 28 Sep 2020 14:34:51 +0200
Message-Id: <20200928123502.435373-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Factor out a helper from nvme_update_ns_info that configures the
per-namespaces metadata and PI settings.  Also make sure the helpers
clear the flags explicitly instead of all of ->features to allow for
potentially reusing ->features for future non-metadata flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 78 ++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4a5c4d45755b55..443aba9c9fdd11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1966,6 +1966,50 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return 0;
 }
 
+static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	/*
+	 * The PI implementation requires the metadata size to be equal to the
+	 * t10 pi tuple size.
+	 */
+	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	if (ns->ms == sizeof(struct t10_pi_tuple))
+		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	else
+		ns->pi_type = 0;
+
+	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+		return 0;
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		/*
+		 * The NVMe over Fabrics specification only supports metadata as
+		 * part of the extended data LBA.  We rely on HCA/HBA support to
+		 * remap the separate metadata buffer from the block layer.
+		 */
+		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
+			return -EINVAL;
+		if (ctrl->max_integrity_segments)
+			ns->features |=
+				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	} else {
+		/*
+		 * For PCIe controllers, we can't easily remap the separate
+		 * metadata buffer from the block layer and thus require a
+		 * separate metadata buffer for block layer metadata/PI support.
+		 * We allow extended LBAs for the passthrough interface, though.
+		 */
+		if (id->flbas & NVME_NS_FLBAS_META_EXT)
+			ns->features |= NVME_NS_EXT_LBAS;
+		else
+			ns->features |= NVME_NS_METADATA_SUPPORTED;
+	}
+
+	return 0;
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
@@ -2115,37 +2159,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		return -ENODEV;
 	}
 
-	ns->features = 0;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	/* the PI implementation requires metadata equal t10 pi tuple size */
-	if (ns->ms == sizeof(struct t10_pi_tuple))
-		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
-		ns->pi_type = 0;
-
-	if (ns->ms) {
-		/*
-		 * For PCIe only the separate metadata pointer is supported,
-		 * as the block layer supplies metadata in a separate bio_vec
-		 * chain. For Fabrics, only metadata as part of extended data
-		 * LBA is supported on the wire per the Fabrics specification,
-		 * but the HBA/HCA will do the remapping from the separate
-		 * metadata buffers for us.
-		 */
-		if (id->flbas & NVME_NS_FLBAS_META_EXT) {
-			ns->features |= NVME_NS_EXT_LBAS;
-			if ((ctrl->ops->flags & NVME_F_FABRICS) &&
-			    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) &&
-			    ctrl->max_integrity_segments)
-				ns->features |= NVME_NS_METADATA_SUPPORTED;
-		} else {
-			if (WARN_ON_ONCE(ctrl->ops->flags & NVME_F_FABRICS))
-				return -EINVAL;
-			if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
-				ns->features |= NVME_NS_METADATA_SUPPORTED;
-		}
-	}
-
+	ret = nvme_configure_metadata(ns, id);
+	if (ret)
+		return ret;
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
