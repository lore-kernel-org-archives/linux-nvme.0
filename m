Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJh5r+zaR3hYg7Pukex70knTH6tRKZdY0dbcdYIAH58=; b=a6ZsKTuABFBZUaS+/YQvvSwNHF
	dXVc0FUdGKY6wyg+mAazeRTdKxDzAFwPHgBOg8sx7yasKSK9TPL2q/y4zYOSt++0cOtuh9Pa0+rNe
	J7N/Yv0qPLr32nVOBdQXwItSgTvjjvDKAe4FfGYdEE9AmNCPkSJ0Aa2lKo69F8lRTUtGFMBeiztQe
	zA1tO+U03zfV2++bPVTX+1VTvAfWvy5jWtahK5ykVq7X5KWyqfHQOaXYpU+RnXI/Jd6VpY6swwfjg
	CwST7tu4ggPRjnF50YdZ5T+XQCOa86ZsYJAoQ+f/+YC893Zys9iqhJSc1him+HWLaFF3gvkd4nN4+
	ISAclk+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh6d4-008KVj-Dl; Wed, 20 Apr 2022 09:28:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh6ch-008KJx-Fk
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 09:27:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9F4B21F752;
 Wed, 20 Apr 2022 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650446858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJh5r+zaR3hYg7Pukex70knTH6tRKZdY0dbcdYIAH58=;
 b=NGNLLkHIncCSP/9DBUku2+KxVT4QU/1hNPul9NmFZ4+ox0afLJ/tRKuDuzF1yi3316zM0Z
 g89LhgLZ68svIoxk37M+cYlZwBxpkHHnBmO1CZhrqLWaKqxbfeUYgmgP9BoPmb3afwYQO9
 qdWIvfIvJDz08Hd0v7RAP3oRMPNQEr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650446858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJh5r+zaR3hYg7Pukex70knTH6tRKZdY0dbcdYIAH58=;
 b=bbvkNCmodnK/QH+307dEqWhmsrx9bvpCvnwL/ah3Z6SNcnA166BY7Vpd6kiJ+5fQ9rWr2D
 JVKFGQsSTU3AoXCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 8D90A2C152;
 Wed, 20 Apr 2022 09:27:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 856B95193E82; Wed, 20 Apr 2022 11:27:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] nvmet: expose discovery subsystem
Date: Wed, 20 Apr 2022 11:27:30 +0200
Message-Id: <20220420092730.35101-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220420092730.35101-1-hare@suse.de>
References: <20220420092730.35101-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_022743_697123_CB77E477 
X-CRM114-Status: GOOD (  18.71  )
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

Add a module option 'expose_discovery_subsys' to expose the
default discovery subsystem via configfs.
When this option is enabled the internal discovery subsystem
is disabled, and the admin has to create a discovery
subsystem manually.
The discovery subsystem then has to be linked into the ports
which should present the discovery subsystem.

o- /
  o- ports
  | o- 2
  |   o- subsystems
  |     o- nqn.io-2
  | o- 3
  |   o- subsystems
  |     o- nqn.2014-08.org.nvmexpress.discovery
  |     o- nqn.io-1
  o- subsystems
    o- nqn.2014-08.org.nvmexpress.discovery
    | o- namespaces
    o- nqn.io-1
    | o- namespaces
    o- nqn.io-2
      o- namespaces

So in this example the standard discovery service would be available on
port 3, presenting information about subsystem nqn.io-1.
Port 2 would not present a discovery service, but a controller can connect
to subsystem nqn.io-2 on that port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 10 +++++++---
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/discovery.c | 20 +++++++++++++++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 44573fe0dfe4..365d374d809d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1364,13 +1364,17 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
 	struct nvmet_subsys *subsys;
+	enum nvme_subsys_type subsys_type = NVME_NQN_NVME;
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
-		pr_err("can't create discovery subsystem through configfs\n");
-		return ERR_PTR(-EINVAL);
+		if (nvmet_disc_subsys) {
+			pr_err("can't create discovery subsystem through configfs\n");
+			return ERR_PTR(-EINVAL);
+		}
+		subsys_type = NVME_NQN_CURR;
 	}
 
-	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys = nvmet_subsys_alloc(name, subsys_type);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index afd80999a335..ab458ff516db 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1505,7 +1505,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 
 		disc_subsys = port->disc_subsys ?
 			port->disc_subsys : nvmet_disc_subsys;
-		if (!kref_get_unless_zero(&disc_subsys->ref))
+		if (!disc_subsys || !kref_get_unless_zero(&disc_subsys->ref))
 				return NULL;
 		return disc_subsys;
 	}
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index ea8fce538342..3b94b60056cf 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -12,6 +12,11 @@ struct nvmet_subsys *nvmet_disc_subsys;
 
 static u64 nvmet_genctr;
 
+static int expose_discovery_subsys;
+module_param(expose_discovery_subsys, int, 0644);
+MODULE_PARM_DESC(expose_discovery_subsys,
+		 "Expose discovery subsytem in configfs");
+
 static void __nvmet_disc_changed(struct nvmet_port *port,
 				 struct nvmet_ctrl *ctrl)
 {
@@ -36,6 +41,8 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 
 	disc_subsys = port->disc_subsys ?
 		port->disc_subsys : nvmet_disc_subsys;
+	if (!disc_subsys)
+		return;
 
 	mutex_lock(&disc_subsys->lock);
 	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
@@ -59,6 +66,8 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 
 	disc_subsys = port->disc_subsys ?
 		port->disc_subsys : nvmet_disc_subsys;
+	if (!disc_subsys)
+		return;
 
 	mutex_lock(&disc_subsys->lock);
 
@@ -180,7 +189,7 @@ static size_t discovery_log_entries(struct nvmet_req *req)
 	struct nvmet_port *r;
 	size_t entries = 0;
 
-	if (!req->port->disc_subsys)
+	if (!req->port->disc_subsys && nvmet_disc_subsys)
 		entries++;
 
 	list_for_each_entry(r, nvmet_ports, global_entry) {
@@ -247,7 +256,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
-	if (!req->port->disc_subsys) {
+	if (!req->port->disc_subsys && nvmet_disc_subsys) {
 		nvmet_format_discovery_entry(hdr, req->port,
 				nvmet_disc_subsys->subsysnqn,
 				traddr, NVME_NQN_CURR, numrec);
@@ -441,6 +450,10 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 
 int __init nvmet_init_discovery(void)
 {
+	if (expose_discovery_subsys) {
+		nvmet_disc_subsys = NULL;
+		return 0;
+	}
 	nvmet_disc_subsys =
 		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_CURR);
 	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);
@@ -448,5 +461,6 @@ int __init nvmet_init_discovery(void)
 
 void nvmet_exit_discovery(void)
 {
-	nvmet_subsys_put(nvmet_disc_subsys);
+	if (nvmet_disc_subsys)
+		nvmet_subsys_put(nvmet_disc_subsys);
 }
-- 
2.29.2


