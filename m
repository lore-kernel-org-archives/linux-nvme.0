Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A54C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 06:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmMGnP7L7bn/5ssBCNCkB8ryZejZU4L6IU8tNWtA8SU=; b=xlArx0pIxGGNAU+ENSJX7wAiZ5
	Q1ebJrS07mpuozfdhWYjP+lYKK2b1SMD2ax30Yp2XyBVbMzbiTiBw6yQK2bW29cC5YuLCez90U1eQ
	Gy5lh7rCXrom3OFJ2VOQAXwfAu/5NCLOIZbbLwoyInxmb8S96eyoHor/YsNd9tJPGK7/4WC1Kfg0B
	OyKF/X7jy2Bs7zsQNxPU/tFXs0bJLTd5hDgZPhAJhj2xIt96NKS5LbqWRT/Tb7CKTRv8wZECVi/B0
	eUqOZMhwntaZcLZ6twFJibwPBUCeNGfmZjwV70bWdI1/RS4gWwF/6ihcrrluGI7GbmkiU0NBi8eKd
	W6zrL5fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWtSJ-007q1N-2r;
	Fri, 18 Aug 2023 06:59:35 +0000
Received: from out-15.mta0.migadu.com ([91.218.175.15])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWtSF-007q0K-2L
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 06:59:34 +0000
Message-ID: <a60de9ff-6dad-f243-6bd0-56810ef57c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692341959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmMGnP7L7bn/5ssBCNCkB8ryZejZU4L6IU8tNWtA8SU=;
	b=qk7w6tviAs5Oa5HG9F4Y1FXDH7P1BeQVk9ddJEzlTyeN+JDa1EwWL6exFVAaxqWOeEyiL3
	GJ+u9sm8V8Dpgi/mdD8dxbYG7FJgVJ/zF4fKPIUM6n3WcMmO5IRODTQA5Djyp4EDiw4VCq
	V+e5XLxhAaI+92zrhup++X+05QLElEM=
Date: Fri, 18 Aug 2023 14:59:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V2] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>
References: <20230818015244.1176929-1-ming.lei@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230818015244.1176929-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_235932_375602_EE5D8F69 
X-CRM114-Status: GOOD (  24.24  )
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

Hi,

On 2023/8/18 09:52, Ming Lei wrote:
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
> 
> Then dead lock is caused:
> 
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
> 
> 2) error handler is waiting for CPU hotplug lock
> 
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
> 
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- fix "Cc: block list"
> 	- add tested-by tag
> 
>  lib/group_cpus.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index aa3f6815bb12..15006e79196f 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -348,6 +348,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  {
>  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t local_cpu_present_mask;
>  	cpumask_var_t nmsk, npresmsk;
>  	int ret = -ENOMEM;
>  	struct cpumask *masks = NULL;
> @@ -355,6 +356,16 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return NULL;
>  
> +	if (!zalloc_cpumask_var(&local_cpu_present_mask, GFP_KERNEL))
> +		goto fail_local_pres_mask;
> +
> +	/*
> +	 * Make a local cache of 'cpu_present_mask', so the two stages
> +	 * spread can observe consistent 'cpu_present_mask' without holding
> +	 * cpu hotplug lock.
> +	 */
> +	cpumask_copy(local_cpu_present_mask, cpu_present_mask);
> +

Maybe we can reuse npresmsk instead of allocating another cpumask?
In the first stage: npresmsk = cpu_present_mask
In the second stage: npresmsk = cpu_possible_mask & ~npresmsk

>  	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
>  		goto fail_nmsk;
>  
> @@ -366,13 +377,11 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>  
> -	/* Stabilize the cpumasks */
> -	cpus_read_lock();
>  	build_node_to_cpumask(node_to_cpumask);
>  
>  	/* grouping present CPUs first */
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  cpu_present_mask, nmsk, masks);
> +				  local_cpu_present_mask, nmsk, masks);
>  	if (ret < 0)
>  		goto fail_build_affinity;
>  	nr_present = ret;
> @@ -387,15 +396,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		curgrp = 0;
>  	else
>  		curgrp = nr_present;
> -	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +	cpumask_andnot(npresmsk, cpu_possible_mask, local_cpu_present_mask);
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>  				  npresmsk, nmsk, masks);
>  	if (ret >= 0)
>  		nr_others = ret;
>  
>   fail_build_affinity:
> -	cpus_read_unlock();
> -
>  	if (ret >= 0)
>  		WARN_ON(nr_present + nr_others < numgrps);

This fail_build_affinity tag seems unneeded anymore.

The patch looks good to me:

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

>  
> @@ -406,6 +413,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	free_cpumask_var(npresmsk);
>  
>   fail_nmsk:
> +	free_cpumask_var(local_cpu_present_mask);
> +
> + fail_local_pres_mask:
>  	free_cpumask_var(nmsk);
>  	if (ret < 0) {
>  		kfree(masks);


