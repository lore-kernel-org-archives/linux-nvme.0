Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D43C43327
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNruNrtELMCDSkeLvhdYt98meVygRYHwINz89asKZqk=; b=mqaqvR/nadEH1nB1Gj21Z9CX+O
	yBpONdnkcPRIKHydZhoudkFPPeWCnH/so/yOe4uvq/HY+stHEF5B5vx8R99gLaHLrDqRYbb/P/NV6
	eqpoQ++4PXnT78AJ4Jif8HScdRO4yHfBC4Lc6fQVC/Uqj1KMfEooreUVbs9DHTMEwGBw5gGEhYBSO
	AcXb24RlKsyJC7vgVt+RLQLxSPqrzdpKcPwgYhHMjzfi7jzg8T9UXK+UVi8K4uLdioAdJO0go0PfS
	jbVyyQu+JD9tXJS6MSRes/hIu9tnnJIxHpZNtJVh05vTCmmP9ZaOhZ+tm/eCpMjPV4DEKvXFWJGfC
	sT87x9+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4La-0000000DhLx-3Oqt;
	Mon, 29 Jun 2026 05:15:54 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we4LW-0000000DhKt-0kkl
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 05:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782710151; x=1814246151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DoIqrJilPkXnz4B18AvFiA2xFOShKOgo4CWDov633M=;
  b=FwqtDRWkts27sNfy9ZtVSi9ddypbaMSoECwQ/cW3oZfghrZaafR7bjxR
   7LFZqkNMIcq6t9Sl2L74RP6SQs0t1T5bw07b4ssduISeO7UJ7MC4QVdsy
   SH9rhu7RUv57Ot0Ul5VlQeBnsgHqGJth8qjVFRSFw2CtJIIkQHDuR6pGk
   lzXCwg6h7ywn9ZyhpneMBs5HbmdAbKZmqZViHo+fDa8VuJXbUSVq3V5V5
   9Q1fXAOHNbK4PudB+h52wEgs7fkhq8rqdkQRBHEzg+HSKyEJhnkWWvDLZ
   mpv4FWAGnIHtP5tB2i6ic7n6hFVn+cewNemhY5s3eikmlhjj77BE/WWQ/
   A==;
X-CSE-ConnectionGUID: FeDWhDvZTOmvNVCcgW2JrQ==
X-CSE-MsgGUID: OyO82FtQSDGG78JYjFBaLw==
X-IronPort-AV: E=Sophos;i="6.24,231,1774281600"; 
   d="scan'208";a="150909812"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2026 13:15:47 +0800
X-CSE-ConnectionGUID: e3vgXoPwRemxJx9YOM1usQ==
X-CSE-MsgGUID: 1zD6SUzmQo2kmCrwGq2o7g==
IronPort-SDR: 6a41ff75_NSd5mcJljF3H03aWJEUNcsgpzyFi5FloyK55t2YPYKbkjj+
 U6FlC0wqm+gcnU1t57RlORJkZPvqyi0CPATJ8ew==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2026 22:15:32 -0700
X-CSE-ConnectionGUID: GASTXjM+TrK975qtvevj3g==
X-CSE-MsgGUID: 7Akzlz/0QamXtupu1k7l1g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 28 Jun 2026 22:15:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvmet-rdma: fix response resource leak on queue teardown
Date: Mon, 29 Jun 2026 14:15:28 +0900
Message-ID: <20260629051529.810925-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
References: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_221550_279641_74B98E38 
X-CRM114-Status: GOOD (  15.81  )
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

When an nvme target with rdma transport is removed while I/Os are in
flight, a response can be posted but its send completion is never
delivered before the connection is torn down. As a result
nvmet_rdma_send_done() and nvmet_rdma_release_rsp() are never called for
the response, and this leaks the allocated RDMA read/write context and
request SGLs.

These leaks are recreated by running blktests nvme/061 with the rdma
transport and the siw driver. Kernel kmemleak feature reports them as
follows:

  unreferenced object 0xffff88812bc490c0 (size 32):
    comm "kworker/2:1H", pid 409, jiffies 4307744490
    backtrace (crc 89afd339):
      __kmalloc_noprof+0x5f9/0x890
      sgl_alloc_order+0x7b/0x380
      nvmet_req_alloc_sgls+0x290/0x4f0 [nvmet]
      nvmet_rdma_map_sgl_keyed+0x241/0x12e0 [nvmet_rdma]
      nvmet_rdma_handle_command+0x73e/0xb80 [nvmet_rdma]
      __ib_process_cq+0x149/0x4c0 [ib_core]
      ib_cq_poll_work+0x49/0x160 [ib_core]
      process_one_work+0x8b2/0x1640
      worker_thread+0x5fd/0xfe0
      kthread+0x367/0x460
      ret_from_fork+0x655/0x9d0
      ret_from_fork_asm+0x1a/0x30

  unreferenced object 0xffff88814bd05e80 (size 64):
    comm "kworker/3:1H", pid 148, jiffies 4295195428
    backtrace (crc e35510cb):
      __kmalloc_noprof+0x5f9/0x890
      rdma_rw_ctx_init+0x333/0x1fa0 [ib_core]
      nvmet_rdma_map_sgl_keyed+0x5c8/0x12e0 [nvmet_rdma]
      nvmet_rdma_handle_command+0x73e/0xb80 [nvmet_rdma]
      __ib_process_cq+0x149/0x4c0 [ib_core]
      ib_cq_poll_work+0x49/0x160 [ib_core]
      process_one_work+0x8b2/0x1640
      worker_thread+0x5fd/0xfe0
      kthread+0x367/0x460
      ret_from_fork+0x655/0x9d0
      ret_from_fork_asm+0x1a/0x30

To avoid the memory leaks, reclaim the memory of the in-flight responses
when the queue QP is torn down. Call nvmet_rdma_free_rsp_resources()
that frees up the RDMA read/write context and the request SGLs of such
responses.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/rdma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3c34f235e542..de5a88fbb233 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1345,9 +1345,27 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	goto out;
 }
 
+static bool nvmet_rdma_reclaim_rsp(struct sbitmap *sb, unsigned int bitnr,
+				   void *data)
+{
+	struct nvmet_rdma_queue *queue = data;
+
+	nvmet_rdma_free_rsp_resources(&queue->rsps[bitnr]);
+
+	return true;
+}
+
 static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 {
 	ib_drain_qp(queue->qp);
+
+	/*
+	 * Reclaim resources of a response that is still in-flight when the
+	 * queue is being torn down. This happens when the connection was
+	 * forcefully disconnected while an I/O is in flight.
+	 */
+	sbitmap_for_each_set(&queue->rsp_tags, nvmet_rdma_reclaim_rsp, queue);
+
 	if (queue->cm_id)
 		rdma_destroy_id(queue->cm_id);
 	ib_destroy_qp(queue->qp);
-- 
2.54.0


