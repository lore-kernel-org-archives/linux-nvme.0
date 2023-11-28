Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FBC07CA9
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCLGsdK08V2JSkB++Kk5WqTtal6TleYOsqquF177v7I=; b=E0FFgVF6OP7EkjW8rLKq9+kKvd
	7N4g8eoUO8H70s/DdURfvZf7WsVDk5a5nt7AVIJJH/o4f9aSeXGJxleIDTar6jV4u6zw/jiQp6qpw
	ig9fYpUopnPcKknqsaOW1AnEQiIk2d3uKWqnciLqT/w3nNOXGk7uqMofy8VyDuF4N1fkydB+4EH9x
	ZZF/OBIKrqF7h3jQ3+PYwEwFmnpqcwKTylu1MbLfb/WesU7SgxLFzS64Ow8Dgiu9FRRwtIwOTkQpV
	HFyYpKLXoETs+TaPsglJARv8iWE60pWRyXA6PDbiatDgIQlPKi4ndd5SkAi+Hx/spMyog278mf+wP
	zcOQHmEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r85I9-006LIX-1q;
	Tue, 28 Nov 2023 21:06:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r85I5-006LFa-1u
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 21:06:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 122DC61931;
	Tue, 28 Nov 2023 21:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D64C433CB;
	Tue, 28 Nov 2023 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205604;
	bh=K2JVbDHeoqX+MlOIFHC1DfxUy2I0OtEKxFLemGaGLwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scYo0i5qZ9sgH8BnNo+91WVZzGkO39iRiLsp5Lx2zZsJDqPloH7NWQp3gK60zjOyn
	 pT8dNEprWLAnVChnZ5DUst2MK4w8nmgbNCLGJAXFXVkYZeoJGAK4uonHdFASTGXUXb
	 LG20CQ4Zvt8l1lpMK7Ag80sgD1b/KkTlonan6u9d183G7S+KkxM0z3TFktz1slINQJ
	 xsFxZ6HZVxLUJc12ForFiXHInutG4tRKyzjiZSeHRiEtE6AG9X1Z7dIjINAv6Ty1a8
	 Mua1MfBzHAyv4m5XVw2dEflFjfpWX8vUd9n97ZiVQXxoPuUOEpSn+Lmfh0fcqj9afs
	 kFuWHv7VPQOow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 16/40] nvme: catch errors from nvme_configure_metadata()
Date: Tue, 28 Nov 2023 16:05:22 -0500
Message-ID: <20231128210615.875085-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_130645_707666_7C629F50 
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit cd9aed606088d36a7ffff3e808db4e76b1854285 ]

nvme_configure_metadata() is issuing I/O, so we might incur an I/O
error which will cause the connection to be reset.
But in that case any further probing will race with reset and
cause UAF errors.
So return a status from nvme_configure_metadata() and abort
probing if there was an I/O error.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21783aa2ee8e1..5e314a8fb9407 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1813,16 +1813,18 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return ret;
 }
 
-static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
 
-	if (nvme_init_ms(ns, id))
-		return;
+	ret = nvme_init_ms(ns, id);
+	if (ret)
+		return ret;
 
 	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return;
+		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
@@ -1831,7 +1833,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return;
+			return 0;
 
 		ns->features |= NVME_NS_EXT_LBAS;
 
@@ -1858,6 +1860,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		else
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
+	return 0;
 }
 
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
@@ -2031,7 +2034,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	nvme_configure_metadata(ns, id);
+	ret = nvme_configure_metadata(ns, id);
+	if (ret < 0) {
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		goto out;
+	}
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 
-- 
2.42.0


