Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:37:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94FA61107
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E94FA61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bY9lNX4x16zJSzXYA0t0waheWh0mHaoWCe5MRjZYZjI=; b=xj8hFQi6MjGPCh
	CTxWvmx/VYtNVYqpVSdmZN1bI0PtvKgdqfcwhzhVC6sBnJav7nq15o/Yix/86ZQxJW/2TfqjH9sBR
	wloKviVsS0NrA/QMYHHWlR57/i9QoU7cgqSThPhdq5Y2nyJoJfH76eHPKnJzNj9eipmP1H4HlxzFC
	PZiULcSoeW0zNJhI6OG8wcEgjA8TZr0DVyPRdbhNmFjNkjtWToHlJldl0kjXUiKUrrhufV1dFpHWj
	M0cIPfRHzfgYzT5hHPCP5h6ssknZ+1BGVs9YSW9orgUsHWxX4z9hDDlNTEiFSfoXW2v8+jPHgbWqv
	/EiGXiiFmGQYQwAf2iow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvsJ-00767V-7G; Wed, 22 Sep 2021 06:36:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075b4-TN
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5961F22263;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceGiZe6nSUnBp/1PIX31yQZeZcGOCa4BBhCfj5RsBd8=;
 b=GgkFEr4d8eGVdLeO7eL5CfDPvc8AVkrXg036OCJne4aZhtD+NLwVu93Hw5bwEic3kw37MY
 mXHUBK+C1ItY7n7fcdxe3WhJKPlDwblmfecioa03GIi26tzabM+zmfxAx+56LW3LiBwJ5o
 FQgrSTzotneAyBe5+BjxyWPLHuQR7Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceGiZe6nSUnBp/1PIX31yQZeZcGOCa4BBhCfj5RsBd8=;
 b=8anwncw/vNodsHjcDFtNDkRGw+qvKrQSjBvPF2McyAYyBTBCKXRPAld7UhdvKm0H87S7AA
 kUq3zvPd8PlkUABg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5227FA3BA3;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 0D7E9518EAFA; Wed, 22 Sep 2021 08:35:27 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 7/7] nvme: display correct subsystem NQN
Date: Wed, 22 Sep 2021 08:35:25 +0200
Message-Id: <20210922063525.143045-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_240393_29752056 
X-CRM114-Status: GOOD (  12.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With discovery controllers supporting unique subsystem NQNs the
actual subsystem NQN might be different from that one passed in
via the connect args. So add a helper to display the resulting
subsystem NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c    | 2 +-
 drivers/nvme/host/fabrics.h | 5 +++++
 drivers/nvme/host/fc.c      | 2 +-
 drivers/nvme/host/rdma.c    | 2 +-
 drivers/nvme/host/tcp.c     | 2 +-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ad01e2778cb6..084a2df2a58e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -221,7 +221,7 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	dev_info(ctrl->device,
-		 "Removing ctrl: NQN \"%s\"\n", ctrl->opts->subsysnqn);
+		 "Removing ctrl: NQN \"%s\"\n", nvmf_ctrl_subsysnqn(ctrl));
 
 	flush_work(&ctrl->reset_work);
 	nvme_stop_ctrl(ctrl);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index b61b666e10ec..56253a060258 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -179,6 +179,11 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	return true;
 }
 
+static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
+{
+	return ctrl->subsys ? ctrl->subsys->subnqn : ctrl->opts->subsysnqn;
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..fa8bd6c21073 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3572,7 +3572,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
-		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
+		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
 
 	return &ctrl->ctrl;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 042c594bc57e..d795a9868674 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2385,7 +2385,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
-		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3c1c29dd3020..78966b8ddb1e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2582,7 +2582,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 
 	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
