Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C62DCD4F26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XscuRBpcvLQ03mqrlCNRpOYlxDudnTTrjNuap5LaMIg=; b=e9CAosbgKOqaFKfX7h8yrcwtT4
	u00HZBEWLTbH3TBhIx+l9pvT9EpXsL6KZIp0L8ooI6nXsjLtl57gJzS6kqNQ0t2KZS3D/HmdAnziV
	inBGl9RBbnUkOLSG3l9ZSimQAI4m7gdTGMef1/cQlHB4BkJD3/98GmQgB2aVUHkhMl26Qlb7E1gPH
	YgNlZG3vdHfLaEAPsh5orKNZsil6RCG9oqdQvwoY5iCdPTUUyzzUGEc+FjbEBAury3gb1lV8uzkYQ
	bmcqp8I7kKwhtWrJ8SaXA3z5zy92E4I4efDpsCEFNopARJkzFOuw+eeLe7XaP6563g7EJ1VKPBDZj
	aX34STdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxFE-00000005zcR-3PIZ;
	Tue, 23 Jun 2026 09:16:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxFC-00000005zaW-2HIo
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B09326020A;
	Tue, 23 Jun 2026 09:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8751F000E9;
	Tue, 23 Jun 2026 09:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206193;
	bh=XscuRBpcvLQ03mqrlCNRpOYlxDudnTTrjNuap5LaMIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J6tPrSrnYVEygR2vfGtaAkPjnWKzq17EeF7OGUmtu2U2mzYwVfPMlwjL2SXkcqIIb
	 O+uGPhINX+cJJlgkL9CAaIj+Sinm1huzlD51dbyF2NJD5hVrTY4m3AdpTaP01kK6AZ
	 xGOZKWlRuKuqbAdjRATwA9a+vkwXQAEIsbAFNp/tk7+1NtCal29wKqa3obV7fY/nWs
	 lhcC1oZ8ctzY7qEs8/A3kd0nT4bI3FzY2NDxUNhl+PYFEYB8VPsracU+60RCUUrJLD
	 Yqnx2w0XDY3K7y3N98Syiwv8KNRUFv524wyQ36143wN1MQLsu+AcJM7IzhwzgoXZ9U
	 pZQdYFNoMaFzg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:56 +0200
Subject: [PATCH RFC v3 11/12] nvmet: make configfs setup namespace aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-11-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=5861;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Y0Wtl4b41J/T5qByGGWHfuUH6u3u/rhYzej/TdOBvy0=;
 b=QioP/jbEMzBTXD8S5J+a7RU/k3khEH9VfWrXPVGtAXOC55YG/n21qEDxLI3TCHkoOCDmEfD5y
 Nz8mYOopvrXD7P5e06iJgoVKuQlR4qWkickLQW2QdIudaB5f2rnQuYF
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
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

Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
nvmet configfs namespace aware.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c | 103 +++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9c761a7f98496d59aa993e3663f0b3da63b6d3c1..0c0f7719336d80e57a007e74ed542f6276f57fa0 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1780,6 +1780,7 @@ static void nvmet_subsys_release(struct config_item *item)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
+	configfs_remove_default_groups(&subsys->group);
 	nvmet_subsys_del_ctrls(subsys);
 	nvmet_subsys_put(subsys);
 }
@@ -2072,6 +2073,7 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	nvmet_del_port_list(port);
 
+	configfs_remove_default_groups(&port->group);
 	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
@@ -2185,9 +2187,6 @@ static const struct config_item_type nvmet_ports_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_subsystems_group;
-static struct config_group nvmet_ports_group;
-
 #ifdef CONFIG_NVME_TARGET_AUTH
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
@@ -2369,8 +2368,6 @@ static const struct config_item_type nvmet_hosts_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_hosts_group;
-
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
@@ -2384,9 +2381,11 @@ static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct config_item *subsystems_item;
+	struct config_group *subsystems_group;
 	struct nvmet_subsys *disc_subsys;
 	struct list_head *entry;
-	char *old_nqn, *new_nqn;
+	char *old_nqn = NULL, *new_nqn;
 	size_t len;
 
 	len = strcspn(page, "\n");
@@ -2398,7 +2397,14 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		return -ENOMEM;
 
 	down_write(&nvmet_config_sem);
-	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
+	subsystems_item = config_group_find_item(to_config_group(item), "subsystems");
+	if (WARN_ON(!subsystems_item)) {
+		kfree(new_nqn);
+		up_write(&nvmet_config_sem);
+		return -EINVAL;
+	}
+	subsystems_group = to_config_group(subsystems_item);
+	list_for_each(entry, &subsystems_group->cg_children) {
 		struct config_item *item =
 			container_of(entry, struct config_item, ci_entry);
 
@@ -2432,6 +2438,69 @@ static const struct config_item_type nvmet_root_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static int nvmet_configfs_fill_subsystem(struct configfs_subsystem *subsys,
+					 struct net *net_ns)
+{
+	struct config_group *subsystems_group, *ports_group, *hosts_group;
+	int err;
+
+	err = nvmet_add_disc_subsys(net_ns);
+	if (err < 0)
+		return err;
+
+	subsystems_group = kzalloc_obj(*subsystems_group);
+	if (!subsystems_group) {
+		nvmet_del_disc_subsys(net_ns);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(subsystems_group,
+			"subsystems", &nvmet_subsystems_type);
+	configfs_add_default_group(subsystems_group,
+			&subsys->su_group);
+
+	ports_group = kzalloc_obj(*ports_group);
+	if (!ports_group) {
+		kfree(subsystems_group);
+		nvmet_del_disc_subsys(net_ns);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(ports_group,
+			"ports", &nvmet_ports_type);
+	configfs_add_default_group(ports_group,
+			&subsys->su_group);
+
+	hosts_group = kzalloc_obj(*hosts_group);
+	if (!hosts_group) {
+		kfree(ports_group);
+		kfree(subsystems_group);
+		nvmet_del_disc_subsys(net_ns);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(hosts_group,
+			"hosts", &nvmet_hosts_type);
+	configfs_add_default_group(hosts_group,
+			&subsys->su_group);
+	strscpy(subsys->su_group.cg_item.ci_namebuf, "nvmet",
+		sizeof(subsys->su_group.cg_item.ci_namebuf));
+	subsys->su_group.cg_item.ci_type = &nvmet_root_type;
+
+	return 0;
+}
+
+static void nvmet_configfs_clear_subsystem(struct configfs_subsystem *subsys,
+					   struct net *net_ns)
+{
+	struct config_group *g, *n;
+
+	list_for_each_entry_safe(g, n, &subsys->su_group.default_groups,
+				 group_entry) {
+		list_del(&g->group_entry);
+		config_item_put(&g->cg_item);
+		kfree(g);
+	}
+	nvmet_del_disc_subsys(net_ns);
+}
+
 static struct configfs_subsystem nvmet_configfs_subsystem = {
 	.su_group = {
 		.cg_item = {
@@ -2439,30 +2508,14 @@ static struct configfs_subsystem nvmet_configfs_subsystem = {
 			.ci_type	= &nvmet_root_type,
 		},
 	},
+	.fill_subsystem = nvmet_configfs_fill_subsystem,
+	.clear_subsystem = nvmet_configfs_clear_subsystem,
 };
 
 int __init nvmet_init_configfs(void)
 {
 	int ret;
 
-	config_group_init(&nvmet_configfs_subsystem.su_group);
-	mutex_init(&nvmet_configfs_subsystem.su_mutex);
-
-	config_group_init_type_name(&nvmet_subsystems_group,
-			"subsystems", &nvmet_subsystems_type);
-	configfs_add_default_group(&nvmet_subsystems_group,
-			&nvmet_configfs_subsystem.su_group);
-
-	config_group_init_type_name(&nvmet_ports_group,
-			"ports", &nvmet_ports_type);
-	configfs_add_default_group(&nvmet_ports_group,
-			&nvmet_configfs_subsystem.su_group);
-
-	config_group_init_type_name(&nvmet_hosts_group,
-			"hosts", &nvmet_hosts_type);
-	configfs_add_default_group(&nvmet_hosts_group,
-			&nvmet_configfs_subsystem.su_group);
-
 	ret = configfs_register_subsystem(&nvmet_configfs_subsystem);
 	if (ret) {
 		pr_err("configfs_register_subsystem: %d\n", ret);

-- 
2.51.0


