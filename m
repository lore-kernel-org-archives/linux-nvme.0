Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4886DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 17:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dC59BSZZXNdYOBVPtM6tEAJYR2yhSg1BDKwbEXq1Q/I=; b=sChe4H4ObX9Ms3eY4lOMxcIYcY
	Mn2nb3wM/bhGV8+LN3cIuNRSq42C92sGOZBowEoG1/RYKWd9rf4mgzm7SWiJHCReBKnhMSobPhMno
	z9Qnc/bQ1CS31iqgx/ffbSGo4tpSpsjcACknk1P/1h+Zw+mQNgYPhsF73+l0B3x+uE3oJtAgODj8Z
	OZhXwz5CGdDxrXubwBeSr6duwE8Z/XP5L7JU89gWa0CkkPybe48aqnyK16+CFP53K8A81aK3I2d5H
	m9gzgL0NDGfPDdNe6P2GOWHIs8E2Ifbh1fad++mW3Kb18dKaPBXR6lDWQJh8AuWqnhTlDkiAdQ/l7
	Ks450B6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2d1e-003F5Y-FX; Wed, 29 Dec 2021 17:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2d1c-003F46-2a
 for linux-nvme@lists.infradead.org; Wed, 29 Dec 2021 17:46:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 930F068AFE; Wed, 29 Dec 2021 18:46:03 +0100 (CET)
Date: Wed, 29 Dec 2021 18:46:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 3/3] nvme-pci: fix queue_rqs list splitting
Message-ID: <20211229174602.GC28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211227164138.2488066-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211229_094608_316482_D355E757 
X-CRM114-Status: GOOD (  14.03  )
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

> +			rq_list_move(rqlist, &requeue_list, req, prev, next);
> +
> +			req = prev;
> +			if (!req)
> +				continue;

Shouldn't this be a break?

> +			*rqlist = next;
> +			prev = NULL;
> +		} else
> +			prev = req;
> +	}

I wonder if a restart label here would be a little cleaner, something
like:


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 992ee314e91ba..29b433fd12bdd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -999,9 +999,11 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 
 static void nvme_queue_rqs(struct request **rqlist)
 {
-	struct request *req, *next, *prev = NULL;
+	struct request *req, *next, *prev;
 	struct request *requeue_list = NULL;
 
+restart:
+	prev = NULL;
 	rq_list_for_each_safe(rqlist, req, next) {
 		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 
@@ -1009,9 +1011,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 			/* detach 'req' and add to remainder list */
 			rq_list_move(rqlist, &requeue_list, req, prev, next);
 
+			if (!prev)
+				break;
 			req = prev;
-			if (!req)
-				continue;
 		}
 
 		if (!next || req->mq_hctx != next->mq_hctx) {
@@ -1019,9 +1021,9 @@ static void nvme_queue_rqs(struct request **rqlist)
 			req->rq_next = NULL;
 			nvme_submit_cmds(nvmeq, rqlist);
 			*rqlist = next;
-			prev = NULL;
-		} else
-			prev = req;
+			goto restart;
+		}
+		prev = req;
 	}
 
 	*rqlist = requeue_list;

