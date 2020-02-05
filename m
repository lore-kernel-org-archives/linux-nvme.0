Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9401FC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:43:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6238520674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgeW+eqI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luyWcnRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6238520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1N+bTES/u9UNLvKxlcQq0HHcGE/Rmtadfyx9cMWFMTs=; b=YgeW+eqI4bTOILc9Gb3FCKFlxb
	vFdCjxf64w+8YVdY67JhVxvb6owboaiQ+Hoi4d1CXiRFdZlZgVL2rZm3M/PzThBNbroUcMByC8Qe9
	JcAT8r8XWd+dBPqE7pcOoDT1SSPlDXgHzizylKSk52fVRSpxfQnc94otwMalvloQAsK3eRqA8oINN
	wR5smRxCs37xx4z0DavOOA00ld7T7urarNHwt1izlo8hCfYZq3oSvw13guZ8oXtBkalsYqASdXTdY
	lvU8Lxk6VKysD0gaJv/WMofn09agZShGVrhFYfdbY98hZbCLoopiqA5Rv86JbMqGgeion+KaIxgg+
	vIQ5ANVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPdY-0008Oc-Ua; Wed, 05 Feb 2020 18:42:56 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZG-0003nv-EG
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:42 +0000
Received: by mail-wr1-x444.google.com with SMTP id w15so4024736wru.4
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bcmzOn0uiKtnvMmSW6IGQZGT/+Bo2ss2AoiibAxHooQ=;
 b=luyWcnRtYNMoyuHFiwWi9WMAqHbY8SKeRsxjDOj7cbFJElkpMvN+akYGeKgX9Kbk7f
 au4QpJ4qnyeJlXCt4vqTYPn7knmd9VmbwpY3zgSt2ZaaSpDnmRjhDbu+A0y1m9m1KwaO
 9NJBMFP0KJUGHr2XTi+OEJzEpzYYBVxL7aTDNK1DY/I56Qc/sK3cpvXKRG0M9f7bk1ct
 qLjX84YtKD/7AgYPiHz9Qm4SlWoE1JaSCo2XuKYGYYGM6bV/6t6UOLMhDVy3dT3HGxhz
 4YLI2lj9DDoHl3CIhW9ys5z6XKnfmPogA2WTcYOglIgkQn7YrFgijAlEVSR5sV8gdF84
 EZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bcmzOn0uiKtnvMmSW6IGQZGT/+Bo2ss2AoiibAxHooQ=;
 b=OK5bi+qgZqlF7Uy/8ncye8sPuxQN21fI5y5ABRPCdg8Pi6Y//er4SWQG1kjv8uvIqT
 VW93PXzk0hMHgIYJ9cHwghHHgE7Sap5ULNYo1EuBHY5K6jV6QalMhlCHPQIYtQZr5jTW
 2x+Pp0taC3jAw/VSN3nR/8bB8uCVG5LqeBQTQLR3YhspbWBQzVYcmtqdyET5v9bH6pYo
 Vbhx5Dc5M5j0MtyGgcWS9dIZcrcvtIin/Pknrvn5vRlu9Fy9XY1AbfB5zh2bmDXc+SyT
 BUMLqxBcUApApE2m4oKKtyledPp3gEf57eAycTDGHA4J9xAkJ0Aru+/SwHxxUJK7Uhno
 k0Jw==
X-Gm-Message-State: APjAAAUlvMYpaG2gCn7ERpfITT5Rd0J7hjqNYYV06YXiX0LuKzB6uW8i
 +pM2r03Y2gneXpAIrT6ZqifTidkS
X-Google-Smtp-Source: APXvYqzV+7VQL7BV3xPx8YHRLsOG8qIKTEMa4NIwmpmqHOQHKyalW1zFtf6/YHEXGzq3lN8V27GoJw==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr30673598wrv.144.1580927908453; 
 Wed, 05 Feb 2020 10:38:28 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:28 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 17/29] nvmet-fc: Add Disconnect Association Xmt support
Date: Wed,  5 Feb 2020 10:37:41 -0800
Message-Id: <20200205183753.25959-18-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103831_409395_C9915FB5 
X-CRM114-Status: GOOD (  26.23  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As part of FC-NVME-2 (and ammendment on FC-NVME), the target is to
send a Disconnect LS after an association is terminated and any
exchanges for the association have been ABTS'd. The target is also
not to send the receipt to any Disconnect Association LS, received
to initiate the association termination or received while the
association is terminating, until the Disconnect LS has been transmit.

Add support for sending Disconnect Association LS after all I/O's
complete (which is after ABTS'd certainly). Utilizes the new LLDD
api to send ls requests.

There is no need to track the Disconnect LS response or to retry
after timeout. All spec requirements will have been met by waiting
for i/o completion to initiate the transmission.

Add support for tracking the reception of Disconnect Association
and defering the response transmission until after the Disconnect
Association LS has been transmit.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/target/fc.c | 298 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 287 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d52393cd29f7..3e94c4909cf9 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -25,7 +25,7 @@
 struct nvmet_fc_tgtport;
 struct nvmet_fc_tgt_assoc;
 
-struct nvmet_fc_ls_iod {
+struct nvmet_fc_ls_iod {		// for an LS RQST RCV
 	struct nvmefc_ls_rsp		*lsrsp;
 	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
 
@@ -45,6 +45,18 @@ struct nvmet_fc_ls_iod {
 	struct work_struct		work;
 } __aligned(sizeof(unsigned long long));
 
+struct nvmet_fc_ls_req_op {		// for an LS RQST XMT
+	struct nvmefc_ls_req		ls_req;
+
+	struct nvmet_fc_tgtport		*tgtport;
+	void				*hosthandle;
+
+	int				ls_error;
+	struct list_head		lsreq_list; /* tgtport->ls_req_list */
+	bool				req_queued;
+};
+
+
 /* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
 
@@ -91,6 +103,7 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_ls_iod		*iod;
 	spinlock_t			lock;
 	struct list_head		ls_rcv_list;
+	struct list_head		ls_req_list;
 	struct list_head		ls_busylist;
 	struct list_head		assoc_list;
 	struct list_head		host_list;
@@ -146,8 +159,10 @@ struct nvmet_fc_hostport {
 struct nvmet_fc_tgt_assoc {
 	u64				association_id;
 	u32				a_id;
+	atomic_t			terminating;
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_hostport	*hostport;
+	struct nvmet_fc_ls_iod		*rcv_disconn;
 	struct list_head		a_list;
 	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
@@ -236,6 +251,8 @@ static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
 static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
+static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
+				struct nvmet_fc_ls_iod *iod);
 
 
 /* *********************** FC-NVME DMA Handling **************************** */
@@ -327,6 +344,188 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 
+/* ********************** FC-NVME LS XMT Handling ************************* */
+
+
+static void
+__nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
+{
+	struct nvmet_fc_tgtport *tgtport = lsop->tgtport;
+	struct nvmefc_ls_req *lsreq = &lsop->ls_req;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tgtport->lock, flags);
+
+	if (!lsop->req_queued) {
+		spin_unlock_irqrestore(&tgtport->lock, flags);
+		return;
+	}
+
+	list_del(&lsop->lsreq_list);
+
+	lsop->req_queued = false;
+
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+				  (lsreq->rqstlen + lsreq->rsplen),
+				  DMA_BIDIRECTIONAL);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
+
+static int
+__nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
+		struct nvmet_fc_ls_req_op *lsop,
+		void (*done)(struct nvmefc_ls_req *req, int status))
+{
+	struct nvmefc_ls_req *lsreq = &lsop->ls_req;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!tgtport->ops->ls_req)
+		return -EOPNOTSUPP;
+
+	if (!nvmet_fc_tgtport_get(tgtport))
+		return -ESHUTDOWN;
+
+	lsreq->done = done;
+	lsop->req_queued = false;
+	INIT_LIST_HEAD(&lsop->lsreq_list);
+
+	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
+				  lsreq->rqstlen + lsreq->rsplen,
+				  DMA_BIDIRECTIONAL);
+	if (fc_dma_mapping_error(tgtport->dev, lsreq->rqstdma)) {
+		ret = -EFAULT;
+		goto out_puttgtport;
+	}
+	lsreq->rspdma = lsreq->rqstdma + lsreq->rqstlen;
+
+	spin_lock_irqsave(&tgtport->lock, flags);
+
+	list_add_tail(&lsop->lsreq_list, &tgtport->ls_req_list);
+
+	lsop->req_queued = true;
+
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+
+	ret = tgtport->ops->ls_req(&tgtport->fc_target_port, lsop->hosthandle,
+				   lsreq);
+	if (ret)
+		goto out_unlink;
+
+	return 0;
+
+out_unlink:
+	lsop->ls_error = ret;
+	spin_lock_irqsave(&tgtport->lock, flags);
+	lsop->req_queued = false;
+	list_del(&lsop->lsreq_list);
+	spin_unlock_irqrestore(&tgtport->lock, flags);
+	fc_dma_unmap_single(tgtport->dev, lsreq->rqstdma,
+				  (lsreq->rqstlen + lsreq->rsplen),
+				  DMA_BIDIRECTIONAL);
+out_puttgtport:
+	nvmet_fc_tgtport_put(tgtport);
+
+	return ret;
+}
+
+static int
+nvmet_fc_send_ls_req_async(struct nvmet_fc_tgtport *tgtport,
+		struct nvmet_fc_ls_req_op *lsop,
+		void (*done)(struct nvmefc_ls_req *req, int status))
+{
+	/* don't wait for completion */
+
+	return __nvmet_fc_send_ls_req(tgtport, lsop, done);
+}
+
+static void
+nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
+{
+	struct nvmet_fc_ls_req_op *lsop =
+		container_of(lsreq, struct nvmet_fc_ls_req_op, ls_req);
+
+	__nvmet_fc_finish_ls_req(lsop);
+
+	/* fc-nvme target doesn't care about success or failure of cmd */
+
+	kfree(lsop);
+}
+
+/*
+ * This routine sends a FC-NVME LS to disconnect (aka terminate)
+ * the FC-NVME Association.  Terminating the association also
+ * terminates the FC-NVME connections (per queue, both admin and io
+ * queues) that are part of the association. E.g. things are torn
+ * down, and the related FC-NVME Association ID and Connection IDs
+ * become invalid.
+ *
+ * The behavior of the fc-nvme target is such that it's
+ * understanding of the association and connections will implicitly
+ * be torn down. The action is implicit as it may be due to a loss of
+ * connectivity with the fc-nvme host, so the target may never get a
+ * response even if it tried.  As such, the action of this routine
+ * is to asynchronously send the LS, ignore any results of the LS, and
+ * continue on with terminating the association. If the fc-nvme host
+ * is present and receives the LS, it too can tear down.
+ */
+static void
+nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
+{
+	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
+	struct fcnvme_ls_disconnect_assoc_rqst *discon_rqst;
+	struct fcnvme_ls_disconnect_assoc_acc *discon_acc;
+	struct nvmet_fc_ls_req_op *lsop;
+	struct nvmefc_ls_req *lsreq;
+	int ret;
+
+	/*
+	 * If ls_req is NULL or no hosthandle, it's an older lldd and no
+	 * message is normal. Otherwise, send unless the hostport has
+	 * already been invalidated by the lldd.
+	 */
+	if (!tgtport->ops->ls_req || !assoc->hostport ||
+	    assoc->hostport->invalid)
+		return;
+
+	lsop = kzalloc((sizeof(*lsop) +
+			sizeof(*discon_rqst) + sizeof(*discon_acc) +
+			tgtport->ops->lsrqst_priv_sz), GFP_KERNEL);
+	if (!lsop) {
+		dev_info(tgtport->dev,
+			"{%d:%d} send Disconnect Association failed: ENOMEM\n",
+			tgtport->fc_target_port.port_num, assoc->a_id);
+		return;
+	}
+
+	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)&lsop[1];
+	discon_acc = (struct fcnvme_ls_disconnect_assoc_acc *)&discon_rqst[1];
+	lsreq = &lsop->ls_req;
+	if (tgtport->ops->lsrqst_priv_sz)
+		lsreq->private = (void *)&discon_acc[1];
+	else
+		lsreq->private = NULL;
+
+	lsop->tgtport = tgtport;
+	lsop->hosthandle = assoc->hostport->hosthandle;
+
+	nvmefc_fmt_lsreq_discon_assoc(lsreq, discon_rqst, discon_acc,
+				assoc->association_id);
+
+	ret = nvmet_fc_send_ls_req_async(tgtport, lsop,
+				nvmet_fc_disconnect_assoc_done);
+	if (ret) {
+		dev_info(tgtport->dev,
+			"{%d:%d} XMT Disconnect Association failed: %d\n",
+			tgtport->fc_target_port.port_num, assoc->a_id, ret);
+		kfree(lsop);
+	}
+}
+
+
 /* *********************** FC-NVME Port Management ************************ */
 
 
@@ -689,10 +888,14 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	struct nvmet_fc_defer_fcp_req *deferfcp, *tempptr;
 	unsigned long flags;
 	int i, writedataactive;
-	bool disconnect;
+	int disconnect;
 
 	disconnect = atomic_xchg(&queue->connected, 0);
 
+	/* if not connected, nothing to do */
+	if (!disconnect)
+		return;
+
 	spin_lock_irqsave(&queue->qlock, flags);
 	/* abort outstanding io's */
 	for (i = 0; i < queue->sqsize; fod++, i++) {
@@ -921,6 +1124,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	kref_init(&assoc->ref);
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc);
 	atomic_set(&assoc->del_work_active, 0);
+	atomic_set(&assoc->terminating, 0);
 
 	while (needrandom) {
 		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
@@ -957,13 +1161,24 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	struct nvmet_fc_tgt_assoc *assoc =
 		container_of(ref, struct nvmet_fc_tgt_assoc, ref);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
+	struct nvmet_fc_ls_iod	*oldls;
 	unsigned long flags;
 
+	/* Send Disconnect now that all i/o has completed */
+	nvmet_fc_xmt_disconnect_assoc(assoc);
+
 	nvmet_fc_free_hostport(assoc->hostport);
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_del(&assoc->a_list);
+	oldls = assoc->rcv_disconn;
 	spin_unlock_irqrestore(&tgtport->lock, flags);
+	/* if pending Rcv Disconnect Association LS, send rsp now */
+	if (oldls)
+		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
 	ida_simple_remove(&tgtport->assoc_cnt, assoc->a_id);
+	dev_info(tgtport->dev,
+		"{%d:%d} Association freed\n",
+		tgtport->fc_target_port.port_num, assoc->a_id);
 	kfree(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
@@ -986,7 +1201,13 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 	struct nvmet_fc_tgt_queue *queue;
 	unsigned long flags;
-	int i;
+	int i, terminating;
+
+	terminating = atomic_xchg(&assoc->terminating, 1);
+
+	/* if already terminating, do nothing */
+	if (terminating)
+		return;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
@@ -1002,6 +1223,10 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
+	dev_info(tgtport->dev,
+		"{%d:%d} Association deleted\n",
+		tgtport->fc_target_port.port_num, assoc->a_id);
+
 	nvmet_fc_tgt_a_put(assoc);
 }
 
@@ -1171,6 +1396,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	newrec->ops = template;
 	spin_lock_init(&newrec->lock);
 	INIT_LIST_HEAD(&newrec->ls_rcv_list);
+	INIT_LIST_HEAD(&newrec->ls_req_list);
 	INIT_LIST_HEAD(&newrec->ls_busylist);
 	INIT_LIST_HEAD(&newrec->assoc_list);
 	INIT_LIST_HEAD(&newrec->host_list);
@@ -1407,6 +1633,13 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 	/* terminate any outstanding associations */
 	__nvmet_fc_free_assocs(tgtport);
 
+	/*
+	 * should terminate LS's as well. However, LS's will be generated
+	 * at the tail end of association termination, so they likely don't
+	 * exist yet. And even if they did, it's worthwhile to just let
+	 * them finish and targetport ref counting will clean things up.
+	 */
+
 	nvmet_fc_tgtport_put(tgtport);
 
 	return 0;
@@ -1414,7 +1647,7 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 EXPORT_SYMBOL_GPL(nvmet_fc_unregister_targetport);
 
 
-/* *********************** FC-NVME LS Handling **************************** */
+/* ********************** FC-NVME LS RCV Handling ************************* */
 
 
 static void
@@ -1481,6 +1714,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	atomic_set(&queue->connected, 1);
 	queue->sqhd = 0;	/* best place to init value */
 
+	dev_info(tgtport->dev,
+		"{%d:%d} Association created\n",
+		tgtport->fc_target_port.port_num, iod->assoc->a_id);
+
 	/* format a response */
 
 	iod->lsrsp->rsplen = sizeof(*acc);
@@ -1588,7 +1825,11 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 				be16_to_cpu(rqst->connect_cmd.qid)));
 }
 
-static void
+/*
+ * Returns true if the LS response is to be transmit
+ * Returns false if the LS response is to be delayed
+ */
+static int
 nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
@@ -1597,13 +1838,15 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 	struct fcnvme_ls_disconnect_assoc_acc *acc =
 						&iod->rspbuf->rsp_dis_assoc;
 	struct nvmet_fc_tgt_assoc *assoc;
+	struct nvmet_fc_ls_iod *oldls = NULL;
+	unsigned long flags;
 	int ret = 0;
 
 	memset(acc, 0, sizeof(*acc));
 
 	ret = nvmefc_vldt_lsreq_discon_assoc(iod->rqstdatalen, rqst);
 	if (!ret) {
-		/* match an active association */
+		/* match an active association - takes an assoc ref if !NULL */
 		assoc = nvmet_fc_find_target_assoc(tgtport,
 				be64_to_cpu(rqst->associd.association_id));
 		iod->assoc = assoc;
@@ -1621,7 +1864,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 					FCNVME_RJT_RC_INV_ASSOC :
 					FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
-		return;
+		return true;
 	}
 
 	/* format a response */
@@ -1634,9 +1877,40 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			FCNVME_LS_DISCONNECT_ASSOC);
 
 	/* release get taken in nvmet_fc_find_target_assoc */
-	nvmet_fc_tgt_a_put(iod->assoc);
+	nvmet_fc_tgt_a_put(assoc);
+
+	/*
+	 * The rules for LS response says the response cannot
+	 * go back until ABTS's have been sent for all outstanding
+	 * I/O and a Disconnect Association LS has been sent.
+	 * So... save off the Disconnect LS to send the response
+	 * later. If there was a prior LS already saved, replace
+	 * it with the newer one and send a can't perform reject
+	 * on the older one.
+	 */
+	spin_lock_irqsave(&tgtport->lock, flags);
+	oldls = assoc->rcv_disconn;
+	assoc->rcv_disconn = iod;
+	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	nvmet_fc_delete_target_assoc(iod->assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+
+	if (oldls) {
+		dev_info(tgtport->dev,
+			"{%d:%d} Multiple Disconnect Association LS's "
+			"received\n",
+			tgtport->fc_target_port.port_num, assoc->a_id);
+		/* overwrite good response with bogus failure */
+		oldls->lsrsp->rsplen = nvme_fc_format_rjt(oldls->rspbuf,
+						sizeof(*iod->rspbuf),
+						/* ok to use rqst, LS is same */
+						rqst->w0.ls_cmd,
+						FCNVME_RJT_RC_UNAB,
+						FCNVME_RJT_EXP_NONE, 0);
+		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
+	}
+
+	return false;
 }
 
 
@@ -1681,6 +1955,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
 	struct fcnvme_ls_rqst_w0 *w0 = &iod->rqstbuf->rq_cr_assoc.w0;
+	bool sendrsp = true;
 
 	iod->lsrsp->nvme_fc_private = iod;
 	iod->lsrsp->rspbuf = iod->rspbuf;
@@ -1707,7 +1982,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		break;
 	case FCNVME_LS_DISCONNECT_ASSOC:
 		/* Terminate a Queue/Connection or the Association */
-		nvmet_fc_ls_disconnect(tgtport, iod);
+		sendrsp = nvmet_fc_ls_disconnect(tgtport, iod);
 		break;
 	default:
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(iod->rspbuf,
@@ -1715,7 +1990,8 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
 
-	nvmet_fc_xmt_ls_rsp(tgtport, iod);
+	if (sendrsp)
+		nvmet_fc_xmt_ls_rsp(tgtport, iod);
 }
 
 /*
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
