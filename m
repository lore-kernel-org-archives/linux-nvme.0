Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8803C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:22:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3492087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2puG9Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3492087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qik42nBrJsRgwhwJXA4YRI5yi+aD8VXo7XcNhTB52S0=; b=i2puG9Ds9K1Rp+
	m77FrfSI0t7IMztCOjw2ozrdlfhxcQUWIFIovYZD4zSGoCfhFe/4TBvUtfaZ4bjAIPx3wNuLHin1U
	zM1FiM5fMtwDkWIp+HvC1KM1vGRzjo7n0f4gveFVs2npoVJo2Msj79jGU4Bi6ldzPLy+00oozbxIS
	f0tCmLhyyupngR3s6TspWxaY4VrjLcBYUGD1qnB/9wKiuA/agYjpN/6ZuWv+5MdRYqrOG4LNbN0a4
	/nz9uFLCIFlb4xltD0mTfebHx2f5ghb9QyF21I9w6st/XzTrPZP4cnJT4sd7bBiyddzu0sCM7tEn5
	JSFJ1Bzx42+Rk6uxIG/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS1bS-0005Mc-Ba; Tue, 05 Nov 2019 16:22:46 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS1ZP-0003S2-6L
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 16:20:47 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Nov 2019 18:20:29 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xA5GKQmA013132;
 Tue, 5 Nov 2019 18:20:28 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 13/15] nvmet: Add metadata/T10-PI support
Date: Tue,  5 Nov 2019 18:20:24 +0200
Message-Id: <20191105162026.183901-15-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105162026.183901-1-maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_082039_711725_DF60A2F1 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Expose the namespace metadata format when PI is enabled. The user needs
to enable the capability per subsystem and the other metadata properties
are taken from the namespace/bdev.

Usage example:
echo 1 > /config/nvmet/subsystems/${NAME}/attr_pi_enable

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/admin-cmd.c   | 23 +++++++++++++++++++----
 drivers/nvme/target/configfs.c    | 24 ++++++++++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c | 11 +++++++++++
 drivers/nvme/target/nvmet.h       |  5 +++++
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19ae155..20e7f08 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -346,8 +346,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* we support multiple ports, multiples hosts and ANA: */
 	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
 
-	/* no limit on data transfer sizes for now */
-	id->mdts = 0;
+	/* Limit MDTS for metadata capable controllers (assume mpsmin is 4k) */
+	id->mdts = ctrl->pi_support ? ilog2(NVMET_T10_PI_MAX_KB_SZ >> 2) : 0;
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 
@@ -405,9 +405,13 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
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
 
@@ -437,6 +441,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
@@ -493,6 +498,16 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
+			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
+			  NVME_NS_DPC_PI_TYPE3;
+		id->mc = NVME_NS_MC_META_EXT;
+		id->dps = ns->prot_type;
+		id->flbas = NVME_NS_FLBAS_META_EXT;
+		id->lbaf[0].ms = ns->ms;
+	}
+
 	if (ns->readonly)
 		id->nsattr |= (1 << 0);
 	nvmet_put_namespace(ns);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a4..316e3c9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,34 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
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
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_pi_enable,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index ee41b2b..5a99878 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -192,6 +192,17 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	if (ctrl->subsys->pi_support) {
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
index 574ee55..3d102d6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -144,6 +144,7 @@ struct nvmet_port {
 	bool				enabled;
 	int				inline_data_size;
 	const struct nvmet_fabrics_ops	*tr_ops;
+	bool				pi_capable;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -203,6 +204,7 @@ struct nvmet_ctrl {
 	spinlock_t		error_lock;
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
+	bool			pi_support;
 };
 
 struct nvmet_subsys {
@@ -225,6 +227,7 @@ struct nvmet_subsys {
 	u64			ver;
 	u64			serial;
 	char			*subsysnqn;
+	bool			pi_support;
 
 	struct config_group	group;
 
@@ -511,6 +514,8 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->prot_type && ns->ms == sizeof(struct t10_pi_tuple);
 }
 
+#define NVMET_T10_PI_MAX_KB_SZ 128
+
 static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 {
 	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
