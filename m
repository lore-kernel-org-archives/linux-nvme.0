From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 14:26:37 -0700
Subject: [PATCH WIP/RFC v3 1/6] iw_cxgb4: call dev_put() on l2t allocation
 failure
In-Reply-To: <cover.1472574410.git.swise@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
Message-ID: <c867c9f2d1dbffab5718e369897792e97dd7f74b.1472574410.git.swise@opengridcomputing.com>

Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b6a953a..434a7fb 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2117,8 +2117,10 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		}
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t)
+		if (!ep->l2t) {
+			dev_put(pdev);
 			goto out;
+		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = cxgb4_tp_smt_idx(adapter_type,
-- 
2.7.0
