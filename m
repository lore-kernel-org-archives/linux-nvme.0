From: talgi@mellanox.com (Tal Gilboa)
Date: Wed,  6 Mar 2019 10:48:30 +0200
Subject: [RFC/PATCH net-next 7/9] linux/dim: Add completions count to
 dim_sample
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
Message-ID: <20190306084832.57753-8-talgi@mellanox.com>

From: Yamin Friedman <yaminf@mellanox.com>

Added a measurement of completions per/msec to allow for completion based dim
algorithms.

Signed-off-by: Yamin Friedman <yaminf at mellanox.com>
Signed-off-by: Tal Gilboa <talgi at mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c        |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c |  4 ++--
 include/linux/dim.h                               |  7 ++++++-
 lib/dim/dim.c                                     | 11 ++++++++++-
 lib/dim/net_dim.c                                 |  2 +-
 7 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 840b3bf1ae3e..df38c8fd373f 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1035,7 +1035,7 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 
 	if (priv->dim.use_dim) {
 		dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
-				  priv->dim.bytes, &dim_sample);
+				  priv->dim.bytes, 0, &dim_sample);
 		net_dim(&priv->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 131ab07aad83..516703ac0009 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2110,6 +2110,7 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 		dim_create_sample(cpr->event_ctr,
 				  cpr->rx_packets,
 				  cpr->rx_bytes,
+				  0,
 				  &dim_sample);
 		net_dim(&cpr->dim, dim_sample);
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 68d96e333c6d..aca82ef12d28 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1910,7 +1910,7 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 
 	if (ring->dim.use_dim) {
 		dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
-				  ring->dim.bytes, &dim_sample);
+				  ring->dim.bytes, 0, &dim_sample);
 		net_dim(&ring->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 432474754d77..76fc57762083 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -53,7 +53,7 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_AM, &sq->state)))
 		return;
 
-	dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, 0, &dim_sample);
 	net_dim(&sq->dim, dim_sample);
 }
 
@@ -65,7 +65,7 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_AM, &rq->state)))
 		return;
 
-	dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
+	dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, 0, &dim_sample);
 	net_dim(&rq->dim, dim_sample);
 }
 
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 88a74cd83d95..39b621dc8e3e 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -45,6 +45,7 @@
 struct dim_cq_moder {
 	u16 usec;
 	u16 pkts;
+	u16 comps;
 	u8 cq_period_mode;
 };
 
@@ -53,18 +54,22 @@ struct dim_sample {
 	u32     pkt_ctr;
 	u32     byte_ctr;
 	u16     event_ctr;
+	u32     comp_ctr;
 };
 
 struct dim_stats {
 	int ppms; /* packets per msec */
 	int bpms; /* bytes per msec */
 	int epms; /* events per msec */
+	int cpms; /* completions per msec */
+	int cpe_ratio; /* ratio of completions to events */
 };
 
 struct dim { /* Dynamic Interrupt Moderation */
 	u8                                      state;
 	struct dim_stats                        prev_stats;
 	struct dim_sample                       start_sample;
+	struct dim_sample                       measuring_sample;
 	struct work_struct                      work;
 	u8                                      profile_ix;
 	u8                                      mode;
@@ -113,7 +118,7 @@ void dim_park_on_top(struct dim *dim);
 
 void dim_park_tired(struct dim *dim);
 
-void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s);
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, u64 comps, struct dim_sample *s);
 
 void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 		    struct dim_stats *curr_stats);
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 93e1ddd701b0..b7283f1cb000 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -54,12 +54,13 @@ void dim_park_tired(struct dim *dim)
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s)
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, u64 comps, struct dim_sample *s)
 {
 	s->time	     = ktime_get();
 	s->pkt_ctr   = packets;
 	s->byte_ctr  = bytes;
 	s->event_ctr = event_ctr;
+	s->comp_ctr  = comps;
 }
 EXPORT_SYMBOL(dim_create_sample);
 
@@ -71,6 +72,8 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
 	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
 			     start->byte_ctr);
+	u32 ncomps = BIT_GAP(BITS_PER_TYPE(u32), end->comp_ctr,
+			     start->comp_ctr);
 
 	if (!delta_us)
 		return;
@@ -79,5 +82,11 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
 	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
 					delta_us);
+	curr_stats->cpms = DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
+	if (curr_stats->epms != 0)
+		curr_stats->cpe_ratio = (curr_stats->cpms * 100) / curr_stats->epms;
+	else
+		curr_stats->cpe_ratio = 0;
+
 }
 EXPORT_SYMBOL(dim_calc_stats);
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index cf95cd20cf02..10605b77bbc5 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -183,7 +183,7 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
 		/* fall through */
 	case DIM_START_MEASURE:
 		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
-				  end_sample.byte_ctr, &dim->start_sample);
+				  end_sample.byte_ctr, 0, &dim->start_sample);
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
 	case DIM_APPLY_NEW_PROFILE:
-- 
2.19.1
