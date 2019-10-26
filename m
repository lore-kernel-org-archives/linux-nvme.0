Return-Path: <SRS0=T5EX=YT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD2CCA9EB9
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F36222C3
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Oct 2019 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5agWvvl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXGNnhC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F36222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MnzQysZhKAmWbj6RVUKj9K4ojWYR4lXDJCk1VyHhm4M=; b=P5agWvvlF0etnJ
	oMqL2ZC3+CpK8AhAudSrQ3tGd2m4J0Ms1sX65UJy+xtMpX8UFwFpv7dHkrysRdif5qLxF2gFit+WS
	66J3abVyVYCSmzMfDauBjvq8WgucthFMiG/xRq6zSSPytMbqK2m/1/Yj/TfJX1u1DxydcWIsdBojy
	SDMOnXAv6+ZM3A1KVx/5+Sxvwi3kiHKo52dVXoikpu1u8OHHWfAV8EJnBlIwQ47xr4JU3Y7X80tJB
	gwLgARPynMDL48WRBv6h2c6h9OLqvqtq4lpJ/sqlRgV29gH/d/JCDNpkXxtyQ72a7VWD/1mmtVPPp
	PtBCvfIQwJDLmCKZkJAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOLxA-0007GW-8G; Sat, 26 Oct 2019 13:18:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOLx7-0007E3-0p
 for linux-nvme@lists.infradead.org; Sat, 26 Oct 2019 13:17:58 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBE03214DA;
 Sat, 26 Oct 2019 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572095876;
 bh=ipbw6dH6lL0Urna0nXEc+8jJiysud2Vy0AV+ljGCwr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gXGNnhC+lXVBtQWWfl8FvI/+pWQoSbMbPxXf28REOJ4SYZoGyz0rkOQNUlhiWXygl
 aOKcvYat45j8+yDHv8MB4FFskUBnsB4mlXKdMKUfUgZ1BFhH/ie9KHINjYRlJdAjtR
 z684yQ5thiJodFHDO6NoX0gb9GaQApeP8JIXAxVo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 65/99] nvme-pci: Free tagset if no IO queues
Date: Sat, 26 Oct 2019 09:15:26 -0400
Message-Id: <20191026131600.2507-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191026_061757_085983_C2DE6595 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Edmund Nadolski <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 770597ecb2075390c01c425b8b1f551347f1bd70 ]

If a controller becomes degraded after a reset, we will not be able to
perform any IO. We currently teardown previously created request
queues and namespaces, but we had kept the unusable tagset. Free
it after all queues using it have been released.

Tested-by: Edmund Nadolski <edmund.nadolski@intel.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48a71909763be..f94cc01e85a66 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2438,14 +2438,20 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static void nvme_free_tagset(struct nvme_dev *dev)
+{
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	dev->ctrl.tagset = NULL;
+}
+
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	nvme_dbbuf_dma_free(dev);
 	put_device(dev->dev);
-	if (dev->tagset.tags)
-		blk_mq_free_tag_set(&dev->tagset);
+	nvme_free_tagset(dev);
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
@@ -2564,6 +2570,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
