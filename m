Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B34C10F13
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86QPUxD7fzPZOrhagjgMOSlG5abPnKt4lm0KTc4m3Xo=; b=PFf1M/6pfqPLgzHOa+/u8DcfL8
	5ZQT4vyaW0Hw2CrqNzy8j62UYGHgrPKr+L+oUp19Y+PAFUkmx6h85ec5l+4vasgSK9rI1Kupg48To
	8z85Vj2U/jF1e6gHwdqGWqHrPTzbYo3yEMoVIlTXSN+DpOF9BoTKx6mLnWHfY/v3/36jeuBswx7hg
	+yjCE74GcsYbmdidWtnLGRQDXed7w7mwZhk0qdrTc+YSHd+H7H5VAwSiENu5yUJRk3lQIaWP5jM1N
	GwVB6LoqeyFO31dDd3FxAopRYcDh9h84G9/hn+DtjYKhN/6iDVyL5Uq65RcBAO/IP4gD1hfWCAwum
	2EFcokww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA0bt-002z16-0X;
	Mon, 04 Dec 2023 04:31:09 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r92EC-00DVfX-30;
	Fri, 01 Dec 2023 12:02:42 +0000
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ShWmn704Gz1P91G;
	Fri,  1 Dec 2023 19:58:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 20:02:30 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, John
 Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
	<Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, <linux-mm@kvack.org>
Subject: [PATCH RFC 5/6] net: introduce page_frag_cache_drain()
Date: Fri, 1 Dec 2023 20:02:06 +0800
Message-ID: <20231201120208.15080-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201120208.15080-1-linyunsheng@huawei.com>
References: <20231201120208.15080-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_040241_335591_24BEB58C 
X-CRM114-Status: GOOD (  14.54  )
X-Mailman-Approved-At: Sun, 03 Dec 2023 20:31:05 -0800
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
index 7ffbd4fca881..df0a3ceaf59b 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -286,7 +286,6 @@ mtk_wed_wo_queue_free(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 static void
 mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
 	int i;
 
 	for (i = 0; i < q->n_desc; i++) {
@@ -298,19 +297,12 @@ mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
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
 
@@ -320,12 +312,7 @@ mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
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
index 89661a9cf850..8d4f4a06f9d9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1338,7 +1338,6 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noreclaim_flag;
@@ -1349,11 +1348,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
index 92b74d0b8686..f9a553d70a61 100644
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


