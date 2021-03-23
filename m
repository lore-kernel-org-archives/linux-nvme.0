Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDBC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 22:53:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55D2619DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 22:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55D2619DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kINJ4Vxl+14yCVulHiXlaXBBm5FPENJxqaOvNlkc9PA=; b=bk7JzLPVJaudzLm6UE3bG9bpA
	zN0ZsUFzVP+RHHGVcxWr/2rlIkQysAaMKftij24BJhD7dsrt7sMPkcneYongGEeNEYmaJ7hzXthT1
	gGS9PNM75wVZGdjLKokH+bUT1Zn1L6J5DG26vu40yaCXG576rDSwz/B0g8IuTkCGnKToDWvFo5rsE
	dUpPHXcvDlbmdlI1JtLMqhpiiRPAMjd66d+AQXOhU39AZGcs2CikTdWRzzRz+X3fCtUMA/PRQPGsL
	lTN4GNsh+y2lqwTMQNO1qIP5sJ7uamG0YnZx9d5Ob3y4Xh1w20Y4zASWbQfRQGv7le2dQ9DW4lzNA
	oARSvlSvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOptL-00Fwlo-MS; Tue, 23 Mar 2021 22:52:51 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOptF-00Fwl8-Nh
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 22:52:48 +0000
Received: by mail-pg1-f173.google.com with SMTP id h25so13259423pgm.3
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 15:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wsihvCVCXe/JJoI9lIzZZCqOL6YZpe9Mm+lSvc56DZE=;
 b=WzBewS8yPstTSDz00zNyYYMucypWCHkKk/uvPN6I88N/vXoa+AED8U1AlNzWiIMNHN
 v/C0DYRK+kRSjRAB+x73Bo2zi5fnSFLum1NfBzvyrQ9szEpAQU/xHh7q4X1aLZATWd2i
 nm6YIpEMx8rbn3YjWaxxexVyRer9vnxj2rNqE5DNXkvYqoo70hy162UqQxjVrdRVKx2/
 s4X0OVsGNXshRnPuZJXu7VEalopcj/4JTdGs1EZkodPH87gOegLvXzc29PfxjV9Laoth
 G1PUcyFs86Yko7WFwyB/gfRhoe0xW7PaRXA9ewzDDcemudsNiBtqaA2uuywXmlwmwLZC
 h6rg==
X-Gm-Message-State: AOAM5314Hrmn8rDD9v6JorhriobRLz8yIkoLSgfAl8V03XjK5ns9PAe0
 C46DxqlUw5aUGxWDkcps+h0TBJOz6qM=
X-Google-Smtp-Source: ABdhPJwD9K8wKCJSwIK1dgyJDIBzTmNv+a1WaYiiR4vqGlDcMlIYe7NafY0uli1wgJc7/vnHwo191A==
X-Received: by 2002:a17:902:bd06:b029:e6:54ad:519a with SMTP id
 p6-20020a170902bd06b02900e654ad519amr541600pls.52.1616539963848; 
 Tue, 23 Mar 2021 15:52:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9?
 ([2601:647:4802:9070:3b29:de57:36aa:67b9])
 by smtp.gmail.com with ESMTPSA id m4sm227165pgu.4.2021.03.23.15.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 15:52:43 -0700 (PDT)
Subject: Re: [PATCH V3] nvmet-tcp: enable optional queue idle period tracking
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB2869C572ECE86BF9CBF7F649E5649@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4a1f41c-9e99-4ed0-db06-e26496be71df@grimberg.me>
Date: Tue, 23 Mar 2021 15:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB2869C572ECE86BF9CBF7F649E5649@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_225246_075921_08ADA8FB 
X-CRM114-Status: GOOD (  41.53  )
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

Hey Mark,

> nvmet-tcp: enable optional queue idle period tracking
> 
> Add 'idle_poll_period_usecs' option used by io_work() to support
> network devices enabled with advanced interrupt moderation
> supporting a relaxed interrupt model. It was discovered that
> such a NIC used on the target was unable to support initiator
> connection establishment, caused by the existing io_work()
> flow that immediately exits after a loop with no activity and
> does not re-queue itself.
> 
> With this new option a queue is assigned a period of time
> that no activity must occur in order to become 'idle'.  Until
> the queue is idle the work item is requeued.
> 
> The new module option is defined as changeable making it
> flexible for testing purposes.
> 
> The pre-existing legacy behavior is preserved when no module option
> for idle_poll_period_usecs is specified.
> 
> Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---

Its easier to read here with the format:
Changes from v2:
- ...
- ...

Changes from v1:
- ...
- ...

> V2 of this patch removes the accounting of time deducted from the
> idle deadline time period only during io_work activity.  The result
> is a more simple solution, only requiring the selection of a
> sufficient optional time period that will catch any non-idle activity
> to keep a queue active.
> 
> Testing was performed with a NIC using standard HW interrupt mode, with
> and without the new module option enabled.  No measurable performance
> drop was seen when the patch wsa applied and the new option specified
> or not.  A side effect of a standard NIC using the new option
> will reduce the context switch rate.  We measured a drop from roughly
> 90K to less than 300 (for 32 active connections).
> 
> For a NIC using a passive advanced interrupt moderation policy, it was
> then successfully able to achieve and maintain active connections with
> the target.
> ---
> V3 of this patch provides a bit more simplification, pulling the
> tracking code out of io_work and into two support functions.  Now a
> single test made after the process loop in io_work to determine if
> optional idle tracking is active or not.  The base logic of idle tracking
> used as condition to re-queue worker remains the same.
> ---
>   drivers/nvme/target/tcp.c |   44 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index dc1f0f647189..0e86115af9f4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -29,6 +29,16 @@ static int so_priority;
>   module_param(so_priority, int, 0644);
>   MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
>   
> +/* Define a time period (in usecs) that io_work() shall sample an activated
> + * queue before determining it to be idle.  This optional module behavior
> + * can enable NIC solutions that support socket optimized packet processing
> + * using advanced interrupt moderation techniques.
> + */
> +static int idle_poll_period_usecs;
> +module_param(idle_poll_period_usecs, int, 0644);
> +MODULE_PARM_DESC(idle_poll_period_usecs,
> +		"nvmet tcp io_work poll till idle time period in usecs");
> +
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
>   #define NVMET_TCP_IO_WORK_BUDGET	64
> @@ -119,6 +129,9 @@ struct nvmet_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
>   
> +	unsigned long		poll_start;
> +	unsigned long		poll_end;
> +
>   	spinlock_t		state_lock;
>   	enum nvmet_tcp_queue_state state;
>   
> @@ -1198,11 +1211,34 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
>   	spin_unlock(&queue->state_lock);
>   }
>   
> +static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
> +{
> +	queue->poll_start = jiffies;
> +	queue->poll_end = queue->poll_start +
> +			usecs_to_jiffies(idle_poll_period_usecs);
> +}
> +
> +static bool nvmet_tcp_check_queue_deadline(struct nvmet_tcp_queue *queue,
> +		int ops)
> +{
> +	if (!idle_poll_period_usecs)
> +		return false;
> +
> +	if (ops || !queue->poll_start)
> +		nvmet_tcp_arm_queue_deadline(queue);
> +
> +	if (!time_in_range(jiffies, queue->poll_start, queue->poll_end)) {
> +		queue->poll_start = queue->poll_end = 0;
> +		return false;
> +	}
> +	return true;

Can this be simpler somehow? without clearing the poll limits and then
looking at poll_start to indicate that?

> +}
> +
>   static void nvmet_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvmet_tcp_queue *queue =
>   		container_of(w, struct nvmet_tcp_queue, io_work);
> -	bool pending;
> +	bool pending, requeue;
>   	int ret, ops = 0;
>   
>   	do {
> @@ -1223,9 +1259,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
>   
>   	/*
> -	 * We exahusted our budget, requeue our selves
> +	 * Requeue the worker if idle deadline period is in progress or any
> +	 * ops activity was recorded during the do-while loop above.
>   	 */
> -	if (pending)
> +	requeue = nvmet_tcp_check_queue_deadline(queue, ops) || pending;
> +	if (requeue)

I'm thinking that this requeue variable is redundant,

You can do instead:

	if (nvmet_tcp_check_queue_deadline(queue, ops) || pending)
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>   }
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
