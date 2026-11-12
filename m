Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD34606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pwRkrJxk;
	dkim=pass (2048-bit key, unprotected) header.d=hudson-trading.com header.i=@hudson-trading.com header.a=rsa-sha256 header.s=postfix-20201111 header.b=aWTrGIjD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=c30fBkje8zbedbl+2JhtaNjK3lxuM3JZANZfU8ZZcco=; b=pwRkrJxkwKcG9sJm7Qrj/HnBY6
	/QAg0a4BhtrrC2kuZZRZ2wuVKrE6RdHbtERjwPqb+gxNXRt94UJ6xkTvL9T1nMmeykSOtiYnIXKGF
	QmqrYHK5Ifjh1QWhj6VRUUUDtQD+l6K2ni/kRRB/V+p2j9WSTR0VasQ7b0ABGjgDcwg68M6zYg/rD
	jqdd0fVNpOm5MlvmZDdG7BsHf5UzNXgh4167wGq10axZB3qMUtR5riQRX1rQZE5hVJjWxsRWODsZ6
	fhiNWcx20/phOBZi/widOHgzIwPJKZfbTJLZbxBjkHC8hKxuGDKh13mWaaFaGjxKDulJCCoHTO8To
	Dl4AwLcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRayG-0000000Az6w-1yQ3;
	Thu, 12 Nov 2026 20:00:32 +0000
Received: from [38.105.238.108] (helo=smtp.hudson-trading.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRayB-0000000Az67-0OfZ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 20:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hudson-trading.com; i=@hudson-trading.com; q=dns/txt;
 s=postfix-20201111; t=1794512945; h=from : to : cc : subject : date :
 message-id : mime-version : content-transfer-encoding : from;
 bh=c30fBkje8zbedbl+2JhtaNjK3lxuM3JZANZfU8ZZcco=;
 b=aWTrGIjDJ95JwlWPgz6e50ke/BrzqCbBiE7a2/LHn4GRO0IdX8kapPzcgsoxWXMre/oSa
 F1PXjxVaxWpC8/lIj8LAn8LLpTgkOLMzkA5aeJjwQ4R2tH/3qqZ4fHrszreryxR+TrqXhFH
 syGMixoHEOqdoa0uu0UWNvzS/T86tJcHp9jvHqm8haVKg0klkMBt7zrd40hw1arhZpINA8M
 hxzb3RxIAzdQr+6YgMb6rPAkoSKa22J7t8cb6Tzc1fmJmwC/qSfx2fNdgP5Ld4RdOMJEIxL
 fgbLqXwCCfuBCcjbYBEovayuyPJ/JDCgRn3YfPe/UVmbnt14VZZdVij6fK9A==
Received: from shauser-sthiell1.hudson-trading.com (shauser-sthiell1.hudson-trading.com [10.20.74.239])
	by smtp.hudson-trading.com (Postfix) with ESMTP id B270B21E338;
	Thu, 12 Nov 2026 14:49:05 -0500 (EST)
From: Stephane Thiell <sthiell@hudson-trading.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	mgurtovoy@nvidia.com,
	Stephane Thiell <sthiell@hudson-trading.com>
Subject: [PATCH] nvme-rdma: add a module parameter to disable T10-PI offload
Date: Thu, 12 Nov 2026 14:48:38 -0500
Message-ID: <20261112194838.928882-1-sthiell@hudson-trading.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_120027_954534_28A6CC89 
X-CRM114-Status: GOOD (  17.30  )
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
slot costs five firmware commands (four CREATE_MKEY, one CREATE_PSV)
instead of one. These commands are synchronous and take about 0.2 ms
each, and the same number of destroy commands is issued at teardown.
The HCA context memory given to the firmware grows the same way: about
10.4 pages per I/O request slot, against 2.1 without the integrity
pool.

With 48 controllers of 24 I/O queues and a queue size of 128, connect
goes from 172 s to 46 s and disconnect from ~150 s to 35 s.

Add a pi_enable module parameter. With pi_enable=0, pi_capable stays
false in nvme_rdma_configure_admin_queue() and the controller is set up
as on a device without integrity handover: max_integrity_segments is 0
and no integrity MR pool is allocated. As on such a device, a namespace
formatted with protection information is not usable (the core gives it
a capacity of 0).

The default is true, so the behavior does not change unless the
parameter is set.
Signed-off-by: Stephane Thiell <sthiell@hudson-trading.com>
---
Developed and measured before the parallel I/O queue setup of v7.3;
build-tested on v7.4-rc2. If a per-connection fabrics option is preferred
to a module parameter, I can rework it that way.

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


