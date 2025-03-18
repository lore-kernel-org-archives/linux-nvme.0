Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B2C35FF8
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=15fgYcQpad/5tk0d1yz158CsacvJeDSVgb7Y7JLCd4M=; b=K+AULjG1MnPCP1clPrKKeFhW++
	ApXUauNY7Sg6zV9OngcAsCtAo5WlxYTOEh7ina/CIomj3djAmC5Xs1JXrDF8DujPzjMTs562ioW1A
	ht0ap5+/0mS6E2Cf/f75pYVQi8hayNh47YwykG2Ck/howYFI84wXdco+V12ZOcw1LetyqpNt2mfTG
	AU5iXBb+tJqC/b5pbum6Fu7A2L+z1QvfSNzz51Je20Fnuwz2jZsfEkvHBrScjDqsTqjH+LzSHpyiE
	d/7nNXdZJ2CvqP63bFU7J0bvXPA2iUimiBV+SQ1dH6Fx1fm/0rGWsAjWbBRdDvflCo5BiqExLqQ9s
	RvZPWDFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN5-00000005Y7O-2P2J;
	Tue, 18 Mar 2025 10:40:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUN2-00000005Y1Y-29rU
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 10:40:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 036F65C587E;
	Tue, 18 Mar 2025 10:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479FDC4CEDD;
	Tue, 18 Mar 2025 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294427;
	bh=VkLrqF4T6wewDueSatUmlwjgltogJR25syVwXMTNSQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXMbk/T+KPVPo5LwxoAyPNuISC6IZjBtKd6KQvNUOoq5SEPQQQwTJBTZxnlON1/Ct
	 9YuQh/GfRrVFaOpkDnBm4+/KojezsJDnPsrqWb/dZizX/SkUn4nKvqkbFLGJgOEmhw
	 VVeOYaVyiVBTCumUD6BweKCNhEVOjIjapcdGQQoeTA5PmMKTQlQ17FdXgNTOtDOMWW
	 XuRBNOT1iiTl4Ath1/I6TtSdM6H3WjYAvX7jsuUzpUo+uSlL0/HBJAWC7pmv6V2AJt
	 ARwTfki1D8RxHsywsux6/p6I+oSagxFj04fT0NC9wA0GSfpNS6H0QoQzFFt2crXi2m
	 jpVZfJdmdKVjw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:04 +0100
Subject: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_034028_677031_4345705B 
X-CRM114-Status: GOOD (  17.81  )
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

fcloop depends on the host or the target to allocate the fcloop_lsreq
object. This means that the lifetime of the fcloop_lsreq is tied to
either the host or the target. Consequently, the host or the target must
cooperate during shutdown.

Unfortunately, this approach does not work well when the target forces a
shutdown, as there are dependencies that are difficult to resolve in a
clean way.

The simplest solution is to decouple the lifetime of the fcloop_lsreq
object by managing them directly within fcloop. Since this is not a
performance-critical path and only a small number of LS objects are used
during setup and cleanup, it does not significantly impact performance
to allocate them during normal operation.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 53 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 06f42da6a0335c53ae319133119d057aab12e07e..537fc6533a4cf5d39855cf850b82af739eeb3056 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -342,6 +342,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kfree(tls_req);
 
 		spin_lock(&rport->lock);
 	}
@@ -353,10 +354,13 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 			struct nvme_fc_remote_port *remoteport,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_rport *rport = remoteport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
+	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -387,19 +391,23 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 	struct nvme_fc_remote_port *remoteport = tport->remoteport;
 	struct fcloop_rport *rport;
 
+
+	if (!remoteport) {
+		kfree(tls_req);
+		return -ECONNREFUSED;
+	}
+
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
 		((lsreq->rsplen < lsrsp->rsplen) ?
 				lsreq->rsplen : lsrsp->rsplen));
 
 	lsrsp->done(lsrsp);
 
-	if (remoteport) {
-		rport = remoteport->private;
-		spin_lock(&rport->lock);
-		list_add_tail(&tls_req->ls_list, &rport->ls_list);
-		spin_unlock(&rport->lock);
-		queue_work(nvmet_wq, &rport->ls_work);
-	}
+	rport = remoteport->private;
+	spin_lock(&rport->lock);
+	list_add_tail(&tls_req->ls_list, &rport->ls_list);
+	spin_unlock(&rport->lock);
+	queue_work(nvmet_wq, &rport->ls_work);
 
 	return 0;
 }
@@ -426,6 +434,7 @@ fcloop_tport_lsrqst_work(struct work_struct *work)
 		 * callee may free memory containing tls_req.
 		 * do not reference lsreq after this.
 		 */
+		kfree(tls_req);
 
 		spin_lock(&tport->lock);
 	}
@@ -436,8 +445,8 @@ static int
 fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 			struct nvmefc_ls_req *lsreq)
 {
-	struct fcloop_lsreq *tls_req = lsreq->private;
 	struct fcloop_tport *tport = targetport->private;
+	struct fcloop_lsreq *tls_req;
 	int ret = 0;
 
 	/*
@@ -445,6 +454,10 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	 * hosthandle ignored as fcloop currently is
 	 * 1:1 tgtport vs remoteport
 	 */
+
+	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
+	if (!tls_req)
+		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
 
@@ -461,6 +474,9 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
+	if (ret)
+		kfree(tls_req);
+
 	return ret;
 }
 
@@ -475,18 +491,21 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	struct nvmet_fc_target_port *targetport = rport->targetport;
 	struct fcloop_tport *tport;
 
+	if (!targetport) {
+		kfree(tls_req);
+		return -ECONNREFUSED;
+	}
+
 	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
 		((lsreq->rsplen < lsrsp->rsplen) ?
 				lsreq->rsplen : lsrsp->rsplen));
 	lsrsp->done(lsrsp);
 
-	if (targetport) {
-		tport = targetport->private;
-		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
-		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
-	}
+	tport = targetport->private;
+	spin_lock(&tport->lock);
+	list_add_tail(&tport->ls_list, &tls_req->ls_list);
+	spin_unlock(&tport->lock);
+	queue_work(nvmet_wq, &tport->ls_work);
 
 	return 0;
 }
@@ -1129,7 +1148,6 @@ static struct nvme_fc_port_template fctemplate = {
 	/* sizes of additional private data for data structures */
 	.local_priv_sz		= sizeof(struct fcloop_lport_priv),
 	.remote_priv_sz		= sizeof(struct fcloop_rport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 	.fcprqst_priv_sz	= sizeof(struct fcloop_ini_fcpreq),
 };
 
@@ -1152,7 +1170,6 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.target_features	= 0,
 	/* sizes of additional private data for data structures */
 	.target_priv_sz		= sizeof(struct fcloop_tport),
-	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
 static ssize_t

-- 
2.48.1


