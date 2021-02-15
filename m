Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CFC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:18:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAFF64DE0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAFF64DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jinEm5epBhTZ5+FJmjhQBzSam9rlkldR7LHFvGubkGc=; b=T88iZtMR6oP1uM9GcyYcgDuW6
	FC/fgZrvtQIA5L1LR2LpNW+Kw+pfi16lqV0oDPzHYFKL9erHXECBDjixHiGkzd8leJEP0OnwL6Vum
	nVs9K1kLYX0yGUpUdsh6X23NO1y5v2MVhTagweY8Rmzcqyl5h005JstMjnlX3dHFXq66IlRLtUhNP
	BxLtmDHpYX+g2lUKV9zhmTEyhizuSQOBQkhEJh0+anrigIcw3xKeZSTEJ0AJyRfBhHeDqbkAlc+nJ
	4ctM5eMKw9Q0ZvAqH0eppReaikoyFh8nk5kykl24a0CXxbCnXZiMpDloYnN6xWF9Mx+R6zvGCMt7o
	faRslU8Bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBlGH-00026L-JQ; Mon, 15 Feb 2021 21:18:29 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBlGB-00025y-FX
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 21:18:24 +0000
Received: by mail-wr1-f51.google.com with SMTP id n8so10660962wrm.10
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 13:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J2eto/xRzCK7ltkyPGQqShd2ehUNhbC1bT02+8d28E0=;
 b=WZxJZxo4iIrqBnB6ICCT/yPDYf/17Al9VefAW2lWEyIkK29L6f8tB6NcEiLT9UbiiF
 g2y7p9Ib6m44HVRrpsbX+uRyEqDyawuAVsRY9RMv7NbhAtvFoXtCnXtqsQPo8lKe2zCb
 lvIlb8ZgiSOEHycr9E2mHCMdB0glQoRDbcEkbNewcHBh3Oya2ZDKYNJ3cys4oHdti41Z
 xB+UjpOU22nxW56IE27OQlmpWEbqsj7ducj5VIq956f4o8vZP49yxt2631zeekrFYnZE
 wWxkpEDFx/yYLrYLxOQStrF7fMzaKuMCmpk9WVdefZQvabTcsMdjpEmL6GeV4G1ooRxM
 2oCg==
X-Gm-Message-State: AOAM531UrcVheq9Lq5wV4A0If8SteyPQHMx3eB9KHC6+EjiEcr7YiJo2
 Mvm+oAtY0A/JTyqK9zMkMX+STjsxFyo=
X-Google-Smtp-Source: ABdhPJz2qLoGGM+sLLiG9Vw/ISJs2nt7uglwnYnRMNRAJ6uO1i4ZtfqjF5SgmxJC34RPyVBKmDW8jw==
X-Received: by 2002:adf:f591:: with SMTP id f17mr20584845wro.60.1613423901043; 
 Mon, 15 Feb 2021 13:18:21 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321?
 ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
 by smtp.gmail.com with ESMTPSA id u14sm25725960wro.10.2021.02.15.13.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 13:18:20 -0800 (PST)
Subject: Re: [PATCH] nvmet-tcp: enable optional queue idle period tracking
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB286909CAA3A8721B46A02AFFE58C9@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <25dfb6d2-2519-0f30-529f-36dcb4263160@grimberg.me>
Date: Mon, 15 Feb 2021 13:18:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB286909CAA3A8721B46A02AFFE58C9@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_161823_574210_6F754FD0 
X-CRM114-Status: GOOD (  44.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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



On 2/11/21 3:42 PM, Wunderlich, Mark wrote:
> nvmet-tcp: enable optional queue idle period tracking
> 
> Add 'queue idle period' option used by io_work() to support
> network devices enabled with advanced interrupt moderation
> supporting a relaxed interrupt model. It was discovered that
> such a NIC used on the target was unable to support initiator
> connection establishment, caused by the existing io_work()
> flow that immediately exits and does not re-queue itself at
> the first loop with no activity.
> 
> With this new option a queue is assigned a period of time
> that no activity must occur in order to become 'idle'.  Until
> the queue is idle the work item is requeued.
> 
> The new module option is defined as changeable making it
> flexible for testing purposes.
> 
> The pre-existing legacy behavior is preserved when no module option
> for queue idle period is specified.
> 
> Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---
> Testing was performed with a NIC using standard HW interrupt mode, with
> and without the new module option enabled.  No measurable performance
> drop was seen when the patch was applied and the new option specified
> or not.  A side effect of a standard NIC using the new option
> will reduce the context switch rate.  We measured a drop from roughly
> 90K to less than 300 (for 32 active connections).

Nice!

> 
> For a NIC using a passive advanced interrupt moderation policy, it was
> then successfully able to achieve and maintain active connections with
> the target.
> ---
>   drivers/nvme/target/tcp.c |   65 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index dc1f0f647189..f5e6e2806841 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -29,6 +29,16 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
>   
> +/*
> + * Define a time period (in msecs)

Is this in msecs or usecs? Anyway I think it should be in the name as
well.

  that io_work() shall sample an activated
> + * queue before determining it to be idle.  This optional module behavior
> + * can enable NIC solutions that support socket optimized packet processing
> + * using advanced interrupt moderation techniques.
> + */
> +static int queue_idle_period;
> +module_param(queue_idle_period, int, 0644);
> +MODULE_PARM_DESC(queue_idle_period, "nvmet tcp io_work queue idle time period");

I think this should be called "queue_poll_period" maybe? because this is
the period a queue will keep actively trying to read data from the
socket regardless if there is any activity or not right?

Or does this mean a different semantics with this?

> +
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
>   #define NVMET_TCP_IO_WORK_BUDGET	64
> @@ -96,6 +106,7 @@ struct nvmet_tcp_queue {
>   	struct work_struct	io_work;
>   	struct nvmet_cq		nvme_cq;
>   	struct nvmet_sq		nvme_sq;
> +	unsigned long           idle_period;

poll_period?

>   
>   	/* send state */
>   	struct nvmet_tcp_cmd	*cmds;
> @@ -1198,12 +1209,42 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
>   	spin_unlock(&queue->state_lock);
>   }
>   
> +/*
> + * This worker function will process all send and recv packet
> + * activity for a queue. It will loop on the queue for up to a
> + * given maximum operation budget, or until there is no activity
> + * during a single loop iteration.
> + *
> + * Two exit modes are possible.
> + *
> + * The default 'pending' mode where the worker will re-queue
> + * itself, after exiting the work loop, only if any send or recv
> + * activity was recorded during the last pass within the loop.
> + *
> + * A optional 'idle period' mode where in addition to re-queueing
> + * itself because of activity it also tracks if a queue has not reached an
> + * assigned 'idle' period of time. The worker consumes from the assigned
> + * time period, across many potential invocations, until it is expired.
> + * A queue with activity always being awarded a fresh time
> + * period for processing.
> + */
>   static void nvmet_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvmet_tcp_queue *queue =
>   		container_of(w, struct nvmet_tcp_queue, io_work);
>   	bool pending;
>   	int ret, ops = 0;
> +	long period_remaining;
> +	unsigned long idle_deadline;
> +
> +	/* Setup use of optional tracking for idle time period */

Redundant comment.

> +	if (queue_idle_period) {
> +		/* Assign the queue an idle period if not already set */
> +		if (!queue->idle_period)
> +			queue->idle_period =
> +					usecs_to_jiffies(queue_idle_period);
> +		idle_deadline = jiffies + queue->idle_period;

Why do you need to keep a period time?

Why don't you just maintain queue->poll_start and just check if
your past the queue_poll time addition:

	if (queue_idle_period && queue->start_poll == 0)
		queue->start_poll = jiffies;

...
[io_work loop]
...

	if (queue_poll_period) {
		if (!time_after(jiffies, queue->start_poll +
				usecs_to_jiffies(queue_poll_period)))
			pending = true;
		else
			queue->start_poll = 0;
	}

Can this work?

> +	}
>   
>   	do {
>   		pending = false;
> @@ -1222,8 +1263,30 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   
>   	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
>   
> +	/* If optional deadline mode active, determine if queue has reached its
> +	 * idle process deadline limit.  Remaining deadline is calculated. Any ops
> +	 * activity awards the queue a new deadline period.
> +	 */

Comments should stay consistent in style...

> +	if (queue_idle_period) {
> +		/*
> +		 * Clear to award active non-idle queue new period, or
> +		 * reset for future queue activity after exit when idle reached.
> +		 */
> +		queue->idle_period = 0;
> +		if (ops > 0) {
> +			pending = true;

What is this useful for?

> +		} else if (!time_after(jiffies, idle_deadline)) {
> +			period_remaining = (long)(idle_deadline - jiffies);
> +			if (period_remaining > 0) {
> +				pending = true;
> +				queue->idle_period = period_remaining;
> +			}
> +		}
> +	}

See above if it is simpler?

> +
>   	/*
> -	 * We exahusted our budget, requeue our selves
> +	 * We requeue ourself when pending indicates there was activity
> +	 * recorded, or queue has not reached optional idle time period.
>   	 */
>   	if (pending)
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
