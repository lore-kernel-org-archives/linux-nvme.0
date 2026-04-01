Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D7AD35174
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BBENWfOz5m4aXswxX+1QLDnCjth4YArnAPodhlRMRE0=; b=c7CCJKTy+5YiiCnxeC+Ycyy18B
	uYqxaTn8xuf+DZp1WTzvcUePgPS4fa5yepj1kVOZMRdc6cHewCni9Bas+2/y/S5Yg2ODAOD3iFCDf
	PqETms5+FhFpU6A/RfQiIck4222703D2tZ2pXj4CsXOwjkvM2psgMpPp1kXRgdMTjZZxB1ajpLv0x
	0nK0ShlMd1TV2UpwU7YSj/YQbsKmYbWeF6tur+Jy5nd6csYrIlBxuzAWkVaKzFkm06cFdmfT6a/aO
	QJVGzYK2i8/L7VWfUiH2knk++UpsMLmg6WKWNNze5rRNbQb46Z2b3eH9Yrbm2I+MPLTfKMoIvS0jx
	Ks2xgGUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7suO-0000000EW1m-2Byx;
	Wed, 01 Apr 2026 10:34:48 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7suM-0000000EW17-0LYo
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 10:34:47 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b258636d16so32982305ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2026 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775039684; x=1775644484; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBENWfOz5m4aXswxX+1QLDnCjth4YArnAPodhlRMRE0=;
        b=ffUPqvPic1cNEkX+h41URXpmnPdIf1EpaLpihwMBS0F2QN0JlE9nGxTSRT5pK85fYV
         W/mbsYhhcIJ1aGepPcKOchyJ+xWkQevAv28RpiYswfYjM5HODhqwRl9rIZMQM6gqoVgc
         mf+KjWNfpOOuUptc8UKyU9lFr01vAxUCaAMfVMm1Y4PjETJF3OFCvmz5DuhWCG+PUr6d
         C9QK4QFwD1NiBzEdLDWxSq9ngBVHjKYL4RHZ3B6DsZNTe5WSJOyZS2+FcA9oSk71C3d5
         KEkpwV6jWdiJu3KcuxonR/NO+wTsbxfJ+02xbHzIpfkbM0hQwkDLBIYW5/C+tkGrVKoe
         fq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039684; x=1775644484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBENWfOz5m4aXswxX+1QLDnCjth4YArnAPodhlRMRE0=;
        b=VhrkwBwFfDdkzDGz2BZC1laH4OySb2La+USKazZ1TqknrzgDOt2qVj3Y7lcr0KdUOr
         n+VgBpvZKxBIVdTZOTq31QscFEsVBYZdEvM90SBSrTb3QtQquaWsMcOYVYWFRbXQ+k9q
         qjVeWgw11IA06/5aqtNy8z1djwEACzS8RJHROrvyAcY+YTGC9NWh9e5hFhhU3HbhYPn/
         6ZmQJVr7m0TNsvK1R4EH8oXnCrnkDT20Li72kYNx2cIQ2uIe8Hh33NNGQoqA+xMcj+cj
         nrAiRXNCO6Y60RvrWzRwkDXn6XxSMmu9EJtZFzaNBukFMCxn2NOfGdciY83gITtAKnFE
         coYA==
X-Gm-Message-State: AOJu0YxF02vxYF3gJ6bx2iWk2+2Nh7BsfYIqAJSQA/FU9rhXNRsFDRrp
	QIASdQg6C0b2nDs7osfgTEfHb/jsALs4FarP6FLynLoL+wEtvhA5gafWcsQ2RuqWeWc6hnLdaxl
	y9r9YeHVMnf6l9pGTI7OyiEhxrw==
X-Received: from plfn17.prod.google.com ([2002:a17:902:e551:b0:2b0:5e63:fc48])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr30155715ad.43.1775039684372;
 Wed, 01 Apr 2026 03:34:44 -0700 (PDT)
Date: Wed,  1 Apr 2026 10:34:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260401103441.1229964-1-shivajikant@google.com>
Subject: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
From: Shivaji Kant <shivajikant@google.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_033446_147681_721097FC 
X-CRM114-Status: GOOD (  12.50  )
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

Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
RDMA controller supports it.

blk_stack_limits() currently filters out this feature bit because it is
absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
in nvme_update_ns_info() after the stacking operation.

Hardware reachability remains enforced by late-stage distance checks
during DMA mapping.

Suggested-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
 drivers/nvme/host/core.c |  9 +++++++++
 drivers/nvme/host/rdma.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2da54f974fa..0d7b0f286895 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2205,6 +2205,15 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
+
+	/*
+	 * Explicitly check for P2PDMA support as BLK_FEAT_PCI_P2PDMA
+	 * is filtered out by queue_limits_stack_bdev().
+	 */
+	if (ns->ctrl->ops->supports_pci_p2pdma &&
+	   ns->ctrl->ops->supports_pci_p2pdma(ns->ctrl))
+		lim.features |= BLK_FEAT_PCI_P2PDMA;
+
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	blk_mq_unfreeze_queue(ns->disk->queue, memflags);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..3ce6f3e476b0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2189,6 +2189,20 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
+{
+	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
+	bool supported = false;
+
+	if (r_ctrl && r_ctrl->device)
+		supported = ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
+
+	dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
+			supported ? "PASSED" : "FAILED (HW/Driver restriction)");
+
+	return supported;
+}
+
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -2203,6 +2217,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 	.stop_ctrl		= nvme_rdma_stop_ctrl,
 	.get_virt_boundary	= nvme_get_virt_boundary,
+	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
 };
 
 /*
-- 
2.53.0.1213.gd9a14994de-goog


