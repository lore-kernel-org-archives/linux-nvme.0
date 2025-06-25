Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB323C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mw8CJnJCVYYsUXF9Jr5av8R2LKSrWgACEkIN0rlmWhc=; b=orw06WQD7j9yTYissf9badsC6H
	roTDUtBIdg0e7wGosrWNi1WY/1kXLLVXNPjndjx4+CUy9v1Ta/U97mVKrI1B+gLi62gPEURhDdKlm
	8X7Q8aroI8PX7svT1BqI7lWFSdKI8uzCC4IU2nqcNcgpsS5soyYtIvn2womUDRECmx3iKp1HJqpgU
	72QyGcE0fTLTQ3RAqBl2lsAJZwWVWGosQlbL7u0pxqDXIR98MwqSGRbMyXb93kHmf/6uaqnaTvnpC
	V/TgbiI2U934xFqWx719mahLoKuBVgZeOZjGR98nSxt3/8bW3xc6cBVRFp9BIVmxzN2Ny1zHwWo6p
	Gdsqz57Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJzw-00000007jLQ-14Y5;
	Wed, 25 Jun 2025 06:52:44 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJnq-00000007gq9-2Qv2;
	Wed, 25 Jun 2025 06:40:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] nvme: fix atomic write size validation
Date: Wed, 25 Jun 2025 08:39:56 +0200
Message-ID: <20250625064003.436582-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625064003.436582-1-hch@lst.de>
References: <20250625064003.436582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Don't mix the namespace and controller values, and validate the
per-controller limit when probing the controller.  This avoid spurious
failures for controllers with namespaces that have different namespaces
with different logical block sizes, or report the per-namespace values
only for some namespaces.

It also fixes a missing queue_limits_cancel_update in an error path by
removing that error path.

Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/nvme/host/core.c | 33 +++++++++++----------------------
 drivers/nvme/host/nvme.h |  3 +--
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 520fb5f1e214..e533d791955d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2041,17 +2041,7 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		 * no clear language in the specification prohibiting different
 		 * values for different controllers in the subsystem.
 		 */
-		atomic_bs = (1 + ns->ctrl->awupf) * bs;
-	}
-
-	if (!ns->ctrl->subsys->atomic_bs) {
-		ns->ctrl->subsys->atomic_bs = atomic_bs;
-	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
-		dev_err_ratelimited(ns->ctrl->device,
-			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
-			ns->disk ? ns->disk->disk_name : "?",
-			ns->ctrl->subsys->atomic_bs,
-			atomic_bs);
+		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;
@@ -2386,16 +2376,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 
-	/*
-	 * Validate the max atomic write size fits within the subsystem's
-	 * atomic write capabilities.
-	 */
-	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
-		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
-		ret = -ENXIO;
-		goto out;
-	}
-
 	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
@@ -3219,6 +3199,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+	subsys->awupf = le16_to_cpu(id->awupf);
 
 	/* Versions prior to 1.4 don't necessarily report a valid type */
 	if (id->cntrltype == NVME_CTRL_DISC ||
@@ -3556,6 +3537,15 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		if (ret)
 			goto out_free;
 	}
+
+	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
+		dev_err_ratelimited(ctrl->device,
+			"inconsistent AWUPF, controller not added (%u/%u).\n",
+			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	memcpy(ctrl->subsys->firmware_rev, id->fr,
 	       sizeof(ctrl->subsys->firmware_rev));
 
@@ -3651,7 +3641,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a468cdc5b5cb..7df2ea21851f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,7 +410,6 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
-	u16 awupf; /* 0's based value. */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -443,11 +442,11 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
+	u16			awupf; /* 0's based value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
-	u32			atomic_bs;
 };
 
 /*
-- 
2.47.2


