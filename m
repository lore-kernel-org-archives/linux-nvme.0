Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9161CD4F54
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLY5DzRtCqSdJHS1AhA7kLUck0pnN6xgv+TwDnrP08k=; b=dXiFKXS0R55tkRFU0hA1PU1fp/
	0orfdyEj8iqQH22GDU10qUtsMatBWAqwLp8Pfvg44wCCxyP5kQwp2NSNSfHHhKmFl1wzrGUoKku2H
	ojyUwv5gGMwNp4j9J2gMxbLKuHTskR8Ag+pu+Emh843uoqRMvCcUI6g/tbaTRDhMleGQHerEdL9NA
	Ivazjf1xQXhpZHRs++BCiykYycESf26CPEasVMfo8ixJR6NvVMzcvRUTxh1DBV8Upm9s6uQEkK+Yy
	/+zw2rRGoLEdwzkG6H9/vF8s3b1JpiESXna56nbtKMCIzXs1e2y1HE5mXKAlSVt/TSJe7eTiyzPh9
	kU9odH5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT6y2-00000008JUG-1M1g;
	Fri, 29 May 2026 23:50:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT6y0-00000008JTv-0AvL
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 23:50:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CC984327A;
	Fri, 29 May 2026 23:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4691F00893;
	Fri, 29 May 2026 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098615;
	bh=DLY5DzRtCqSdJHS1AhA7kLUck0pnN6xgv+TwDnrP08k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVamTLbBRo98mcmRMFGDhw+GT7k6jeDGMQ4FXw8OfO/3ycjg8Ax0d8X5q6308SF2g
	 k9eY7d7oNaQj0JOl9agP4OHPG97xH/pBTN2JP7Kh5PBxgNOTDIhsKf9Zy7erHgYUxt
	 hGDsIhS0ASk11+R6Avm2w49A4UO2Ilz7bmXkpTj1HopsR6fZa9EGqR63uh6vGI4Jry
	 5FB75r92Pe6ZxOrxx3Picypnvz+jEAGy5UaQjyQhlQI5supHeimfjudQwPA6AxrMpz
	 9+jNI1PPLbD4H08evnBmcoxCIY+jHGnfyjZkOtkBOt3qZcCPS2jJl/3XzsQNylJ5RP
	 oZtISMDVtrLRg==
Date: Fri, 29 May 2026 17:50:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com
Subject: Re: [PATCH] nvme-rdma: parallelize I/O queue allocation and startup
Message-ID: <ahomNc0rSH6FRE8t@kbusch-mbp>
References: <20260529001354.1003640-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529001354.1003640-1-sgogte@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_165016_104591_69E883AF 
X-CRM114-Status: GOOD (  15.51  )
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

On Thu, May 28, 2026 at 06:13:54PM -0600, Surabhi Gogte wrote:
> Refactor nvme rdma I/O queue setup to use parallel work queues,
> combining allocation and startup into a single parallel operation per
> queue. This reduces connection and reconnection setup time when there
> are delays in establishing connections, which is especially important
> for high-core-count hosts.

Seems like a good idea.

> +struct workqueue_struct *nvme_setup_wq;
> +EXPORT_SYMBOL_GPL(nvme_setup_wq);

RDMA is the only one using it, so I don't think we want burden the
common core with this. But I also think a new workqueue is overkill.
Just use the async APIs. Suggestions below:

> +static void nvme_rdma_setup_queue_work(struct work_struct *work)
>  {
> -	int i, ret = 0;
> +	struct nvme_rdma_queue *queue =
> +		container_of(work, struct nvme_rdma_queue, setup_work);

static void nvme_rdma_setup_queue_async(void *data, async_cookie_t cookie)
{
	struct nvme_rdma_queue *queue = data;
	...
}

> +static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, int first,
> +				     int last, size_t queue_size)
>  {

...

> +	for (i = 0; i < nr_queues; i++) {
> +		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
> 
> -	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
> -	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
> -		ret = nvme_rdma_alloc_queue(ctrl, i,
> -				ctrl->ctrl.sqsize + 1);
> -		if (ret)
> -			goto out_free_queues;
> +		queue->ctrl = ctrl;
> +		queue->queue_idx = first + i;
> +		queue->queue_size = queue_size;
> +		INIT_WORK(&queue->setup_work, nvme_rdma_setup_queue_work);
> +		queue_work(nvme_setup_wq, &queue->setup_work);
>  	}

>  
> -	return 0;
> +	for (i = 0; i < nr_queues; i++)
> +		flush_work(&ctrl->queues[first + i].setup_work);

And this part can be:

	ASYNC_DOMAIN_EXCLUSIVE(domain);
	...
	for (i = 0; i < nr_queues; i++) {
		...
		async_schedule_domain(nvme_rdma_setup_queue_async, queue,
			&domain);
        }

        async_synchronize_full_domain(&domain);

It's simpler this way.

