Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120E3C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76o7TcS/uyRgV/l59qW0RiyZONOaSWKLJo76VrGc5OE=; b=aAkMuemVEeFVxwN1Ej039rMgIx
	JZAjmz5MiEF4qwXHVtZwr74mEM9KGsPTDK6vAiRRSF62HDsC8Q8rRRxE6/6Yybtjjp+BGJCGJ46L5
	eZ1PxvusomOEkLb342VQNeGNIVfykLpGeFK4VmI3csEk45N1Ymtj+q+VlHNafAPMw6KtHFnbZq/WD
	+lPrix35VUzP24bm5fL5MxHQLLedSusIsHerbatUMbNeY/8mRu6E7ZNo8p3xvWL7HkQICYyzfDx3q
	JA0WtMRHtEaCgdOV9vKGpMdfIUZm1WTzDm47sdhjQUNMLu4myeocgbXQ0sezBGd4S6eAkJeAuQB5e
	oAW4DXBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRp-0000000BtRg-2XlI;
	Wed, 07 Feb 2024 21:27:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRb-0000000BtGX-2WA6
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=76o7TcS/uyRgV/l59qW0RiyZONOaSWKLJo76VrGc5OE=; b=TBwAllCMYTWdICO6zOrJTxaMR1
	JKRQqTEEh/JjK36ZCEvK10NetBo7oD4GAgaP2KDSTkzDSH+o9z5Q/CCnYULl6BsNOHj6Y1okbiDg0
	iNvyWio5UkxJr1X/wmlukcSZKwhgAkYT4ouKern1FF+WTwDPCT8hxJ8DmpW0uNssxYpyWkw4jSgLQ
	h3XMQc5iYjVrXKnpIVb9jVXdLevwMLF2x3q2/R+L+DZeTtf4YDmKj32IRbL56J/W7XOgUkPOhjWTR
	QbdpF+1xvAMCFZzwf7HqTaYIV2PTffS+oDxJ4fjz44IW65V8nAxPD6PrPU5mjGDYT/o4QTtjPxZ/t
	2oFcxBDA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRT-0000000D8CY-25Y4
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 477E761AB3;
	Wed,  7 Feb 2024 21:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A35C43394;
	Wed,  7 Feb 2024 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341209;
	bh=vDbkSJI7wzoSvESOacVLNT1hZSBIwV4Ql2xwrsn1nGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWa3qHLKUVx1/a9IInCk4FXb8O8SbeBODNw3RIFYvSOjVGNsyOIA17SndoOCCYSo9
	 vGOhYY3hp4iOn87Y3GcPQn88PcRS39hBMq+7corG0lrvLyLFQLZh6LxrZMUby9GBsr
	 VHQ8SHDm3j7P2QNSIM77HYeqxhnrCYUcRvwRHpu+oSafc0qRyzARt4DDq4oG38ZVwV
	 kcmcTe3hQ1380Qca5hPs6vpY0rn6e83OBMLAWEOg3ny3PdIWePWsdY8w9aVFkV0yWK
	 n8iby4wml/ZFNPnDdv0snwDh7dOBdR1vV8jLopqwArG9u5WQWEsXIwDAx9nHitkSf4
	 oLfWtUIslaiJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 20/23] nvmet-fc: avoid deadlock on delete association path
Date: Wed,  7 Feb 2024 16:26:01 -0500
Message-ID: <20240207212611.3793-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212653_825730_85FD127B 
X-CRM114-Status: GOOD (  12.27  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 710c69dbaccdac312e32931abcb8499c1525d397 ]

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 20d3013be08a..1ef075b159b9 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -248,6 +250,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		goto out_puttgtport;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,8 +381,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1404,6 +1413,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


