Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEDDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDg0dLdXO0DnOkaOdqa396XV1M0oY76T1rdZzszRiGk=; b=jb2o8sZUeNaVxazWKiknOyBNpR
	fbPZyM7UMikz75JbzseaYSJsVXrnJPS3PEs8nrQccMnVc+p5w7QTWb43S9NwZFF5uyVe9znIgQLsy
	+nY/oPJ2eVkfQfh7gH+MnFI9UnS3ceSL8+mUZGfhG5LKbk39rP3bUVq2oaXg6d2U5Tj0aPBde3HAE
	JdLY+oHMp1eFNUeU1soRyAqpp0wFnK+IaBLo5gV4YgbudKPhgy+f5a5fHh1JgfGhmZaT4ky2acL29
	iFqvOD0CmzlnH8XZYW+IZOei6BKZv7Z68Di0b3uc4i102vuYTZsnNvIk2MX20ajbixrxxpdjINmzS
	N0QWZtaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc6YL-006TVs-8h; Wed, 06 Apr 2022 14:22:33 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc6Y6-006TO8-Qf
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 14:22:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7C7B9210E4;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649254935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDg0dLdXO0DnOkaOdqa396XV1M0oY76T1rdZzszRiGk=;
 b=bDytKcqAQZ3EvApnXibvyaN/XhnoE0Dnw6u8PltaXImSs8QLyKgz1ksk+w9PgME0eLeGew
 s0Dlkgbq9vtp1VtYnebuP+BUHjNMPp7pCyWxyRyclCWmgzA4GoKdhvse+i9hl4tJj88XH1
 2ewA6s8HEF+xsyEMPnSkagw1BcKsXN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649254935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDg0dLdXO0DnOkaOdqa396XV1M0oY76T1rdZzszRiGk=;
 b=iqnvz15E5clOtECjY36bwmU+6RbXSPdK94QQ8Pv4+dsVgAlYVPMzLX2EhxjLPRKEoIGJNt
 zKILDCSLDRmjdgDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 75B8CA3B88;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 66A6C5193BAC; Wed,  6 Apr 2022 16:22:15 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: make the subsystem type configurable
Date: Wed,  6 Apr 2022 16:22:08 +0200
Message-Id: <20220406142210.71248-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220406142210.71248-1-hare@suse.de>
References: <20220406142210.71248-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_072219_062970_7A5E48BD 
X-CRM114-Status: GOOD (  16.33  )
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
 drivers/nvme/target/configfs.c  | 54 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/discovery.c |  2 +-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44b2988759e..31d2490264e3 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1234,6 +1234,59 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
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
@@ -1263,6 +1316,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
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


