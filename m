Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB1AC7EE30
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sEGWuCgpNs+V0fPpc4jtABMguQYwettS32ld49qaO0Q=; b=D9YZRYAp2pvbuAVZ7PAjx518y3
	1gPWa8mlnvI3B7tFylJGSDVRbuFduSK+I5Pj3oIULwBwQwoTMIT6P6KnISgZk8nkx1Cg6oaaD6szy
	yeFffiNvuwY3ApG+aFbv/Mwr0r/gmMFemeYAVTtzPbGdm+5ILlNJIIRC1z2jI4pvZxxw1Xl97pJBf
	s/Zm2wt5j0H8HNMge56csCqIbozgx9wz37AkIK0mqLpyoBxQOdbWSMkkAi4ngSMxHLqr0XxU9B8PJ
	CXZQf6hNBW9KlqYj/KZ5Y13bXwB5Qb/BU3LbkGNxKa0n4Kkb+no2jrCp4VqfzuXv40hL5Ut1KHHMm
	HZqK/oOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo5-00000006wXl-0VLP;
	Wed, 02 Jul 2025 00:58:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWlo2-00000006wVV-2A9u
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 00:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751417914; x=1782953914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x74/qhqgQxLvud4UWv+6frY0teSYowTdLUNXu3hBbpc=;
  b=l1t1QlX9nCUNSeRWgOMISkbTLmgWAVzigaazN95+aFKtV4TejS9oC1Z2
   PbwGFj09ED63O9tPgo0bJESmnvIWPeRhId/HCSUnvfmUIiAtuX8ZjlzBA
   TFZLllvSnMPxMAE9Gqkq1V8b49MAZcWncGZ23MLSKWJ1nRY2E2VKxPY6T
   H5bRF8XGCsAVUHQPLgSs3l/T+v5FZmDP7vLkabRotlVTQj1G2Fdar6XTn
   sNgAuv/Dm/DAoH9kvH1LmVl0IQYFZyX5O93CzQ24YiXMz7C7D2yAHlYJc
   GFb1i0Ycvdy+vih2ATLTDYqV4G0FL8czkXnzeb+yhTu/k8L0tbZjHD5Sr
   g==;
X-CSE-ConnectionGUID: TibOdqQ1SaWaQffparxaoQ==
X-CSE-MsgGUID: nX3Noy4WQjqNqvehIRJT8Q==
X-IronPort-AV: E=Sophos;i="6.16,280,1744041600"; 
   d="scan'208";a="91662745"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2025 08:58:31 +0800
IronPort-SDR: 686475ac_lcJDOQi2lWqFuy3Q65nG8Fw4bb5aRiqzUGabTc3E0fiMggb
 4BJUMDXEtsqWO1Mf25Vb9WusiVUGRIuBuBZ0FXA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2025 16:56:28 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jul 2025 17:58:32 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v2 1/3] nvme: add capability to connect to an admin controller
Date: Tue,  1 Jul 2025 17:58:27 -0700
Message-ID: <20250702005830.889217-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_175834_619080_EF491865 
X-CRM114-Status: GOOD (  14.94  )
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

Suggested-by: Niklas Cassel <cassel@kernel.org>

Add capability to connect to an administrative controller by
preventing ioq creation for admin-controllers.

* Add helper nvme_admin_ctrl() to check for an administrative controller
* Add helper nvme_override_prohibited_io_queues() to override
  queue_count in nvme_ctrl

Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  2 ++
 drivers/nvme/host/tcp.c  |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..a1155fb8d5be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3149,6 +3149,22 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 	return ctrl->opts && ctrl->opts->discovery_nqn;
 }
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->cntrltype == NVME_CTRL_ADMIN);
+}
+
+/*
+ * An admin controller has one admin queue, but no I/O queues.
+ * Override queue_count so it only creates an admin queue.
+ */
+void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
+{
+	if (nvme_admin_ctrl(ctrl))
+		ctrl->queue_count = 1;
+}
+EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -3215,6 +3231,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
+	if (nvme_admin_ctrl(ctrl))
+		dev_info(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			subsys->subnqn);
+
 	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = &nvme_subsys_class;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7df2ea21851f..5e07ba634e97 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1212,6 +1212,7 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);
 void nvme_put_ns(struct nvme_ns *ns);
+void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl);
 
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9bd3646568d0..7d50a2f31c3a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1026,6 +1026,8 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
+	nvme_override_prohibited_io_queues(&ctrl->ctrl);
+
 	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..bfb52a487c45 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2381,6 +2381,8 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
+	nvme_override_prohibited_io_queues(ctrl);
+
 	if (opts->queue_size > ctrl->sqsize + 1)
 		dev_warn(ctrl->device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-- 
2.43.0


