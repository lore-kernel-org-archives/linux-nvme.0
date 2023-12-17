Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752AAC3DA6E
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Dec 2023 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yaU3JP5hadrOWY5Olk7IETWHwtW5ENd//f66Xmi5O6Q=; b=I14fOsXZNjrH+UNATOOcEuPD5l
	U2R538GCAICv6sHG8RnILt4kxdHKL+yBsIMCh4oTapbRa3EF+AQw6jtBR/XOY6gS8YcH7KWIx1VwS
	cEO1O5aHuJEFP6v3YOWDqnMvSGkpnTlWP3M2k6VprrqIP/80eWNq0ADWcoVLvZN/hTt2KyijWllvb
	1Zvjh1XOEAmCtfI3FGJ3W+IEE+fvwu/eqnhQjIvwiugiVYkjwS79n43j99M4gEuYiHSVNf6615qHU
	0/EYoXgKM/iXRkawU0MevgXF2u6sS+Hw79u2upzr3fdLvVKVo0pTAPKxSYzLSOo+rXb/uYVA6V+lX
	ezbi/2qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEtXy-0084Hi-35;
	Sun, 17 Dec 2023 15:59:18 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEtXw-0084GW-0u
	for linux-nvme@lists.infradead.org;
	Sun, 17 Dec 2023 15:59:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1AFD8CE0B30;
	Sun, 17 Dec 2023 15:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777B7C433C9;
	Sun, 17 Dec 2023 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702828740;
	bh=SSg49DHsDDkmhmL316AsVMFlDKRML5W4d3W9sfQ627A=;
	h=From:To:Cc:Subject:Date:From;
	b=c64RkO/eOfgNGFgCtju9uRiI3z1wp6nUl5JnlmZxmitm58UzXyy0oXVUztuUrsJqy
	 XmU/tAaxgwGzi++uqCsUCilQR6lC+HaSz3WYl552e/lJByncuQBB1PaTf/ADZc4U6n
	 UPlr5fo04OSBrNHokmw7u6mphz8i4OwmvfqmnVkBauK2WHE9MnCa/EWM5tFvNRBVtQ
	 Z+v30afwD6EgYhVP7NDI5Xe17LQMuFX7TOOpI3+zn6wsS5FzNeypc1zyPTAYB1uXnE
	 /6xtummD+Sj8RnkNJshLy+20XRlcLS/vPjlgYVxXc8IOn7R/MixUq0UzERPS+E5EEF
	 eXpaYz+xECM1A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@wdc.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3] nvmet: implement unique discovery NQN
Date: Sun, 17 Dec 2023 16:58:48 +0100
Message-Id: <20231217155848.21292-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_075916_684572_2980ECE1 
X-CRM114-Status: GOOD (  10.81  )
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
This allows to identify discovery connections to the same subsystem
and to minimize the number of discovery connections when
persistent discovery controllers are enabled.
This patch adda a configfs attribute 'discovery_nqn' in the 'nvmet'
configfs directory to specify the unique discovery NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 46 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d937fe05129e..456aa5e009cd 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1587,6 +1587,11 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
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
@@ -2131,7 +2136,48 @@ static const struct config_item_type nvmet_hosts_type = {
 
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
index 3935165048e7..9c028bbedb45 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1530,6 +1530,13 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
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


