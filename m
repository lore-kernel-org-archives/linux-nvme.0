Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8838AC48285
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LFeLLnJaR3JtjOxpUpdms1bffkbapejcBiKMtBdfGb8=; b=nJl9bDh1KNUcI2KH80H5uZxV+i
	vlngzTJKK+le5JZmkub6Kp/7dAC/X8KYunzIxgN+LcEUjcRr3Zb1kT96tuF/gBjV28LgoqEe+KMK5
	PayW17pdrs4oOQ6O4+S1rYzANXfiTLNWCGp/o6pSCWCy2LNeCUspRRMbVanxePKuH+Mk8wYXUw5d+
	ZMX480iiaZuPQJqYg++mYPP3QBRA/WFrwRQhOxBVj8AZO/XzZUuhrtj0+0/7i0e1L2TjrOIpVPjyw
	P3d+ckXLS5LilvhFfgtgGqgpr/8gxCgdmV42vNP/Vplelus4nHzYm/wM3c/s1RnXCFDbUmoM4Cscw
	cRtXrmng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmRZ-0000000GUSq-0NI4;
	Tue, 30 Jan 2024 11:38:21 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUmRM-0000000GULS-3Mvj;
	Tue, 30 Jan 2024 11:38:10 +0000
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TPNR22P6rz1gy1H;
	Tue, 30 Jan 2024 19:36:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B48431404D7;
	Tue, 30 Jan 2024 19:38:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:38:03 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jason Wang <jasowang@redhat.com>, Alexander Duyck
	<alexanderduyck@fb.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v4 3/5] net: introduce page_frag_cache_drain()
Date: Tue, 30 Jan 2024 19:37:08 +0800
Message-ID: <20240130113710.34511-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240130113710.34511-1-linyunsheng@huawei.com>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_033809_224481_111FB885 
X-CRM114-Status: GOOD (  14.81  )
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

When draining a page_frag_cache, most user are doing
the similar steps, so introduce an API to avoid code
duplication.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 11 ++---------
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 17 ++---------------
 drivers/nvme/host/tcp.c                    |  7 +------
 drivers/nvme/target/tcp.c                  |  4 +---
 include/linux/gfp.h                        |  1 +
 mm/page_alloc.c                            | 10 ++++++++++
 6 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index db6d9ae7cd78..dec6458bb8d7 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1276,17 +1276,10 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
-	struct page_frag_cache *nc;
 	int i;
 
-	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
-		nc = &priv->rx[i].page_cache;
-		if (nc->va) {
-			__page_frag_cache_drain(virt_to_page(nc->va),
-						nc->pagecnt_bias);
-			nc->va = NULL;
-		}
-	}
+	for (i = 0; i < priv->rx_cfg.num_queues; i++)
+		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
 
 static void gve_qpls_get_curr_alloc_cfg(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index d58b07e7e123..7063c78bd35f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -286,7 +286,6 @@ mtk_wed_wo_queue_free(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 static void
 mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
 	int i;
 
 	for (i = 0; i < q->n_desc; i++) {
@@ -301,19 +300,12 @@ mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 		entry->buf = NULL;
 	}
 
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
+	page_frag_cache_drain(&q->cache);
 }
 
 static void
 mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
-
 	for (;;) {
 		void *buf = mtk_wed_wo_dequeue(wo, q, NULL, true);
 
@@ -323,12 +315,7 @@ mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 		skb_free_frag(buf);
 	}
 
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
+	page_frag_cache_drain(&q->cache);
 }
 
 static void
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d058d990532b..22e1fb9c9c0f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1344,7 +1344,6 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noreclaim_flag;
@@ -1355,11 +1354,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
-	if (queue->pf_cache.va) {
-		page = virt_to_head_page(queue->pf_cache.va);
-		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
-		queue->pf_cache.va = NULL;
-	}
+	page_frag_cache_drain(&queue->pf_cache);
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	/* ->sock will be released by fput() */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..56224dc59f17 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1591,7 +1591,6 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
-	struct page *page;
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
@@ -1615,8 +1614,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-	page = virt_to_head_page(queue->pf_cache.va);
-	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 28aea17fa59b..6cef1c241180 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -311,6 +311,7 @@ extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 struct page_frag_cache;
+void page_frag_cache_drain(struct page_frag_cache *nc);
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
 			      gfp_t gfp_mask, unsigned int align_mask);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 636145c29f70..06aa1ebbd21c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4699,6 +4699,16 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+void page_frag_cache_drain(struct page_frag_cache *nc)
+{
+	if (!nc->va)
+		return;
+
+	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
+	nc->va = NULL;
+}
+EXPORT_SYMBOL(page_frag_cache_drain);
+
 void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-- 
2.33.0


