Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BBC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 10:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUcKJbXBOEpbBfA0pU0i0kCUvjBr6lSt0Uq5+NFkwQ8=; b=Vft7RKr6jjftqZgTd5cV/tPs/9
	xLGhbqKdWhnQeSqNxZ1TmFarthn3Exf+h8A3w8OHyM3xhusPTuLR4116KqmaVl0u4cG2fX+I6ov1T
	rR2mNSXx5a0o+JLfou7nXhUfYymB6IvEFMinZnxzWHI6TcQyiUioblYrbRwnBZjXaKuJDaHQAHM6V
	g95jzddJp1MUM+Y3UDimi8y1eT0Nfw8AdAF4i5blF00+HmqUPP/M7UNtua/n6GDrzNH1O2flCHd9o
	VlD/LLRgCEfdtypwzFqcPVDMxaPbJcuDrdTflX7u9xfhAaG9RNXx7yvXpKU+h/eorMwkpoPk9+oYv
	SyMbpdBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivSG-00BQIO-Dp; Thu, 13 Oct 2022 10:28:44 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivSD-00BQHw-Uw
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 10:28:43 +0000
Received: by mail-wr1-f41.google.com with SMTP id bv10so2124123wrb.4
        for <linux-nvme@lists.infradead.org>; Thu, 13 Oct 2022 03:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUcKJbXBOEpbBfA0pU0i0kCUvjBr6lSt0Uq5+NFkwQ8=;
        b=NnQO76OpSM4YaoClO46TiLoS7FYmd+gOkBmQO1mwE4JEVzfrMNEexRiZDND8tfONce
         GqXbYmyY+M7pdoSlKCDUo5M1pXvjwr2a4BEjiu6d/vUQLW07tOaPXXsYWbeiU+i65lJN
         A7e0eUX1z+EyTzLKjlpEkrcM7QGKYB5Z4MyYkSv0MUHR/jBoI55Hloea0wmcLsDjgJbH
         rQDNpl8c1LwLWWvxlzFlFZAQoo8udoe+1NdgSBNTGlhyO/8veLlL6Xp+dI++r4jdiC8H
         flfjONvVMOR9QcGlEfXVtoxel+c7nI3nw3oceQlQnvcURdxdIr4ARIjwkNE1phVSQ4DZ
         24GA==
X-Gm-Message-State: ACrzQf2qfBqbKc0Hzdjmn1vSWn7rG3/RGmO9wjkYkxF3HnopjJDE+kx1
	d/8x5yGaoEjqP1e7zFrg1JNSJJNUApw=
X-Google-Smtp-Source: AMsMyM7RflpqOJLx3tuHzisp4dlDMizKRV39aONKPGY5HRvNXGWT7Srx0srIFf2dg91sCJyXcjGBgA==
X-Received: by 2002:a05:6000:1689:b0:22e:2c03:36e7 with SMTP id y9-20020a056000168900b0022e2c0336e7mr21828088wrd.252.1665656919270;
        Thu, 13 Oct 2022 03:28:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m20-20020adfc594000000b0022abcc1e3cesm1699179wrg.116.2022.10.13.03.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:28:38 -0700 (PDT)
Message-ID: <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
Date: Thu, 13 Oct 2022 13:28:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221013094450.5947-2-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_032842_051174_1460322C 
X-CRM114-Status: GOOD (  28.38  )
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



On 10/13/22 12:44, Chao Leng wrote:
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an interface
> to quiesce all the queues on a given tagset. This interface is useful because
> it can speedup the quiesce by doing it in parallel.
> 
> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> in parallel such that all of them wait for the same rcu elapsed period with
> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> sufficient.
> 
> Because some queues never need to be quiesced(e.g. nvme connect_q).
> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
> skip the queue.

I wouldn't say it never nor will ever quiesce, we just don't happen to
quiesce it today...

> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   block/blk-mq.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   include/linux/blkdev.h |  2 ++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..ebe25da08156 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>   #include <linux/prefetch.h>
>   #include <linux/blk-crypto.h>
>   #include <linux/part_stat.h>
> +#include <linux/rcupdate_wait.h>
>   
>   #include <trace/events/block.h>
>   
> @@ -311,6 +312,80 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>   
> +static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	int i = 0;
> +	int count = 0;
> +	struct request_queue *q;
> +	struct rcu_synchronize *rcu;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_noquiesced(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +		count++;
> +	}
> +
> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> +	if (rcu) {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +			if (blk_queue_noquiesced(q))
> +				continue;
> +
> +			init_rcu_head(&rcu[i].head);
> +			init_completion(&rcu[i].completion);
> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
> +			i++;
> +		}
> +
> +		for (i = 0; i < count; i++) {
> +			wait_for_completion(&rcu[i].completion);
> +			destroy_rcu_head(&rcu[i].head);
> +		}
> +		kvfree(rcu);
> +	} else {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			synchronize_srcu(q->srcu);
> +	}
> +}
> +
> +static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_noquiesced(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +	}
> +	synchronize_rcu();
> +}
> +
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	mutex_lock(&set->tag_list_lock);
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		blk_mq_quiesce_blocking_tagset(set);
> +	else
> +		blk_mq_quiesce_nonblocking_tagset(set);
> +
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
> +
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_unquiesce_queue(q);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> +
>   void blk_mq_wake_waiters(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799..1df47606d0a7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
>   void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>   void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>   void blk_mq_quiesce_queue(struct request_queue *q);
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
>   void blk_mq_wait_quiesce_done(struct request_queue *q);
>   void blk_mq_unquiesce_queue(struct request_queue *q);
>   void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d98..f15544299a67 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -579,6 +579,7 @@ struct request_queue {
>   #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>   #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>   #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +#define QUEUE_FLAG_NOQUIESCED	31	/* queue is never quiesced */

the comment is misleading. If this is truely queue that is never
quiescing then blk_mq_quiesce_queue() and friends need to skip it.

I'd call it self_quiesce or something that would reflect that it is
black-listed from tagset-wide quiesce.

