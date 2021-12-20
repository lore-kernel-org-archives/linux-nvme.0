Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2017C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CkpGv/+24qrmi5mrrsF9XE4tKXBT5ixgE5okqFY7Eiw=; b=RY1C67XoaPeAGOHRZiSDvv8g8I
	IWNaVy06LWYgkz8tx3cB4YsPbDpokXRLGOJuG7CfAqD4qqd8FGG/4eCEDelm6sRXFhKC2a8KVzUdF
	OUhsd1jsKbSwGjvdA3g+ySHzVCcxae8IAZoMnuTOVh8TJJex8nQumInRm6Xl8fJdBoC9x3PkPm4eq
	xPthuTt0nDMqemu83BsdnQ/vljuMvyw803cWalqhIupgk/OvZKVVQqnIUE5OP16pPmfkWFSXp/Lm1
	xrlgaB2Mfm7bhgBMsunVxqJQ5YuR1ubqckgkPrlYSOon8xoFeuj6n2KtcdZYFlLbw3u8PnYdSSccr
	UcCA68qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzEzy-001PV4-GJ; Mon, 20 Dec 2021 09:30:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzEzv-001PTk-PJ
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 09:30:25 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 948A6218F4;
 Mon, 20 Dec 2021 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639992620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CkpGv/+24qrmi5mrrsF9XE4tKXBT5ixgE5okqFY7Eiw=;
 b=AIEUkzGtK211b8aG83D4WeZ4Iiw51czQx9tJGDqdfoqMYEC+H6WMNgzAwqDlaFHPxBgVh+
 30PKbzpP7mThq+zgrEY9iENRd46QAIRIaYRUC6tsCCegZiMVohAArJVt1783BK6vAvei/u
 KMTATi2x/F06eiuTJwDDZnKnrl3ZIUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639992620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CkpGv/+24qrmi5mrrsF9XE4tKXBT5ixgE5okqFY7Eiw=;
 b=bEIFnIazl1bxvUOw78ARYhRcgzJ79xUu40qHU3+ICJJTLA+rwIgVAIODMH/IaS3nxdRI8w
 mWUtcz+yq9HiseDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 60CF0A3B87;
 Mon, 20 Dec 2021 09:30:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8FE585192240; Mon, 20 Dec 2021 10:30:19 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv3] nvme: add 'iopolicy' module parameter
Date: Mon, 20 Dec 2021 10:30:17 +0100
Message-Id: <20211220093017.84283-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_013024_001554_9D1D9F81 
X-CRM114-Status: GOOD (  14.63  )
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

While the 'iopolicy' sysfs attribute can be set at runtime, most
storage arrays prefer to use the 'round-robin' iopolicy per default.
We can use udev rules to set this, but is getting rather unwieldy
for rebranded arrays as we would have to update the udev rules
anytime a new array shows up, leading to the same mess we currently
have in multipathd for configuring the RDAC arrays.

Hence this patch adds a module parameter 'iopolicy' to allow the
admin to switch the default, and to do away with the need for a
udev rule here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c      |  4 +---
 drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44c375a1edbb..be404004c235 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2747,9 +2747,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		return -EINVAL;
 	}
 	subsys->awupf = le16_to_cpu(id->awupf);
-#ifdef CONFIG_NVME_MULTIPATH
-	subsys->iopolicy = NVME_IOPOLICY_NUMA;
-#endif
+	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7f2071f2460c..de98c0e05777 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,33 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static int iopolicy = NVME_IOPOLICY_NUMA;
+
+static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
+{
+	char *endp;
+	int p;
+
+	if (!val)
+		return -EINVAL;
+	p = simple_strtoul(val, &endp, 0);
+	if (p != NVME_IOPOLICY_NUMA &&
+	    p != NVME_IOPOLICY_RR)
+		return -EINVAL;
+	iopolicy = p;
+	return 0;
+}
+
+module_param_call(iopolicy, nvme_set_iopolicy, param_get_int,
+		  &iopolicy, 0644);
+MODULE_PARM_DESC(iopolicy,
+	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");
+
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
+{
+	subsys->iopolicy = iopolicy;
+}
+
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
 	struct nvme_ns_head *h;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a54096ba0552..fe224016418e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -767,6 +767,7 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
@@ -864,6 +865,9 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 {
 }
+static inline void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_revalidate_zones(struct nvme_ns *ns);
-- 
2.29.2


