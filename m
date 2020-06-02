Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E3C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B3D2074B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C1X/zj+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B3D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MU9wfwfk74rlXJYsK0h+WPshAHBHibpSvt6w7uVObuI=; b=C1X/zj+pCEBRbG
	wwjtpkSZpL6mypRaiyrV4YgITHaeSTXyCxgffrgt+ekaNAcD+6Ub8fO1MgrvXGfJYF6rOt1YuK4Il
	gfJG3nHilWrWMjqNkR2o4W3Du4s2yBfHMKdm/YoGSjSFu8hyiEERX+8vTzwNY3RLDfJvehaSY/9lU
	7n/dlyvzayBu+auO9EbbBqvwXwkiTxiaLJg3VwY3H1g/OVd6yeax1LSPO3EJEJuuRJDBVBkTlSUKM
	mQcRuF49422cw4/igDLMMbdjoPHh3uuxu7qs6Cd/HUR/M3EfsWgTE5Ihe8M/AxJVZw6vD0YNlNw48
	vo+tedi6igvRkLN/XE8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jg6mM-0003kE-HC; Tue, 02 Jun 2020 13:16:30 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jg6ll-0003AN-Gm
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 13:15:57 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 2 Jun 2020 16:15:47 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 052DFkVj031311;
 Tue, 2 Jun 2020 16:15:47 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, james.smart@broadcom.com, chaitanya.kulkarni@wdc.com
Subject: [PATCH 3/5] nvme: replace transport name with trtype enum for ops
Date: Tue,  2 Jun 2020 16:15:44 +0300
Message-Id: <20200602131546.51903-4-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200602131546.51903-1-maxg@mellanox.com>
References: <20200602131546.51903-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200602_061554_020199_1267B9FF 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: israelr@mellanox.com, nitzanc@mellanox.com, oren@mellanox.com,
 Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use common code to map transport type to transport name instead of
duplicating logic.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 drivers/nvme/host/fabrics.h | 4 ++--
 drivers/nvme/host/fc.c      | 2 +-
 drivers/nvme/host/rdma.c    | 2 +-
 drivers/nvme/host/tcp.c     | 2 +-
 drivers/nvme/target/loop.c  | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c819..bd5e44e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -528,7 +528,8 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 	lockdep_assert_held(&nvmf_transports_rwsem);
 
 	list_for_each_entry(ops, &nvmf_transports, entry) {
-		if (strcmp(ops->name, opts->transport) == 0)
+		if (strcmp(nvme_trtype_to_name(ops->trtype),
+			   opts->transport) == 0)
 			return ops;
 	}
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a0ec40a..1fd52f0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -119,7 +119,7 @@ struct nvmf_ctrl_options {
  * @entry:		Used by the fabrics library to add the new
  *			registration entry to its linked-list internal tree.
  * @module:             Transport module reference
- * @name:		Name of the NVMe fabric driver implementation.
+ * @trtype:		NVMe fabric transport type
  * @required_opts:	sysfs command-line options that must be specified
  *			when adding a new NVMe controller.
  * @allowed_opts:	sysfs command-line options that can be specified
@@ -141,7 +141,7 @@ struct nvmf_ctrl_options {
 struct nvmf_transport_ops {
 	struct list_head	entry;
 	struct module		*module;
-	const char		*name;
+	u8			trtype;
 	int			required_opts;
 	int			allowed_opts;
 	struct nvme_ctrl	*(*create_ctrl)(struct device *dev,
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index cb00075..67db0ae 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3694,7 +3694,7 @@ struct nvmet_fc_traddr {
 
 
 static struct nvmf_transport_ops nvme_fc_transport = {
-	.name		= "fc",
+	.trtype		= NVMF_TRTYPE_FC,
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR | NVMF_OPT_HOST_TRADDR,
 	.allowed_opts	= NVMF_OPT_RECONNECT_DELAY | NVMF_OPT_CTRL_LOSS_TMO,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856d..5e7dda3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2329,7 +2329,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 }
 
 static struct nvmf_transport_ops nvme_rdma_transport = {
-	.name		= "rdma",
+	.trtype		= NVMF_TRTYPE_RDMA,
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7c7c188..c678f97 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2487,7 +2487,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 }
 
 static struct nvmf_transport_ops nvme_tcp_transport = {
-	.name		= "tcp",
+	.trtype		= NVMF_TRTYPE_TCP,
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d54e73..257ee60 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -674,7 +674,7 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
 };
 
 static struct nvmf_transport_ops nvme_loop_transport = {
-	.name		= "loop",
+	.trtype		= NVMF_TRTYPE_LOOP,
 	.module		= THIS_MODULE,
 	.create_ctrl	= nvme_loop_create_ctrl,
 	.allowed_opts	= NVMF_OPT_TRADDR,
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
