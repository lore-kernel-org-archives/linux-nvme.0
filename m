From: talgi@mellanox.com (Tal Gilboa)
Date: Wed,  6 Mar 2019 10:48:26 +0200
Subject: [RFC/PATCH net-next 3/9] linux/dim: Rename externally exposed macros
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
Message-ID: <20190306084832.57753-4-talgi@mellanox.com>

Renamed macros in use by external drivers.

Signed-off-by: Tal Gilboa <talgi at mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c     |  4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c  |  2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en_dim.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 10 +++++-----
 include/linux/dim.h                            | 12 ++++++------
 include/linux/net_dim.h                        | 18 +++++++++---------
 8 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index f9521d0274b7..0dbdef541f3c 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1114,7 +1114,7 @@ static void bcm_sysport_dim_work(struct work_struct *work)
 			net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	bcm_sysport_set_rx_coalesce(priv, cur_profile.usec, cur_profile.pkts);
-	dim->state = NET_DIM_START_MEASURE;
+	dim->state = DIM_START_MEASURE;
 }
 
 /* RX and misc interrupt routine */
@@ -1466,7 +1466,7 @@ static void bcm_sysport_init_dim(struct bcm_sysport_priv *priv,
 	struct bcm_sysport_net_dim *dim = &priv->dim;
 
 	INIT_WORK(&dim->dim.work, cb);
-	dim->dim.mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	dim->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	dim->event_ctr = 0;
 	dim->packets = 0;
 	dim->bytes = 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6a512871176b..08d0679ccf63 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7673,7 +7673,7 @@ static void bnxt_enable_napi(struct bnxt *bp)
 
 		if (bp->bnapi[i]->rx_ring) {
 			INIT_WORK(&cpr->dim.work, bnxt_dim_work);
-			cpr->dim.mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+			cpr->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 		}
 		napi_enable(&bp->bnapi[i]->napi);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
index afa97c8bb081..16a4588709d1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c
@@ -28,5 +28,5 @@ void bnxt_dim_work(struct work_struct *work)
 	cpr->rx_ring_coal.coal_bufs = cur_moder.pkts;
 
 	bnxt_hwrm_set_ring_coal(bnapi->bp, bnapi);
-	dim->state = NET_DIM_START_MEASURE;
+	dim->state = DIM_START_MEASURE;
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 983245c0867c..eee48dae8ed5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1928,7 +1928,7 @@ static void bcmgenet_dim_work(struct work_struct *work)
 			net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
 	bcmgenet_set_rx_coalesce(ring, cur_profile.usec, cur_profile.pkts);
-	dim->state = NET_DIM_START_MEASURE;
+	dim->state = DIM_START_MEASURE;
 }
 
 /* Assign skb to RX DMA descriptor. */
@@ -2085,7 +2085,7 @@ static void bcmgenet_init_dim(struct bcmgenet_rx_ring *ring,
 	struct bcmgenet_net_dim *dim = &ring->dim;
 
 	INIT_WORK(&dim->dim.work, cb);
-	dim->dim.mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	dim->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	dim->event_ctr = 0;
 	dim->packets = 0;
 	dim->bytes = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index d67adf70a97b..a80303add7c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -38,7 +38,7 @@ mlx5e_complete_dim_work(struct net_dim *dim, struct net_dim_cq_moder moder,
 			struct mlx5_core_dev *mdev, struct mlx5_core_cq *mcq)
 {
 	mlx5_core_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts);
-	dim->state = NET_DIM_START_MEASURE;
+	dim->state = DIM_START_MEASURE;
 }
 
 void mlx5e_rx_dim_work(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 099d307e6f25..7d80f803f445 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -679,11 +679,11 @@ static int mlx5e_alloc_rq(struct mlx5e_channel *c,
 
 	switch (params->rx_cq_moderation.cq_period_mode) {
 	case MLX5_CQ_PERIOD_MODE_START_FROM_CQE:
-		rq->dim.mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE;
+		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
 		break;
 	case MLX5_CQ_PERIOD_MODE_START_FROM_EQE:
 	default:
-		rq->dim.mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+		rq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
 
 	rq->page_cache.head = 0;
@@ -2345,7 +2345,7 @@ static void mlx5e_build_ico_cq_param(struct mlx5e_priv *priv,
 
 	mlx5e_build_common_cq_param(priv, param);
 
-	param->cq_period_mode = NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	param->cq_period_mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 }
 
 static void mlx5e_build_icosq_param(struct mlx5e_priv *priv,
@@ -4545,8 +4545,8 @@ static struct net_dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
 static u8 mlx5_to_net_dim_cq_period_mode(u8 cq_period_mode)
 {
 	return cq_period_mode == MLX5_CQ_PERIOD_MODE_START_FROM_CQE ?
-		NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE :
-		NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+		DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+		DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 }
 
 void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 16ef59524b69..adb20e58bf19 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -75,15 +75,15 @@ struct net_dim { /* Dynamic Interrupt Moderation */
 };
 
 enum {
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
-	NET_DIM_CQ_PERIOD_NUM_MODES
+	DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
+	DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
+	DIM_CQ_PERIOD_NUM_MODES
 };
 
 enum {
-	NET_DIM_START_MEASURE,
-	NET_DIM_MEASURE_IN_PROGRESS,
-	NET_DIM_APPLY_NEW_PROFILE,
+	DIM_START_MEASURE,
+	DIM_MEASURE_IN_PROGRESS,
+	DIM_APPLY_NEW_PROFILE,
 };
 
 enum {
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index 1ce0899b5f30..98ea0bb6f130 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -78,13 +78,13 @@
 }
 
 static const struct net_dim_cq_moder
-rx_profile[NET_DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_RX_EQE_PROFILES,
 	NET_DIM_RX_CQE_PROFILES,
 };
 
 static const struct net_dim_cq_moder
-tx_profile[NET_DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_EQE_PROFILES,
 	NET_DIM_TX_CQE_PROFILES,
 };
@@ -101,7 +101,7 @@ net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
 static inline struct net_dim_cq_moder
 net_dim_get_def_rx_moderation(u8 cq_period_mode)
 {
-	u8 profile_ix = cq_period_mode == NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
 			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
 
 	return net_dim_get_rx_moderation(cq_period_mode, profile_ix);
@@ -119,7 +119,7 @@ net_dim_get_tx_moderation(u8 cq_period_mode, int ix)
 static inline struct net_dim_cq_moder
 net_dim_get_def_tx_moderation(u8 cq_period_mode)
 {
-	u8 profile_ix = cq_period_mode == NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
 			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
 
 	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
@@ -247,7 +247,7 @@ static inline void net_dim(struct net_dim *dim,
 	u16 nevents;
 
 	switch (dim->state) {
-	case NET_DIM_MEASURE_IN_PROGRESS:
+	case DIM_MEASURE_IN_PROGRESS:
 		nevents = BIT_GAP(BITS_PER_TYPE(u16),
 				  end_sample.event_ctr,
 				  dim->start_sample.event_ctr);
@@ -256,17 +256,17 @@ static inline void net_dim(struct net_dim *dim,
 		dim_calc_stats(&dim->start_sample, &end_sample,
 				   &curr_stats);
 		if (net_dim_decision(&curr_stats, dim)) {
-			dim->state = NET_DIM_APPLY_NEW_PROFILE;
+			dim->state = DIM_APPLY_NEW_PROFILE;
 			schedule_work(&dim->work);
 			break;
 		}
 		/* fall through */
-	case NET_DIM_START_MEASURE:
+	case DIM_START_MEASURE:
 		net_dim_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
 			       &dim->start_sample);
-		dim->state = NET_DIM_MEASURE_IN_PROGRESS;
+		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
-	case NET_DIM_APPLY_NEW_PROFILE:
+	case DIM_APPLY_NEW_PROFILE:
 		break;
 	}
 }
-- 
2.19.1
