Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD97C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 06:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOEB42yd5Z5Usk+ssmLsNw3rzqziiIYI6EYTF/teq6A=; b=QQyrbe4UoLyotjtfpNNBaW5B8U
	yV6dcjPHYoVm5jPrT8EwbKJwZVpTO8yPMhISBbia9A4ClxJKiXBnzL0+wLm/OMmB2EmY3rV+kGCy8
	Id/IPwPhWreAK+JsMGHWNgJIH5pkusAZ4TYyHct9AX9w3c129r1icrFAhfZ7W2vQzqwJqOA8cxBts
	7cu2Pdu/srKuP9V6RlXGy21uVP76H2NSAev3/DhVDe00yd/xPi10dP0Epq5HhJNsqDp34wS9eeIRi
	5ZBhqBze9I4Y5QXgNqk3Ma/uaxwIX4C+vu5K/4Wo6RwAT2g4jzbjwce/vHZ+c27meyzRMC1WpIKIu
	/J6ANffg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncib5-00FO0g-Fl; Fri, 08 Apr 2022 06:59:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncian-00FNud-Uj
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 06:59:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9A8F7215FF;
 Fri,  8 Apr 2022 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649401175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOEB42yd5Z5Usk+ssmLsNw3rzqziiIYI6EYTF/teq6A=;
 b=CYVluE40GEEHYYykdVIUANswfx76k8UC7ThPvubYDdsOPHS584J7cvZm/W5EQ5V+yCnlAw
 hi4HwFXmoyfxWFUsaqM8jDxIT3tWbx47U4nA5fmjZAggDl5hLRc+P7gaPMEuZZStVuiv5e
 p/OQq6/yg+3NGyqD7k+7i2mWPIdzKxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649401175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOEB42yd5Z5Usk+ssmLsNw3rzqziiIYI6EYTF/teq6A=;
 b=NxPsQaQR2Hfg6vZfD4OIywlz867vladRjULAfcyoYSS8SD3aLKGxYQ0DuiWeU3wMIbF6CL
 SzFOvxo9we55IwAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 8ECC9A3B88;
 Fri,  8 Apr 2022 06:59:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id BC9785193C09; Fri,  8 Apr 2022 08:59:34 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvmet: per-port discovery subsystem
Date: Fri,  8 Apr 2022 08:59:29 +0200
Message-Id: <20220408065930.123015-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220408065930.123015-1-hare@suse.de>
References: <20220408065930.123015-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_235938_226600_464093F9 
X-CRM114-Status: GOOD (  17.66  )
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
and reset if that link is removed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 10 +++++++++
 drivers/nvme/target/core.c      | 15 ++++++++++---
 drivers/nvme/target/discovery.c | 39 ++++++++++++++++++++++-----------
 drivers/nvme/target/nvmet.h     |  1 +
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 38b0ab9fb721..44573fe0dfe4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -821,6 +821,12 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	link->subsys = subsys;
 
 	down_write(&nvmet_config_sem);
+	if (subsys->type == NVME_NQN_CURR &&
+	    port->disc_subsys) {
+		pr_err("discovery subsystem already present\n");
+		ret = -EAGAIN;
+		goto out_free_link;
+	}
 	ret = -EEXIST;
 	list_for_each_entry(p, &port->subsystems, entry) {
 		if (p->subsys == subsys)
@@ -835,6 +841,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 
 	list_add_tail(&link->entry, &port->subsystems);
 	subsys->port_count++;
+	if (subsys->type == NVME_NQN_CURR)
+		port->disc_subsys = subsys;
 	nvmet_port_disc_changed(port, subsys);
 
 	up_write(&nvmet_config_sem);
@@ -866,6 +874,8 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 	subsys->port_count--;
 	nvmet_port_del_ctrls(port, subsys);
 	nvmet_port_disc_changed(port, subsys);
+	if (port->disc_subsys == subsys)
+		port->disc_subsys = NULL;
 
 	if (list_empty(&port->subsystems))
 		nvmet_disable_port(port);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 90e75324dae0..afd80999a335 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1495,10 +1495,19 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
+	/*
+	 * As per spec discovery subsystems with a unique NQN
+	 * have to respond to both NQNs, the unique NQN and the
+	 * standard discovery NQN.
+	 */
 	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
-		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
-			return NULL;
-		return nvmet_disc_subsys;
+		struct nvmet_subsys *disc_subsys;
+
+		disc_subsys = port->disc_subsys ?
+			port->disc_subsys : nvmet_disc_subsys;
+		if (!kref_get_unless_zero(&disc_subsys->ref))
+				return NULL;
+		return disc_subsys;
 	}
 
 	down_read(&nvmet_config_sem);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index b5012df790d5..6b8aa6c4e752 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -29,18 +29,22 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 			     struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
 	nvmet_genctr++;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	disc_subsys = port->disc_subsys ?
+		port->disc_subsys : nvmet_disc_subsys;
+
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
@@ -48,19 +52,23 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
-					struct nvmet_subsys *subsys,
 					struct nvmet_host *host)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys;
+
+	disc_subsys = port->disc_subsys ?
+		port->disc_subsys : nvmet_disc_subsys;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	mutex_lock(&disc_subsys->lock);
+
+	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
 		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
-	mutex_unlock(&nvmet_disc_subsys->lock);
+	mutex_unlock(&disc_subsys->lock);
 }
 
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
@@ -76,7 +84,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
 				continue;
-			__nvmet_subsys_disc_changed(port, subsys, host);
+			__nvmet_subsys_disc_changed(port, host);
 		}
 }
 
@@ -146,7 +154,10 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_subsys_link *p;
 	struct nvmet_port *r;
-	size_t entries = 1;
+	size_t entries = 0;
+
+	if (!req->port->disc_subsys)
+		entries++;
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
@@ -208,10 +219,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
-	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
-				     traddr, NVME_NQN_CURR, numrec);
-	numrec++;
+	if (!req->port->disc_subsys) {
+		nvmet_format_discovery_entry(hdr, req->port,
+				nvmet_disc_subsys->subsysnqn,
+				traddr, NVME_NQN_CURR, numrec);
+		numrec++;
+	}
 
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ecba3890ce65..8df297a190bf 100644
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


