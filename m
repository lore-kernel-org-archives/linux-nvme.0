Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B947C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD1B238EC
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1B238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yx0eH+qGSXp6V8OmMRWBbANwlczhuSTtltcUS+wZQXA=; b=xWFQ5rT6IerM7YWWE4oyZ5WmK
	FAS7T04G8kty1Jk8PoIZ9BqfPFE/LaBltGABrXb+mCzL02vZJi181yeWENMowyuqF+R3qHHS+ib2Y
	jezHLL3Vtn4ZxfH2yzuvBI2oHkehecMPeTqbnHKP1EoWvKjmn4cWsfXxoiKbbzGC5rtmmVNHlr2M6
	LFJ8aC5M/qrYeAc85Gd2YMrX1gkWTQMHE9pNx+aG1U3nxdE5VaZRYglcQXDvCNveqsQ/1sQ5/OnbH
	SZsqAqSAzKYhmxJrHAQWox79ewq8rAgd/RQ4VlYFBUXB4QXa0BQGCv9NkRUDt0riHzE+bww0sd8jI
	UWp79lw+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmNjK-00019r-TQ; Mon, 07 Dec 2020 21:07:34 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmNil-0000us-6w
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:07:11 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 7 Dec 2020 23:06:54 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7L6qIN029788;
 Mon, 7 Dec 2020 23:06:54 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH v1 net-next 15/15] net/mlx5e: NVMEoTCP workaround CRC after
 resync
Date: Mon,  7 Dec 2020 23:06:49 +0200
Message-Id: <20201207210649.19194-16-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201207210649.19194-1-borisp@mellanox.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_160700_246873_E2AC621C 
X-CRM114-Status: GOOD (  15.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yoray Zack <yorayz@nvidia.com>

The nvme-tcp crc computed over the first packet after resync may provide
the wrong signal when the packet contains multiple PDUs. We workaround
that by ignoring the cqe->nvmeotcp_crc signal for the first packet after
resync.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c         |  1 +
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h         |  3 +++
 .../mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c    | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 12 ++++--------
 include/linux/mlx5/device.h                        |  4 ++--
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 756decf53930..e9f7f8b17c92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -844,6 +844,7 @@ mlx5e_nvmeotcp_dev_resync(struct net_device *netdev,
 	struct mlx5e_nvmeotcp_queue *queue =
 				(struct mlx5e_nvmeotcp_queue *)tcp_ddp_get_ctx(sk);
 
+	queue->after_resync_cqe = 1;
 	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 5be300d8299e..a309971e11b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -50,6 +50,7 @@ struct mlx5e_nvmeotcp_sq {
  *	@ccoff_inner: Current offset within the @ccsglidx element
  *	@priv: mlx5e netdev priv
  *	@inv_done: invalidate callback of the nvme tcp driver
+ *	@after_resync_cqe: indicate if resync occurred
  */
 struct mlx5e_nvmeotcp_queue {
 	struct tcp_ddp_ctx		tcp_ddp_ctx;
@@ -82,6 +83,8 @@ struct mlx5e_nvmeotcp_queue {
 
 	/* for flow_steering flow */
 	struct completion		done;
+	/* for MASK HW resync cqe */
+	bool				after_resync_cqe;
 };
 
 struct mlx5e_nvmeotcp {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index 298558ae2dcd..4b813de592be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -175,6 +175,20 @@ mlx5e_nvmeotcp_handle_rx_skb(struct net_device *netdev, struct sk_buff *skb,
 		return skb;
 	}
 
+#ifdef CONFIG_TCP_DDP_CRC
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	skb->ddp_crc = queue->after_resync_cqe ? 0 :
+		cqe_is_nvmeotcp_crcvalid(cqe);
+	queue->after_resync_cqe = 0;
+#endif
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return skb;
+	}
+
 	stats = priv->channels.c[queue->channel_ix]->rq.stats;
 
 	/* cc ddp from cqe */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2688396d21f8..960aee0d5f0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1079,10 +1079,6 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 	if (unlikely(mlx5_ipsec_is_rx_flow(cqe)))
 		mlx5e_ipsec_offload_handle_rx_skb(netdev, skb, cqe);
 
-#if defined(CONFIG_TCP_DDP_CRC) && defined(CONFIG_MLX5_EN_NVMEOTCP)
-	skb->ddp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
-#endif
-
 	if (lro_num_seg > 1) {
 		mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
 		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt, lro_num_seg);
@@ -1197,7 +1193,7 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 	page_ref_inc(di->page);
 
 #if defined(CONFIG_TCP_DDP) && defined(CONFIG_MLX5_EN_NVMEOTCP)
-	if (cqe_is_nvmeotcp_zc_or_resync(cqe))
+	if (cqe_is_nvmeotcp(cqe))
 		skb = mlx5e_nvmeotcp_handle_rx_skb(rq->netdev, skb, cqe,
 						   cqe_bcnt, true);
 #endif
@@ -1253,7 +1249,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 	skb->len  += headlen;
 
 #if defined(CONFIG_TCP_DDP) && defined(CONFIG_MLX5_EN_NVMEOTCP)
-	if (cqe_is_nvmeotcp_zc_or_resync(cqe))
+	if (cqe_is_nvmeotcp(cqe))
 		skb = mlx5e_nvmeotcp_handle_rx_skb(rq->netdev, skb, cqe,
 						   cqe_bcnt, false);
 #endif
@@ -1486,7 +1482,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	skb->len  += headlen;
 
 #if defined(CONFIG_TCP_DDP) && defined(CONFIG_MLX5_EN_NVMEOTCP)
-	if (cqe_is_nvmeotcp_zc_or_resync(cqe))
+	if (cqe_is_nvmeotcp(cqe))
 		skb = mlx5e_nvmeotcp_handle_rx_skb(rq->netdev, skb, cqe,
 						   cqe_bcnt, false);
 #endif
@@ -1539,7 +1535,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	page_ref_inc(di->page);
 
 #if defined(CONFIG_TCP_DDP) && defined(CONFIG_MLX5_EN_NVMEOTCP)
-	if (cqe_is_nvmeotcp_zc_or_resync(cqe))
+	if (cqe_is_nvmeotcp(cqe))
 		skb = mlx5e_nvmeotcp_handle_rx_skb(rq->netdev, skb, cqe,
 						   cqe_bcnt, true);
 #endif
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index ea4d158e8329..ae879576e371 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -882,9 +882,9 @@ static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
 	return ((cqe->nvmetcp >> 4) & 0x1);
 }
 
-static inline bool cqe_is_nvmeotcp_zc_or_resync(struct mlx5_cqe64 *cqe)
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
 {
-	return ((cqe->nvmetcp >> 4) & 0x5);
+	return ((cqe->nvmetcp >> 4) & 0x7);
 }
 
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
