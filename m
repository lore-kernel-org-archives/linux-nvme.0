Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163AC71134
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 05:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBSO0GtUDvsctGv+r6Ikqnoj5u7pAVGrgeAZvU/02k8=; b=Ccyl4PhP5mAsAbZcVqFc9OrCOj
	pAXN+yTdAdJfYldvVqlrMfoOqoR4vCv6RLG2szHzEOj+WeK9b0rB3fdRLSfEjWqBmOkSCh2fWPO6o
	xlErTtPHKK+DFBy3qKufJJPYdqHdhxIOcl46Swqn0uZ8gvmHU2d33hG+MbFAq41alq6vkm1nfOTsW
	X9QPqg+PwMX6fHbO2JDwCQwlABe5n3vfK7pNmPu4+DT5uKAGnkj5wSQMAK83hHBpW4DVBiOchqhfL
	JvcPvRDOvic3SHgaGNZg3SmZb0lSy3PcLNkhDbeoizht5QM30ejvkuhVZlKt9ZWTEWCPj1z06PGPD
	ewQ31egg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEQ3-00000008uFS-3HPl;
	Wed, 11 Jun 2025 05:54:39 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPEQ1-00000008uEd-2bqv;
	Wed, 11 Jun 2025 05:54:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/2] nvme: refactor the atomic write unit detection
Date: Wed, 11 Jun 2025 07:54:11 +0200
Message-ID: <20250611055432.2401372-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611055432.2401372-1-hch@lst.de>
References: <20250611055432.2401372-1-hch@lst.de>
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

Move all the code out of nvme_update_disk_info into the helper, and
rename the helper to have a somewhat less clumsy name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 72 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 724f5732786c..520fb5f1e214 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2015,21 +2015,51 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 }
 
 
-static void nvme_update_atomic_write_disk_info(struct nvme_ns *ns,
-			struct nvme_id_ns *id, struct queue_limits *lim,
-			u32 bs, u32 atomic_bs)
+static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
+		struct nvme_id_ns *id, struct queue_limits *lim, u32 bs)
 {
-	unsigned int boundary = 0;
+	u32 atomic_bs, boundary = 0;
 
-	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
-		if (le16_to_cpu(id->nabspf))
+	/*
+	 * We do not support an offset for the atomic boundaries.
+	 */
+	if (id->nabo)
+		return bs;
+
+	if ((id->nsfeat & NVME_NS_FEAT_ATOMICS) && id->nawupf) {
+		/*
+		 * Use the per-namespace atomic write unit when available.
+		 */
+		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
+		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+	} else {
+		/*
+		 * Use the controller wide atomic write unit.  This sucks
+		 * because the limit is defined in terms of logical blocks while
+		 * namespaces can have different formats, and because there is
+		 * no clear language in the specification prohibiting different
+		 * values for different controllers in the subsystem.
+		 */
+		atomic_bs = (1 + ns->ctrl->awupf) * bs;
+	}
+
+	if (!ns->ctrl->subsys->atomic_bs) {
+		ns->ctrl->subsys->atomic_bs = atomic_bs;
+	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
+		dev_err_ratelimited(ns->ctrl->device,
+			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+			ns->disk ? ns->disk->disk_name : "?",
+			ns->ctrl->subsys->atomic_bs,
+			atomic_bs);
 	}
+
 	lim->atomic_write_hw_max = atomic_bs;
 	lim->atomic_write_hw_boundary = boundary;
 	lim->atomic_write_hw_unit_min = bs;
 	lim->atomic_write_hw_unit_max = rounddown_pow_of_two(atomic_bs);
 	lim->features |= BLK_FEAT_ATOMIC_WRITES;
+	return atomic_bs;
 }
 
 static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
@@ -2067,34 +2097,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		valid = false;
 	}
 
-	atomic_bs = phys_bs = bs;
-	if (id->nabo == 0) {
-		/*
-		 * Bit 1 indicates whether NAWUPF is defined for this namespace
-		 * and whether it should be used instead of AWUPF. If NAWUPF ==
-		 * 0 then AWUPF must be used instead.
-		 */
-		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
-			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
-		else
-			atomic_bs = (1 + ns->ctrl->awupf) * bs;
-
-		/*
-		 * Set subsystem atomic bs.
-		 */
-		if (ns->ctrl->subsys->atomic_bs) {
-			if (atomic_bs != ns->ctrl->subsys->atomic_bs) {
-				dev_err_ratelimited(ns->ctrl->device,
-					"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
-					ns->disk ? ns->disk->disk_name : "?",
-					ns->ctrl->subsys->atomic_bs,
-					atomic_bs);
-			}
-		} else
-			ns->ctrl->subsys->atomic_bs = atomic_bs;
-
-		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
-	}
+	phys_bs = bs;
+	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
 		/* NPWG = Namespace Preferred Write Granularity */
-- 
2.47.2


