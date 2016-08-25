From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 25 Aug 2016 13:49:15 -0700
Subject: [PATCH WIP/RFC 1/6] iw_cxgb4: call dev_put() on l2t allocation failure
In-Reply-To: <cover.1472219585.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
Message-ID: <f49ba58ba5bd80c901e263dd6ffa0f99a199ecfb.1472219585.git.swise@opengridcomputing.com>

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b6a953a..a4f3f1d 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2117,8 +2117,11 @@ static int import_ep(struct c4iw_ep *ep, int iptype, __u8 *peer_ip,
 		}
 		ep->l2t = cxgb4_l2t_get(cdev->rdev.lldi.l2t,
 					n, pdev, rt_tos2priority(tos));
-		if (!ep->l2t)
+		if (!ep->l2t) {
+			err = -ENOMEM;
+			dev_put(pdev);
 			goto out;
+		}
 		ep->mtu = pdev->mtu;
 		ep->tx_chan = cxgb4_port_chan(pdev);
 		ep->smac_idx = cxgb4_tp_smt_idx(adapter_type,
-- 
2.7.0
