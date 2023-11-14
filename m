Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D02C4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Nov 2023 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Mu51fWo96bfPNeQciKYnJqyWobwPHSohQRpv5vAfy7o=; b=lRgQckdEiVyRcmv1vzgd1SIDBS
	UV7VpaRqH2MsfhNv/5vmJwP8bBnCQp20ZByQ079YChDJRjmGoRc+EAsGiyj7hpb4p25EI72SuhGp5
	RZahaxVFEqEpR5tMzoO2dzkScSRaNBNOlcskg5US5BiIw5Bq1c/D1Qqzzajm4UEMXsR8pIIu37j/M
	c8gv2zReWj29WSLAk7vcMgVZBFwduwj+faB3kWg8kHG4rTfsHGAO4Fsg3+Ydb7uM7DFBnPz8eh+5l
	jRN71v2f0OVqIqkRjdOXnDvis1oUElNFDV2vVD4dYACsSv/htVU6XDka52rwoTQyUDKrt80Ynn7FR
	DSkullnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tRc-00G20w-22;
	Tue, 14 Nov 2023 13:27:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2tRa-00G1zO-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 14 Nov 2023 13:27:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id B975B1F88C;
	Tue, 14 Nov 2023 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699968422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mu51fWo96bfPNeQciKYnJqyWobwPHSohQRpv5vAfy7o=;
	b=1RLPATkctOSmhvul4+NqPfsy6XVWs7wOwKIctO8KrVurb7ml4gfE53CJLwL9X9MiHmcA3Y
	7ZsLI39Gzhbag91lsZ1+1EbkjRYsHB+NhrUlxDwIvY9sPpmBq4xUoJoF9+NVXClmsqZp7D
	KpAAG15CoiH/2h1NUbcA01VwJCY4Kek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699968422;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mu51fWo96bfPNeQciKYnJqyWobwPHSohQRpv5vAfy7o=;
	b=Gx7B6ufChTP2iFE36V0turCkg+O6L05T7un2tlr5k7oRUzl+4UGYTKxgsieThQd5w82HSN
	Btq/fMsUtvI7fFBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 9F95E2C3F6;
	Tue, 14 Nov 2023 13:27:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AB0C351ED1CF; Tue, 14 Nov 2023 14:27:02 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: catch errors from nvme_configure_metadata()
Date: Tue, 14 Nov 2023 14:27:01 +0100
Message-Id: <20231114132701.49048-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.89 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-2.60)[98.22%]
X-Rspamd-Queue-Id: B975B1F88C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_052706_357383_6CB71B23 
X-CRM114-Status: GOOD (  12.99  )
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

nvme_configure_metadata() is issuing I/O, so we might incur an I/O
error which will cause the connection to be reset.
But in that case any further probing will race with reset and
cause UAF errors.
So return a status from nvme_configure_metadata() and abort
probing if there was an I/O error.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..fd28e6b6574c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1814,16 +1814,18 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
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
@@ -1832,7 +1834,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return;
+			return 0;
 
 		ns->features |= NVME_NS_EXT_LBAS;
 
@@ -1859,6 +1861,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		else
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
+	return 0;
 }
 
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
@@ -2032,7 +2035,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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
2.35.3


