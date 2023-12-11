Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AC7C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wzW7vhyR+SA+b7LKRuIoGzFtYhJyv2cAsvsHbsB1KVY=; b=S90WYiJzp9EHxZNHF91wXIOxWF
	oWyxSxpo+gVuD4h3fAKvWXUkLoMGXj9Fe1TIiDj8giLNL0b3KHgBnlseF3mD6G9f1aQ1bkKwkB4mE
	PPKhj28mfNBdD6kQRBZi/cD8+7KuqCQP63Vw/I9ZsJx7nE0WUmmP+kRrVPhOmJDUCKkmEZzwc688b
	bDo6FJ/dvELrK8Z3yGR2PDOXUruofwqHNuV3W4CSfaSV0fcVed8ACooChf/7h/nlRY/mTDCmjQE29
	x9DFN5ONggcjNYixDhpJC2e+dkpFHZh1sri/E4Hf2WveTkFCMlBExltlzZoKJxqVOKQ8UH964jWBL
	HH4umPTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbND-004JVh-1q;
	Mon, 11 Dec 2023 08:10:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbN8-004JV9-0o
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 08:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9356961006;
	Mon, 11 Dec 2023 08:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76AAC433C8;
	Mon, 11 Dec 2023 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702282234;
	bh=xtHmn7VwQ6bfnKleLvKv7W+cdnipOZxo4744LWotqj4=;
	h=From:To:Cc:Subject:Date:From;
	b=nzeA+gPMLe5J0bqILoQfZU1iWK8ai/gmolkJBC3Ji+NLDzuSA04MK87O0h1406y3T
	 TvZnFmzq2IN6tLfGf4Rw3cFVKQoAEWi8xXx2IzKot30VszG4W6TMy1koM+TObVe+Pg
	 1RCx3pSODrnLqmcdFZiEpjbmFRTx33rXhoUnpKhXqWtHBhiRrbBYADSl2PJAcIKXes
	 x8UazYHMWlQ4uEvo34qZx9P9w5/pySPAIge1afEgjVbaiG3qlstQ6qaED42k4gXiJ7
	 5gYDyd/SWROsNLcb1dtwf18RFzYud5x4ixriKN4awycLw5dbWQ8Zpdj1sm+h9UIqh+
	 eQaomVqR5l8gw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet: implement unique discovery NQN
Date: Mon, 11 Dec 2023 09:10:33 +0100
Message-Id: <20231211081033.14529-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_001038_394439_9B5E304F 
X-CRM114-Status: GOOD (  11.25  )
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

Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
directory to specify the unique discovery NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 45 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 ++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d937fe05129e..88911d0cd057 100644
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
@@ -2131,7 +2136,47 @@ static const struct config_item_type nvmet_hosts_type = {
 
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
+	size_t len;
+	struct list_head *entry;
+
+	len = strcspn(page, "\n");
+	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
+		struct config_item *item = container_of(entry, struct config_item, ci_entry);
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


