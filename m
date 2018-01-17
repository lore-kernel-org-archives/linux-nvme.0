From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 15:52:58 +0200
Subject: [PATCH 4/4] IB/srpt: notify QP on Last WQE Reached event arrival
In-Reply-To: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
Message-ID: <1516197178-26493-5-git-send-email-maxg@mellanox.com>

In order to avoid resource leakage for QP associated with
a Shared Receive Queue (SRQ), notify it on Last WQE Reached
event arrival.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index bfa576a..241c8eb 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -209,6 +209,7 @@ static void srpt_qp_event(struct ib_event *event, struct srpt_rdma_ch *ch)
 		pr_debug("%s-%d, state %s: received Last WQE event.\n",
 			 ch->sess_name, ch->qp->qp_num,
 			 get_ch_state_name(ch->state));
+		ib_notify_qp(ch->qp, event->event);
 		break;
 	default:
 		pr_err("received unrecognized IB QP event %d\n", event->event);
-- 
1.8.3.1
