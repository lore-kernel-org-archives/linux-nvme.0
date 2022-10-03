Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32005C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dY6T2rPEWG/mT84R+nSgsINRdss5Cg0549TjuWhIX0g=; b=RcQh4SHCFsJdXlr33TwD/XADSI
	gi/wvRcAHSkxhXM5ZjYj9UzXqVdZb5wBkEO2ncGL315v+CdQRUklGlL4nPjDmSpitZqaCnll2l+aw
	7noH6ilA2u1QLo+hXPFOWEnxPKY3hk8+vCMFQTwLGhQVDQwaDYs/6Wk2ngnk+jaVtmEanXP2apRz+
	3xYDgi6PjTdixvYuCstjVCfopoxpZESXZevvXN1ZZk6UP6NUMIWcI4lpyesFecc3Besc+52wvDKpn
	ORAPK+WbcU12WTM6A6/yB50Ls6Si0KILC3y9JZ+uzgExqPMHN6u/p/d57CIfRfqLXewfWsbr9Pa6E
	Iv/H1OPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHzU-0057aV-7Y; Mon, 03 Oct 2022 09:44:00 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHzK-0057Ub-G4
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 09:43:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id o5so6644933wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 02:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dY6T2rPEWG/mT84R+nSgsINRdss5Cg0549TjuWhIX0g=;
        b=LAA8IDzx4iwze5TkiPI5WmXY+7A3QHqYTqZhCKmW/iZ+MFI60d8/dwNjM5gFBYnWof
         m3tYS93fUA9M1JU4UFrXLUB3VJ4R3XQfrNd3hnGcElZT04pPN9WtJh0deXvP4YDMnXpV
         J5jKzUQcFo17VZN0s/tmcTVZR0ZFtmcsdKlqEy8KlcGQ7r9Tz6ITvyw8/jtREvivwDq1
         hUUTOGCdboUyQ2HkgsALWbe0RZEakKKP/AOFIF7a2HgmzKQc1NULHCnQS70PnmCSL8wA
         Gua9pVjchURBrql7OACeqgUUwjTmo2EKUZ2XwNvHL4KEUNQ3xuEeXKgCg2fzPBUwyQxF
         7wkw==
X-Gm-Message-State: ACrzQf2uyw9PkatuTvAIsav0jOjgBEczuespm4fmfIkNsiy06XJYD+xF
	TLSMcqr8SZz7PYbDI6wun5AzJQvyHrE=
X-Google-Smtp-Source: AMsMyM749L3GX1JH04KPM/Ty74nswQRwfTox0LUw0kL4Dl/HNqyvnHb4FiV9WhT3lHA+ldyxgGMWlQ==
X-Received: by 2002:a05:600c:1ca8:b0:3b4:a5d1:2033 with SMTP id k40-20020a05600c1ca800b003b4a5d12033mr6148112wms.23.1664790228561;
        Mon, 03 Oct 2022 02:43:48 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b00228d67db06esm3545586wrb.21.2022.10.03.02.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:47 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/2] nvme: introduce nvme_start_request
Date: Mon,  3 Oct 2022 12:43:43 +0300
Message-Id: <20221003094344.242593-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003094344.242593-1-sagi@grimberg.me>
References: <20221003094344.242593-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_024350_581722_A4385A6A 
X-CRM114-Status: GOOD (  14.32  )
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

In preparation for nvme-multipath IO stats accounting, we want the
accounting to happen in a centralized place. The request completion
is already centralized, but we need a common helper to request I/O
start.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/apple.c  | 2 +-
 drivers/nvme/host/core.c   | 6 ++++++
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 8 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..6df4b8a5d8ab 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -763,7 +763,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_free_cmd;
 	}
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	apple_nvme_submit_cmd(q, cmnd);
 	return BLK_STS_OK;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bacfd014e3d..64fd772de817 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -419,6 +419,12 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_start_request(struct request *rq)
+{
+	blk_mq_start_request(rq);
+}
+EXPORT_SYMBOL_GPL(nvme_start_request);
+
 void nvme_complete_batch_req(struct request *req)
 {
 	trace_nvme_complete_rq(req);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 127abaf9ba5d..2cdcc7f5d0a9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2744,7 +2744,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	atomic_set(&op->state, FCPOP_STATE_ACTIVE);
 
 	if (!(op->flags & FCOP_FLAGS_AEN))
-		blk_mq_start_request(op->rq);
+		nvme_start_request(op->rq);
 
 	cmdiu->csn = cpu_to_be32(atomic_inc_return(&queue->csn));
 	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d5d44a73f26..c4d1a4e9b961 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -753,6 +753,7 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 }
 
 #define NVME_QID_ANY -1
+void nvme_start_request(struct request *rq);
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3bdb97205699..e898b9e4e6e0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,7 +929,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 			goto out_unmap_data;
 	}
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e52d2362fa1..ab9d5a17704b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2089,7 +2089,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	blk_mq_start_request(rq);
+	nvme_start_request(rq);
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2524b5304bfb..a1df405de7f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2461,7 +2461,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
-	blk_mq_start_request(rq);
+	nvme_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9750a7fca268..c327615decc2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -145,7 +145,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	blk_mq_start_request(req);
+	nvme_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-- 
2.34.1


