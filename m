Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07630C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 13:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ULPdLWOQUIz0D7jBVp2Wr2aB9greKXfQrujJlCYqGYQ=; b=T/W1i5zj/OHR8f0pzL/xZzvkup
	9nBFlhRKVS9h6bnx1gG+hf5TqNyI/uuQm64n5fLeuLJxSweQZIzQQN8WAiA9PXhqulmam132Ko6Jg
	aqm/BC9rf1y1sdU581mUjHXBpMbBaFiYLpD/MqRhIoSOb9SQ45qbHi4d7b/lBtrk5+EYd9iHqr0gZ
	A+/HZwiIOX7MbI2UCzdrQpklMGwr7SHYhEnPdIfrlUKBICUtq4XjMUm++RdFHZ5xe/4HKrg9clqwn
	vJnAIXrQfpJpExmJb6hTW2KNCKxB8MukkHLJep5FiVWvYGeg2GV5L26BDClkEIHDsmYh6GFXXz9/n
	0OeKHLvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvfje-001vIA-O4; Fri, 10 Dec 2021 13:14:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvfjb-001vHO-3U
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 13:14:48 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C1706210F8;
 Fri, 10 Dec 2021 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639142085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ULPdLWOQUIz0D7jBVp2Wr2aB9greKXfQrujJlCYqGYQ=;
 b=Ahftnc9Mrn1M/n4jeqhCM7lKMZfiIezw/1i+HS71LDi3EG0AWIm5Hf0YGcb5P0N94yO1Ho
 OGz/S2sJFKI9C1aUxZfInUyiTtnhrD+UbNcb+E525N9eFVkZjK0WkgmlIrYGkeTwwLzvT5
 56AimRsD1xaR0WmxRImQW/RrZGwClDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639142085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ULPdLWOQUIz0D7jBVp2Wr2aB9greKXfQrujJlCYqGYQ=;
 b=KSi2YZLXlthNzJ6eAzG18cD3XkznHl2OQCsIwKfvQBdKgUigQomZooWUcym9F83F902Ja/
 RFHz/+NPJDr6+7BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 951B3A3B94;
 Fri, 10 Dec 2021 13:14:45 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 82EBC51920BF; Fri, 10 Dec 2021 14:14:45 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add 'iopolicy' module parameter
Date: Fri, 10 Dec 2021 14:14:44 +0100
Message-Id: <20211210131444.120946-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_051447_325072_7A7A032F 
X-CRM114-Status: GOOD (  13.53  )
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
---
 drivers/nvme/host/core.c      |  4 +---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 58f5e8f454e2..282459a163e0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2782,9 +2782,7 @@ static struct nvme_subsystem *nvme_init_subsystem(struct nvme_ctrl *ctrl,
 		kfree(subsys);
 		return ERR_PTR(-EINVAL);
 	}
-#ifdef CONFIG_NVME_MULTIPATH
-	subsys->iopolicy = NVME_IOPOLICY_NUMA;
-#endif
+	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 63367a717805..8f4eea978af7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,16 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static int iopolicy = NVME_IOPOLICY_NUMA;
+module_param(iopolicy, int, 0444);
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
index 6c786ea4185b..ac158b8e825d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -771,6 +771,7 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
@@ -869,6 +870,9 @@ static inline void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
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


