Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4891C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDwLFe32Q5zG/ss4qigL8F6lL0rxOQmbLeK4hewed4I=; b=guQ3XaYb17GORvYy1Ed+FlvBzw
	B036PO1SUeM6Nkh6upaXeVggAjDZYvASZyHX9Ui4w1CRXXjHH9j4LldQRHMsJb6TFSv4HiHiSsXhl
	9bcww+ElgwcFnpZazyZVanrwAxCEp2azpeb9MkbZfdmpkamTmAfC7S9qJhJr4IxvN9e43C9VOSlc1
	YsgSE8eFUeQvboL6ja6elBMKsfRlt4t85XMbARvqA/9rCJjDdAdLqvM5fuB/7NOdi8g7U7tW6CQZP
	HJ5aP7LlE/1Z9dIpr4LJWizv8ewO5INNuDvjgnmIr58sIanTZoul50UxuOQgau+Q2e121I3o1A6el
	q0Fd6pjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwV-000000067V9-09kO;
	Fri, 22 Mar 2024 07:03:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwM-000000067Np-2j8C
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAD0761363;
	Fri, 22 Mar 2024 07:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA5C433A6;
	Fri, 22 Mar 2024 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091025;
	bh=KjufsdNbxeKYE4diGzeH8sTRpJzkZUvZHkld/KSpliQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pcq3SN3nOmdekF0Hq5wwEbPXlmS3H6dgZoXQR8NqAF0omd0rICF7XcqJUyMzfFcyl
	 ptDzvMb0y8clvjNL8lPyD1fkjeKPWBD4Cc17y1a4np5TbWA7vop4h3rKXd9BBIHxwX
	 Pt83N+y7TviyeD9ASKVmnjCpFXTh0Bf7cm+D5RTtC0eOIVKzZ8ABOaoE85tWFbXyvU
	 QTk3s/sGcCCQleBjGXjbNA+oK+BiISDPIGtl6FqxiSzKziAfn2MA4wmlVg3fxB91Zm
	 A3fT8wShhPzipD/h99siJ9fZ4jdWM4uzKuRF5b6Zi5gPsc3L/8VNLQbm5u+gAuOPzb
	 4lN3CBhNw3r+g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] nvmet-rdma: implement host_traddr()
Date: Fri, 22 Mar 2024 08:03:29 +0100
Message-Id: <20240322070333.3820-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000347_023570_E86B5298 
X-CRM114-Status: GOOD (  10.29  )
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

Implement callback to display the host transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/rdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f2bb9d95ecf4..99d98296d0ba 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2014,6 +2014,17 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_rdma_host_port_addr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_len)
+{
+	struct nvmet_sq *nvme_sq = ctrl->sqs[0];
+	struct nvmet_rdma_queue *queue =
+		container_of(nvme_sq, struct nvmet_rdma_queue, nvme_sq);
+
+	return snprintf(traddr, traddr_len, "%pISc",
+			(struct sockaddr *)&queue->cm_id->route.addr.dst_addr);
+}
+
 static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 {
 	if (ctrl->pi_support)
@@ -2038,6 +2049,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.host_traddr		= nvmet_rdma_host_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
 };
-- 
2.35.3


