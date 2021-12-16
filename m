Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4599BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hf/5+TD+Y0VvCWN+SHDam5IgywF4cIvkR/kb58toQeQ=; b=fbSsvMJw+lb48g7UKKBqvOw9uC
	1zKU/qCm4s0BAr8TcTiPzI/pEXjw7lRDnaqIUyN4EsCJV6D/FlUEiI90w2Pfhccs0Ljvt8ogUtO8y
	uEX/89THGmpyQOhXi6Yw1raPmrOpfy+1cfIx4Z4RDHe+coubw97fifn2iz+kOUY4XtdWNI20L+rLm
	7NyxRueu4iUlnc2ch3kExM3RttjPkgKv76c9zmn7CRGwSRfwVKzSDqoFbSWh3X1zI5U4TTzdoUoOP
	3eoU5LMn5/vrEVGTMc0OkSB+H1eQ9OZV/vpAWMrRf81OyB2hUwDRkjMeXjZTVZYuSD01kXEX4aPFl
	hyFhGsRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmqm-004MQ7-Py; Thu, 16 Dec 2021 09:14:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxmdU-004Fjl-B4; Thu, 16 Dec 2021 09:01:12 +0000
Date: Thu, 16 Dec 2021 01:01:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YbsAWGcCPn/3BgzF@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-2-axboe@kernel.dk>
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

This whole series seems to miss a linux-block cc..

On Wed, Dec 15, 2021 at 09:24:18AM -0700, Jens Axboe wrote:
> If we have a list of requests in our plug list, send it to the driver in
> one go, if possible. The driver must set mq_ops->queue_rqs() to support
> this, if not the usual one-by-one path is used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 26 +++++++++++++++++++++++---
>  include/linux/blk-mq.h |  8 ++++++++
>  2 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e02e7017db03..f24394cb2004 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2512,6 +2512,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  {
>  	struct blk_mq_hw_ctx *this_hctx;
>  	struct blk_mq_ctx *this_ctx;
> +	struct request *rq;
>  	unsigned int depth;
>  	LIST_HEAD(list);
>  
> @@ -2520,7 +2521,28 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	plug->rq_count = 0;
>  
>  	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
> +		struct request_queue *q;
> +
> +		rq = rq_list_peek(&plug->mq_list);
> +		q = rq->q;

Nit: I'd just drop the q local variable as it is rather pointless.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

