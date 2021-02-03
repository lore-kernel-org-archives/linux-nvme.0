Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF6C433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:15:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCBA64E31
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 16:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCBA64E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oXN2r5EPnyuBKWNFLaVTomq1u5pHhTlimoQ/UhFdPas=; b=Om6jLcCEm9rFdRH3Rl83JnOOz
	RbBsE9PZww0yrxobQLN2AQWqfZzD9oyCW/6FiuHwAjfu54tnVp6Se2H5aUHNy3wajxR4IjBa141xb
	vsSN7FFt7bDL5um9UaYbnaZNU3Z07CIYSuL6H6kFCJeY9H/ovxWLZuCYUSqwgRrZTv4Nak0EFA68z
	gs1LFiGAgJmsbquRTaQceuBcNL35U0A5DhPvZq5vVU9YZRpfZVMSnWoyrpvznR2WyaAafKnAHTd4w
	dIt6xPA/LPOyrCRGebko+0TwrqkPexPxrxXrCdh6+ORbj6MdmdcdjenDtcP16gmSRBffiqbcYTGp6
	TGriHx7cQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Knz-0000TY-Mv; Wed, 03 Feb 2021 16:14:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Knx-0000SM-9x
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 16:14:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 56FBB68C4E; Wed,  3 Feb 2021 17:14:55 +0100 (CET)
Date: Wed, 3 Feb 2021 17:14:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
Message-ID: <20210203161455.GB4116@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201034940.18891-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_111457_562846_27858279 
X-CRM114-Status: GOOD (  15.17  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

So I think this is conceptually fine, but I still find the API a little
arcane.  What do you think about the following incremental patch?
If that looks good and tests good for you I can apply the series with
the modifications:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0befaad788a094..02579f4f776c7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -355,6 +355,21 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+/*
+ * Called to unwind from ->queue_rq on a failed command submission so that the
+ * multipathing code gets called to potentially failover to another path.
+ * The caller needs to unwind all transport specific resource allocations and
+ * must return propagate the return value.
+ */
+blk_status_t nvme_host_path_error(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	blk_mq_set_request_complete(req);
+	nvme_complete_rq(req);
+	return BLK_STS_OK;
+}
+EXPORT_SYMBOL_GPL(nvme_host_path_error);
+
 bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index cedf9b31898673..5dfd806fc2d28c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -552,11 +552,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
-
-	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
-	blk_mq_set_request_complete(rq);
-	nvme_complete_rq(rq);
-	return BLK_STS_OK;
+	return nvme_host_path_error(rq);
 }
 EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a72f0718109100..5819f038104149 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -575,6 +575,7 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6993efb27b39f0..f51af5e4970a2b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2091,16 +2091,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
 	if (unlikely(err)) {
-		if (err == -EIO) {
-			/*
-			 * Fail the reqest so upper layer can failover I/O
-			 * if another path is available
-			 */
-			req->status = NVME_SC_HOST_PATH_ERROR;
-			blk_mq_set_request_complete(rq);
-			nvme_rdma_complete_rq(rq);
-			return BLK_STS_OK;
-		}
 		goto err_unmap;
 	}
 
@@ -2109,7 +2099,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 err_unmap:
 	nvme_rdma_unmap_data(queue, rq);
 err:
-	if (err == -ENOMEM || err == -EAGAIN)
+	if (err == -EIO)
+		ret = nvme_host_path_error(rq);
+	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
 	else
 		ret = BLK_STS_IOERR;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
