Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82446C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Ms3X5yTu8/X7KTrYdKSdN88IG4tvirJg5Cly6RMCjk=; b=GTPCOQfJ7qCUVyl9qMtbKTAh89
	NLcKHpNAH0soMea1XdeOtdEcIriI1taCIUu6n2PUuLwOQ16NIjn0eQszF15TROSFDfpIkWQldW+UV
	JsSy0ktA2rzA8sFHoFmR6f3owfpTWtXGDs10egvPSQRwQz4XFX4F4v9ZE3JE2x8oCE7qBv2Njm+Cc
	dgAB6JUeJ2KfU9j3pa03yRu07JXoNWe5HEL7wBayW6ikywKNHX2JleUrK4Jg8OJGRl5Qd5EAHHJPZ
	h7f78ZNOS58HaETWEbFqJdKFT77McRC2RicFpQP6vSw9dGvvT+qMQRlvAbbJbfwF61/PyHNxDAWGy
	QkwLmnPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSbc-00000009uzv-1o6U;
	Thu, 13 Feb 2025 06:21:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSah-00000009uqC-2s7n
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:20:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71E2F68D05; Thu, 13 Feb 2025 07:20:48 +0100 (CET)
Date: Thu, 13 Feb 2025 07:20:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ruozhu Li <david.li@jaguarmicro.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvmet-rdma: recheck queue state is LIVE in state lock
 in recv done
Message-ID: <20250213062048.GD19608@lst.de>
References: <20250211034543.808-1-david.li@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211034543.808-1-david.li@jaguarmicro.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_222051_896417_3110FF38 
X-CRM114-Status: GOOD (  15.74  )
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

> +++ b/drivers/nvme/target/rdma.c
> @@ -1042,12 +1042,16 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&queue->state_lock, flags);
> -		if (queue->state == NVMET_RDMA_Q_CONNECTING)
> -			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
> -		else
> -			nvmet_rdma_put_rsp(rsp);
> +		if (queue->state != NVMET_RDMA_Q_LIVE) {

You'll want a comment based on the commit message that the first live
check is racy. 

> +			if (queue->state == NVMET_RDMA_Q_CONNECTING)
> +				list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
> +			else
> +				nvmet_rdma_put_rsp(rsp);
> +
> +			spin_unlock_irqrestore(&queue->state_lock, flags);
> +			return;

This gets a bit messy now.  What about a struture like this instead?

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..ae6a123ac63f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -996,6 +996,23 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -1038,18 +1055,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->n_rdma = 0;
 	rsp->invalidate_rkey = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
-
 	nvmet_rdma_handle_command(queue, rsp);
 }
 

