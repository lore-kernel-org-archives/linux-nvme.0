Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF2EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xfsnsGgtGGPu1WdagVd6CkLNhuefZ2Tr3jhSiRKb1k=; b=XVnixRyQYjyRfuujYjDmERQxem
	XcUUdIVdDmWLnVQDrmzhSg9fGvYEvjR5pQqO9taMnfLZQyEk7uZ/vHYAzxLdOCm43PaV93f/NpEv3
	hDA94gKTt/Qx+2OkJWrSiv0ZWmyWr/rpci3ddZ6m9WsLIzKBRyMIq5iqJ+w3Dt6IydgN379NHGWoW
	t4Oyy6r2aYjjqBo93akquYsavRM8RcUjLZ07FFie6vr73mncO9t2IWf1F/vD+pxiWaXsxXMNVkltY
	jH30fM+s9yR+acKaJgeu9w4QtpInpDpP2L+Js67/UWjWf/0Z+iGZ0fJD4/ogyFOKJAuxzkUerBlOt
	F3Esbgtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncPnp-00BOmU-UQ; Thu, 07 Apr 2022 10:55:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncPgT-00BLj1-M8
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 10:48:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 109271F85E;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649328491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xfsnsGgtGGPu1WdagVd6CkLNhuefZ2Tr3jhSiRKb1k=;
 b=KKMylsslxDatoLl4A3U+TFwUkroYwBH51C8KgiJVMn4HMoQvMkay9wAadwzrq+AYSxdNh7
 paxLzRTAXrQJStqxTuTFNCu1i0I1aCBy+ysMOhhGznHKoxtznsV51leeIokA35a2/TSSPK
 qtiAfnsvFvrxW6bFixtiShFl8eO9LlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649328491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xfsnsGgtGGPu1WdagVd6CkLNhuefZ2Tr3jhSiRKb1k=;
 b=WA0viGD5Lnl1rTZR3O9HVJ8AmouvVRInRiHg6v/7q6jXJIm4QuHzUWB0UChH8gRoWkLCiM
 LcWtP6mL+iZROoAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 04AECA3B97;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id E3B6D5193BE7; Thu,  7 Apr 2022 12:48:10 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvmet: per-port discovery subsystem
Date: Thu,  7 Apr 2022 12:48:07 +0200
Message-Id: <20220407104808.29007-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220407104808.29007-1-hare@suse.de>
References: <20220407104808.29007-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_034814_080991_92B056CC 
X-CRM114-Status: GOOD (  17.81  )
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

Add a 'disc_subsys' pointer to each port to specify which discovery
subsystem to use.
The pointer is set when a discovery subsystem is linked into a port,
and reset to the original, built-in discovery subsystem if that link
is removed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 11 +++++++++++
 drivers/nvme/target/core.c      |  6 +++---
 drivers/nvme/target/discovery.c | 32 +++++++++++++++++++-------------
 drivers/nvme/target/nvmet.h     |  1 +
 4 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 07c2d563d11b..a3af14e687f2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	link->subsys = subsys;
 
 	down_write(&nvmet_config_sem);
+	if (subsys->type == NVME_NQN_CURR &&
+	    port->disc_subsys != nvmet_disc_subsys) {
+		pr_err("discovery subsystem already present\n");
+		ret = -EAGAIN;
+		goto out_free_link;
+	}
 	ret = -EEXIST;
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (p->subsys == subsys)
@@ -834,6 +840,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	}
 
 	list_add_tail(&link->entry, &port->subsystems);
+	if (subsys->type == NVME_NQN_CURR)
+		port->disc_subsys = subsys;
 	nvmet_port_disc_changed(port, subsys);
 
 	up_write(&nvmet_config_sem);
@@ -864,6 +872,8 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 	list_del(&p->entry);
 	nvmet_port_del_ctrls(port, subsys);
 	nvmet_port_disc_changed(port, subsys);
+	if (port->disc_subsys == subsys)
+		port->disc_subsys = nvmet_disc_subsys;
 
 	if (list_empty(&port->subsystems))
 		nvmet_disable_port(port);
@@ -1690,6 +1700,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
+	port->disc_subsys = nvmet_disc_subsys;
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..cb69ca04c6c7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1496,9 +1496,9 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		return NULL;
 
 	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
-		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
-			return NULL;
-		return nvmet_disc_subsys;
+		if (!kref_get_unless_zero(&port->disc_subsys->ref))
+				return NULL;
+		return port->disc_subsys;
 	}
 
 	down_read(&nvmet_config_sem);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index b5012df790d5..e3d8cc407a94 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -29,18 +29,19 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 			     struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys = port->disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
 	nvmet_genctr++;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
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
@@ -48,19 +49,19 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
-					struct nvmet_subsys *subsys,
 					struct nvmet_host *host)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys = port->disc_subsys;
 
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
@@ -76,7 +77,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
 				continue;
-			__nvmet_subsys_disc_changed(port, subsys, host);
+			__nvmet_subsys_disc_changed(port, host);
 		}
 }
 
@@ -146,7 +147,10 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
-	size_t entries = 1;
+	size_t entries = 0;
+
+	if (req->port->disc_subsys == nvmet_disc_subsys)
+		entries++;
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
@@ -208,10 +212,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
-	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
-				     traddr, NVME_NQN_CURR, numrec);
-	numrec++;
+	if (req->port->disc_subsys == nvmet_disc_subsys) {
+		nvmet_format_discovery_entry(hdr, req->port,
+				nvmet_disc_subsys->subsysnqn,
+				traddr, NVME_NQN_CURR, numrec);
+		numrec++;
+	}
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..e9a2f3257195 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -144,6 +144,7 @@ struct nvmet_port {
 	struct list_head		global_entry;
 	struct config_group		ana_groups_group;
 	struct nvmet_ana_group		ana_default_group;
+	struct nvmet_subsys		*disc_subsys;
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
-- 
2.29.2


