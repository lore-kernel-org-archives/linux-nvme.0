Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C0C3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 16:00:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0452206D9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 16:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="StWvym/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0452206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wXhsHox/cZjGag76Uw0x2YHRAKwCLU1KXMB5rq5O/M=; b=StWvym/3RIsF86
	W4VUAfPblnHehDklrRpw1P4AplRCUH4q2n/J5LW9L5MuA6TVWEifx8DwXWj6iglCNfbMRh2YDa0Qy
	sHnHfiGeUglKurkOAKXKzQ6zKBq6wbvItfqasf6QmpLB4SjCe6e0zg/Q9cCz0l4naMT3iIsMN7idR
	/BLZjni2w1/mBkj18siyacSwP0hWS2PncOIvEgAKA8LlbZ1jC2kK2wJKB6OoYJJeyUxJzEcZrsN+3
	SGooZAxi3pW8QoPLHy9S0bERtfdYPmGyDLoFxyzopKq7dJPP7+c8usbq6Cwm1fuZev0N9Gq7bAqA9
	7j7HHzqbPw+5g/8/c0Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVdWZ-0006f8-Jg; Mon, 04 May 2020 16:00:55 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVdTr-00011G-9s
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 15:58:14 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 4 May 2020 18:57:57 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 044FvtCQ017882;
 Mon, 4 May 2020 18:57:57 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 14/16] nvmet: add metadata/T10-PI support
Date: Mon,  4 May 2020 18:57:53 +0300
Message-Id: <20200504155755.221125-15-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200504155755.221125-1-maxg@mellanox.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_085807_763354_1D3FF16E 
X-CRM114-Status: GOOD (  16.66  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
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
 drivers/nvme/target/admin-cmd.c   | 26 +++++++++++++++---
 drivers/nvme/target/configfs.c    | 58 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 21 +++++++++++---
 drivers/nvme/target/fabrics-cmd.c |  7 +++--
 drivers/nvme/target/nvmet.h       | 19 +++++++++++++
 5 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 905aba8..9c8a00d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -341,6 +341,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
+	u32 cmd_capsule_size;
 	u16 status = 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -433,9 +434,15 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	strlcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
-	/* Max command capsule size is sqe + single page of in-capsule data */
-	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
-				  req->port->inline_data_size) / 16);
+	/*
+	 * Max command capsule size is sqe + in-capsule data size.
+	 * Disable in-capsule data for Metadata capable controllers.
+	 */
+	cmd_capsule_size = sizeof(struct nvme_command);
+	if (!ctrl->pi_support)
+		cmd_capsule_size += req->port->inline_data_size;
+	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
+
 	/* Max response capsule size is cqe */
 	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
 
@@ -465,6 +472,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
@@ -482,7 +490,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
 	if (!ns)
 		goto done;
 
@@ -526,6 +534,16 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
+			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
+			  NVME_NS_DPC_PI_TYPE3;
+		id->mc = NVME_MC_EXTENDED_LBA;
+		id->dps = ns->pi_type;
+		id->flbas = NVME_NS_FLBAS_META_EXT;
+		id->lbaf[0].ms = ns->metadata_size;
+	}
+
 	if (ns->readonly)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58cabd7..42e5f61 100644
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
@@ -987,6 +1017,28 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
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
+	subsys->pi_support = pi_enable;
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
+#endif
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
@@ -994,6 +1046,9 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&nvmet_subsys_attr_attr_pi_enable,
+#endif
 	NULL,
 };
 
@@ -1297,6 +1352,9 @@ static void nvmet_port_release(struct config_item *item)
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&nvmet_attr_param_pi_enable,
+#endif
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 50dfc60..9f6b0f9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -322,12 +322,21 @@ int nvmet_enable_port(struct nvmet_port *port)
 	if (!try_module_get(ops->owner))
 		return -EINVAL;
 
-	ret = ops->add_port(port);
-	if (ret) {
-		module_put(ops->owner);
-		return ret;
+	/*
+	 * If the user requested PI support and the transport isn't pi capable,
+	 * don't enable the port.
+	 */
+	if (port->pi_enable && !ops->metadata_support) {
+		pr_err("T10-PI is not supported by transport type %d\n",
+		       port->disc_addr.trtype);
+		ret = -EINVAL;
+		goto out_put;
 	}
 
+	ret = ops->add_port(port);
+	if (ret)
+		goto out_put;
+
 	/* If the transport didn't set inline_data_size, then disable it. */
 	if (port->inline_data_size < 0)
 		port->inline_data_size = 0;
@@ -335,6 +344,10 @@ int nvmet_enable_port(struct nvmet_port *port)
 	port->enabled = true;
 	port->tr_ops = ops;
 	return 0;
+
+out_put:
+	module_put(ops->owner);
+	return ret;
 }
 
 void nvmet_disable_port(struct nvmet_port *port)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 52a6f70..42bd12b 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -197,6 +197,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
+
 	uuid_copy(&ctrl->hostid, &d->hostid);
 
 	status = nvmet_install_queue(ctrl, req);
@@ -205,8 +207,9 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	pr_info("creating controller %d for subsystem %s for NQN %s.\n",
-		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
+	pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
+		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
+		ctrl->pi_support ? " T10-PI is enabled" : "");
 	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ceedaaf..2986e2c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -145,6 +145,7 @@ struct nvmet_port {
 	bool				enabled;
 	int				inline_data_size;
 	const struct nvmet_fabrics_ops	*tr_ops;
+	bool				pi_enable;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -204,6 +205,7 @@ struct nvmet_ctrl {
 	spinlock_t		error_lock;
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
+	bool			pi_support;
 };
 
 struct nvmet_subsys_model {
@@ -233,6 +235,7 @@ struct nvmet_subsys {
 	u64			ver;
 	u64			serial;
 	char			*subsysnqn;
+	bool			pi_support;
 
 	struct config_group	group;
 
@@ -284,6 +287,7 @@ struct nvmet_fabrics_ops {
 	unsigned int type;
 	unsigned int msdbd;
 	bool has_keyed_sgls : 1;
+	bool metadata_support : 1;
 	void (*queue_response)(struct nvmet_req *req);
 	int (*add_port)(struct nvmet_port *port);
 	void (*remove_port)(struct nvmet_port *port);
@@ -510,6 +514,14 @@ static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
+static inline u32 nvmet_rw_metadata_len(struct nvmet_req *req)
+{
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
+		return 0;
+	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) *
+			req->ns->metadata_size;
+}
+
 static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 {
 	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
@@ -524,4 +536,11 @@ static inline __le16 to0based(u32 a)
 	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
 }
 
+static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
+{
+	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
+		return false;
+	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
+}
+
 #endif /* _NVMET_H */
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
