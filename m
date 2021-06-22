Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D5C48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 07:43:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784816112D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 07:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784816112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ql6d6cCIGH7m7kemItrn0NL5rF85vJcbo/80t0rp+4E=; b=vqExMnIuGabcxt
	/AN2h4xP7GXFkGJFmLwt0Xc+OdFhwJfjLzgCgBy6Slr80VRwyT8ekgLOvp5gmF48xyGFmKfSdwjVl
	ekJP3HPVLvnhkEhEsGvqlOEy1UUwFupjm+kvyfiY85XWDXm48kEMl+dNeQX4U1HCFgjlbD9Nj75UI
	gl1e7w1w617QOdoS7ysYpslwkL1AUcq4XFAhlXQHjNFaaMClpIs2kzHhXxErRiIt7CRQF0aiTLz8Q
	8YcnKPAt+BpH2RCG34YnCXAClSGk3WOKNnv60vnkKelhZtyuzJf+J9rqCf76bOBrPal46eFcDDGEv
	ZWYR1FbxDKRqQQdPsCvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvb3r-0064UQ-96; Tue, 22 Jun 2021 07:43:07 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvb3o-0064TE-Gj
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 07:43:05 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 f16-20020a05600c1550b02901b00c1be4abso1068771wmg.2
 for <linux-nvme@lists.infradead.org>; Tue, 22 Jun 2021 00:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ogdQk6dbD/xVFTTUGDdu5c0vOPla9hABdQSZVTdVOzE=;
 b=SzGiOq3a59qWTZ6PXiD+UxXE5XQNNJiSVoSyoqVYZ9k4WOrI/xOJ0mnXaU71dv0V5G
 +ZendAjPbhUich7Hbu+dBmocyu6vn/F6oDY3Xp3gGCF6lJOwP76d/ENrGC18OjTgtJvp
 IQWwCnhOEDTojAdPGtrukz8B3a135yNA2QgI01QXMrg+zAuc2jfO8V7u2dgqMWAAwOOz
 YzC4u38acOOj1XNpQKAzALqBPGzIakUfkPamkDl/Fwfnzz2q7zg7dl2qDUcijmo3rvsN
 qQL9CzW4cZMCPDCpeiOZP3kLRpfICxwf+hvzQJMznRGX8KxXRPboR3qETxAk2KKHx1sT
 nh+A==
X-Gm-Message-State: AOAM5331qZ8TasHn3AV8tMfrK73+Z9aQ0XP9il5ygXEA2ypyo2C8H/t2
 p9hquQl+UVx6ZTXtjiKLgV/ju0xf/2Y=
X-Google-Smtp-Source: ABdhPJxRdsZJgEZdX/gybLL36/M6v7TvxOWLf7TLJjnM7g79lFR6ZxEnbbSJG5Vv7BUeJv8RrjQG3A==
X-Received: by 2002:a05:600c:35c1:: with SMTP id
 r1mr2938931wmq.181.1624347782867; 
 Tue, 22 Jun 2021 00:43:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:a450:8917:2b92:33b7])
 by smtp.gmail.com with ESMTPSA id f12sm24274980wru.81.2021.06.22.00.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 00:43:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-rdma: process wr wait list from a non-atomic context
Date: Tue, 22 Jun 2021 00:42:57 -0700
Message-Id: <20210622074257.1273123-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_004304_606520_9B44C08B 
X-CRM114-Status: GOOD (  14.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If we fail to post a rsp capsule, we release the rsp and
if we happen to have a work waiting on the wr_wait_list, hence
we need to process them, however the context can be softirq
hence we need to schedule this on a kthread as I/O submission
may schedule.

Reported-by: Michal Kalderon <mkalderon@marvell.com>
Tested-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/rdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44b..9684d8972a3e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -102,6 +102,7 @@ struct nvmet_rdma_queue {
 
 	struct work_struct	release_work;
 	struct list_head	rsp_wait_list;
+	struct work_struct	wr_wait_work;
 	struct list_head	rsp_wr_wait_list;
 	spinlock_t		rsp_wr_wait_lock;
 
@@ -517,8 +518,10 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 	return ret;
 }
 
-static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
+static void nvmet_rdma_process_wr_wait_list(struct work_struct *w)
 {
+	struct nvmet_rdma_queue *queue =
+		container_of(w, struct nvmet_rdma_queue, wr_wait_work);
 	spin_lock(&queue->rsp_wr_wait_lock);
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
@@ -677,7 +680,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 		nvmet_req_free_sgls(&rsp->req);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
-		nvmet_rdma_process_wr_wait_list(queue);
+		schedule_work(&queue->wr_wait_work);
 
 	nvmet_rdma_put_rsp(rsp);
 }
@@ -1445,6 +1448,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
+	INIT_WORK(&queue->wr_wait_work, nvmet_rdma_process_wr_wait_list);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
 	queue->port = port->nport;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
