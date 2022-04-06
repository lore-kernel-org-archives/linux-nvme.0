Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051D0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 14:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3TiZCS6NFzH35CZ7ZYVvB4uDZWV6AS22EWilauh9Ww=; b=X7Ls4PjbX87gvjnZT0rvVOcyXI
	f5Kdj/UXo0AfHHVCbzZfcd0Me2SUq0gnFzzOQSYZuqjgFSl6zKyijHpD+7sFVVdwUiU48AVLRF3GQ
	neozKLTSKCg2S21BSqXr6hCXFuXDBTPDUi8JCS81TJSYAhOzKGWhCQCE27GqRRtvXpj2AT0XX0314
	EemZSUqAtGw+0wLqMtw+4kzIsYx1CMvoGIAUP+VIdKhclIWMMguNZn6dUkdrZFQkKXz+NlPwz4MpE
	l9yXl8UIOcclQROttMKyU1FaZgI+ROWuAqdBqSyi8mkdMcs30y63WgZgLkaNVlM9nl5vr2PxQZHGA
	fRhNdN8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc6YR-006TZD-OG; Wed, 06 Apr 2022 14:22:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc6Y6-006TOB-Qd
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 14:22:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8093B21123;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649254935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3TiZCS6NFzH35CZ7ZYVvB4uDZWV6AS22EWilauh9Ww=;
 b=VkSss6iXtK2u5ri8RjC7QZe4riBZ2tmq9aDmqLmzA8pQYOXvqNHpnYcYOzjLrb0aeC/+cd
 qcUupOpubmDgVMivfffzYWbmwYhALpo0ubCZnoKZ9re7QFh+4KBCjJ0x5EUz+qcRDrUC/R
 BtQzyqPreLqgeLPLVKicZBGO5b9VHAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649254935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3TiZCS6NFzH35CZ7ZYVvB4uDZWV6AS22EWilauh9Ww=;
 b=yiS1aNfOGT+Qqaxbvl1DVle5EdLy2Qznrg8DoQi7FAXZmbUmBZACmQFaW1EPflmCvWjgRU
 gnCnjdiFhq3h1CBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 78F64A3B89;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 6A5A45193BAE; Wed,  6 Apr 2022 16:22:15 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvmet: expose discovery subsystems
Date: Wed,  6 Apr 2022 16:22:09 +0200
Message-Id: <20220406142210.71248-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220406142210.71248-1-hare@suse.de>
References: <20220406142210.71248-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_072219_170502_FCB154DB 
X-CRM114-Status: GOOD (  19.83  )
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

Add a module parameter 'expose_discovery_subsys' to allow creation
of discovery subsystems through configfs.
If the option is enabled no default discovery subsystem is created
per default, and the user is required to create one via configfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 26 ++++++++++++--
 drivers/nvme/target/core.c      | 19 ++++++++--
 drivers/nvme/target/discovery.c | 63 ++++++++++++++++++++++++++-------
 drivers/nvme/target/nvmet.h     |  2 ++
 4 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 31d2490264e3..1fd4d09e3db4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -20,6 +20,16 @@ static const struct config_item_type nvmet_subsys_type;
 static LIST_HEAD(nvmet_ports_list);
 struct list_head *nvmet_ports = &nvmet_ports_list;
 
+static int expose_discovery_subsys;
+module_param(expose_discovery_subsys, int, 0644);
+MODULE_PARM_DESC(expose_discovery_subsys,
+		 "Expose discovery subsytem in configfs");
+
+bool nvmet_expose_discovery_subsys(void)
+{
+	return expose_discovery_subsys;
+}
+
 struct nvmet_type_name_map {
 	u8		type;
 	const char	*name;
@@ -1264,6 +1274,11 @@ static ssize_t nvmet_subsys_attr_type_store(struct config_item *item,
 	if (subsys->subsys_discovered)
 		return -EACCES;
 
+	if (!expose_discovery_subsys) {
+		pr_err("Unique discovery subsystem NQNs are not enabled\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(nvmet_subsys_type_map); i++) {
 		if (sysfs_streq(page, nvmet_subsys_type_map[i].name))
 			goto found;
@@ -1348,13 +1363,18 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
 	struct nvmet_subsys *subsys;
+	enum nvme_subsys_type subsys_type = NVME_NQN_NVME;
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
-		pr_err("can't create discovery subsystem through configfs\n");
-		return ERR_PTR(-EINVAL);
+		if (expose_discovery_subsys)
+			subsys_type = NVME_NQN_CURR;
+		else {
+			pr_err("can't create discovery subsystem through configfs\n");
+			return ERR_PTR(-EINVAL);
+		}
 	}
 
-	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys = nvmet_subsys_alloc(name, subsys_type);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..2187af97c47e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1491,14 +1491,19 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
 	struct nvmet_subsys_link *p;
+	enum nvme_subsys_type subsys_type = NVME_NQN_NVME;
 
 	if (!port)
 		return NULL;
 
 	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
-		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
-			return NULL;
-		return nvmet_disc_subsys;
+		if (nvmet_expose_discovery_subsys())
+			subsys_type = NVME_NQN_CURR;
+		else {
+			if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
+				return NULL;
+			return nvmet_disc_subsys;
+		}
 	}
 
 	down_read(&nvmet_config_sem);
@@ -1510,6 +1515,13 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 			up_read(&nvmet_config_sem);
 			return p->subsys;
 		}
+		if (subsys_type == NVME_NQN_CURR &&
+		    p->subsys->type == subsys_type) {
+			if (!kref_get_unless_zero(&p->subsys->ref))
+				break;
+			up_read(&nvmet_config_sem);
+			return p->subsys;
+		}
 	}
 	up_read(&nvmet_config_sem);
 	return NULL;
@@ -1544,6 +1556,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
 		subsys->max_qid = 0;
+		subsys->allow_any_host = 1;
 		break;
 	default:
 		pr_err("%s: Unknown Subsystem type - %d\n", __func__, type);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index b5012df790d5..13fda8f9d60c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -29,18 +29,32 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 			     struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys = nvmet_disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
 	nvmet_genctr++;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	if (nvmet_expose_discovery_subsys()) {
+		struct nvmet_subsys_link *s;
+
+		disc_subsys = NULL;
+		list_for_each_entry(s, &port->subsystems, entry) {
+			if (s->subsys->type == NVME_NQN_CURR) {
+				disc_subsys = s->subsys;
+				break;
+			}
+		}
+		if (!disc_subsys)
+			return;
+	}
+	mutex_lock(&disc_subsys->lock);
+	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
 		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
-	mutex_unlock(&nvmet_disc_subsys->lock);
+	mutex_unlock(&disc_subsys->lock);
 
 	/* If transport can signal change, notify transport */
 	if (port->tr_ops && port->tr_ops->discovery_chg)
@@ -48,19 +62,33 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
-					struct nvmet_subsys *subsys,
 					struct nvmet_host *host)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys = nvmet_disc_subsys;
+
+	if (nvmet_expose_discovery_subsys()) {
+		struct nvmet_subsys_link *s;
+
+		disc_subsys = NULL;
+		list_for_each_entry(s, &port->subsystems, entry) {
+			if (s->subsys->type == NVME_NQN_CURR) {
+				disc_subsys = s->subsys;
+				break;
+			}
+		}
+		if (!disc_subsys)
+			return;
+	}
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	mutex_lock(&disc_subsys->lock);
+	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
 		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
-	mutex_unlock(&nvmet_disc_subsys->lock);
+	mutex_unlock(&disc_subsys->lock);
 }
 
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
@@ -76,7 +104,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
 				continue;
-			__nvmet_subsys_disc_changed(port, subsys, host);
+			__nvmet_subsys_disc_changed(port, host);
 		}
 }
 
@@ -146,7 +174,10 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
-	size_t entries = 1;
+	size_t entries = 0;
+
+	if (!nvmet_expose_discovery_subsys())
+		entries++;
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
@@ -208,10 +239,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
-	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
-				     traddr, NVME_NQN_CURR, numrec);
-	numrec++;
+	if (!nvmet_expose_discovery_subsys()) {
+		nvmet_format_discovery_entry(hdr, req->port,
+				nvmet_disc_subsys->subsysnqn,
+				traddr, NVME_NQN_CURR, numrec);
+		numrec++;
+	}
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
@@ -393,6 +426,8 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 
 int __init nvmet_init_discovery(void)
 {
+	if (nvmet_expose_discovery_subsys())
+		return 0;
 	nvmet_disc_subsys =
 		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_CURR);
 	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);
@@ -400,5 +435,7 @@ int __init nvmet_init_discovery(void)
 
 void nvmet_exit_discovery(void)
 {
+	if (nvmet_expose_discovery_subsys())
+		return;
 	nvmet_subsys_put(nvmet_disc_subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..4d51d5d95ffb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -532,6 +532,8 @@ extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
 extern u64 nvmet_ana_chgcnt;
 extern struct rw_semaphore nvmet_ana_sem;
 
+bool nvmet_expose_discovery_subsys(void);
+
 bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
-- 
2.29.2


