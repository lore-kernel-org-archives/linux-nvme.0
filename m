Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756AACDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoO2vvsD/W3NmrVG65QmB80w34/tcLTfioE9Iru78yA=; b=dqbxIZFsfw1ZyCJd2opkgpDEX1
	Tkv4Y0TC7R8NhJLJSAq/4UBLUU1mEk4fGH9mbmk0WKsprv2rl7esOcWshw56iV433uKqMB+frzstK
	nndIuUwCSjIkn7T8oWOHcjB9rd+KQvz0NqaQaFc2AH6oE9Ire0hhLiw7szieS8DzmnFuoqkUZShJN
	srpywPiL5fsJ94lxx0soDh1YR6Y7fdQapjjsxrGdVDTrx7FgCilJRB8ccm5bFjhODMKKdR7obNWT3
	TJtMltvqzxqpAWGab4BYtodt4Nn2VTA8QC+D+T1A7xXhGk+Xpws0ZcP1CXCltNxshkaVOZ4blVUZl
	pM59YJuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxFF-00000005zdc-47cW;
	Tue, 23 Jun 2026 09:16:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxFF-00000005zcV-0wz1
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C7316020A;
	Tue, 23 Jun 2026 09:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3EC1F00A3A;
	Tue, 23 Jun 2026 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206196;
	bh=FoO2vvsD/W3NmrVG65QmB80w34/tcLTfioE9Iru78yA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I57Mkn5XnZtx7iJeUM9RqGHZiLArsKfx7GP7NsIJq2EcLZrpHFPxPqyo5ptZ/P2VN
	 5JkX2tZeRPBa8dnBSUXUwhBzr2R63v8vi6NRqyaBwg6VWuxS1dXOt5RtxVZ2UQkVaV
	 td6dwmckkPZbS5sikHkVwNqXwFQ2wakRgYAXBe7KTVBJM6MFNNHeTqItp0L+mraAaI
	 lyn9HxlOsj8U9+xdx1E3FH3ZZ14GmilWY4+Lk0wagjm0xd4Zbe26BY7Cz+nriivj8U
	 FHQrw+nZZ9Bgi9I+RXAa18syCfQoGyGxUQR0Q98myDbt6bgwf/BAEYjzhDGgG0S34p
	 3k+H8DEw4/mvw==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:57 +0200
Subject: [PATCH RFC v3 12/12] nvmet: enable transports for net namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-12-841c100fd5dd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=12781;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=vU8DJf9e14U0YtgLVJ5aToe0Qos5ERGWDcuKB+wdbb4=;
 b=4OYP0GPkq/Bq+SfIAmONKQNq/Hzd5MzsB1qZBdxl3TsfN+p3lgMXYYFy3ArmlkCTfDqgvDJ3k
 hCUqzj6U1M9AHLGLG9ZrbQElSRMia7HRTz2h3c0C5W7/7OVS+3e6/1s
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

Add a net_ns pointer to the port and modify the transport target
drivers to select the corrent namespaces when creating ports.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c  | 19 +++++++++++++------
 drivers/nvme/target/core.c      | 12 ++++++++++--
 drivers/nvme/target/discovery.c | 13 +++++++------
 drivers/nvme/target/loop.c      |  4 ++++
 drivers/nvme/target/nvmet.h     |  3 ++-
 drivers/nvme/target/rdma.c      |  6 +++---
 drivers/nvme/target/tcp.c       |  6 +++---
 fs/configfs/mount.c             | 16 ++++++++++++++++
 include/linux/configfs.h        |  2 ++
 9 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 0c0f7719336d80e57a007e74ed542f6276f57fa0..7636ac3773b4002a4d68aa9d1e666d01129ced55 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -71,7 +71,7 @@ struct list_head *nvmet_get_port_list(struct net *net_ns)
 
 static int nvmet_add_port_list(struct nvmet_port *p)
 {
-	u64 ns_id = nvmet_get_ns_id(&init_net);
+	u64 ns_id = nvmet_get_ns_id(p->net_ns);
 	struct list_head *port_list;
 	int err = 0;
 
@@ -100,7 +100,7 @@ static int nvmet_add_port_list(struct nvmet_port *p)
 static void nvmet_del_port_list(struct nvmet_port *p)
 {
 	struct list_head *port_list;
-	u64 ns_id = nvmet_get_ns_id(&init_net);
+	u64 ns_id = nvmet_get_ns_id(p->net_ns);
 
 	xa_lock(&nvmet_ports_xa);
 	port_list = xa_load(&nvmet_ports_xa, ns_id);
@@ -1799,13 +1799,14 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
 	struct nvmet_subsys *subsys, *disc_subsys;
+	struct net *net_ns = configfs_ns_from_group(group);
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
 		pr_err("can't create discovery subsystem through configfs\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (!disc_subsys)
 		return ERR_PTR(-ENOENT);
 	if (sysfs_streq(name, disc_subsys->subsysnqn)) {
@@ -1813,7 +1814,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		return ERR_PTR(-EINVAL);
 	}
 
-	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME, net_ns);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
@@ -2125,6 +2126,10 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	port->net_ns = configfs_ns_from_group(group);
+	if (!port->net_ns)
+		port->net_ns = get_net(&init_net);
+
 	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
@@ -2371,7 +2376,8 @@ static const struct config_item_type nvmet_hosts_type = {
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
-	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(&init_net);
+	struct net *net_ns = configfs_ns_from_group(to_config_group(item));
+	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(net_ns);
 
 	if (!disc_subsys)
 		return -ENOENT;
@@ -2383,6 +2389,7 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 {
 	struct config_item *subsystems_item;
 	struct config_group *subsystems_group;
+	struct net *net_ns = configfs_ns_from_group(to_config_group(item));
 	struct nvmet_subsys *disc_subsys;
 	struct list_head *entry;
 	char *old_nqn = NULL, *new_nqn;
@@ -2415,7 +2422,7 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (disc_subsys) {
 		old_nqn = disc_subsys->subsysnqn;
 		disc_subsys->subsysnqn = new_nqn;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1831a218319b84a1e1a1cfba7fb48e3ad40b09f7..39989b8bae92f8e5b384a93c891b9f3e9900305e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1803,7 +1803,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (!disc_subsys)
 		return NULL;
 
@@ -1835,7 +1835,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 }
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type)
+		enum nvme_subsys_type type, struct net *net_ns)
 {
 	struct nvmet_subsys *subsys;
 	char serial[NVMET_SN_MAX_SIZE / 2];
@@ -1893,8 +1893,16 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	/* Disable debugfs for non-initial namespaces */
+	if (net_ns == &init_net) {
+		ret = nvmet_debugfs_subsys_setup(subsys);
+		if (ret)
+			goto free_subsysnqn;
+	}
 	return subsys;
 
+free_subsysnqn:
+	kfree(subsys->subsysnqn);
 free_fr:
 	kfree(subsys->firmware_rev);
 free_mn:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e929402314f66b635e330980d4d771b9474e7e3d..b4984fc65ba787456186a0c18ff8586f388fa50d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -26,7 +26,7 @@ int nvmet_add_disc_subsys(struct net *net_ns)
 	int err;
 
 	disc_subsys = nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME,
-					 NVME_NQN_CURR);
+					 NVME_NQN_CURR, net_ns);
 	if (IS_ERR(disc_subsys))
 		return PTR_ERR(disc_subsys);
 	err = xa_insert(&nvmet_disc_xa, ns_id,
@@ -67,7 +67,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	disc_subsys->genctr++;
@@ -93,7 +93,7 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 	struct nvmet_ctrl *ctrl;
 	struct nvmet_subsys *disc_subsys;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	mutex_lock(&disc_subsys->lock);
@@ -113,14 +113,15 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 	struct nvmet_subsys_link *s;
 	struct list_head *port_list;
 	struct nvmet_subsys *disc_subsys;
+	struct net *net_ns = configfs_ns_from_group(&subsys->group);
 
 	lockdep_assert_held(&nvmet_config_sem);
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	disc_subsys->genctr++;
 
-	port_list = nvmet_get_port_list(&init_net);
+	port_list = nvmet_get_port_list(net_ns);
 	list_for_each_entry(port, port_list, global_entry)
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
@@ -257,7 +258,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 	hdr = buffer;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(req->port->net_ns);
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index fcb1f8186fdd0d3e2a4d32c9e529ae0cf8d9d42a..0edd690902ce4bbdb692419e718204569ba48c6e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -9,6 +9,7 @@
 #include <linux/nvme.h>
 #include <linux/module.h>
 #include <linux/parser.h>
+#include <linux/nsproxy.h>
 #include "nvmet.h"
 #include "../host/nvme.h"
 #include "../host/fabrics.h"
@@ -538,6 +539,9 @@ static struct nvmet_port *nvme_loop_find_port(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&nvme_loop_ports_mutex);
 	list_for_each_entry(p, &nvme_loop_ports, entry) {
+		/* Skip ports from non-matching namespaces */
+		if (p->net_ns != current->nsproxy->net_ns)
+			continue;
 		/* if no transport address is specified use the first port */
 		if ((ctrl->opts->mask & NVMF_OPT_TRADDR) &&
 		    strcmp(ctrl->opts->traddr, p->disc_addr.traddr))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fc871b2b777d633dd64b6d339e124668fd760f8b..681f935d80086b610f137bd64fa27ed16296b3f3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -210,6 +210,7 @@ struct nvmet_port {
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
 	struct key			*keyring;
+	struct net			*net_ns;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
@@ -629,7 +630,7 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 		char *traddr, size_t traddr_len);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type);
+		enum nvme_subsys_type type, struct net *net_ns);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ac26f4f774c4de62e163ded12bded70edbab68f7..cad2391a6d0a78928d76d6d10d37f3348b708136 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1870,8 +1870,8 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 	struct rdma_cm_id *cm_id;
 	int ret;
 
-	cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
-			RDMA_PS_TCP, IB_QPT_RC);
+	cm_id = rdma_create_id(port->nport->net_ns, nvmet_rdma_cm_handler,
+			port, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
 		pr_err("CM ID creation failed\n");
 		return PTR_ERR(cm_id);
@@ -1964,7 +1964,7 @@ static int nvmet_rdma_add_port(struct nvmet_port *nport)
 		nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
 	}
 
-	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+	ret = inet_pton_with_scope(nport->net_ns, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
 		pr_err("malformed ip/port passed: %s:%s\n",
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15c52f1f95f1b040f380d01c0b7ad690355d91be..016bef65a76dd9004471fe8bbcd3550f5910137a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2074,7 +2074,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
-	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+	ret = inet_pton_with_scope(nport->net_ns, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
 		pr_err("malformed ip/port passed: %s:%s\n",
@@ -2087,8 +2087,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+	ret = sock_create_kern(nport->net_ns, port->addr.ss_family, SOCK_STREAM,
+			    IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 095a480b6ea27db9a43b067af7e6352fd0ae50ee..7941257d558b72f8f341501a516ceef7c28062f3 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -276,6 +276,22 @@ void configfs_release_fs(struct super_block *sb)
 	mntput(mnt);
 }
 
+struct net *configfs_ns_from_group(struct config_group *group)
+{
+	struct configfs_super_info *info = configfs_root;
+	struct net *net_ns = NULL;
+
+	if (group) {
+		struct dentry *dentry = group->cg_item.ci_dentry;
+
+		info = dentry->d_sb->s_fs_info;
+		if (info)
+			net_ns = info->net_ns;
+	}
+	return net_ns;
+}
+EXPORT_SYMBOL_GPL(configfs_ns_from_group);
+
 static int __init configfs_init(void)
 {
 	int err = -ENOMEM;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 893ae778585fb8be60026c661cb1ef63980ff0e3..76e0bb1a72b9dbbbb3695cfe6b282abb77d03f63 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -258,6 +258,8 @@ configfs_register_default_group(struct config_group *parent_group,
 				const struct config_item_type *item_type);
 void configfs_unregister_default_group(struct config_group *group);
 
+struct net *configfs_ns_from_group(struct config_group *group);
+
 /* These functions can sleep and can alloc with GFP_KERNEL */
 /* WARNING: These cannot be called underneath configfs callbacks!! */
 int configfs_depend_item(struct configfs_subsystem *subsys,

-- 
2.51.0


