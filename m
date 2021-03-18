Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD32C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 22:46:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4FF64EED
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 22:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4FF64EED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LYbMK53vib0AsOUKHJvmWqJ8KL5jLj+3Ug1wcwuzX9k=; b=OLYfSbeVoGR8R3UEaS6aSYbf2
	tJ5m3UdQifwMUz9Vz0+cUPWjsYbnCiQZhkiw3X1G5DTJ38JBYXuYzYN5wPitplwJFKS0mUEWimQU+
	rcj1jvH1T402Tu31rjBybal2mXd1Ahnm97Jx0RnUOHvgowPqeHL7zds8ojAn2Ue9ingR+3aiUp7kg
	AGpeM2KUyVVMqcFII1TunYuOfy9Fl8YDg50O8w9nBNX8sc6B9WB7rwlwtI8IQ1fxd6t5YaB1kcSTD
	Uv9GkVX7sWNRSs7HTSk9lK4uB8NR1IIUFxADR0UfEvC+hznmsS2djd/z+xzPWkvOAUXP9CbbYGx61
	V5OwU8NeA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lN1Oy-0068C5-8P; Thu, 18 Mar 2021 22:46:00 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lN1Os-0068BJ-3u
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 22:45:56 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so3900045pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 15:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=08CnF44UNHoEBepwlczwmfgpFTu29QxHTkWiwp+RL1M=;
 b=pZLM17YPdY4jyfct7gV0x/Rv9nLQV0S4VWKGQThrt+HQr3PxhRA5jH6pdvxrVo+xhS
 a5qGHIf9fopPILrBayoHHJRRDcr98pZ4Hpruq1a11j5Etdq+9+JA7amXPPuowuRZTaw3
 bI3H3pdCI07PwXrfVbhO7NQmXY9DiFPoJSWBMmk7OpMCXM7KHXGudXcw0BEPxU2Aw8uf
 tE2zxk3SC2k37W4TO9hv3FVSwRuVjWoM1IHwHv1bbrjqmCcVmhMTo/i+MXN1UEcSaaBw
 MQ0KneiW61XGHl0J+saMhNPDHrqL4ktbQrftadIQrq0rMqxjrEwKra1xvvNQVmbmsAa6
 7xnA==
X-Gm-Message-State: AOAM53014TTMWYPpBTt2gfp0SzgWG82EUf1OXDLQBN5v4HBHXg+BSb1x
 1oETTe7JUscwMWVv27OP1UQ=
X-Google-Smtp-Source: ABdhPJxQTrntyNf6MdjbJVkI93N87SM+JU0ci+tOlGbOB0WVrFTCCe6dPZV/AYfu+lh0qHP/DGLH5w==
X-Received: by 2002:a17:90a:df85:: with SMTP id
 p5mr6446720pjv.204.1616107552702; 
 Thu, 18 Mar 2021 15:45:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ce5f:588:9ba1:3bac?
 ([2601:647:4802:9070:ce5f:588:9ba1:3bac])
 by smtp.gmail.com with ESMTPSA id s22sm2984202pgv.94.2021.03.18.15.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 15:45:52 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <388a104d-6f70-5f65-619f-6d55c139f7da@grimberg.me>
Date: Thu, 18 Mar 2021 15:45:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_224554_785365_7F1C6A75 
X-CRM114-Status: GOOD (  34.04  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Placing the request on the requeue_list is fine, but the question is
>>>> when to kick the requeue_work, nothing guarantees that an alternate path
>>>> exist or will in a sane period. So constantly requeue+kick sounds like
>>>> a really bad practice to me.
>>>
>>> nvme_mpath_set_live(), where you reported the deadlock, kicks the
>>> requeue_list. The difference that NOWAIT provides is that
>>> nvme_mpath_set_live's schronize_srcu() is no longer blocked forever
>>> because the .submit_bio() isn't waiting for entery on a frozen queue, so
>>> now it's free to schedule the dispatch.
>>>
>>> There's probably an optimization to kick it sooner if there's a viable
>>> alternate path, but that could be a follow on.
>>
>> That would be mandatory I think, otherwise this would introduce
>> a regression...
>>
>>> If there's no immediate viable path, then the requests would remain on
>>> the requeue list. That currently happens as long as there's a potential
>>> controller in a reset or connecting state.
>>
>> Well, also worth to keep in mind that now we'll need to clone the bio
>> because we need to override bi_end_io which adds us some overhead
>> in the data path. Unless we make submit_bio return a status which
>> is a much bigger scope of a change I would expect...
> 
> Having submit_bio() return the enter status was where I was going with
> this, but the recursive handling makes this more complicated than I
> initially thought.
> 
> If you use the NOWAIT flag today with a freezing queue, the IO will end
> with BLK_STS_AGAIN and punt retry handling to the application. I'm
> guessing you don't want that to happen, so a little more is required for
> this idea.
> 
> Since it's an error path, perhaps a block operations callback is okay?
> Something like this compile tested patch?

Maybe... I don't see any apparent reason why it would not work...

> ---
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..423b89005a28 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -475,6 +475,16 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>   	}
>   }
>   
> +static inline void bio_enter_error(struct bio *bio)
> +{
> +	struct gendisk *disk = bio->bi_bdev->bd_disk;
> +
> +	if (disk->fops->enter_err)
> +		disk->fops->enter_err(bio);
> +	else
> +		bio_wouldblock_error(bio);
> +}
> +
>   static inline int bio_queue_enter(struct bio *bio)
>   {
>   	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> @@ -484,7 +494,7 @@ static inline int bio_queue_enter(struct bio *bio)
>   	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
>   	if (unlikely(ret)) {
>   		if (nowait && !blk_queue_dying(q))
> -			bio_wouldblock_error(bio);
> +			bio_enter_error(bio);
>   		else
>   			bio_io_error(bio);
>   	}
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index edf19bbb904f..2c27eeaa83b0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2366,9 +2366,24 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
>   	nvme_put_ns_head(disk->private_data);
>   }
>   
> +void nvme_ns_head_enter_err(struct bio *bio)
> +{
> +	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
> +
> +	if (nvme_available_path(head)) {
> +		spin_lock_irq(&head->requeue_lock);
> +		bio_list_add(&head->requeue_list, bio);
> +		spin_unlock_irq(&head->requeue_lock);
> +	} else {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +	}
> +}

Nice, you can take the error path in nvme_ns_head_submit_bio
and use it there too:
--
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5c67a5e96738..8d0ef83f545c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -318,17 +318,8 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
                 trace_block_bio_remap(bio, disk_devt(ns->head->disk),
                                       bio->bi_iter.bi_sector);
                 ret = submit_bio_noacct(bio);
-       } else if (nvme_available_path(head)) {
-               dev_warn_ratelimited(dev, "no usable path - requeuing 
I/O\n");
-
-               spin_lock_irq(&head->requeue_lock);
-               bio_list_add(&head->requeue_list, bio);
-               spin_unlock_irq(&head->requeue_lock);
         } else {
-               dev_warn_ratelimited(dev, "no available path - failing 
I/O\n");
-
-               bio->bi_status = BLK_STS_IOERR;
-               bio_endio(bio);
+               nvme_ns_head_enter_err(bio);
         }

         srcu_read_unlock(&head->srcu, srcu_idx);
--

And move the prints as well for some logging..

> +
>   const struct block_device_operations nvme_ns_head_ops = {
>   	.owner		= THIS_MODULE,
>   	.submit_bio	= nvme_ns_head_submit_bio,
> +	.enter_err	= nvme_ns_head_enter_err,
>   	.open		= nvme_ns_head_open,
>   	.release	= nvme_ns_head_release,
>   	.ioctl		= nvme_ioctl,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a1d476e1ac02..47595bb09032 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -274,7 +274,7 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   	return ns;
>   }
>   
> -static bool nvme_available_path(struct nvme_ns_head *head)
> +bool nvme_available_path(struct nvme_ns_head *head)
>   {
>   	struct nvme_ns *ns;
>   
> @@ -313,7 +313,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>   	ns = nvme_find_path(head);
>   	if (likely(ns)) {
>   		bio_set_dev(bio, ns->disk->part0);
> -		bio->bi_opf |= REQ_NVME_MPATH;
> +		bio->bi_opf |= REQ_NVME_MPATH | REQ_NOWAIT;
>   		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>   				      bio->bi_iter.bi_sector);
>   		ret = submit_bio_noacct(bio);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 815c032a190e..5dbd6baebd70 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -677,6 +677,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
>   void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>   struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
>   blk_qc_t nvme_ns_head_submit_bio(struct bio *bio);
> +bool nvme_available_path(struct nvme_ns_head *head);
>   
>   static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
>   {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bc6bc8383b43..b5ae1aa292c1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1862,6 +1862,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
>   
>   struct block_device_operations {
>   	blk_qc_t (*submit_bio) (struct bio *bio);
> +	void (*enter_err) (struct bio *bio);
>   	int (*open) (struct block_device *, fmode_t);
>   	void (*release) (struct gendisk *, fmode_t);
>   	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
> --
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
