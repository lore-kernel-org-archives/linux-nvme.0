Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E94C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 05:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+B8u7VsaUllcnXwbLyKAgESHBOIGfavqAoty/yFi8Mo=; b=HFDNkCfAhBxcaRz0cr8+HOXv5j
	O5DwCuNoFd+DLQfiNRgSi1qrxsLSHKO+I0zo4TTJ6e4tfIMc4n4XDSaCbm4l/XYRFjhh3cntIW5B0
	mGn9iKbO+Md9ua83Ny7/T7OXPIJDO50lbR308U17PWvP234AgncFl6He12y3Aisp+z6OsmcQAvtAi
	Fy0a9FN6LuEvGBXYiivYwOnWQlYxHHnS7eIhVdYnjKPOZEQOHiq9gaMk2bk0EJt6e0B+9aJ4ydHlJ
	K/KQPDrV8tu4y+E7ykUhu7qv+JIQxUzgK8QrkUwZzUfachKvZUNiZn87Hjo9KoSNAS+QsI/heVghR
	pCJW08Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4Lg-0000000DhMs-3tks;
	Mon, 29 Jun 2026 05:16:00 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4LV-0000000DhKM-42F4
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 05:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782710151; x=1814246151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPRRKkSsO/67nTG5mbNmoNWxGwYQWQ1m2DLERmXcovI=;
  b=lXRFZTmJJlMWKMw14scCfcEIclp6fTjfKA4nl4SJYWUbSK7A97Oka8ev
   y9cyhUZb8QBtHzkRabHpppNHfFvSp0oa+87mxZQWuujb8i4y6aJBHQIYT
   FUHgKNP6wx0z6iFy4o2d0/3JXauImcRX3i9noPs7Y02YNWkAArAT5KZbO
   CpfNbwEiCKNVLz/qFkO67jzYhJTCCDLVDSlE54v4i9Rt4ZiV6vSD2S/KB
   CTK6s07/vaKASQV54C4prd8dnQTLqOWVOKld8LoJjHl2c37+UA7cV/N/W
   xdU22pEjNEmBsenpzMsl3LtsWfS2j0sZcf8uHkDZFHFlWd6YvKWWSbv/Z
   Q==;
X-CSE-ConnectionGUID: pVMjrEvuSPmIBXwTawu/eg==
X-CSE-MsgGUID: 4ZK9qLD1SsSP/6max0+hig==
X-IronPort-AV: E=Sophos;i="6.24,231,1774281600"; 
   d="scan'208";a="150909811"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2026 13:15:47 +0800
X-CSE-ConnectionGUID: DRSXGIx1SW6F6DZzjQF7kQ==
X-CSE-MsgGUID: cBCZTkgRSRGlC63euvjjHA==
IronPort-SDR: 6a41ff74_LI+x8bUGo6KUXnPhPId3vxPX7byu2Rb3nI5DltHur8ycw3e
 0l5MoZX3sNWIWX2M6plN8GruyoGSb/5o4YAjTXg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2026 22:15:31 -0700
X-CSE-ConnectionGUID: 67XX8wMkSCGkkzbioj24NA==
X-CSE-MsgGUID: WBTIzVKvQuqNaPJgj+M9+w==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 28 Jun 2026 22:15:31 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvmet-rdma: factor out response resource cleanup
Date: Mon, 29 Jun 2026 14:15:27 +0900
Message-ID: <20260629051529.810925-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
References: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_221550_066263_A11D637D 
X-CRM114-Status: GOOD (  13.60  )
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

Move the RDMA read/write context teardown and the request SGL freeing
out of nvmet_rdma_release_rsp() into a new helper function
nvmet_rdma_free_rsp_resources().

This is a refactoring with no functional change, in preparation for the
following patch that uses nvmet_rdma_free_rsp_resources().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ea1185b8267e..3c34f235e542 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -657,18 +657,25 @@ static void nvmet_rdma_rw_ctx_destroy(struct nvmet_rdma_rsp *rsp)
 				    req->sg, req->sg_cnt, nvmet_data_dir(req));
 }
 
-static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
+static void nvmet_rdma_free_rsp_resources(struct nvmet_rdma_rsp *rsp)
 {
 	struct nvmet_rdma_queue *queue = rsp->queue;
 
-	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
-
 	if (rsp->n_rdma)
 		nvmet_rdma_rw_ctx_destroy(rsp);
 
 	if (rsp->req.sg < rsp->cmd->inline_sg ||
 	    rsp->req.sg >= rsp->cmd->inline_sg + queue->dev->inline_page_count)
 		nvmet_req_free_sgls(&rsp->req);
+}
+
+static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
+{
+	struct nvmet_rdma_queue *queue = rsp->queue;
+
+	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
+
+	nvmet_rdma_free_rsp_resources(rsp);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
 		nvmet_rdma_process_wr_wait_list(queue);
-- 
2.54.0


