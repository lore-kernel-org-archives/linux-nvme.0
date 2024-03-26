Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7414CD1280
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4c2nj0CHSI3ZO8dT8kcChD3fJTuTQyR0i2sLr/ivfKU=; b=WbKq2jrCsyNHl0E+yFOza9hGaR
	KmutQ7qupuDy9rq7vRMPmE3Ry0+yM9ipsW3pM+l7/4/EU9Y/7n3wj+ot8Kw1PsOE3wXtRdjF+i+Jm
	/j6+Q4JbyK+Z78XQjSF/2OL598RS7BPdY+gTk3mCejxf3SbZErcjZU/a375dhV2F3U7KH4V7wIhGy
	FyOjIrR68uTAtQxR53GFjPXEyXB0x9uSdJbVIX3GlURldjqetwkKmF148lD4huw+DjCqddLN9aku0
	lWS+n8sLxf/krzB9NuSFncx22AHDSnusZG9x9gDyAbjDZ6wZgr5QuFW+UC94j7vLd6Cz2sL47HyTa
	TUE3jD6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XA-00000004NWv-0YQW;
	Tue, 26 Mar 2024 12:04:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X5-00000004NUZ-37jO
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:04:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2FB6361009;
	Tue, 26 Mar 2024 12:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F9EC433C7;
	Tue, 26 Mar 2024 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454638;
	bh=VgwFIeWqyQc4putVA2M+wwQJ0KVsGYbnTCnBS3Q9bL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOtQ3aqT8qzFuwMNqAozkmhI1LFnI/9qfMKSkJuolIQQv2TPbJ+U1Tyef5B2iEpZh
	 X7gAqZmhPPIrSkanF/uZ5jsdJIlHey1sa+gvY0HbEtOL5rmLzYK/EM/XFskmt+icfr
	 R5oHfOsZGP6NcrtKoCYp0k9SB5XpdQsDwuulATfDgc16purhOWyicZUig/nllpc+ek
	 BF/88aooPVU0qfJ8g23szmhhQsvT2AZXz571q4dtRtq6C8a4aGYsQ4Nu/0CPNNNo3j
	 EfCPaoSEscxsPvsXUDvToEXBBD4c0zvwFUx+iDHoCrDT+CTNOCaQw381g4GNr7tY9h
	 hI7b9dRev6jhg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/7] nvmet-rdma: implement host_traddr()
Date: Tue, 26 Mar 2024 13:03:39 +0100
Message-Id: <20240326120342.105740-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050400_158921_047EA9BA 
X-CRM114-Status: UNSURE (   9.83  )
X-CRM114-Notice: Please train this message.
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 5b8c63e74639..26f12c80f7ea 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2012,6 +2012,17 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
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
@@ -2036,6 +2047,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
+	.host_traddr		= nvmet_rdma_host_port_addr,
 	.get_mdts		= nvmet_rdma_get_mdts,
 	.get_max_queue_size	= nvmet_rdma_get_max_queue_size,
 };
-- 
2.35.3


