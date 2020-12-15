Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100CC2BBCF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 12:19:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B798D224F4
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 12:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B798D224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l9wGraURJUC15z9UrRRABYT83hC0nUxVXUt8rlHXAjg=; b=wbdLOM0fhMGvOVpEXAXMxVHxCs
	8GsVjwJg6jUxKc3QtaVhBX8YvEjsxIXYjf4F+6O2GM/UNsXjHvDBFIXA5M/hzkQxkP8ycvCpSmDhW
	424nlzWJwZ6oIPmNOfy5gs1V2CD6XRWrvvmJGGpt2snQXMcubHXZ+eDAT2Ct5yQwiBUMLuuSoJ4DE
	IWOMQTaVrn7rfv1lDnDw336jhBcX6yRlEzroBRRO/7XkzsgDWSMCjPHr2JW0rCdoRB9+Dx7yIZGJz
	Y21r9uL4q+Hm4C0/ZUkOO8iH+vyUxr1j++jQL0C5ThICqdJHYwZ0yZA2XcR0WDWGWbjDL3SB/yBl1
	GY9tm8VQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp9I9-000334-KS; Tue, 15 Dec 2020 12:18:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp9I5-00032R-PB
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 12:18:55 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0BFCH1Up029223; Tue, 15 Dec 2020 07:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1Ke6IdGHfHQf/3VRLeN4JoR5y0TXK6UIBlUzSKCRduE=;
 b=IxUMjCS36mLsDCVr8VPB6Tjy6DvKLMkmyKw7v7J5FEe93HoiDg4qN3pEkZ6EgxNicwHY
 LCHyOfYPcr9y1NATFqOreOfL9F3t/61IKmO7hrYG5h46SHBKiN+EfgcgAZahjxQgAC3U
 Tpv0kGonlTYOhXp1d+FM+p/WmLeLy0wC7axykTLoA/nqkB+a9umWa35iwNWvUBs8dNg4
 TMzwyolPgE5BLTmYSENZv13X59q49Q71QkZoZQtWxjOIwik/nnL/UJdsFfvYGKb3Z8iR
 XIegI3svg6ELJZ57WPNN2SzxTn2kj+GEwChUmjNPhx7Q2i+dFEzh+boz1Q8piZDykRPM PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 35ew0w00v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Dec 2020 07:18:50 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BFCIoRI035096;
 Tue, 15 Dec 2020 07:18:50 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 35ew0w00uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Dec 2020 07:18:50 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFCIRY1003373;
 Tue, 15 Dec 2020 12:18:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 35cn4hb8h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Dec 2020 12:18:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0BFCIjgU25821570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Dec 2020 12:18:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A755111C052;
 Tue, 15 Dec 2020 12:18:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FA3911C04C;
 Tue, 15 Dec 2020 12:18:43 +0000 (GMT)
Received: from Pescara.zurich.ibm.com (unknown [9.163.44.2])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 15 Dec 2020 12:18:42 +0000 (GMT)
From: Bernard Metzler <bmt@zurich.ibm.com>
To: linux-rdma@vget.kernel.org
Subject: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive Queues.
Date: Tue, 15 Dec 2020 13:16:33 +0100
Message-Id: <20201215121633.3838-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-15_10:2020-12-14,
 2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=929
 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_071854_220194_A1EBC574 
X-CRM114-Status: GOOD (  29.24  )
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
Cc: Bernard Metzler <bmt@zurich.ibm.com>, yi.zhang@redhat.com,
 kamalheib1@gmail.com, linux-nvme@lists.infradead.org, jgg@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

During connection setup, the application may choose to zero-size
inbound and outbound READ queues, as well as the Receive queue.
This patch fixes handling of zero-sized queues.

Reported-by: Kamal Heib <kamalheib1@gmail.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 54 ++++++++++++++++-----------
 drivers/infiniband/sw/siw/siw_qp_rx.c | 26 +++++++++----
 drivers/infiniband/sw/siw/siw_qp_tx.c |  4 +-
 drivers/infiniband/sw/siw/siw_verbs.c | 18 +++++++--
 5 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index e9753831ac3f..6f17392f975a 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -654,7 +654,7 @@ static inline struct siw_sqe *orq_get_free(struct siw_qp *qp)
 {
 	struct siw_sqe *orq_e = orq_get_tail(qp);
 
-	if (orq_e && READ_ONCE(orq_e->flags) == 0)
+	if (READ_ONCE(orq_e->flags) == 0)
 		return orq_e;
 
 	return NULL;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 875d36d4b1c6..b686a09a75ae 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -199,26 +199,28 @@ void siw_qp_llp_write_space(struct sock *sk)
 
 static int siw_qp_readq_init(struct siw_qp *qp, int irq_size, int orq_size)
 {
-	irq_size = roundup_pow_of_two(irq_size);
-	orq_size = roundup_pow_of_two(orq_size);
-
-	qp->attrs.irq_size = irq_size;
-	qp->attrs.orq_size = orq_size;
-
-	qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
-	if (!qp->irq) {
-		siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
-		qp->attrs.irq_size = 0;
-		return -ENOMEM;
+	if (irq_size) {
+		irq_size = roundup_pow_of_two(irq_size);
+		qp->irq = vzalloc(irq_size * sizeof(struct siw_sqe));
+		if (!qp->irq) {
+			siw_dbg_qp(qp, "irq malloc for %d failed\n", irq_size);
+			qp->attrs.irq_size = 0;
+			return -ENOMEM;
+		}
 	}
-	qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
-	if (!qp->orq) {
-		siw_dbg_qp(qp, "orq malloc for %d failed\n", orq_size);
-		qp->attrs.orq_size = 0;
-		qp->attrs.irq_size = 0;
-		vfree(qp->irq);
-		return -ENOMEM;
+	if (orq_size) {
+		orq_size = roundup_pow_of_two(orq_size);
+		qp->orq = vzalloc(orq_size * sizeof(struct siw_sqe));
+		if (!qp->orq) {
+			siw_dbg_qp(qp, "orq malloc for %d failed\n", orq_size);
+			qp->attrs.orq_size = 0;
+			qp->attrs.irq_size = 0;
+			vfree(qp->irq);
+			return -ENOMEM;
+		}
 	}
+	qp->attrs.irq_size = irq_size;
+	qp->attrs.orq_size = orq_size;
 	siw_dbg_qp(qp, "ORD %d, IRD %d\n", orq_size, irq_size);
 	return 0;
 }
@@ -288,13 +290,14 @@ int siw_qp_mpa_rts(struct siw_qp *qp, enum mpa_v2_ctrl ctrl)
 	if (ctrl & MPA_V2_RDMA_WRITE_RTR)
 		wqe->sqe.opcode = SIW_OP_WRITE;
 	else if (ctrl & MPA_V2_RDMA_READ_RTR) {
-		struct siw_sqe *rreq;
+		struct siw_sqe *rreq = NULL;
 
 		wqe->sqe.opcode = SIW_OP_READ;
 
 		spin_lock(&qp->orq_lock);
 
-		rreq = orq_get_free(qp);
+		if (qp->attrs.orq_size)
+			rreq = orq_get_free(qp);
 		if (rreq) {
 			siw_read_to_orq(rreq, &wqe->sqe);
 			qp->orq_put++;
@@ -889,6 +892,9 @@ int siw_activate_tx(struct siw_qp *qp)
 	struct siw_wqe *wqe = tx_wqe(qp);
 	int rv = 1;
 
+	if (!qp->attrs.irq_size)
+		goto no_irq;
+
 	irqe = &qp->irq[qp->irq_get % qp->attrs.irq_size];
 
 	if (irqe->flags & SIW_WQE_VALID) {
@@ -933,6 +939,7 @@ int siw_activate_tx(struct siw_qp *qp)
 
 		goto out;
 	}
+no_irq:
 	sqe = sq_get_next(qp);
 	if (sqe) {
 skip_irq:
@@ -971,7 +978,7 @@ int siw_activate_tx(struct siw_qp *qp)
 			}
 			spin_lock(&qp->orq_lock);
 
-			if (!siw_orq_empty(qp)) {
+			if (qp->attrs.orq_size && !siw_orq_empty(qp)) {
 				qp->tx_ctx.orq_fence = 1;
 				rv = 0;
 			}
@@ -981,6 +988,11 @@ int siw_activate_tx(struct siw_qp *qp)
 			   wqe->sqe.opcode == SIW_OP_READ_LOCAL_INV) {
 			struct siw_sqe *rreq;
 
+			if (unlikely(!qp->attrs.orq_size)) {
+				/* We negotiated not to send READ req's */
+				rv = -EINVAL;
+				goto out;
+			}
 			wqe->sqe.num_sge = 1;
 
 			spin_lock(&qp->orq_lock);
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 4bd1f1f84057..981e11f31b2d 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -678,6 +678,10 @@ static int siw_init_rresp(struct siw_qp *qp, struct siw_rx_stream *srx)
 				   DDP_ECODE_UT_INVALID_MSN_RANGE, 0);
 		return -EPROTO;
 	}
+	if (unlikely(!qp->attrs.irq_size)) {
+		run_sq = 0;
+		goto error_irq;
+	}
 	spin_lock_irqsave(&qp->sq_lock, flags);
 
 	if (tx_work->wr_status == SIW_WR_IDLE) {
@@ -712,8 +716,9 @@ static int siw_init_rresp(struct siw_qp *qp, struct siw_rx_stream *srx)
 		/* RRESP now valid as current TX wqe or placed into IRQ */
 		smp_store_mb(resp->flags, SIW_WQE_VALID);
 	} else {
-		pr_warn("siw: [QP %u]: irq %d exceeded %d\n", qp_id(qp),
-			qp->irq_put % qp->attrs.irq_size, qp->attrs.irq_size);
+error_irq:
+		pr_warn("siw: [QP %u]: IRQ exceeded or null, size %d\n",
+			qp_id(qp), qp->attrs.irq_size);
 
 		siw_init_terminate(qp, TERM_ERROR_LAYER_RDMAP,
 				   RDMAP_ETYPE_REMOTE_OPERATION,
@@ -740,6 +745,9 @@ static int siw_orqe_start_rx(struct siw_qp *qp)
 	struct siw_sqe *orqe;
 	struct siw_wqe *wqe = NULL;
 
+	if (unlikely(!qp->attrs.orq_size))
+		return -EPROTO;
+
 	/* make sure ORQ indices are current */
 	smp_mb();
 
@@ -796,8 +804,8 @@ int siw_proc_rresp(struct siw_qp *qp)
 		 */
 		rv = siw_orqe_start_rx(qp);
 		if (rv) {
-			pr_warn("siw: [QP %u]: ORQ empty at idx %d\n",
-				qp_id(qp), qp->orq_get % qp->attrs.orq_size);
+			pr_warn("siw: [QP %u]: ORQ empty, size %d\n",
+				qp_id(qp), qp->attrs.orq_size);
 			goto error_term;
 		}
 		rv = siw_rresp_check_ntoh(srx, frx);
@@ -1290,11 +1298,13 @@ static int siw_rdmap_complete(struct siw_qp *qp, int error)
 					      wc_status);
 		siw_wqe_put_mem(wqe, SIW_OP_READ);
 
-		if (!error)
+		if (!error) {
 			rv = siw_check_tx_fence(qp);
-		else
-			/* Disable current ORQ eleement */
-			WRITE_ONCE(orq_get_current(qp)->flags, 0);
+		} else {
+			/* Disable current ORQ element */
+			if (qp->attrs.orq_size)
+				WRITE_ONCE(orq_get_current(qp)->flags, 0);
+		}
 		break;
 
 	case RDMAP_RDMA_READ_REQ:
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index d19d8325588b..7989c4043db4 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1107,8 +1107,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
 		/*
 		 * RREQ may have already been completed by inbound RRESP!
 		 */
-		if (tx_type == SIW_OP_READ ||
-		    tx_type == SIW_OP_READ_LOCAL_INV) {
+		if ((tx_type == SIW_OP_READ ||
+		     tx_type == SIW_OP_READ_LOCAL_INV) && qp->attrs.orq_size) {
 			/* Cleanup pending entry in ORQ */
 			qp->orq_put--;
 			qp->orq[qp->orq_put % qp->attrs.orq_size].flags = 0;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7cf3242ffb41..95003678cf3f 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -362,13 +362,23 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	if (rv)
 		goto err_out;
 
+	num_sqe = attrs->cap.max_send_wr;
+	num_rqe = attrs->cap.max_recv_wr;
+
 	/* All queue indices are derived from modulo operations
 	 * on a free running 'get' (consumer) and 'put' (producer)
 	 * unsigned counter. Having queue sizes at power of two
 	 * avoids handling counter wrap around.
 	 */
-	num_sqe = roundup_pow_of_two(attrs->cap.max_send_wr);
-	num_rqe = roundup_pow_of_two(attrs->cap.max_recv_wr);
+	if (num_sqe)
+		num_sqe = roundup_pow_of_two(num_sqe);
+	else {
+		/* Zero sized SQ is not supported */
+		rv = -EINVAL;
+		goto err_out;
+	}
+	if (num_rqe)
+		num_rqe = roundup_pow_of_two(num_rqe);
 
 	if (udata)
 		qp->sendq = vmalloc_user(num_sqe * sizeof(struct siw_sqe));
@@ -960,9 +970,9 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 	unsigned long flags;
 	int rv = 0;
 
-	if (qp->srq) {
+	if (qp->srq || qp->attrs.rq_size == 0) {
 		*bad_wr = wr;
-		return -EOPNOTSUPP; /* what else from errno.h? */
+		return -EINVAL;
 	}
 	if (!rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "no kernel post_recv for user mapped rq\n");
-- 
2.17.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
