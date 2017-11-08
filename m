From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Nov 2017 11:57:38 +0200
Subject: [PATCH v3 5/9] svcrdma: Use RDMA core implicit CQ allocation
In-Reply-To: <20171108095742.25365-1-sagi@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
Message-ID: <20171108095742.25365-6-sagi@grimberg.me>

Get some of the wisdom of CQ completion vector spreading
and CQ queue-pair chunking for free.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 include/linux/sunrpc/svc_rdma.h          |  2 --
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 22 ++--------------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 995c6fe9ee90..95e0b7a1b311 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -118,8 +118,6 @@ struct svcxprt_rdma {
 	struct list_head     sc_rq_dto_q;
 	spinlock_t	     sc_rq_dto_lock;
 	struct ib_qp         *sc_qp;
-	struct ib_cq         *sc_rq_cq;
-	struct ib_cq         *sc_sq_cq;
 
 	spinlock_t	     sc_lock;		/* transport lock */
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 5caf8e722a11..d51ead156898 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -780,21 +780,11 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		dprintk("svcrdma: error creating PD for connect request\n");
 		goto errout;
 	}
-	newxprt->sc_sq_cq = ib_alloc_cq(dev, newxprt, newxprt->sc_sq_depth,
-					0, IB_POLL_WORKQUEUE);
-	if (IS_ERR(newxprt->sc_sq_cq)) {
-		dprintk("svcrdma: error creating SQ CQ for connect request\n");
-		goto errout;
-	}
-	newxprt->sc_rq_cq = ib_alloc_cq(dev, newxprt, newxprt->sc_rq_depth,
-					0, IB_POLL_WORKQUEUE);
-	if (IS_ERR(newxprt->sc_rq_cq)) {
-		dprintk("svcrdma: error creating RQ CQ for connect request\n");
-		goto errout;
-	}
 
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.event_handler = qp_event_handler;
+	qp_attr.create_flags = IB_QP_CREATE_ASSIGN_CQS;
+	qp_attr.poll_ctx = IB_POLL_WORKQUEUE;
 	qp_attr.qp_context = &newxprt->sc_xprt;
 	qp_attr.port_num = newxprt->sc_port_num;
 	qp_attr.cap.max_rdma_ctxs = ctxts;
@@ -804,8 +794,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.cap.max_recv_sge = newxprt->sc_max_sge;
 	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	qp_attr.qp_type = IB_QPT_RC;
-	qp_attr.send_cq = newxprt->sc_sq_cq;
-	qp_attr.recv_cq = newxprt->sc_rq_cq;
 	dprintk("svcrdma: newxprt->sc_cm_id=%p, newxprt->sc_pd=%p\n",
 		newxprt->sc_cm_id, newxprt->sc_pd);
 	dprintk("    cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
@@ -959,12 +947,6 @@ static void __svc_rdma_free(struct work_struct *work)
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_destroy_qp(rdma->sc_qp);
 
-	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
-		ib_free_cq(rdma->sc_sq_cq);
-
-	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
-		ib_free_cq(rdma->sc_rq_cq);
-
 	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
-- 
2.14.1
