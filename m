Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B3606A32E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bH9FDNx/;
	dkim=pass (2048-bit key, unprotected) header.d=hudson-trading.com header.i=@hudson-trading.com header.a=rsa-sha256 header.s=postfix-20201111 header.b=EwFZ/ARs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=klM8axKcLEWb6h1i1bDiGTuH6roxhmbwPwLQDuNnm38=; b=bH9FDNx/rl9XMhuPyMUkylYJxg
	j2aUUZJuB2ycRPatdR36lsreDKx2cfrOeYMlhi5U34o5QBGEV1sgI/kTBKgd7iBkMk8jtmwLuq7pQ
	/Qi6h9NK//7k5hvzOFln4CalJYMqr80b28bJcvgVDyFj80JOQ/QO0//FiY8qYiXsPNW5Poo/+y46O
	6Rkl1RB492960AqmIOSFWpD/aKjv/kd5Lh+SXBU4/LKnIc/0OUYANOYMePYPUZFx42YZGo5CYHDRS
	g/21/0L6RTld2BsUyjfLhAYSHBYuSXJgYN7ANH5x4LPvn7YrZZRIBAw/quJJHGFzj1nI+D7+Xxm5E
	l0JZJAsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRbvF-0000000B2mq-0VAo;
	Thu, 12 Nov 2026 21:01:29 +0000
Received: from [38.105.238.108] (helo=smtp.hudson-trading.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRbvC-0000000B2mH-0mAn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hudson-trading.com; i=@hudson-trading.com; q=dns/txt;
 s=postfix-20201111; t=1794517284; h=from : to : cc : subject : date :
 message-id : mime-version : content-transfer-encoding : from;
 bh=klM8axKcLEWb6h1i1bDiGTuH6roxhmbwPwLQDuNnm38=;
 b=EwFZ/ARsXPUgHNoIzlEQOE+L62ZfbAGSIO7J1892HZxqjUrgmE9Mhm9edgXkotvZUUFNt
 1KBqD7Ypqd53LOCDUpS5qbCFJD2ui93K5mCGfAZhkqsHYupvpwVfJhCLfAWiD/tBd+ERyL5
 ycMVyILi911eMTtCy2H6BvVVT1fn0sYVsUBKpq8QWzNBsF4SGxY3WFm/hoehxSKH3rjkoVY
 v76y4N2Qb/egDX2MAhV3I9r/ZQHNkCH6ygGstdxQfuP/GYWLiIJKyzISLH87IT7ABYW+4+S
 LEN5g4kjAcaYQE/4rLmXvUtGsFpGndJOMhiKVBgo89EjP5EsdL7XF4G15tEw==
Received: from shauser-sthiell1.hudson-trading.com (shauser-sthiell1.hudson-trading.com [10.20.74.239])
	by smtp.hudson-trading.com (Postfix) with ESMTP id 5926221E439;
	Thu, 12 Nov 2026 16:01:24 -0500 (EST)
From: Stephane Thiell <sthiell@hudson-trading.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	mgurtovoy@nvidia.com,
	Stephane Thiell <sthiell@hudson-trading.com>
Subject: [PATCH v2] nvme-rdma: add a module parameter to disable T10-PI offload
Date: Thu, 12 Nov 2026 16:01:05 -0500
Message-ID: <20261112210105.992764-1-sthiell@hudson-trading.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_130126_329623_9887BECF 
X-CRM114-Status: GOOD (  17.47  )
X-Spam-Score: -1.3 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the RDMA device advertises IBK_INTEGRITY_HANDOVER, nvme-rdma
enables T10-PI offload for the controller before any namespace is
known, and every I/O queue then allocates an integrity MR pool of
queue_size entries next to its plain MR pool. Hosts whose namespaces
are not formatted with protection information never use these MRs but
pay for them on every connect, reconnect and disconnect.

On mlx5 an integrity MR is three mkeys and a PSV pair, so each request
slot costs five synchronous firmware commands (four CREATE_MKEY, one
CREATE_PSV) instead of one, the same objects are destroyed again at
teardown, and the HCA context memory per slot grows about fivefold.

Measured before the parallel I/O queue setup of v7.3, with 48
controllers of 24 I/O queues and a queue size of 128, connect went from
172 s to 46 s and disconnect from ~150 s to 35 s.

Add a pi_enable module parameter. With pi_enable=0, pi_capable stays
false in nvme_rdma_configure_admin_queue() and the controller is set up
as on a device without integrity handover: max_integrity_segments is 0
and no integrity MR pool is allocated. Namespaces that work with PI
offload keep working, with the controller inserting and stripping the PI
(PRACT).

The default is true, so the behavior does not change unless the
parameter is set.
Signed-off-by: Stephane Thiell <sthiell@hudson-trading.com>
---
v2:
- Changelog: correct the PI namespace, teardown and timing statements
  (v1 wrongly said a PI namespace gets a capacity of 0); simplify the
  memory figures.
v1: https://lore.kernel.org/linux-nvme/20261112194838.928882-1-sthiell@hudson-trading.com/

Measured on a 6.12-based kernel; build-tested only on v7.4-rc2. If a
per-connection fabrics option, or creating the integrity pool only when
a PI namespace appears, is preferred to a module parameter, I can rework
it that way.

 drivers/nvme/host/rdma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 32189fdfc0f5..267de27b743e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -156,6 +156,11 @@ module_param(register_always, bool, 0444);
 MODULE_PARM_DESC(register_always,
 	 "Use memory registration even for contiguous memory regions");
 
+static bool pi_enable = true;
+module_param(pi_enable, bool, 0444);
+MODULE_PARM_DESC(pi_enable,
+	 "Use T10-PI offload if the RDMA device supports it (default: true)");
+
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event);
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
@@ -806,8 +811,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
 
 	/* T10-PI support */
-	if (ctrl->device->dev->attrs.kernel_cap_flags &
-	    IBK_INTEGRITY_HANDOVER)
+	if (pi_enable && (ctrl->device->dev->attrs.kernel_cap_flags &
+			  IBK_INTEGRITY_HANDOVER))
 		pi_capable = true;
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,

base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
-- 
2.39.1


