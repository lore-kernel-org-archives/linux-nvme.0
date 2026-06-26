Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D6FCD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5i/m/tnFCKvlmZICczPgBP150awLuwsOt78766Bt4Ns=; b=S8tU/fIRrGETk0gKUpswBctR3x
	2Gi2b7nN4aU61BO6tBnLAEdwl3/XxHqA94FrpcjnfwdIp0k52CcPfzbeLTtIlfwhbwCoBQwLA1zJm
	DiSZiQ6UIhhwRF9VmRj7zSyfBFXjoaHnInMfQBKMzATOP67FgvqjfoJUB/+zr/vL8vXDSF0Nu3fdV
	tnO9M3ULPv3NJuWGSnB7dSsnLP8S7aT5V6A+e0yWWOtzXao9tL76QWsYz8go+pdIuDTd26Vct/u2S
	L9hz1yBoCrySRd6dxTrKw1vDbgG0vWP9l1ua9hX4h3Wt96GcNyv/YwjdN3wNzn/2myja3tmWIKnZ2
	v/MIbDfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1AY-0000000AgnW-2jqX;
	Fri, 26 Jun 2026 07:40:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1AW-0000000AgnA-06sI
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:40:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85E5B68AFE; Fri, 26 Jun 2026 09:40:04 +0200 (CEST)
Date: Fri, 26 Jun 2026 09:40:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com,
	adailey@purestorage.com
Subject: Re: [PATCH v3 2/2] nvme-rdma: parallelize I/O queue allocation and
 startup
Message-ID: <20260626074004.GB12072@lst.de>
References: <20260625212722.1302344-1-sgogte@purestorage.com> <20260625212722.1302344-3-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625212722.1302344-3-sgogte@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_004008_222815_F8903DCC 
X-CRM114-Status: GOOD (  17.70  )
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

On Thu, Jun 25, 2026 at 03:27:22PM -0600, Surabhi Gogte wrote:
> -static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
> +static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, unsigned int first,

Overly long line.

> +		unsigned int last, size_t queue_size)
>  {
> +	ASYNC_DOMAIN_EXCLUSIVE(queue_domain);
> +	struct nvme_rdma_setup_ctx *ctxs;
> +	int nr_queues = last - first;
> +	int err = 0, i, ret;
>  
> +	ctxs = kmalloc_array(nr_queues, sizeof(*ctxs), GFP_KERNEL);

This should use kmalloc_objs in the brave new world.

> +	if (!ctxs)
>  		return -ENOMEM;
>  
> +	for (i = 0; i < nr_queues; i++) {
> +		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
> +
> +		queue->ctrl = ctrl;
> +		queue->queue_size = queue_size;
> +
> +		ctxs[i].queue = queue;
> +		ctxs[i].err = &err;
> +		async_schedule_domain(nvme_rdma_setup_queue_async, &ctxs[i],
> +				&queue_domain);
>  	}
>  
> +	async_synchronize_full_domain(&queue_domain);
> +	kfree(ctxs);

It would nice if the async domain had a way to do the error propagation.
Well, that would be a nice follow on if you're interested.

Talking about follow ons:  do you plan to do a similar change
to nvme-tcp?  It would be great to keep the setup path for
both in sync.


