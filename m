Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F9C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mDfsoiGiyVtTSi4poeMQ8PGfxsi/zECG1hOp2agcUCY=; b=i7s/+tbYAjsM4p36pF/ocjrXm/
	oCzrrC2ou9vdZfsQudllDnjOxBANKOOPAnji0oC73a5OIjqiblFDU9JjBFoSoGzzgchhVEAlNK4iX
	Opi+eJpVOPoGn+mCdqda25xOcVj2d++6FGxsDgzTF8cL64A0AXKLOcdByjJZOtLy4D/id/4zEUDEQ
	Hn6bV07koBcbm/99QBAqiiXFdIWZWOvxljqf8eb6vJIsR+fyHUPLDnpras5OwJsDc4SzTtps3vG5A
	rljlPSwS9zMlOfmX9y9lBTBNdqLo2sukdytgiOjjAGpcja3CzqYUUTAI/VlyzrwrvEzAEzbDsmPqN
	Ur1yIkBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnZ21-000000069Og-3iI8;
	Fri, 22 Mar 2024 07:09:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnZ1y-000000069Nx-45Yg
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:09:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D7E9BCE16D2;
	Fri, 22 Mar 2024 07:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9A4C43390;
	Fri, 22 Mar 2024 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091372;
	bh=9Kt8nt2HZ9jzNvLnlciHn7R5F/t21OVefBclxDvR3SQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ksDV8Qd975/HyraH0aWudD2zf4v26Dt9+InZrefEL55sDJ3PER06WamrSfABd5lLS
	 o2PA/c+CbRrZHtznQE/zGGZWUdQ+02E7rUjJFnrJkbtjWRzfyOrRbZfU3fV96igwHm
	 TrjbtMMXCvLSw7hdCM7indkFUM/kTDtr2EaQAwMa3MfeC5XJ7Wp5aZVGAC9GdzN6vz
	 Av7V+s5Qn9/iSjackHUMqEn8dhcIoikkCJCwc+VQzKpoS9mb/NTt7IzLQjpn38GhXt
	 IsCzklWN6NcXy6nezySKi6m4wJniZkmTlBswA8wwjZgEtVR1xXvk03r8YO9CJPtSZP
	 bziG/MI1JJK6g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4] nvmet: implement unique discovery NQN
Date: Fri, 22 Mar 2024 08:09:27 +0100
Message-Id: <20240322070927.30454-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000935_378500_C3C4126C 
X-CRM114-Status: GOOD (  12.04  )
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

From: Hannes Reinecke <hare@suse.de>

Unique discovery NQNs allow to differentiate between discovery
services from (typically physically separate) NVMe-oF subsystems.
This is required for establishing secured connections as otherwise
the credentials won't be unique and the integrity of the connection
cannot be guaranteed.
This patch adda a configfs attribute 'discovery_nqn' in the 'nvmet'
configfs directory to specify the unique discovery NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 46 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 77a6e817b315..e8ead4ab35aa 100644
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
@@ -2159,7 +2164,48 @@ static const struct config_item_type nvmet_hosts_type = {
 
 static struct config_group nvmet_hosts_group;
 
+static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
+					     char *page)
+{
+	return sprintf(page, "%s\n", nvmet_disc_subsys->subsysnqn);
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
index 694e91cdfc8d..2ae6d70f47a2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1552,6 +1552,13 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
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


