Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFEBC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyGPqsbyM+o/waC/snbt/Zuwaa3Q4YW9cnMRXpLc38I=; b=zbF8dKd7FdKSSds5bUNDkoXoaD
	RNOLUjbWHawzHgsm8BsFJY9YNm+nn3ls8pXy6+rkae5Qhu3Khs7NDDNgCleOxlR9BeN2B7UxUUcT7
	jM0CNXDOzgAic11pI/bqARnVkQahIT1zsFs6XPUmxWYpDiefQ47OwXh/W5xM1+mTo0T/0fR5ttyOe
	J8t/EogjyMyuErp3SlkjVBFXSdQrsz1LU0ecWKQJCS5HrbaOVE9omDu/f/pWHkZUtGJeZAd2yOq0z
	cV0emhETbHZ6yv19MpC27MaFQex6+hdcm8B6VK7eRaCWbKJ840C5YDicmv7MtcQCkfJ7oqDNS7Dcc
	pgrzmr9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2Un-00BaJO-1f;
	Thu, 07 Dec 2023 00:44:05 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2Uk-00BaIn-2b
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 00:44:04 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce972ac39dso111010b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 06 Dec 2023 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701909841; x=1702514641; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyGPqsbyM+o/waC/snbt/Zuwaa3Q4YW9cnMRXpLc38I=;
        b=knsgtK5cQHKFmbqubQBOknq+1doTblPCapSEksDUiPX/cF7vgtn+S9L2WOpVvlRF5H
         HqCxwluhlcy8zgnTdsYChlcW1OdXl7R944n+apPZf9EoYGBz7bgZG1IGvNINcz/lyWAt
         fxbA6a64RiGM8o17DM6UlkExgH4sFY8TOs7E/wJq6XIArrNRTuzlraDEPLHZsvpXOsch
         YHEifhgtWmkXuVUNJQQO2vIZisG7irnB4IIV4RTWrnxd0RT1QFUfG4YtLxoixlZb2e80
         gg9rQpBJWju2Rk2ddN8LZr1iVQeDLaoF6BUm2DGbSwojv0KB4k54yRWJFLnijX/bz+77
         sSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909841; x=1702514641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyGPqsbyM+o/waC/snbt/Zuwaa3Q4YW9cnMRXpLc38I=;
        b=ovjzy3pExNrN31qpv7zsGLL1eHXdChJ91x/wN3IUJdxiYnMnEm7kHUHMXB7HhEPkGR
         77g5DaWUI8yUeRoHbMHa8h5igDr8fs0zxatFFTNyIF7wzDC5SP5DQ5rIs031GhmfuMLc
         Q0wm6pvyVMp5KXrePb9HHrOMAUH//WsunFFSE8R90ky8/Wox5yX726JkvEN8hhl6T3lf
         LvZMRjytdGn7ocrCqI1JN13o5N//forMMwOTPsaLf5CJomBSyt+i7D8CqB4pT6y5E2+2
         3eicJS84DnK9mW78QtifSDLa2f06Wd8rEM71eixr8qLoyPhlxX9UzghS3XZOKGBAbri9
         YHvA==
X-Gm-Message-State: AOJu0YyeeA+HZ3QpVJqpceGRqcUeYcBr9HW6t/+VAZ5mEFgHL6OX3DtZ
	wDDzr/p8XtFU47y1nNqQB5o=
X-Google-Smtp-Source: AGHT+IEnwNUCMDTgXHQpgn/W2yuZcnEzZR3jkgKOSL28Lu5yXG+RTr5nf40kOUZcgJ4J0tto9yQozw==
X-Received: by 2002:a05:6a00:b87:b0:6ce:6b7c:ba41 with SMTP id g7-20020a056a000b8700b006ce6b7cba41mr2046931pfj.64.1701909841025;
        Wed, 06 Dec 2023 16:44:01 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b006cbe1bb5e3asm114399pfo.138.2023.12.06.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:44:00 -0800 (PST)
Date: Wed, 6 Dec 2023 16:41:44 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
Message-ID: <ZXEUyH/38KeATuF4@yury-ThinkPad>
References: <20231120083559.285174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120083559.285174-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_164402_864429_802F6015 
X-CRM114-Status: GOOD (  31.81  )
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

Hi Ming,

On Mon, Nov 20, 2023 at 04:35:59PM +0800, Ming Lei wrote:
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
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/group_cpus.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index aa3f6815bb12..ee272c4cefcc 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -366,13 +366,25 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>  
> -	/* Stabilize the cpumasks */
> -	cpus_read_lock();
>  	build_node_to_cpumask(node_to_cpumask);
>  
> +	/*
> +	 * Make a local cache of 'cpu_present_mask', so the two stages
> +	 * spread can observe consistent 'cpu_present_mask' without holding
> +	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
> +	 * hotplug code.
> +	 *
> +	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
> +	 * we can live with the case because it only affects that hotplug
> +	 * CPU is handled in the 1st or 2nd stage, and either way is correct
> +	 * from API user viewpoint since 2-stage spread is sort of
> +	 * optimization.
> +	 */
> +	cpumask_copy(npresmsk, data_race(cpu_present_mask));

Now that you initialize the npresmsk explicitly, you can allocate it
using alloc_cpumask_var().

The same actually holds for nmsk too, and even before this patch. Maybe
fix it in a separate prepending patch?

> +
>  	/* grouping present CPUs first */
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  cpu_present_mask, nmsk, masks);
> +				  npresmsk, nmsk, masks);
>  	if (ret < 0)
>  		goto fail_build_affinity;
>  	nr_present = ret;
> @@ -387,15 +399,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		curgrp = 0;
>  	else
>  		curgrp = nr_present;
> -	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>  				  npresmsk, nmsk, masks);

The first thing the helper does is checking if nprepmask is empty.
cpumask_andnot() returns false in that case. So, assuming that present
cpumask in the previous call can't be empty, we can save few cycles if
drop corresponding check in the helper and do like this:
        
	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk) == 0) {
                nr_others = 0;
                goto fail_build_affinity;
        }

  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
  				  npresmsk, nmsk, masks);

Although, it's not related to this patch directly. So, if you fix
zalloc_cpumask_var(), the patch looks good to me.

Reviewed-by: Yury Norov <yury.norov@gmail.com>

>  	if (ret >= 0)
>  		nr_others = ret;
>  
>   fail_build_affinity:
> -	cpus_read_unlock();
> -
>  	if (ret >= 0)
>  		WARN_ON(nr_present + nr_others < numgrps);
>  
> -- 
> 2.41.0
> 

