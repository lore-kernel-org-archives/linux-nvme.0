Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03612C00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hJ0oXfYzFGZPwV7+d4AWWANgQrF2fBvSQVEWuPskVE=; b=gotELkZJtixvp7wKQOYDZI2U+0
	KOshZgTehHliDcnlsTqbBIgg+t5kzOcU46E0yJ7Hj+HJoC0eaTX+5uCDxSA9eiwXdH8qpe4jlyWUK
	T0XooGOLSI7X4/ydfUrBKrXpLOUp2YgOHCtXsuSDa6rPDMkMKDRdSy++kLFqVOVrVZpdBbW4AFdzb
	fGSLflx45++elERtTc8WQ1JbNJ+GlUQVks7ow+Cw1jI8dV4lRju30Wl1CxnWcyUaqnv1EKlb2MVxU
	o79yA9UwH/KDmhwi4pgIhPx3zkPoM4YO6ppHjEe7Xah2IY+Ck0f0Rlm5ftjRwkMnSDwxClaATt7Q+
	n9eQMPpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfh-008x5T-02;
	Tue, 24 Oct 2023 06:13:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfd-008x4c-1t
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:13:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id DFE9121B7D;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 247CF2D107;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 503D751EC3DB; Tue, 24 Oct 2023 08:13:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Date: Tue, 24 Oct 2023 08:13:37 +0200
Message-Id: <20231024061337.35621-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231024061337.35621-1-hare@suse.de>
References: <20231024061337.35621-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
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
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.00)[11.07%]
X-Rspamd-Queue-Id: DFE9121B7D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_231341_797354_1EC0DFEB 
X-CRM114-Status: GOOD (  10.93  )
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

Setting up I/O queues might take quite some time on larger and/or
busy setups, so KATO might expire before all I/O queues could be
set up.
Fix this by start keep alive from the ->init_ctrl_finish() callback,
and stopping it when calling nvme_cancel_admin_tagset().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/fc.c   | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa..f48b4f735d2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
 
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(ctrl);
 	if (ctrl->admin_tagset) {
 		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
 				nvme_cancel_request, ctrl);
@@ -3200,6 +3201,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
 	ctrl->identified = true;
 
+	nvme_start_keep_alive(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl_finish);
@@ -4333,7 +4336,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
-	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
@@ -4344,8 +4346,6 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_start_keep_alive(ctrl);
-
 	nvme_enable_aen(ctrl);
 
 	/*
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..a9affc8b755b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2530,6 +2530,12 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * clean up the admin queue. Same thing as above.
 	 */
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
+
+	/*
+	 * Open-coding nvme_cancel_admin_tagset() as fc
+	 * is not using nvme_cancel_request().
+	 */
+	nvme_stop_keep_alive(ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
-- 
2.35.3


