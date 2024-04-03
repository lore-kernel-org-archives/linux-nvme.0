Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155AECD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RGOvzPF7wrYSF3fyaPoB2S3W4m5D/hE5B5ShEPTdNlA=; b=zb0cgyHqNBsgEdmcXeY+UyxE0h
	GF9lWITN1lryWrH+pmDcE/8uhCjcVfTmAAm42naarA5WflowH5lD+LhXjoJjY7OyMD1ZFZ9SakeeE
	aV/iXSIQKrTPh8Rd+51oa2meMSvaaIHhFX0C59VMY+Sv+IJeh9tgxAc4gWUceml/wMMqCIfgGWqGw
	X83Xv4NU9Lbu3imgZ3xF7TKkO/tSvSnCovL+W7Bly6zQ5RaD9D9h/CWp/8wKJ9kbhuI+QGw6wJlXe
	/sF0aP7evdZOk67iYoLzE97EU7qdz4riJYMzD/9/RwLCQ4wGEAm+CF9ECPtXcCwCcR2/eo9AaxgJV
	9RRZNLbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrypw-0000000Fmio-0cty;
	Wed, 03 Apr 2024 11:31:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrypt-0000000FmiA-3bMj
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 11:31:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C0C46134A;
	Wed,  3 Apr 2024 11:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C2C433F1;
	Wed,  3 Apr 2024 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712143880;
	bh=K6fajy3MpX4LA8pqtcLmY2eaT+lykCo/bSmhvPLCUJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=SMLhafjt5uKOL74uW/voLQ/TQ3834+V9eanUnBVX7BSSDZMEERULPxIkeRByYpZi9
	 qQOEjwSCVwUGsiYrbRaMDHmv+DvwZtRXW/FY9xyohqeeobOkv1RHsoloqKKu8eVTXw
	 nLEjbD0saIUwhESrMfctuewsajPBRXUMMl8D29C9tEDgo83CD/WUaWYr5sOvr+C+8/
	 RCf+LBr9FCLLNpuzXWFEhlymZsOfZ6dGGzrg9atZe/VZWwkC4VbICXIQZKiqs5NkPt
	 liOfcEWKsFgf2TtbtS10cMOiESCjmyyBZFSLo/SAWx3WarEBVKWWSn1CoVMjd6AD3X
	 L6m0h4VuYg0Ng==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv5] nvmet: implement unique discovery NQN
Date: Wed,  3 Apr 2024 13:31:14 +0200
Message-Id: <20240403113114.76342-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_043122_111628_8E00E7ED 
X-CRM114-Status: GOOD (  12.80  )
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

Unique discovery NQNs allow to differentiate between discovery
services from (typically physically separate) NVMe-oF subsystems.
This is required for establishing secured connections as otherwise
the credentials won't be unique and the integrity of the connection
cannot be guaranteed.
This patch adds a configfs attribute 'discovery_nqn' in the 'nvmet'
configfs directory to specify the unique discovery NQN.

Changes to v2:
- Rework as per suggestion from Chaitanya

Changes to v3:
- Update commit log
- Rebase to 6.9

Changes to v4:
- Include reviews from Chaitanya

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 47 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 +++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 77a6e817b315..a2325330bf22 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1613,6 +1613,11 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
+		pr_err("can't create subsystem using unique discovery NQN\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
@@ -2159,7 +2164,49 @@ static const struct config_item_type nvmet_hosts_type = {
 
 static struct config_group nvmet_hosts_group;
 
+static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
+					     char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
+}
+
+static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct list_head *entry;
+	size_t len;
+
+	len = strcspn(page, "\n");
+	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
+		struct config_item *item =
+			container_of(entry, struct config_item, ci_entry);
+
+		if (!strncmp(config_item_name(item), page, len)) {
+			pr_err("duplicate NQN %s\n", config_item_name(item));
+			up_write(&nvmet_config_sem);
+			return -EINVAL;
+		}
+	}
+	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
+	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
+	up_write(&nvmet_config_sem);
+
+	return len;
+}
+
+CONFIGFS_ATTR(nvmet_root_, discovery_nqn);
+
+static struct configfs_attribute *nvmet_root_attrs[] = {
+	&nvmet_root_attr_discovery_nqn,
+	NULL,
+};
+
 static const struct config_item_type nvmet_root_type = {
+	.ct_attrs		= nvmet_root_attrs,
 	.ct_owner		= THIS_MODULE,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6bbe4df0166c..8860a3eb71ec 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1541,6 +1541,13 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	}
 
 	down_read(&nvmet_config_sem);
+	if (!strncmp(nvmet_disc_subsys->subsysnqn, subsysnqn,
+				NVMF_NQN_SIZE)) {
+		if (kref_get_unless_zero(&nvmet_disc_subsys->ref)) {
+			up_read(&nvmet_config_sem);
+			return nvmet_disc_subsys;
+		}
+	}
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
 				NVMF_NQN_SIZE)) {
-- 
2.35.3


