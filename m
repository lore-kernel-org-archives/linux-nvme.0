Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA2EC07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaigyb9FXrMSSdei/I/NavoMuzjJn0TOXq6wT5pppgU=; b=eayQUL5QGp7IGGEMKILc/6EZqz
	BjP9LzzI9RBHvXwAfvKmb6q3cr2XchK1eDFjPL1Np9lz5HU2hdzrUij1QCyWkb82l03QzyBZqOWZp
	C0O+9atJGiv5xvEjmVympabHxcSRCtvsUg/XUPALR4v++2dDaUsgGoXErizVZuCrocr4p4++8KaLi
	UjiQV3YFLA9Quye7bFB4rzchYROHdM3OF8l6sTZcmfkMGL6MgK+CP64RdbSx/OClTgn2kx9btkCeE
	BvY+dg9Lz5A6mybcGvPNWrzXGRQWRbVQ8CdZsUtApB2QON2NX7bahZe7EvV9n0rgBvMFd2guuzchI
	f6KuCz+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfh-008x61-39;
	Tue, 24 Oct 2023 06:13:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfd-008x4a-1t
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:13:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id DFE1621869;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1DC082D106;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4853551EC3D9; Tue, 24 Oct 2023 08:13:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme-loop: always quiesce and cancel commands before destroying admin q
Date: Tue, 24 Oct 2023 08:13:36 +0200
Message-Id: <20231024061337.35621-3-hare@suse.de>
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
	 BAYES_HAM(-0.00)[29.89%]
X-Rspamd-Queue-Id: DFE1621869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_231341_797230_FFB8F6A9 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

Once ->init_ctrl_finish() is called there may be commands outstanding,
so we should quiesce the admin queue and cancel all commands prior
to call nvme_loop_destroy_admin_queue().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 48d5df054cd0..9cb434c58075 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -466,6 +466,8 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 out_destroy_io:
 	nvme_loop_destroy_io_queues(ctrl);
 out_destroy_admin:
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
@@ -600,6 +602,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
-- 
2.35.3


