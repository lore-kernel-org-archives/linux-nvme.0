Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42451C4332E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:12:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3AC23A5F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3AC23A5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iZj7G0rqfC4nRW9fw59xNqh9HYcomAVCvXVcXx2S/tE=; b=turgoUM4Vr8SBcm+al43WDWFB
	07Z2Yw1zjI9CFVmgS/3Bzxi4Ok5mlTWNY3ME8Un7CBWXnSh9hCGLiQDU1UE0OiyT+Hgka2BvR0H2f
	i3GNzfABTbBONXPD4mZRyamp3DS70dMW726t++3fdPsPq2m/MzMNvW+y3hBW6N1ZS54tx/CEi3I3O
	NeMVhEXhNr/JzCWdoCahgb5ILoonT8O/D5rPMpppr6x5SKS/Ybo1+HeQzv1YY0yqU2xxAV3oCC8kC
	/6u9EohIQQYdxd9LZh/3itzkvUAbjai6NwtvIfX9gSf/kwgHz8BuRFWk7gC+cfSjh1p5ZGCbFZ57Y
	M4B7b74AA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l04HY-0000wL-BK; Thu, 14 Jan 2021 15:11:28 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l04Gv-0000gI-W1
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 15:11:02 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 14 Jan 2021 17:10:45 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 10EFAh0H000835;
 Thu, 14 Jan 2021 17:10:45 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, dsahern@gmail.com,
 smalin@marvell.com
Subject: [PATCH v2 net-next 17/21] net/mlx5e: NVMEoTCP async ddp invalidation
Date: Thu, 14 Jan 2021 17:10:29 +0200
Message-Id: <20210114151033.13020-18-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210114151033.13020-1-borisp@mellanox.com>
References: <20210114151033.13020-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_101050_902863_09A707B4 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-Ishay <benishay@nvidia.com>

Teardown ddp contexts asynchronously by posting a WQE, and calling back
to nvme-tcp when the corresponding CQE is received.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f00d76f1ded4..eb929edabd6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -36,6 +36,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVME_TCP,
+	MLX5E_ICOSQ_WQE_UMR_NVME_TCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVME_TCP,
 #endif
 };
@@ -184,6 +185,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 3a42477f1bd7..22fa1e9f3e7a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -152,6 +152,7 @@ enum wqe_type {
 	BSF_KLM_UMR = 1,
 	SET_PSV_UMR = 2,
 	BSF_UMR = 3,
+	KLM_INV_UMR = 4,
 };
 
 static void
@@ -208,6 +209,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
 				   MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, KLM_ALIGNMENT)));
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask |= cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 						MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -306,8 +314,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqe_bbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqe_bbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -316,12 +324,17 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 	case SET_PSV_UMR:
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVME_TCP;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVME_TCP_INVALIDATE;
+		break;
 	default:
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVME_TCP;
 		break;
 	}
 
-	if (type == SET_PSV_UMR)
+	if (type == KLM_INV_UMR)
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+	else if (type == SET_PSV_UMR)
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 }
 
@@ -336,7 +349,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqe_bbs = MLX5E_NVMEOTCP_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqe_bbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqe_bbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->zerocopy, queue->crc_rx);
 	sq->pc += wqe_bbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -353,7 +366,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqe_bbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqe_bbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqe_bbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqe_bbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -377,7 +390,8 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqe_bbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqe_bbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqe_bbs, pi, ccid,
+			       klm_length ? KLM_UMR : KLM_INV_UMR);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, *klm_offset,
 			       klm_length, wqe_type);
 	*klm_offset += cur_klm_entries;
@@ -395,8 +409,13 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	struct mlx5e_icosq *sq = &queue->sq->icosq;
 
 	/* TODO: set stricter wqe_sz; using max for now */
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
-	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(queue->max_klms_per_wqe);
+	if (klm_length == 0) {
+		wqes = 1;
+		wqe_sz = MLX5E_NVMEOTCP_STATIC_PARAMS_WQEBBS;
+	} else {
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+		wqe_sz = MLX5E_KLM_UMR_WQE_SZ(queue->max_klms_per_wqe);
+	}
 
 	max_wqe_bbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 
@@ -735,6 +754,24 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	return 0;
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct tcp_ddp_io *ddp = q_entry->ddp;
+	const struct tcp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     q_entry->sgl_length, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 void mlx5e_nvmeotcp_ctx_comp(struct mlx5e_icosq_wqe_info *wi)
 {
 	struct mlx5e_nvmeotcp_queue *queue = wi->nvmeotcp_q.queue;
@@ -751,6 +788,19 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct tcp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		(struct mlx5e_nvmeotcp_queue *)tcp_ddp_get_ctx(sk);
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct nvmeotcp_queue_entry *q_entry;
+
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ON(q_entry->sgl_length == 0);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index d0e515502d6d..5a613addfc7c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -103,6 +103,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_comp(struct mlx5e_icosq_wqe_info *wi);
 int mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv);
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 056fc24dd5ed..598d62366af2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -630,6 +630,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 		case MLX5E_ICOSQ_WQE_UMR_NVME_TCP:
 			break;
+		case MLX5E_ICOSQ_WQE_UMR_NVME_TCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVME_TCP:
 			mlx5e_nvmeotcp_ctx_comp(wi);
 			break;
@@ -707,6 +710,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVME_TCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVME_TCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVME_TCP:
 				mlx5e_nvmeotcp_ctx_comp(wi);
 				break;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
