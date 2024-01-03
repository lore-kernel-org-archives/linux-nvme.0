Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092FAC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPfRm0RxHNeiMA1fbdeDjZpspbrje3JC2BDkcjIVSZs=; b=JHqtISFq0oD9Hs31Bd458iG1Fw
	IPjKgfcCggvJJT40VXIIW+AgygQ5xXmp1EYJ4v9VZxQRZK6xY0N+SUAQFJ7mvX0Mzd1vgrkZhzvgU
	GSM9zkMdv75yo1azth2xA2E4XZf0Mg2k/dwm0qND5uSqihrXCTxGs75Tx6fz+GMOFf02gLD9NrJux
	9r3T2xexreURmGi5lcouHoYFpEh4EukQWMlxsoIa8qTt3ptSkPi1nCHG3sO9q75UznUXog55JCkBY
	d2JzF/YDTR7JI4f/tBvTIYWD8y5gh/5CeUSRqG1mIlBuspThb2rgHrw7Pckuo3iQJ//kgFlONF5U6
	HHoUTCVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKyl6-00AQXZ-2C;
	Wed, 03 Jan 2024 10:46:00 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKy0N-00AJ7D-27;
	Wed, 03 Jan 2024 09:57:46 +0000
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T4lR93hNjz1FHNv;
	Wed,  3 Jan 2024 17:53:41 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5586B1404F1;
	Wed,  3 Jan 2024 17:57:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:57:27 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jason Wang <jasowang@redhat.com>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
Date: Wed, 3 Jan 2024 17:56:48 +0800
Message-ID: <20240103095650.25769-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240103095650.25769-1-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_015744_003203_2060B967 
X-CRM114-Status: GOOD (  15.16  )
X-Mailman-Approved-At: Wed, 03 Jan 2024 02:45:58 -0800
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
---
 drivers/net/ethernet/google/gve/gve_main.c | 11 ++---------
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 17 ++---------------
 drivers/nvme/host/tcp.c                    |  7 +------
 drivers/nvme/target/tcp.c                  |  4 +---
 drivers/vhost/net.c                        |  4 +---
 include/linux/gfp.h                        |  2 ++
 mm/page_alloc.c                            | 10 ++++++++++
 7 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 619bf63ec935..d976190b0f4d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1278,17 +1278,10 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 
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
 
 static int gve_open(struct net_device *dev)
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
index 08805f027810..c80037a78066 100644
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
index 4cc27856aa8f..11237557cfc5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1576,7 +1576,6 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
-	struct page *page;
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
@@ -1600,8 +1599,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-	page = virt_to_head_page(queue->pf_cache.va);
-	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 }
 
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 805e11d598e4..4b2fcb228a0a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1386,9 +1386,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
-	if (n->pf_cache.va)
-		__page_frag_cache_drain(virt_to_head_page(n->pf_cache.va),
-					n->pf_cache.pagecnt_bias);
+	page_frag_cache_drain(&n->pf_cache);
 	kvfree(n);
 	return 0;
 }
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index bbd75976541e..03ba079655d3 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -316,6 +316,8 @@ extern void *page_frag_alloc_align(struct page_frag_cache *nc,
 				   unsigned int fragsz, gfp_t gfp_mask,
 				   unsigned int align);
 
+void page_frag_cache_drain(struct page_frag_cache *nc);
+
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 			     unsigned int fragsz, gfp_t gfp_mask)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 083e0c38fb62..5a0e68edcb05 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4716,6 +4716,16 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
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
 void *page_frag_alloc_align(struct page_frag_cache *nc,
 		      unsigned int fragsz, gfp_t gfp_mask,
 		      unsigned int align)
-- 
2.33.0


