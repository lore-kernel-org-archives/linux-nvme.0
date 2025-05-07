Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEB3C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWUSRdHDGQt5cFnS2XZN2nxKNKZWnmb9kpXv9rmHFlA=; b=daxYPPouRz5tgOL5CkpnbYmY+N
	3Mz08N2b86dgjtnNLad/eUSeA5nKiZKuHatZkPq37sZ4/ptfjVgrTYfrENE56pDxA4BqlZBSqwfI0
	DwYnIskfzn/O8a1+5ZLLQEQreMWNx4piH8zpywmy8v6NLRc6SodOgnrP1vL5+rRlPUocxl9KBpm9N
	T89PDs+8XIgap4vPSu0lIv37v/roCIUNXjd6r7zPQfHXgOGNFYi/GbNYpAO+n9HFMzYZqz68fEH6r
	YhwQzIIjiiYs7cQuuwbbH67IijpNGju0Yi5S/gHt5Nqtgaecr4Ln6lZtZ6KSJ2GDXpLOm+UPq61+E
	BbHDP1qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo4-0000000FMz2-0B3E;
	Wed, 07 May 2025 12:23:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo3-0000000FMxk-26Ij
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5E9A629D5;
	Wed,  7 May 2025 12:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C0C4CEE7;
	Wed,  7 May 2025 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620602;
	bh=bWfF/z6J6VjDnFu295fwOKQGsLQiUbigzuCMF8Epxkw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aKocHqCloH3XUjV8KfPLiFtcfK4rgFUtH8psUn+MTLIHKbWMurnP9cM6wzMEkD8z/
	 7JFPItaOTQukdfrtMSbHhpMPG9cCTqba+ofjxjETHUAfacHqdp32pDR62UJ8SOwonE
	 tPim3gqH57e7PeGctL/O9hlpyvigibfpVUViStM+RrI9MX8UL9putJwa+k9zjeK1zy
	 XZKdpi0OEL1vnb6A9U+Vd22mR+1vTvFUQmd4Sq7i6D39h4uMOklAnb8dMDp9QuOSYf
	 9aN9+nwuE8Eg9qyFlR2ejUYLVqThZxUfAP1Nv/3/9ZSk1SqwS3Zp6kabdwiQELqHLW
	 UYAZK7z6+ANow==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:03 +0200
Subject: [PATCH v6 07/14] nvmet-fcloop: access fcpreq only when holding
 reqlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-7-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

The abort handling logic expects that the state and the fcpreq are only
accessed when holding the reqlock lock.

While at it, only handle the aborts in the abort handler.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 0c0117e03adc81c643e90a7e7832ff087a4c2fd7..9adaee3c7129f7e270842c5d09f78de2e108479a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -619,12 +619,13 @@ fcloop_fcp_recv_work(struct work_struct *work)
 {
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
-	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	struct nvmefc_fcp_req *fcpreq;
 	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
+	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -639,16 +640,19 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	}
 	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
-	if (unlikely(aborted))
-		ret = -ECANCELED;
-	else {
-		if (likely(!check_for_drop(tfcp_req)))
-			ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
-				&tfcp_req->tgt_fcp_req,
-				fcpreq->cmdaddr, fcpreq->cmdlen);
-		else
-			pr_info("%s: dropped command ********\n", __func__);
+	if (unlikely(aborted)) {
+		/* the abort handler will call fcloop_call_host_done */
+		return;
+	}
+
+	if (unlikely(check_for_drop(tfcp_req))) {
+		pr_info("%s: dropped command ********\n", __func__);
+		return;
 	}
+
+	ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
+				   &tfcp_req->tgt_fcp_req,
+				   fcpreq->cmdaddr, fcpreq->cmdlen);
 	if (ret)
 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
 }
@@ -663,9 +667,10 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
+		fcpreq = tfcp_req->fcpreq;
+		tfcp_req->fcpreq = NULL;
 		break;
 	case INI_IO_COMPLETED:
 		completed = true;
@@ -688,10 +693,6 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	tfcp_req->fcpreq = NULL;
-	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
-
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
 }

-- 
2.49.0


