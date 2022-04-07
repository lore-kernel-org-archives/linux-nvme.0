Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38B5C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDuZCBKF/pPKfYOKhPv9Qacg44URohiyznOFHN/n1QU=; b=c0vnGR2K5PBJl0eLaqYQf/IikP
	dKB7j032b8B3kPzsN1guXtsbk9NvgVeEdb/ja6U8YjIrZX3/YznDbcn6lbG4GDbFnmlRS6KK6WAZE
	QtG5435AFD/LoesbixCO4d3S85qUhS4O9kqN+olg7xfVMTqV0PyZoqm+UM/eAYbE9AshCzstuIiO2
	QVN1qTJDEBlw3s9HYbXXFeVM3ZtDd4pC8leaLhSbAmgph0H2r52DtA17F+VX2PR71qyz045v557uG
	YECrURLbSGCW+2ZO0oCiaorirdEWYO89lXlbgkStsK5iTsqkApiLx8D1YaSDBp30rimCO2AXK5rgh
	x8o2HU/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncPnD-00BOV3-9p; Thu, 07 Apr 2022 10:55:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncPgT-00BLiz-ME
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 10:48:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 09E201F85C;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649328491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDuZCBKF/pPKfYOKhPv9Qacg44URohiyznOFHN/n1QU=;
 b=0GklyhMpq1WA5tDBXVKDaZZsXzsBqw+N8TEEeP6ba/XH1nldad9MjhZMjTXolYdSR7GaX6
 binborhsyB4mSwKdX4di2PJ+Lnrbq5sNNjrLzYV94WoxVr6/71CYSP4MAjMDtFotgUoozM
 UA1yO6QtERoOJkqKDpbohSFvD0JWSwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649328491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDuZCBKF/pPKfYOKhPv9Qacg44URohiyznOFHN/n1QU=;
 b=ebQMx9xcYfG9GmESvDl2cjhlMP74fMrCzo2bA52CCjHRoiA0KXNW4LUdQWLj9aFftpBojW
 gWPEcPkiwhfas0CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id F130EA3B95;
 Thu,  7 Apr 2022 10:48:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id DD6E35193BE5; Thu,  7 Apr 2022 12:48:10 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: make the subsystem type configurable
Date: Thu,  7 Apr 2022 12:48:06 +0200
Message-Id: <20220407104808.29007-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220407104808.29007-1-hare@suse.de>
References: <20220407104808.29007-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_034814_012953_13D3FB78 
X-CRM114-Status: GOOD (  18.56  )
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
 drivers/nvme/target/configfs.c  | 71 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/discovery.c |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44b2988759e..07c2d563d11b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1234,6 +1234,76 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
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
+	struct nvmet_port *p;
+	struct nvmet_subsys_link *s;
+	int i;
+
+	if (subsys->subsys_discovered)
+		return -EACCES;
+
+	/*
+	 * Do not allow to change the subsystem type if it's
+	 * already linked to ports; the user should unlink it first.
+	 */
+	down_read(&nvmet_config_sem);
+	list_for_each_entry(p, &nvmet_ports_list, global_entry) {
+		list_for_each_entry(s, &p->subsystems, entry) {
+			if (s->subsys == subsys) {
+				up_read(&nvmet_config_sem);
+				return -EACCES;
+			}
+		}
+	}
+	up_read(&nvmet_config_sem);
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
+		if (!xa_empty(&subsys->namespaces)) {
+			pr_err("discovery subsystem cannot have namespaces\n");
+			return -EINVAL;
+		}
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
@@ -1263,6 +1333,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
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
 
-- 
2.29.2


