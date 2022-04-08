Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA224C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 06:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKC2k4XYckR/FUBz6S5XUo6o92vVk0tnLC4swPyO724=; b=m16FHxa6TX7pNWTDf6xKszCbIQ
	Ol3xp+zWjTM9WYyNQvlNuspA0cM0v2F2kOFM8GFy5+ZJm4Z6zWpQgG+O+4xpqyNcezb4iFGWFO7HC
	D7+otzp46bzKNrcpWgucPayS8SxgzvZYI0cVW0iGwuEhxS2YkwTfM9OpDxkZ6jcUr9k7H8+B6XDWe
	N6P1aNuImFUviijethgabCwU5Y3s5RN9F93FDJxgGVUQdrWHcvm5BR68SxyFOgWKCCqpQrq9X9Zgl
	qvMhg8MvoJyNRfZy7/6JB9fyJZb2Odjk+dxFDI4Yk1gv68MJw7b/rNx9Zw9PGj72Jkd62y2U8/WX9
	7zoslIFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nciaw-00FNxo-7j; Fri, 08 Apr 2022 06:59:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncian-00FNub-Uh
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 06:59:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9A3F5215FE;
 Fri,  8 Apr 2022 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649401175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKC2k4XYckR/FUBz6S5XUo6o92vVk0tnLC4swPyO724=;
 b=zRQ/I8u6J7T5HsVFHWKLQuQ7vC4IJQAZaudK9YOauJ/1PCoC6lLWA1cEfrb1VZh4Q49JwC
 ziWF9k1A6tbkRwvE+JRtkiJ0yjYyJanztCE5+HV1qzZt4LolIJ9X//jIRBkgvSveHMVMCX
 H28sOdvVxg8f9q5mqyG3stIgaFFBQQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649401175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKC2k4XYckR/FUBz6S5XUo6o92vVk0tnLC4swPyO724=;
 b=dAcaZJK2jDI28XbCn6zbFAnIrAd+NTIpCgGdeGGHceotYtZ6D2FktSjwE3yinzKVrRjvVf
 7K9tf81w0ikLz/Cg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 8EB4EA3B83;
 Fri,  8 Apr 2022 06:59:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id B6F8E5193C07; Fri,  8 Apr 2022 08:59:34 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: make the subsystem type configurable
Date: Fri,  8 Apr 2022 08:59:28 +0200
Message-Id: <20220408065930.123015-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220408065930.123015-1-hare@suse.de>
References: <20220408065930.123015-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_235938_211310_D6B433E5 
X-CRM114-Status: GOOD (  18.08  )
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
 drivers/nvme/target/configfs.c  | 60 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/discovery.c |  2 +-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44b2988759e..38b0ab9fb721 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -834,6 +834,7 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	}
 
 	list_add_tail(&link->entry, &port->subsystems);
+	subsys->port_count++;
 	nvmet_port_disc_changed(port, subsys);
 
 	up_write(&nvmet_config_sem);
@@ -862,6 +863,7 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 
 found:
 	list_del(&p->entry);
+	subsys->port_count--;
 	nvmet_port_del_ctrls(port, subsys);
 	nvmet_port_disc_changed(port, subsys);
 
@@ -1234,6 +1236,63 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
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
+	if (subsys->port_count) {
+		pr_err("cannot change type when linked to ports\n");
+		up_write(&nvmet_config_sem);
+		return -EACCES;
+	}
+	if (!xa_empty(&subsys->namespaces)) {
+		pr_err("cannot change type when namespaces are configured\n");
+		up_write(&nvmet_config_sem);
+		return -EACCES;
+	}
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
@@ -1263,6 +1322,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_type,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c2162eef8ce1..b5012df790d5 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -219,7 +219,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 		nvmet_format_discovery_entry(hdr, req->port,
 				p->subsys->subsysnqn, traddr,
-				NVME_NQN_NVME, numrec);
+				p->subsys->type, numrec);
 		numrec++;
 	}
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..ecba3890ce65 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -216,6 +216,7 @@ struct nvmet_subsys {
 
 	struct mutex		lock;
 	struct kref		ref;
+	unsigned int		port_count;
 
 	struct xarray		namespaces;
 	unsigned int		nr_namespaces;
-- 
2.29.2


