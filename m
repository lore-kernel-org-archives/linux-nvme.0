Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C72C433E4
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CD9206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C0cyOwLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD9206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K0Ax156hyhyJRT3zhCVYNyDTpdiorWvfldMeRZAuttU=; b=C0cyOwLO4XjWAcCAWbScFCqRr
	oSfJl7dwwzW+jAEy3hTRwFNOM/zfDaaUvIq/u/1emL7SXzmcWiykCMumfU8nsLnapfWLrcNkRRyr2
	qwl6Lk7TEIdhgiD5co4rB7qeid88+iFVYgR7wM8R+5zavlzKFPDrFixydhJP+WLPIp12cwZ8Z7RyW
	Nsl+fhbZguWfJPpKaIq2YMwMFCXu7raU+Ag5KkN5N73IWb7DjlC1RYqSbMhYUpjudPZ0ffDJJS5F6
	owGRQvXmKeOUqD7enzvgot1R57jW0G6YIQ9WO2BsoR5YrZm6RFqwL+FW55me8cBrlUovCIqjzeTqB
	m92bwAg5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5el-0003Sk-7k; Fri, 24 Jul 2020 21:55:07 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5ef-0003QN-CU
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 21:55:02 +0000
Received: by mail-pj1-f66.google.com with SMTP id cv18so6412727pjb.1
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 14:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PcuqqoGtoWKgbECmGg9dz/IJPY+0/UqjCTR3wZRyJQ4=;
 b=Xd2rHgVJpvbcpB/lNaESoFJm0ocybnc/dIGnCLZdMgCK2ovvuzf3TuM3BigQ7kWFi3
 q9BQB/xGW7ZbKraWJpZZhMddW66uSmoJedIZ/fQbTz/+s5c7mH2e/OA70qus6tmI9Uuf
 GChVW6wVGmMQRjtEk919w2lEJby86cCJrCanUE1OZ/HhrCXBm6FJnb2T6Et0gRuzHP/P
 P0u9irhYWiu0Bw4Rqa+DQsoxoH+iVwhSom1biifpqmFh1Ip7beYNBG4+uwLGRrgomLi8
 bcXZ7ujmqV6Wx07Lw0R9aIZkjUl6fQAstHWJWoi3Wfyu0TsSBBAUZsIfnZPH4QuW5n+C
 mxhA==
X-Gm-Message-State: AOAM531RRT2HWP9MhcMKsWefURUw5d8NDli6vJWvwawIOx6tHUL2quYS
 ElBY3JmDgellXm3iTHRCBrOvbbPg
X-Google-Smtp-Source: ABdhPJyFOlzZDOdg2CRmWufHN4WRQjQj+mmIZSfTTiOny9cxGX4J2NtiY7eJ7/g4T/XIxSSfBd0aUQ==
X-Received: by 2002:a17:902:fe0b:: with SMTP id
 g11mr9971030plj.269.1595627699823; 
 Fri, 24 Jul 2020 14:54:59 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 144sm7565112pfb.31.2020.07.24.14.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 14:54:59 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH for-testing 4/4] nvme-rdma: use blocking quiesce interface
Date: Fri, 24 Jul 2020 14:54:52 -0700
Message-Id: <20200724215452.26401-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724215452.26401-1-sagi@grimberg.me>
References: <20200724215452.26401-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_175501_555262_2F10BAB0 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5c3848974ccb..edd3cf1d5138 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -793,6 +793,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = nctrl->numa_node;
+		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
 		set->driver_data = ctrl;
@@ -806,7 +807,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = nctrl->numa_node;
-		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
 		if (nctrl->max_integrity_segments)
@@ -1008,7 +1009,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+		nvme_stop_blocking_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		if (ctrl->ctrl.tagset) {
 			blk_mq_tagset_busy_iter(ctrl->ctrl.tagset,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
