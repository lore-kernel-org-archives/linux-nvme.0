Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8379ECA0FF9
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Aug 2025 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r45WXOD1tRg3Ezb0EZPQG7pstyndTM/E6AkgU48idLA=; b=EvoFNRWkqGX1glfnVyKf+ihEgU
	L7BzrCXRA9syUkKCk1fDcmHwiz1kcdrRxBHUYXd0dK+staJ/O/25lzB7BdSd2+3a1OrRtsICqT1dO
	/ZYMUUd7HgM9Mk8ixiahiuFrt+fH4vykfGBLL+8oZS7k0H/rjcgCTO0G5fKZaupeJTAaTqjjIt3V5
	/bL8bagI1ta6uUWTHU2AAsH/B73I1XNP3rqVmmUMHQJvWBIaTtRduXh0Fis47xDOy5wC35YmTBNZd
	8YZkpbbSCTqgxASVbRx9xez9cXNjO1MqiTpVkS9xbg44Vyzh7eYs0dhtrO81PBBQfahNxEDJgrPVt
	22wc4I0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us9jd-000000078MB-2OaH;
	Sat, 30 Aug 2025 00:46:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us1Fx-00000006FBP-3d8F
	for linux-nvme@lists.infradead.org;
	Fri, 29 Aug 2025 15:43:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 11DFB601D4;
	Fri, 29 Aug 2025 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E653C4CEF5;
	Fri, 29 Aug 2025 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482192;
	bh=aoPIGzDgsINBf0Ebqd1cCI2ZeqD5+jR9ioyq3QpOSC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RScIlWWhzgJbNdbu3nEiGj1gatpovR7GejHeJFrJeo9hD/4NgLB1vvGr/1Od89alU
	 czJg9ktUZGmpVvxVdan1tLBCFWhUxvAdoxFIBeRp7ePDczy40jWpROG1/prHBK/13R
	 ou+54nR0iwgfHrW0Nic728fjdv2dhvMTPsBVE2H40Lhska/4vKPpLjVew2Evg6shyt
	 vOHmboA86T1mQ6QnXod6PP5bYsKQG6xqi3YbcEK31twncnLc1ZuJ6pJJZg/OlgwgK0
	 iYz/+lG737KIWAehiH117fhueoIDv7eoFuFrIaoQy6OlQMbONSDbOoVV+5V7uuiwsN
	 DtIY9FdHrUItA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:43:00 +0200
Subject: [PATCH v2 1/2] nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-fix-nvmet-fc-v2-1-26620e2742c7@kernel.org>
References: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
In-Reply-To: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
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

It’s possible for more than one async command to be in flight from
__nvmet_fc_send_ls_req. For each command, a tgtport reference is taken.

In the current code, only one put work item is queued at a time, which
results in a leaked reference.

To fix this, move the work item to the nvmet_fc_ls_req_op struct, which
already tracks all resources related to the command.

Fixes: 710c69dbaccd ("nvmet-fc: avoid deadlock on delete association path")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a9b18c051f5bd830a6ae45ff0f4892c3f28c8608..6725c34dd7c90ae38f8271368e609fd0ba267561 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -54,6 +54,8 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 	int				ls_error;
 	struct list_head		lsreq_list; /* tgtport->ls_req_list */
 	bool				req_queued;
+
+	struct work_struct		put_work;
 };
 
 
@@ -111,8 +113,6 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
-
-	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -235,12 +235,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
-static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+static void nvmet_fc_put_lsop_work(struct work_struct *work)
 {
-	struct nvmet_fc_tgtport *tgtport =
-		container_of(work, struct nvmet_fc_tgtport, put_work);
+	struct nvmet_fc_ls_req_op *lsop =
+		container_of(work, struct nvmet_fc_ls_req_op, put_work);
 
-	nvmet_fc_tgtport_put(tgtport);
+	nvmet_fc_tgtport_put(lsop->tgtport);
+	kfree(lsop);
 }
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
@@ -367,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  DMA_BIDIRECTIONAL);
 
 out_putwork:
-	queue_work(nvmet_wq, &tgtport->put_work);
+	queue_work(nvmet_wq, &lsop->put_work);
 }
 
 static int
@@ -388,6 +389,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsreq->done = done;
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
+	INIT_WORK(&lsop->put_work, nvmet_fc_put_lsop_work);
 
 	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
@@ -447,8 +449,6 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
 	__nvmet_fc_finish_ls_req(lsop);
 
 	/* fc-nvme target doesn't care about success or failure of cmd */
-
-	kfree(lsop);
 }
 
 /*
@@ -1410,7 +1410,6 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
-	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {

-- 
2.51.0


