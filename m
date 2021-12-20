Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4863FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1Grl/DHA3IMW7tvgxprXGyQliHtwbFMHg7MlY30ACHY=; b=bXKTX67QM+EAEN+LLSVn2ouW3E
	EYaE8qu3qg1LqRKiyVZYZC201vouoDhIWEDXigzpL0iqL6hRHC0N7iZ2y9xze5OPrEM0E6NkAJxBD
	HDFaXHQqTT4rTPZPXdgIs63ee40lp1PKZQjksI5TltDMC0Z66P4niIgSrdw+sRZwXzIhz/nKs2q6L
	/6pDZp6I06e7yvSO7t0w3snZ5cfQgEkunLv83Exz9kip38/QzyNgylKTqHLZtMbACnrj1W6NpsbPk
	hg501DtZsn9NgvBSAxY+clrbuRnLPbzD0Mj4PeUZa0u7AtKWbaNp093WKPL3eTxrwh2YEcdaNe/rQ
	lss4nweA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzI8z-002OLx-E3; Mon, 20 Dec 2021 12:51:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzI8s-002OL5-I1
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 12:51:52 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9959B1F395;
 Mon, 20 Dec 2021 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1640004708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Grl/DHA3IMW7tvgxprXGyQliHtwbFMHg7MlY30ACHY=;
 b=ExLa9ciY21OPsVgd/Cezgt1N94oVLu8d8W6avdXLLOJ8kihOV+KVIP9E4HyR/wu2Vo9JKi
 mmj08KZH4PO0V9PuNYUlGjlNH6QAgaVA/jMNpBbDs1kXVjrXShhlNp/ZavbKGYB4rEC8i2
 5/moB2i51PTYYvmN7ZBDFhD2QY2IAKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1640004708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1Grl/DHA3IMW7tvgxprXGyQliHtwbFMHg7MlY30ACHY=;
 b=S5koRnbJcrTdito5mWCUmsTZfh91iMarOPNG4QQSNS6eSC23iHNFNX8pIAEBe6gGbaDVpq
 OM9imh0zkcrAFWAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 66A70A3B87;
 Mon, 20 Dec 2021 12:51:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 904495192247; Mon, 20 Dec 2021 13:51:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4] nvme: add 'iopolicy' module parameter
Date: Mon, 20 Dec 2021 13:51:45 +0100
Message-Id: <20211220125145.38146-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_045150_766883_F901FBFA 
X-CRM114-Status: GOOD (  15.28  )
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
 drivers/nvme/host/multipath.c | 41 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 3 files changed, 41 insertions(+), 8 deletions(-)

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
index 7f2071f2460c..892bd5dcb46b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -13,6 +13,42 @@ module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+static const char *nvme_iopolicy_names[] = {
+	[NVME_IOPOLICY_NUMA]	= "numa",
+	[NVME_IOPOLICY_RR]	= "round-robin",
+};
+
+static int iopolicy = NVME_IOPOLICY_NUMA;
+
+static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
+{
+	if (!val)
+		return -EINVAL;
+	if (!strncmp(val, "numa", 4))
+		iopolicy = NVME_IOPOLICY_NUMA;
+	else if (!strncmp(val, "round-robin", 11))
+		iopolicy = NVME_IOPOLICY_RR;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
+{
+	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
+}
+
+module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
+	&iopolicy, 0644);
+MODULE_PARM_DESC(iopolicy,
+	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
+
+void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
+{
+	subsys->iopolicy = iopolicy;
+}
+
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 {
 	struct nvme_ns_head *h;
@@ -706,11 +742,6 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 	struct device_attribute subsys_attr_##_name =	\
 		__ATTR(_name, _mode, _show, _store)
 
-static const char *nvme_iopolicy_names[] = {
-	[NVME_IOPOLICY_NUMA]	= "numa",
-	[NVME_IOPOLICY_RR]	= "round-robin",
-};
-
 static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
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


