From: talgi@mellanox.com (Tal Gilboa)
Date: Wed,  1 May 2019 17:44:34 +0300
Subject: [PATCH rdma-for-next 4/9] linux/dim: Rename net_dim_sample() to
 net_dim_create_sample()
In-Reply-To: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
References: <1556721879-35987-1-git-send-email-talgi@mellanox.com>
Message-ID: <1556721879-35987-5-git-send-email-talgi@mellanox.com>

In order to avoid confusion between the function and the similarly
named struct.
In preparation for removing the 'net' prefix from dim members.

Signed-off-by: Tal Gilboa <talgi at mellanox.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c        | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 8 ++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c    | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 6 ++----
 include/linux/dim.h                               | 8 ++++----
 include/linux/net_dim.h                           | 4 ++--
 6 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 480089f..7a41ec7 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1028,8 +1028,8 @@ static int bcm_sysport_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (priv->dim.use_dim) {
-		net_dim_sample(priv->dim.event_ctr, priv->dim.packets,
-			       priv->dim.bytes, &dim_sample);
+		net_dim_create_sample(priv->dim.event_ctr, priv->dim.packets,
+				      priv->dim.bytes, &dim_sample);
 		net_dim(&priv->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 21db503..1528620 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2127,10 +2127,10 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 	if (bp->flags & BNXT_FLAG_DIM) {
 		struct net_dim_sample dim_sample;
 
-		net_dim_sample(cpr->event_ctr,
-			       cpr->rx_packets,
-			       cpr->rx_bytes,
-			       &dim_sample);
+		net_dim_create_sample(cpr->event_ctr,
+				      cpr->rx_packets,
+				      cpr->rx_bytes,
+				      &dim_sample);
 		net_dim(&cpr->dim, dim_sample);
 	}
 	mmiowb();
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index eee48da..8ab2d67 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1909,8 +1909,8 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (ring->dim.use_dim) {
-		net_dim_sample(ring->dim.event_ctr, ring->dim.packets,
-			       ring->dim.bytes, &dim_sample);
+		net_dim_create_sample(ring->dim.event_ctr, ring->dim.packets,
+				      ring->dim.bytes, &dim_sample);
 		net_dim(&ring->dim.dim, dim_sample);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index b4af5e1..6dd8202 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -53,8 +53,7 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_AM, &sq->state)))
 		return;
 
-	net_dim_sample(sq->cq.event_ctr, stats->packets, stats->bytes,
-		       &dim_sample);
+	net_dim_create_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&sq->dim, dim_sample);
 }
 
@@ -66,8 +65,7 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 	if (unlikely(!test_bit(MLX5E_RQ_STATE_AM, &rq->state)))
 		return;
 
-	net_dim_sample(rq->cq.event_ctr, stats->packets, stats->bytes,
-		       &dim_sample);
+	net_dim_create_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
 	net_dim(&rq->dim, dim_sample);
 }
 
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 67b80e9..2413021 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -149,10 +149,10 @@ static inline void dim_park_tired(struct net_dim *dim)
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 
-static inline void net_dim_sample(u16 event_ctr,
-				  u64 packets,
-				  u64 bytes,
-				  struct net_dim_sample *s)
+static inline void net_dim_create_sample(u16 event_ctr,
+					 u64 packets,
+					 u64 bytes,
+					 struct net_dim_sample *s)
 {
 	s->time	     = ktime_get();
 	s->pkt_ctr   = packets;
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index d90f96f..93c4e21 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -260,8 +260,8 @@ static inline void net_dim(struct net_dim *dim,
 		}
 		/* fall through */
 	case DIM_START_MEASURE:
-		net_dim_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
-			       &dim->start_sample);
+		net_dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
+				      end_sample.byte_ctr, &dim->start_sample);
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		break;
 	case DIM_APPLY_NEW_PROFILE:
-- 
1.8.3.1
