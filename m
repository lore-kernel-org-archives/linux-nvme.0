Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F19C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VOsiGAz/W+CINZFyxhPMnCIFHgsxPFjAFU6FVjoOOXk=; b=yll53l2cLY+ccsby+bpCuGSF17
	sO35wDvTUHr5CkGk7HN0rKw+XH1e+aCPILmwtFyIOcoNXrRebnJ3gFzUgcEm8ZjSX/5YsL35lAX62
	kkc7EUDZ60nROuVfKHTzSLViw9ZnP3zCsv4BIzBJKN0qmAEj9pEEpb6kW0e2aEk/jcRFaVXJx4A10
	3A27v4Ludr83LsSlw/LWcpkP5MQdDyGW6MQ12FF++B82Rg5zMMPKQ6AKPq4mxZJIiblJ5z/uZefwe
	W053CIFMoaPzqRRFE10gvVmWAb9hpPNiNPDdOtvrXk46LlJ2D/meBp8HDhtNqymVbwYGVmwXmTdhK
	P8zlOxOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWAK-002JS9-25;
	Wed, 12 Apr 2023 08:49:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWAH-002JRY-1U
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 08:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681289356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VOsiGAz/W+CINZFyxhPMnCIFHgsxPFjAFU6FVjoOOXk=;
	b=MZ2xU2bdc/TzKKb72WIEQtb0F4xn6m6AR/zFJQvWoFEjI528HgWwC0FJqE0mIi5Ul9gNm+
	AVEKQlhLsBrXfwbBiA3GnrL3djfyU12WRCs4KOVQQjJhtgLfRBJYEbTM3XdjLD/1jGNfzk
	HMW6SNjyhhhpnTUomNiRtSCFi1EFvlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-bh0vyNklMY6iyLWZjVxbcg-1; Wed, 12 Apr 2023 04:49:13 -0400
X-MC-Unique: bh0vyNklMY6iyLWZjVxbcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B54C1101A54F;
	Wed, 12 Apr 2023 08:49:12 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE9A1415117;
	Wed, 12 Apr 2023 08:49:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Ming Lei <ming.lei@redhat.com>,
	James Smart <jsmart2021@gmail.com>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] nvme-fcloop: fix "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage"
Date: Wed, 12 Apr 2023 16:49:04 +0800
Message-Id: <20230412084904.162324-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_014917_576968_A0A06C38 
X-CRM114-Status: GOOD (  15.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

fcloop_fcp_op() could be called from flush request's ->end_io(flush_end_io) in
which the spinlock of fq->mq_flush_lock is grabbed with irq saved/disabled.

So fcloop_fcp_op() can't call spin_unlock_irq(&tfcp_req->reqlock) simply
which enables irq unconditionally.

Fixes the warning by switching to spin_lock_irqsave()/spin_unlock_irqrestore()

Fixes: c38dbbfab1bc ("nvme-fcloop: fix inconsistent lock state warnings")
Cc: James Smart <jsmart2021@gmail.com>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/fcloop.c | 48 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..c780af36c1d4 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -614,10 +614,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
 	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -626,11 +627,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 		aborted = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
@@ -655,8 +656,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		container_of(work, struct fcloop_fcpreq, abort_rcv_work);
 	struct nvmefc_fcp_req *fcpreq;
 	bool completed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
@@ -665,11 +667,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		completed = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(completed)) {
 		/* remove reference taken in original abort downcall */
@@ -681,9 +683,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->fcpreq = NULL;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
@@ -699,11 +701,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, tio_done_work);
 	struct nvmefc_fcp_req *fcpreq;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	tfcp_req->inistate = INI_IO_COMPLETED;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
 }
@@ -807,13 +810,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 	u32 rsplen = 0, xfrlen = 0;
 	int fcp_err = 0, active, aborted;
 	u8 op = tgt_fcpreq->op;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	active = tfcp_req->active;
 	aborted = tfcp_req->aborted;
 	tfcp_req->active = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(active))
 		/* illegal - call while i/o active */
@@ -821,9 +825,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	if (unlikely(aborted)) {
 		/* target transport has aborted i/o prior */
-		spin_lock_irq(&tfcp_req->reqlock);
+		spin_lock_irqsave(&tfcp_req->reqlock, flags);
 		tfcp_req->active = false;
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		tgt_fcpreq->transferred_length = 0;
 		tgt_fcpreq->fcp_error = -ECANCELED;
 		tgt_fcpreq->done(tgt_fcpreq);
@@ -880,9 +884,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 		break;
 	}
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->active = false;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tgt_fcpreq->transferred_length = xfrlen;
 	tgt_fcpreq->fcp_error = fcp_err;
@@ -896,15 +900,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
+	unsigned long flags;
 
 	/*
 	 * mark aborted only in case there were 2 threads in transport
 	 * (one doing io, other doing abort) and only kills ops posted
 	 * after the abort request
 	 */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->aborted = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tfcp_req->status = NVME_SC_INTERNAL;
 
@@ -946,6 +951,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	struct fcloop_ini_fcpreq *inireq = fcpreq->private;
 	struct fcloop_fcpreq *tfcp_req;
 	bool abortio = true;
+	unsigned long flags;
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
@@ -958,7 +964,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		return;
 
 	/* break initiator/target relationship for io */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 	case INI_IO_ACTIVE:
@@ -968,11 +974,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		abortio = false;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
-- 
2.31.1


