Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F5C35274
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DTs7bp0q8Nzz2Mxw2IU1zirNQvTLc7eNkESe6pj0rRg=; b=LsI8VkZDEm55o/CNJKd6VtmQB6
	gzmzt94wFDXo0y53H0pUh3AXMf0UQyWFGSgiJduJODwj4gbrThJ3f4kKMgTcL31v5pJnC+/+xUZ+n
	20B/sNMbZdji8eHsFNuH1SsMdZjNUsXihM+ZitAzxaFyzh70LWrWbmrF3PGoAvuMUu+yZVg+jQWos
	m6pDj9Dby4PS9wcic75enSTsjxm+aUKVZw/9ish5b3USjbNRXBHfRu4bnM6QIgheNQiqwBgvtP/Cu
	IN+uAkjFAj5ASh3BKHndGFUr0TubHjLGjN/lI5mzeUWGYYQeN842QOtVWFDCoy+ooHKHjwyfQl0xa
	uDO27jGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7TZ-003GNE-27;
	Fri, 15 Dec 2023 12:39:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE7TV-003GMC-35
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 12:39:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 05459B8286F;
	Fri, 15 Dec 2023 12:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252C9C433C8;
	Fri, 15 Dec 2023 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702643967;
	bh=eNpT3eEZto//hFk7pH/jFcxr9BcLPu3sEufm4Xm3s6U=;
	h=From:To:Cc:Subject:Date:From;
	b=Dj3F8atWubUovxylSOGRPDAPNiRAHvsWwj0V6YR+MMTGkOpX5ni08Pwkye1rEXJWy
	 o6FlWlrlYicLcV68UJ2fb8hdV24gB6/zGr/nwsTyuJS84H82/FoD2pObiknaIcjD4c
	 4JrHxCbb2O0w0/wCaTEfdq5BENhU4rAmg5DoFoZDKsnoEQkABJOtkq5mVs3kj1L6g1
	 MxFZo6IQOpabg4Z+6t5CvVQnfPljIghQtdwJZTBh6ruCpDlNSXM5/BmLO7vBdTE/4J
	 psICmyetjWUF+Ar8CCTumo0AmFmoDuONT88Dkwk3ObrAb+RLUZQpiq+RuefpeAuTmy
	 SbIxnTEHMqq4g==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvmet: implement unique discovery NQN
Date: Fri, 15 Dec 2023 13:39:29 +0100
Message-Id: <20231215123929.172940-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_043930_319120_2E01FEB5 
X-CRM114-Status: GOOD (  11.08  )
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


