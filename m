Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB83C11D0C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 20:38:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60DF206EF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 20:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="moIIXnwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60DF206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wrvmRV3nhcq5wREXk/0Q7YAuf7DfE6lQU/rJdqjsTyI=; b=moIIXnwefYNwRy
	wb2GKN/XutrtYsgnMFOTfrt/QXodLXFGBonFhaKycmCUUNq6woYpjAQnBRZxfPD4FfH3XJPt2d4WJ
	P0Zvhw5CW3ufJOYn2qa3jENtKxsP55cNl94DOMDt1NmEE4qzWnfFal9j+wJRFYed4O0slGb0qZAn9
	Belyhnl9V2XOU22r1mcbGyHhCwdIZneKyLP1MJv7TZalEO0h6NG9G+lSKxymmiarW2ZkIcEdJ7bgl
	DJ17JoEzDxR5cIbcSuv2YrGDdueML2zad6ZZxlxjOne02JiNE51rVhsMI+VMmFcXtxXXatVzUdMrz
	VP2XVKlK9tTL8cKvDrow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4saI-0001iv-JK; Thu, 20 Feb 2020 20:38:10 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4sZD-0000dx-Pi
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 20:37:07 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1j4sZ8-0005cT-DD; Thu, 20 Feb 2020 13:37:02 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1j4sZ8-0006yM-7d; Thu, 20 Feb 2020 13:36:58 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Thu, 20 Feb 2020 13:36:49 -0700
Message-Id: <20200220203652.26734-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220203652.26734-1-logang@deltatee.com>
References: <20200220203652.26734-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com,
 Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 6/9] nvme: Export existing nvme core functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_123703_846304_6ABB4D9D 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Export nvme_put_ns(), nvme_command_effects(), nvme_execute_passthru_rq()
and nvme_find_get_ns() for use in the nvmet passthru code.

The exports are conditional on CONFIG_NVME_TARGET_PASSTHRU.

Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 14 +++++++++-----
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 756f8ee201d9..ea6285da7dbd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -465,7 +465,7 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
@@ -898,8 +898,8 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				u8 opcode)
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode)
 {
 	u32 effects = 0;
 
@@ -984,7 +984,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_queue_scan(ctrl);
 }
 
-static void nvme_execute_passthru_rq(struct request *rq)
+void nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
@@ -3449,7 +3449,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -4233,6 +4233,10 @@ EXPORT_SYMBOL_GPL(nvme_sync_queues);
  * use by the nvmet-passthru and should not be used for
  * other things.
  */
+EXPORT_SYMBOL_GPL(nvme_put_ns);
+EXPORT_SYMBOL_GPL(nvme_command_effects);
+EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq);
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 196a0d38e19c..5e96c30b8291 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -693,6 +693,11 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
  * use by the nvmet-passthru and should not be used for
  * other things.
  */
+void nvme_put_ns(struct nvme_ns *ns);
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode);
+void nvme_execute_passthru_rq(struct request *rq);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned int nsid);
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
