Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D4C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:19:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F2A20578
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6/jKgrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F2A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DNHE4xS0MZ5812AyeqmdOpBabuGr8MLCCAQeSuYP+Rc=; b=s6/jKgrSopgeO2
	aIjs+wPdO+XIw4fP0/GNxWzXC1mpbW5u3yD6ldKQj5i1fonXnE61EbpPwMr1Z/xv/e44GO2O2Ry3V
	+hbyI+zWaPkOKZ/UNVrfPpAN5BgpTyqUe+liOxQBI0Y7gRlKThGc68EV1l3ui11eY/oIF/LH46gST
	m4kNifvOjkaOknSEJ1thAN5SyCTjeb/5POlrwGMepDer8YqTMbHFOjo7bZfiw3s0beN2K3Op5YpQy
	TW4NTlMLTcDSsT3E5+mqcPnVEnZFrrU5T0ZIhwTCA7CZPc3UjcxIwqvZjhX1YNIoS60vAZ34GEE/V
	+a8/DC5SB1UEirPTRj8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHsdQ-0002A3-AW; Fri, 27 Mar 2020 17:19:08 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaI-0007ry-VE
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:16:04 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:48 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjjH004869;
 Fri, 27 Mar 2020 20:15:47 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 14/17] nvmet: Add metadata/T10-PI support
Date: Fri, 27 Mar 2020 20:15:42 +0300
Message-Id: <20200327171545.98970-16-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_101555_502931_0DEE122B 
X-CRM114-Status: GOOD (  12.74  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Expose the namespace metadata format when PI is enabled. The user needs
to enable the capability per subsystem and per port. The other metadata
properties are taken from the namespace/bdev.

Usage example:
echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable
echo 1 > /config/nvmet/ports/${PORT_NUM}/param_pi_enable

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/admin-cmd.c   | 19 ++++++++++--
 drivers/nvme/target/configfs.c    | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c | 11 +++++++
 drivers/nvme/target/nvmet.h       | 26 +++++++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 24ed5b2..8a2c059 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -432,9 +432,13 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	strlcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
-	/* Max command capsule size is sqe + single page of in-capsule data */
+	/*
+	 * Max command capsule size is sqe + single page of in-capsule data.
+	 * Disable inline data for Metadata capable controllers.
+	 */
 	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
-				  req->port->inline_data_size) / 16);
+				  req->port->inline_data_size *
+				  !ctrl->pi_support) / 16);
 	/* Max response capsule size is cqe */
 	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
 
@@ -464,6 +468,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
@@ -520,6 +525,16 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
+			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
+			  NVME_NS_DPC_PI_TYPE3;
+		id->mc = NVME_NS_MC_META_EXT;
+		id->dps = ns->md_type;
+		id->flbas = NVME_NS_FLBAS_META_EXT;
+		id->lbaf[0].ms = ns->ms;
+	}
+
 	if (ns->readonly)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7aa1078..19bf240 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -248,6 +248,36 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, param_inline_data_size);
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static ssize_t nvmet_param_pi_enable_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->pi_enable);
+}
+
+static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	bool val;
+
+	if (strtobool(page, &val))
+		return -EINVAL;
+
+	if (port->enabled) {
+		pr_err("Disable port before setting pi_enable value.\n");
+		return -EACCES;
+	}
+
+	port->pi_enable = val;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_pi_enable);
+#endif
+
 static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
@@ -987,6 +1017,31 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
+						char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n", to_subsys(item)->pi_support);
+}
+
+static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
+						 const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	bool pi_enable;
+
+	if (strtobool(page, &pi_enable))
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	subsys->pi_support = pi_enable;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
+#endif
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
@@ -994,6 +1049,9 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&nvmet_subsys_attr_attr_pi_enable,
+#endif
 	NULL,
 };
 
@@ -1289,6 +1347,9 @@ static void nvmet_port_release(struct config_item *item)
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&nvmet_attr_param_pi_enable,
+#endif
 	NULL,
 };
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 52a6f70..799de18 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -197,6 +197,17 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	if (ctrl->subsys->pi_support && ctrl->port->pi_enable) {
+		if (ctrl->port->pi_capable) {
+			ctrl->pi_support = true;
+			pr_info("controller %d T10-PI enabled\n", ctrl->cntlid);
+		} else {
+			ctrl->pi_support = false;
+			pr_warn("T10-PI is not supported on controller %d\n",
+				ctrl->cntlid);
+		}
+	}
+
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	status = nvmet_install_queue(ctrl, req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e7954d9..b976aad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -145,6 +145,8 @@ struct nvmet_port {
 	bool				enabled;
 	int				inline_data_size;
 	const struct nvmet_fabrics_ops	*tr_ops;
+	bool				pi_capable;
+	bool				pi_enable;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -204,6 +206,7 @@ struct nvmet_ctrl {
 	spinlock_t		error_lock;
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
+	bool			pi_support;
 };
 
 struct nvmet_subsys_model {
@@ -233,6 +236,7 @@ struct nvmet_subsys {
 	u64			ver;
 	u64			serial;
 	char			*subsysnqn;
+	bool			pi_support;
 
 	struct config_group	group;
 
@@ -513,6 +517,28 @@ static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
+{
+	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) * req->ns->ms;
+}
+
+static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
+{
+	return ns->md_type && ns->ms == sizeof(struct t10_pi_tuple);
+}
+#else
+static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
+{
+	return 0;
+}
+
+static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 {
 	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
