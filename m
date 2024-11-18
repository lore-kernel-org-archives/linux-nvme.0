Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE70D49231
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cJ9LHoLwlfgB/KP+4VpBlxQYJY2gKtgt9vzmNBIx6g=; b=d5giF4U9yJVYpmNveb0Q1H7Srt
	clNk4JD061RS1I9MQEAcox1hzOxrIypO3F9SIA1s0I2CWzU6W1DUUBE+D3fB0xs1IRHsyzhpYQAv+
	sbvYzXij6bqENWnXqXasqbLRYVCpN8ktDAUSRZq7xI8GXAbNn42Mux5f8+G3VMdgRO0CJq/PwJ5AA
	zkEU27QNP3qdsM2gYKD4EfJSsoQzse3ZNyTCD+EnOW++mCajmx8uXTWKsMq2bjCN4/WKPAmefgIDd
	ss4q/ipGBfJHf65gFBJCFkWwe2Mn1C+C+SVYZZVCkCD9eQskkf6OpGQ2ISnaiaKe/GfVlz+EDCx9t
	r2WH26rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3cR-00000009uxr-3y4B;
	Mon, 18 Nov 2024 15:24:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3be-00000009ung-3SSe
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 15:24:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CDE968D31; Mon, 18 Nov 2024 16:23:57 +0100 (CET)
Date: Mon, 18 Nov 2024 16:23:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Subject: Re: don't reorder requests passed to ->queue_rqs
Message-ID: <20241118152357.GA7513@lst.de>
References: <20241113152050.157179-1-hch@lst.de> <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com> <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk> <20241114041603.GA8971@lst.de> <0236980b-b892-460c-802e-a87a79b7ac0b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0236980b-b892-460c-802e-a87a79b7ac0b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_072403_148564_755DA069 
X-CRM114-Status: GOOD (  28.11  )
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

On Thu, Nov 14, 2024 at 08:14:11AM -0700, Jens Axboe wrote:
> > that goes back to the scheme currently used upstream in nvme and virtio
> > that just cuts of the list at a hctx change instead of moving the
> > requests one by one now that the block layer doesn't mess up the order.
> 
> I think that would be useful. I can test.

I played with this a bit, and I really hate keeping prev for the
unlinking.  So this version uses a slightly different approach:

 ‐ a first pass that just rolls through all requests and does the prep
   checks.  If they fail that is recorded in a new field in the iod
   (could also become a request flag)
 - the submission loop inside sq_lock becomes a bit more complex
   as it handles breaking out of the inner loop for hctx changes,
   and to move the previously failed commands to the resubmit list.

But this completely gets rid of the prev tracking and all list
manipulation except for the final list_pop.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f2e3ad2cc52..3470dae73a8c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -233,6 +233,7 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	bool aborted;
+	bool batch_failed;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
 				   pool in use */
 	unsigned int dma_len;	/* length of single DMA segment mapping */
@@ -843,6 +844,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	blk_status_t ret;
 
 	iod->aborted = false;
+	iod->batch_failed = false;
 	iod->nr_allocations = -1;
 	iod->sgt.nents = 0;
 
@@ -904,54 +906,51 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
+static void nvme_submit_cmds(struct rq_list *rqlist,
+		struct rq_list *requeue_list)
 {
-	struct request *req;
+	struct request *req = rq_list_peek(rqlist);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
 	spin_lock(&nvmeq->sq_lock);
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+		if (iod->batch_failed)
+			rq_list_add_tail(requeue_list, req);
+		else
+			nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+
+		if (!req->rq_next || req->mq_hctx != req->rq_next->mq_hctx)
+			break;
 	}
 	nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
-static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
-{
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return false;
-	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
-		return false;
-
-	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
-}
-
 static void nvme_queue_rqs(struct rq_list *rqlist)
 {
-	struct rq_list submit_list = { };
 	struct rq_list requeue_list = { };
-	struct nvme_queue *nvmeq = NULL;
 	struct request *req;
 
-	while ((req = rq_list_pop(rqlist))) {
-		if (nvmeq && nvmeq != req->mq_hctx->driver_data)
-			nvme_submit_cmds(nvmeq, &submit_list);
-		nvmeq = req->mq_hctx->driver_data;
+	rq_list_for_each(rqlist, req) {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-		if (nvme_prep_rq_batch(nvmeq, req))
-			rq_list_add_tail(&submit_list, req);
-		else
-			rq_list_add_tail(&requeue_list, req);
+		/*
+		 * We should not need to do this, but we're still using this to
+		 * ensure we can drain requests on a dying queue.
+		 */
+		if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)) ||
+		    unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)) ||
+		    unlikely(nvme_prep_rq(nvmeq->dev, req) != BLK_STS_OK))
+			iod->batch_failed = true;
 	}
 
-	if (nvmeq)
-		nvme_submit_cmds(nvmeq, &submit_list);
+	do {
+		nvme_submit_cmds(rqlist, &requeue_list);
+	} while (!rq_list_empty(rqlist));
+
 	*rqlist = requeue_list;
 }
 

