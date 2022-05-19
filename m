Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE637C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MEf0YQ0y4ow8e54jZ8PV+UCsNTU4jzl8U+Ize2jaT8U=; b=hXaTxFoVbcVPWUj/SmRGNipBAJ
	jVTe5lLg93grs6q26XJUtgHlvZnk75BkfqyEdzWjUsCfy0PfPS9pJDVsWUHNOvFYMvvIfnerQf/wV
	aKNmhMLWpj21QOqeRI9og2Jzsek3V76McdXcjhRNpcRvfIV+/ZqD8wS3fhizueVcFGzcxXUgZAOTy
	jK8upSOfMYAIcP5p2wzKFlzo/792eolMTNgivsr+vl3SsQN6ESpOsK5DYN1oRsWPMcrtp9PJ3wPfs
	44pNo5zk7YvRRP5kB+5VLornPuAwhi/Li4db1ZTKqBBjTgTLyT2zOCYD1AHAxL5YxCfP54TqP+ENj
	WcaNwYdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrhtK-007qO5-9j; Thu, 19 May 2022 15:16:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhPo-007YW7-8J
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 14:46:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 56EA821A5B;
 Thu, 19 May 2022 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652971567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MEf0YQ0y4ow8e54jZ8PV+UCsNTU4jzl8U+Ize2jaT8U=;
 b=C3bb2GCbVo1qL9zOJif67llkxX150g+9d9bSTbSSXssSWEmdgstE0mIhPMHgvj06qvGhgn
 /awLeSzN7TYLiJAO4nnqROGeNSsIjwx/lMDY1AVmJGgV4dP3Iel5C2mtPll9uUsOhB9zsa
 vU0SV5rhSBR9l1TO5cyOXsuetfdkFHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652971567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MEf0YQ0y4ow8e54jZ8PV+UCsNTU4jzl8U+Ize2jaT8U=;
 b=96lVQVUH6Gqp5wpuRROphjzua0vGwRrWJce59soBdNfSpibarOJy74VpZ36aweiMpIVOAl
 kLJJ2iP2Ei2cMXAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 443862C141;
 Thu, 19 May 2022 14:46:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 35495519457A; Thu, 19 May 2022 16:46:07 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Muneendra <muneendra.kumar@broadcom.com>,
 James Smart <jsmart2021@gmail.com>
Subject: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if BLK_CGROUP_FC_APPID
 is not set
Date: Thu, 19 May 2022 16:45:55 +0200
Message-Id: <20220519144555.22197-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_074612_475513_DA0F2F8C 
X-CRM114-Status: GOOD (  12.54  )
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

If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
is undefined, so it needs to be masked out.

This patch is just a diff to the v2 patchset, as the original version has
already been merged.

Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")
Cc: Muneendra <muneendra.kumar@broadcom.com>
Cc: James Smart <jsmart2021@gmail.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a11c69e68118..3c778bb0c294 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+		return NULL;
+	return blkcg_get_fc_appid(rq->bio);
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
-- 
2.29.2


