Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ADEC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gxL8Oh/ciXKjgGSOs0LQhgXOqH2IT4INdVvjEe2uTAM=; b=pFNrodWI2Bbu9A7yVmW1cP/hq0
	mUCok/BOIeTMFKFitfK6LuibyrdjtzkwzpXYK8IJZqEKHyd14vdqTICnFxA0A86y0yp2G3R1UsbD3
	kgzKDdRqmlRk6jXWQP7L16GbhdVSouMWk9TeTY90xfm0h5+AWIvgri0cKRHJ3ykRsveCUU9YU9ahy
	Aru71Yjyf2tAr8vc6c+NKDeE2QHzEUx1PvlwJTyJrpsV8Q1uRYl8iR9B6BGnmebJhSzGRspQ5mc2s
	pdQ6bKlo/DHbdW3tjr6PDFDD9wlzqGGFMA1ZOVb7Zo9ZNxA/tEwlBoDfx/dzvWpH6Lezc0kQzZZWB
	7eLRsM1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUr5m-00GQ8e-95; Thu, 17 Mar 2022 14:27:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUr5O-00GQ2T-Dd
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 14:26:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BC95A21118;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647527200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxL8Oh/ciXKjgGSOs0LQhgXOqH2IT4INdVvjEe2uTAM=;
 b=qoFCqzT+md5rhO5EiHyt8AEOaRc7yN9prM8/YX0dZatLvW/J0KHk3aFg6IYL4QCcJ2QRgw
 7vDvVC4YCdMGYVUI0E/toRVc4X2e5UxTCFixKy9RvqexGIZ0NBHCMpHtnZlTv9Wo9tZ7JE
 fkKEEPKQrDFyqxBQLoY9LWIoUYlLNt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647527200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxL8Oh/ciXKjgGSOs0LQhgXOqH2IT4INdVvjEe2uTAM=;
 b=RP3vHzqMaCpgPMFimhtZQTw4euaF1NPDtIp5NIyWm7JEhRjuTmQQ60xakIWRRXO6xXrJfE
 5DUtxRvJmRvuUhBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 6BB96A3B87;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 59E1B5193768; Thu, 17 Mar 2022 15:26:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvmet: make the subsystem type configurable
Date: Thu, 17 Mar 2022 15:26:33 +0100
Message-Id: <20220317142634.49324-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220317142634.49324-1-hare@suse.de>
References: <20220317142634.49324-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_072642_655786_56F27B23 
X-CRM114-Status: GOOD (  18.61  )
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

Make the subsystem type configurable to allow for unique
discovery subsystems by changing the subsystem type to
'discovery'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 65 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  3 ++
 drivers/nvme/target/discovery.c | 20 +++++++++-
 drivers/nvme/target/nvmet.h     |  3 ++
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 57a6795a2d8d..ae6815b72d7d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -930,6 +930,9 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 
 found:
 	list_del(&p->entry);
+	/* Reset to static discovery controller */
+	if (nvmet_disc_subsys == subsys)
+		nvmet_set_disc_subsys(NULL);
 	nvmet_port_del_ctrls(port, subsys);
 	nvmet_port_disc_changed(port, subsys);
 
@@ -1302,6 +1305,67 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 
+static const struct nvmet_type_name_map nvmet_subsys_type_map[] = {
+	{ NVME_NQN_DISC,	"referral" },
+	{ NVME_NQN_NVME,	"nvme" },
+	{ NVME_NQN_CURR,	"discovery" },
+};
+
+static ssize_t nvmet_subsys_attr_type_show(struct config_item *item,
+						 char *page)
+{
+	u8 type = to_subsys(item)->type;
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(nvmet_subsys_type_map); i++) {
+		if (nvmet_subsys_type_map[i].type == type)
+			return snprintf(page, PAGE_SIZE, "%s\n",
+					nvmet_subsys_type_map[i].name);
+	}
+
+	return snprintf(page, PAGE_SIZE, "\n");
+}
+
+static ssize_t nvmet_subsys_attr_type_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int i;
+
+	if (subsys->subsys_discovered)
+		return -EACCES;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_subsys_type_map); i++) {
+		if (sysfs_streq(page, nvmet_subsys_type_map[i].name))
+			goto found;
+	}
+
+	pr_err("Invalid value '%s' for subsystem type\n", page);
+	return -EINVAL;
+
+found:
+	down_write(&nvmet_config_sem);
+	if (nvmet_subsys_type_map[i].type == NVME_NQN_CURR) {
+		if (nvmet_has_unique_disc_subsys()) {
+			pr_err("unique discovery subsystem already present\n");
+			return -EINVAL;
+		}
+		if (!xa_empty(&subsys->namespaces)) {
+			pr_err("discovery subsystem cannot have namespaces\n");
+			return -EINVAL;
+		}
+		nvmet_subsys_del_ctrls(nvmet_disc_subsys);
+		nvmet_set_disc_subsys(subsys);
+	} else if (subsys->type == NVME_NQN_CURR)
+		nvmet_set_disc_subsys(NULL);
+
+	subsys->type = nvmet_subsys_type_map[i].type;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_type);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
 						char *page)
@@ -1331,6 +1395,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_type,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 83eba511d098..a9d03dfe547e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1527,6 +1527,9 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	}
 	up_read(&nvmet_config_sem);
 
+	if (nvmet_has_unique_disc_subsys())
+		return NULL;
+
 	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
 		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
 			return NULL;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c2162eef8ce1..bceeec00099a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -9,9 +9,23 @@
 #include "nvmet.h"
 
 struct nvmet_subsys *nvmet_disc_subsys;
+static struct nvmet_subsys *_nvmet_disc_subsys;
 
 static u64 nvmet_genctr;
 
+bool nvmet_has_unique_disc_subsys(void)
+{
+	return (_nvmet_disc_subsys != nvmet_disc_subsys);
+}
+
+void nvmet_set_disc_subsys(struct nvmet_subsys *subsys)
+{
+	if (subsys)
+		nvmet_disc_subsys = subsys;
+	else
+		nvmet_disc_subsys = _nvmet_disc_subsys;
+}
+
 static void __nvmet_disc_changed(struct nvmet_port *port,
 				 struct nvmet_ctrl *ctrl)
 {
@@ -393,12 +407,14 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 
 int __init nvmet_init_discovery(void)
 {
-	nvmet_disc_subsys =
+	_nvmet_disc_subsys =
 		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_CURR);
+	nvmet_disc_subsys = _nvmet_disc_subsys;
 	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);
 }
 
 void nvmet_exit_discovery(void)
 {
-	nvmet_subsys_put(nvmet_disc_subsys);
+	nvmet_disc_subsys = NULL;
+	nvmet_subsys_put(_nvmet_disc_subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 81061aa8c6d3..658e3fd81f06 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -556,6 +556,9 @@ void nvmet_exit_discovery(void);
 extern struct nvmet_subsys *nvmet_disc_subsys;
 extern struct rw_semaphore nvmet_config_sem;
 
+bool nvmet_has_unique_disc_subsys(void);
+void nvmet_set_disc_subsys(struct nvmet_subsys *subsys);
+
 extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
 extern u64 nvmet_ana_chgcnt;
 extern struct rw_semaphore nvmet_ana_sem;
-- 
2.29.2


