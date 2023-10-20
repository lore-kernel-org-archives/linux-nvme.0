Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BEC07480
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wsXzd67JzTmoSq/T9Ijtn3SUPXHL/EhV/xwzZUmo9w=; b=sZ7odb+f6axyStLOh24MtdpKDU
	SUraQmEJaGh2p5asgyiyuGKX4srRYoYdFyvXC4YXUY8mYH96wOtmHy0uVxvR5Efpszp61m4txrx+f
	2L77gNbXyFOlOqHwUGrbnzvbdzfzeLtBJ48evLOjiitBc3veoDR+40CfbPQjWKm08hLjDcpASmaAw
	cFoIHbKz56FaAk4RpOpfpH7j5A/SBwAk2TkSdjs+qLbA4nruFDHx0X7Nv4PS+XUn8TiPTV7LcNMI/
	AFvbXsFq3b/KbT95xI3OSX80V5oA6EghZeFvD3oN1bnu1AIvRkn7auijgyVcV9Ziw0XEGIzCN/JMQ
	vcIs62Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqS5-002UOh-2T;
	Fri, 20 Oct 2023 14:26:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRw-002UKf-1b
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:26:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 5659421A2A;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1D3872C8A3;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4581151EC18F; Fri, 20 Oct 2023 16:26:02 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] nvme-fc: add missing quiesce in nvme_fc_create_association()
Date: Fri, 20 Oct 2023 16:25:57 +0200
Message-Id: <20231020142600.47246-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231020142600.47246-1-hare@suse.de>
References: <20231020142600.47246-1-hare@suse.de>
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
	 BAYES_HAM(-0.00)[31.56%]
X-Rspamd-Queue-Id: 5659421A2A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072604_689898_72A85604 
X-CRM114-Status: GOOD (  10.24  )
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

nvme_fc_create_association() is calling nvme_unquiesce_admin_queue(),
but does not quiesce the queue upon failure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..17b6c9238d68 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3135,7 +3135,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
 		ret = -EIO;
 	if (ret)
-		goto out_disconnect_admin_queue;
+		goto out_quiesce_admin_queue;
 
 	/* sanity checks */
 
@@ -3144,7 +3144,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
 				ctrl->ctrl.icdoff);
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto out_disconnect_admin_queue;
+		goto out_quiesce_admin_queue;
 	}
 
 	/* FC-NVME supports normal SGL Data Block Descriptors */
@@ -3152,7 +3152,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		goto out_disconnect_admin_queue;
+		goto out_quiesce_admin_queue;
 	}
 
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
@@ -3199,6 +3199,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 out_term_aen_ops:
 	nvme_fc_term_aen_ops(ctrl);
+out_quiesce_admin_queue:
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 out_disconnect_admin_queue:
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
-- 
2.35.3


