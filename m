Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCCC28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gG4J+5wPzsIFcwpQCaZ8XdyImnqOJ7MXBLEuR4oDEMs=; b=IrSYMVkYLRg8CZgu+0i14fbvpG
	WSOtteJEqT1o3qOHDSpe6USqNpD6N+i/iDrLa/0PmDPmvt6Zo+/od8eM7HOgojpWQpbQeDDYXgE6F
	oQ6fOG/tsMf9pOsxXaetwgLzspkHAXMyS19HssrRmoxOgBrP8FfMgb2woQ8jpcqab4drSBXUgiriE
	TzxkK0mHVFpb1FFDBSqp5ECI1ztFPNRsNgoXFESdl/RAYWR6r8YVUamvwebbp458UIo5xROYn+TYK
	zNee/Vh+pLPr02VRSeZqS7tFoRupZAmEnolk2tBSK/V13prwr+Eggx1RfPcj04VGfUKGepm7X7Fbk
	NonqfBSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyILw-0000000EPuX-2J5d;
	Fri, 28 Mar 2025 22:39:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyHNe-0000000ELre-0nUO
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 21:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743197806; x=1774733806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQe2G896JEYRzT0Y5ioNXvgMBbFTWdKFqJkL1/XPLNs=;
  b=SWAxO6yZo3ddDiGOsHyGFIbwq2zRYHjAMTlYRq1Ao+f59mSfwkgybZtt
   BgjAjqPOe7cBYyB1XROzanies0baLJlZbgH3MDBJrQiG9DF3QxRoBkWv+
   N1b143MrEJt9yvHqEgqyBkGeh5OE73Y7WIRjR4vVkf3z9xBQm8SXomM1G
   YrGBkcZ17ehZTFeVEsdjl9OH0eYfvQAZdPRokZ1IStSfo4iJv7AjhQZdx
   Q2wxxWlZQaA9KPj2M1qq15rF4iFdoaq9pQDmNgSIPx4Bzu/kUO1I7BPlh
   hFAGX0XfRH7Gl7/kVJVOsTmwZHu2i3dZ/TKB4B8c2GawrgNI26UfsAlY0
   g==;
X-CSE-ConnectionGUID: EJLk6RTiRhiyGRPFiV1lmg==
X-CSE-MsgGUID: KpaIOMpnSqCj8p8tXmn1VA==
X-IronPort-AV: E=Sophos;i="6.14,284,1736784000"; 
   d="scan'208";a="64005081"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2025 05:36:42 +0800
IronPort-SDR: 67e70879_66HkSrmBczzUP5f9bUJtV8oVt2tnNWTzY8CZL/2jo3IWlke
 G7SzaOK6jkU2dxuMWIZU3vztfYBYOpyhxWf9wyQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2025 13:37:13 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Mar 2025 14:36:41 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: niklas.cassel@wdc.com,
	damien.lemoal@wdc.com,
	kamaljit.singh1@wdc.com
Subject: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq creation for admin & disco ctrlrs
Date: Fri, 28 Mar 2025 14:36:40 -0700
Message-ID: <20250328213640.798910-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_143646_291818_B5A2883C 
X-CRM114-Status: GOOD (  20.64  )
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

Added capability to connect to an administrative controller by
preventing ioq creation for admin-controllers. Also prevent ioq creation
for discovery-controllers as the spec prohibits them.

* Added nvme_admin_ctrl() to check for an administrative controller

* Renamed nvme_discovery_ctrl() to nvmf_discovery_ctrl() as discovery is
  more relevant to fabrics

* Similar to a discovery ctrl, prevent an admin-ctrl from getting a
  smart log (LID=2). LID 2 is optional for admin controllers but in the
  future when we add support for the newly added LID=0 (supported log
  pages), we can make GLP accesses smarter by basing such calls on
  response from LID=0 reads.

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c    | 25 +++++++++++++------------
 drivers/nvme/host/fabrics.h |  5 +++++
 drivers/nvme/host/nvme.h    |  5 +++++
 drivers/nvme/host/rdma.c    | 11 +++++++++++
 drivers/nvme/host/tcp.c     | 11 +++++++++++
 5 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60537c9224bf..417893c4e8e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2800,11 +2800,6 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
-static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
-{
-	return ctrl->opts && ctrl->opts->discovery_nqn;
-}
-
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -2825,7 +2820,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		}
 
 		if ((id->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-		    nvme_discovery_ctrl(ctrl))
+		    nvmf_discovery_ctrl(ctrl))
 			continue;
 
 		dev_err(ctrl->device,
@@ -2863,13 +2858,19 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	else
 		subsys->subtype = NVME_NQN_NVME;
 
-	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
+	if (nvmf_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
 		dev_err(ctrl->device,
 			"Subsystem %s is not a discovery controller",
 			subsys->subnqn);
 		kfree(subsys);
 		return -EINVAL;
 	}
+	if (nvme_admin_ctrl(ctrl)) {
+		dev_info(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			subsys->subnqn);
+	}
+
 	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
@@ -3093,20 +3094,20 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
 
-	if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
+	if (!nvmf_discovery_ctrl(ctrl) && !ctrl->kas) {
 		dev_err(ctrl->device,
 			"keep-alive support is mandatory for fabrics\n");
 		return -EINVAL;
 	}
 
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
+	if (!nvmf_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
 
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
+	if (!nvmf_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
@@ -3290,7 +3291,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
@@ -4492,7 +4493,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * checking that they started once before, hence are reconnecting back.
 	 */
 	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
-	    nvme_discovery_ctrl(ctrl))
+	    nvmf_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
 	if (ctrl->queue_count > 1) {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..679cf5282cee 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -181,6 +181,11 @@ struct nvmf_transport_ops {
 					struct nvmf_ctrl_options *opts);
 };
 
+static inline bool nvmf_discovery_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->opts && ctrl->opts->discovery_nqn;
+}
+
 static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a..7c2d896a754c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1135,6 +1135,11 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->cntrltype == NVME_CTRL_ADMIN);
+}
+
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 299e3c19df9d..0f3150411bd5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1030,6 +1030,17 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
+	/* An admin or discovery controller has one admin queue, but no I/O queues */
+	if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctrl)) {
+		ctrl->ctrl.queue_count = 1;
+	} else if (ctrl->ctrl.queue_count < 2) {
+		/* I/O controller with no I/O queues is not allowed */
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->ctrl.device,
+			"I/O controller doesn't allow zero I/O queues!\n");
+		goto destroy_admin;
+	}
+
 	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 644f84284b6f..3fe2f617bfd5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2199,6 +2199,17 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
+	/* An admin or discovery controller has one admin queue, but no I/O queues */
+	if (nvme_admin_ctrl(ctrl) || nvmf_discovery_ctrl(ctrl)) {
+		ctrl->queue_count = 1;
+	} else if (ctrl->queue_count < 2) {
+		/* I/O controller with no I/O queues is not allowed */
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->device,
+			"I/O controller doesn't allow zero I/O queues!\n");
+		goto destroy_admin;
+	}
+
 	if (opts->queue_size > ctrl->sqsize + 1)
 		dev_warn(ctrl->device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-- 
2.43.0


