From: talgi@mellanox.com (Tal Gilboa)
Date: Wed,  6 Mar 2019 10:48:24 +0200
Subject: [RFC/PATCH net-next 1/9] linux/dim: Move logic to dim.h
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
Message-ID: <20190306084832.57753-2-talgi@mellanox.com>

In preparation for supporting more implementations of the DIM
algorithm, I'm moving what would become common logic to a common
library. Downstream DIM implementations will use the common lib
for their implementation.

Signed-off-by: Tal Gilboa <talgi at mellanox.com>
---
 include/linux/dim.h     | 183 ++++++++++++++++++++++++++++++++++++++++
 include/linux/net_dim.h | 148 +-------------------------------
 2 files changed, 185 insertions(+), 146 deletions(-)
 create mode 100644 include/linux/dim.h

diff --git a/include/linux/dim.h b/include/linux/dim.h
new file mode 100644
index 000000000000..c745c5d457ff
--- /dev/null
+++ b/include/linux/dim.h
@@ -0,0 +1,183 @@
+/*
+ * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2017-2018, Broadcom Limited. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef DIM_H
+#define DIM_H
+
+#include <linux/module.h>
+
+#define NET_DIM_NEVENTS 64
+#define IS_SIGNIFICANT_DIFF(val, ref) \
+	(((100UL * abs((val) - (ref))) / (ref)) > 10) /* more than 10% difference */
+#define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
+
+
+struct net_dim_cq_moder {
+	u16 usec;
+	u16 pkts;
+	u8 cq_period_mode;
+};
+
+struct net_dim_sample {
+	ktime_t time;
+	u32     pkt_ctr;
+	u32     byte_ctr;
+	u16     event_ctr;
+};
+
+struct net_dim_stats {
+	int ppms; /* packets per msec */
+	int bpms; /* bytes per msec */
+	int epms; /* events per msec */
+};
+
+struct net_dim { /* Dynamic Interrupt Moderation */
+	u8                                      state;
+	struct net_dim_stats                    prev_stats;
+	struct net_dim_sample                   start_sample;
+	struct work_struct                      work;
+	u8                                      profile_ix;
+	u8                                      mode;
+	u8                                      tune_state;
+	u8                                      steps_right;
+	u8                                      steps_left;
+	u8                                      tired;
+};
+
+enum {
+	NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
+	NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
+	NET_DIM_CQ_PERIOD_NUM_MODES
+};
+
+enum {
+	NET_DIM_START_MEASURE,
+	NET_DIM_MEASURE_IN_PROGRESS,
+	NET_DIM_APPLY_NEW_PROFILE,
+};
+
+enum {
+	NET_DIM_PARKING_ON_TOP,
+	NET_DIM_PARKING_TIRED,
+	NET_DIM_GOING_RIGHT,
+	NET_DIM_GOING_LEFT,
+};
+
+enum {
+	NET_DIM_STATS_WORSE,
+	NET_DIM_STATS_SAME,
+	NET_DIM_STATS_BETTER,
+};
+
+enum {
+	NET_DIM_STEPPED,
+	NET_DIM_TOO_TIRED,
+	NET_DIM_ON_EDGE,
+};
+
+static inline bool net_dim_on_top(struct net_dim *net_dim)
+{
+	switch (net_dim->tune_state) {
+	case NET_DIM_PARKING_ON_TOP:
+	case NET_DIM_PARKING_TIRED:
+		return true;
+	case NET_DIM_GOING_RIGHT:
+		return (net_dim->steps_left > 1) && (net_dim->steps_right == 1);
+	default: /* NET_DIM_GOING_LEFT */
+		return (net_dim->steps_right > 1) && (net_dim->steps_left == 1);
+	}
+}
+
+static inline void net_dim_turn(struct net_dim *net_dim)
+{
+	switch (net_dim->tune_state) {
+	case NET_DIM_PARKING_ON_TOP:
+	case NET_DIM_PARKING_TIRED:
+		break;
+	case NET_DIM_GOING_RIGHT:
+		net_dim->tune_state = NET_DIM_GOING_LEFT;
+		net_dim->steps_left = 0;
+		break;
+	case NET_DIM_GOING_LEFT:
+		net_dim->tune_state = NET_DIM_GOING_RIGHT;
+		net_dim->steps_right = 0;
+		break;
+	}
+}
+
+static inline void net_dim_park_on_top(struct net_dim *net_dim)
+{
+	net_dim->steps_right  = 0;
+	net_dim->steps_left   = 0;
+	net_dim->tired        = 0;
+	net_dim->tune_state   = NET_DIM_PARKING_ON_TOP;
+}
+
+static inline void net_dim_park_tired(struct net_dim *net_dim)
+{
+	net_dim->steps_right  = 0;
+	net_dim->steps_left   = 0;
+	net_dim->tune_state   = NET_DIM_PARKING_TIRED;
+}
+
+static inline void net_dim_sample(u16 event_ctr,
+				  u64 packets,
+				  u64 bytes,
+				  struct net_dim_sample *s)
+{
+	s->time	     = ktime_get();
+	s->pkt_ctr   = packets;
+	s->byte_ctr  = bytes;
+	s->event_ctr = event_ctr;
+}
+
+static inline void net_dim_calc_stats(struct net_dim_sample *start,
+				  struct net_dim_sample *end,
+				  struct net_dim_stats *curr_stats)
+{
+	/* u32 holds up to 71 minutes, should be enough */
+	u32 delta_us = ktime_us_delta(end->time, start->time);
+	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
+	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
+			     start->byte_ctr);
+
+	if (!delta_us)
+		return;
+
+	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
+	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
+	curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
+					delta_us);
+}
+
+#endif /* DIM_H */
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index fd458389f7d1..373cda74b167 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -35,73 +35,10 @@
 #define NET_DIM_H
 
 #include <linux/module.h>
-
-struct net_dim_cq_moder {
-	u16 usec;
-	u16 pkts;
-	u8 cq_period_mode;
-};
-
-struct net_dim_sample {
-	ktime_t time;
-	u32     pkt_ctr;
-	u32     byte_ctr;
-	u16     event_ctr;
-};
-
-struct net_dim_stats {
-	int ppms; /* packets per msec */
-	int bpms; /* bytes per msec */
-	int epms; /* events per msec */
-};
-
-struct net_dim { /* Adaptive Moderation */
-	u8                                      state;
-	struct net_dim_stats                    prev_stats;
-	struct net_dim_sample                   start_sample;
-	struct work_struct                      work;
-	u8                                      profile_ix;
-	u8                                      mode;
-	u8                                      tune_state;
-	u8                                      steps_right;
-	u8                                      steps_left;
-	u8                                      tired;
-};
-
-enum {
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
-	NET_DIM_CQ_PERIOD_NUM_MODES
-};
-
-/* Adaptive moderation logic */
-enum {
-	NET_DIM_START_MEASURE,
-	NET_DIM_MEASURE_IN_PROGRESS,
-	NET_DIM_APPLY_NEW_PROFILE,
-};
-
-enum {
-	NET_DIM_PARKING_ON_TOP,
-	NET_DIM_PARKING_TIRED,
-	NET_DIM_GOING_RIGHT,
-	NET_DIM_GOING_LEFT,
-};
-
-enum {
-	NET_DIM_STATS_WORSE,
-	NET_DIM_STATS_SAME,
-	NET_DIM_STATS_BETTER,
-};
-
-enum {
-	NET_DIM_STEPPED,
-	NET_DIM_TOO_TIRED,
-	NET_DIM_ON_EDGE,
-};
+#include <linux/dim.h>
 
 #define NET_DIM_PARAMS_NUM_PROFILES 5
-/* Adaptive moderation profiles */
+/* Netdev dynamic interrupt moderation profiles */
 #define NET_DIM_DEFAULT_RX_CQ_MODERATION_PKTS_FROM_EQE 256
 #define NET_DIM_DEFAULT_TX_CQ_MODERATION_PKTS_FROM_EQE 128
 #define NET_DIM_DEF_PROFILE_CQE 1
@@ -188,36 +125,6 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
 	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
 }
 
-static inline bool net_dim_on_top(struct net_dim *dim)
-{
-	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
-		return true;
-	case NET_DIM_GOING_RIGHT:
-		return (dim->steps_left > 1) && (dim->steps_right == 1);
-	default: /* NET_DIM_GOING_LEFT */
-		return (dim->steps_right > 1) && (dim->steps_left == 1);
-	}
-}
-
-static inline void net_dim_turn(struct net_dim *dim)
-{
-	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
-		break;
-	case NET_DIM_GOING_RIGHT:
-		dim->tune_state = NET_DIM_GOING_LEFT;
-		dim->steps_left = 0;
-		break;
-	case NET_DIM_GOING_LEFT:
-		dim->tune_state = NET_DIM_GOING_RIGHT;
-		dim->steps_right = 0;
-		break;
-	}
-}
-
 static inline int net_dim_step(struct net_dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
@@ -245,21 +152,6 @@ static inline int net_dim_step(struct net_dim *dim)
 	return NET_DIM_STEPPED;
 }
 
-static inline void net_dim_park_on_top(struct net_dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tired        = 0;
-	dim->tune_state   = NET_DIM_PARKING_ON_TOP;
-}
-
-static inline void net_dim_park_tired(struct net_dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tune_state   = NET_DIM_PARKING_TIRED;
-}
-
 static inline void net_dim_exit_parking(struct net_dim *dim)
 {
 	dim->tune_state = dim->profile_ix ? NET_DIM_GOING_LEFT :
@@ -267,9 +159,6 @@ static inline void net_dim_exit_parking(struct net_dim *dim)
 	net_dim_step(dim);
 }
 
-#define IS_SIGNIFICANT_DIFF(val, ref) \
-	(((100UL * abs((val) - (ref))) / (ref)) > 10) /* more than 10% difference */
-
 static inline int net_dim_stats_compare(struct net_dim_stats *curr,
 					struct net_dim_stats *prev)
 {
@@ -351,39 +240,6 @@ static inline bool net_dim_decision(struct net_dim_stats *curr_stats,
 	return dim->profile_ix != prev_ix;
 }
 
-static inline void net_dim_sample(u16 event_ctr,
-				  u64 packets,
-				  u64 bytes,
-				  struct net_dim_sample *s)
-{
-	s->time	     = ktime_get();
-	s->pkt_ctr   = packets;
-	s->byte_ctr  = bytes;
-	s->event_ctr = event_ctr;
-}
-
-#define NET_DIM_NEVENTS 64
-#define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
-
-static inline void net_dim_calc_stats(struct net_dim_sample *start,
-				      struct net_dim_sample *end,
-				      struct net_dim_stats *curr_stats)
-{
-	/* u32 holds up to 71 minutes, should be enough */
-	u32 delta_us = ktime_us_delta(end->time, start->time);
-	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
-	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
-			     start->byte_ctr);
-
-	if (!delta_us)
-		return;
-
-	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
-	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
-	curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
-					delta_us);
-}
-
 static inline void net_dim(struct net_dim *dim,
 			   struct net_dim_sample end_sample)
 {
-- 
2.19.1
