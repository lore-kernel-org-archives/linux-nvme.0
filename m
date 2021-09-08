Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00AEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 20:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2DF60EFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 20:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D2DF60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5NcMpsbhqVCtgirpa09YHlZ60Qt160yhXtLzjOBtl8=; b=oaNgRL60C9bRSXvEeU6/G7LZBA
	PdVuSIDGd0ldLc5s/6w4+rqge+vm+I6U0g3+t8dQ+vQYVGCY+w5ibdrurapDX1SXXVRtKV8BEzcQw
	bepYoQZJ4nsYpDh512p8CH/WTV1/iI45DvvHUCL15CBIREnyqgm/jwMn57KsmeCpWbcXpmgu8xcCH
	XfPiLQkCTkHH05nQp/Ey0bQB0pGKlxGULZXb+RBLOrjIHtX2M3jOj54enf4iTwG6js4HI1I0p1n16
	oIwIDv3i1cjnsQj0H0eS9uMS3Cn5i4RBOrHtoWmN3zoX4qSksFJM/VgxvetAQTKzCJBhIwciLHQpb
	SUwC5SdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mO4c3-007ZwO-H4; Wed, 08 Sep 2021 20:56:07 +0000
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mO4c0-007Zvo-3l
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 20:56:05 +0000
Received: by mail-ed1-f45.google.com with SMTP id s25so4774249edw.0
 for <linux-nvme@lists.infradead.org>; Wed, 08 Sep 2021 13:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UiTqM7KmYIZe3e5WMYAH1LNRUYWEzD8B47U+rPeswGM=;
 b=rkLbgXjbRV98VkyJo9VK2ankequ6zrTFNBEKla6FwffuQLw2CxnPPmcBxvWpWgzMet
 J7ixUGvzB1o5AyMb/psUgR4vPbGKWu55x3v45HSiVBkME97+fZGuICSkiprUnhvx/D7O
 6/eYWjSuRKzpnVWkKbEEOKp4t7p+lbQuffq3gc/KyF0H9jDEZ0t3HdcbIehoNCr/d0Yl
 7C5E7jOj3JEVMasr7StfIPZfv6qKf1tePMbn9XwX+gwwOEtVlBenE7WHr22lII5ascb9
 3e3vfjnYQ7Xc9gtCRCyX4+PWLqIlqxtPxxOHh+JoyvjP2kbgeg/mksfRZBBeA8Gtj3BG
 1DkQ==
X-Gm-Message-State: AOAM530Fe3mFWXuB+1yEkkFg5VB8382rW8LUCIyNDioQgxLD0oEE3ZOs
 ySpWoYB3cZHL6OPADyfBaoV33sOP97I=
X-Google-Smtp-Source: ABdhPJxoSUllLSeX+JoiHHO27hLuMz7gKBYeVPRa3gZNpJWyDVtIQ0eNhIhEJXMZW0BII/sOur0Kwg==
X-Received: by 2002:a05:6402:1913:: with SMTP id
 e19mr193677edz.9.1631134561758; 
 Wed, 08 Sep 2021 13:56:01 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id gl2sm45167ejb.110.2021.09.08.13.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 13:56:01 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Keith Busch <kbusch@kernel.org>, Samuel Jones <sjones@kalrayinc.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
Date: Wed, 8 Sep 2021 23:55:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_135604_218220_111DF131 
X-CRM114-Status: GOOD (  33.79  )
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


>>> 1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
>>> 2. Userspace context is descheduled.
>>> 3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
>>> 4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
>>> 5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.
>>>
>>> This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:
>>>
>>> 1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
>>> 2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
>>> 3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread
>>>
>>> Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?
>>
>> Sounds possible. The "pending" check on the req_list was to fix a race
>> condition where the io_work could miss handling a request, resulting in
>> a different command time out. It sounds like that could make the io_work
>> spin without having anything to do, while starving the lower priority
>> task. I'll try to think of another way to handle it.
> 
> Instead of relying on io_work to determine if there's pending requests,
> the queuing action can try to re-schedule it only after the send_mutex
> is released, and I think that should address the issue you've described
> while still fixing the IO timeout the "pending" trick was addressing.
> Can you try the below patch?
> 
> Sagi, does this look okay to you?

It looks OK to me, but on the other hand the former
one looked perfectly fine to me. I'm trying to understand
if we can have a race condition hiding here....

> ---
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e2ab12f3f51c..e4249b7dc056 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -274,6 +274,12 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   	} while (ret > 0);
>   }
>   
> +static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
> +{
> +	return !list_empty(&queue->send_list) ||
> +		!llist_empty(&queue->req_list) || queue->more_requests;
> +}
> +
>   static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		bool sync, bool last)
>   {
> @@ -294,9 +300,10 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		nvme_tcp_send_all(queue);
>   		queue->more_requests = false;
>   		mutex_unlock(&queue->send_mutex);
> -	} else if (last) {
> -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	}
> +
> +	if (last && nvme_tcp_queue_more(queue))
> +		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);

Basically now the last request in the batch will not trigger
unconditionally (if the direct-send path was not taken), but only if it
sees queued requests, which in theory could be reaped by a running
io_work, that would result in an empty io_work invocation. On one hand
it is undesired, on the other hand should be harmless as it shouldn't
miss an invocation... So it looks reasonable to me.

Sam, can you run some more extensive I/O testing with this (different
patterns of r/w and block sizes)? Also Keith, can you ask the WD folks
to also take it for a spin?

All of these issues have a common theme, which is less I/O queues than
CPUs for each controller which make RX/TX and queue_rq/io_work compete
and usually controllers with smaller MDTS (that trigger multiple R2Ts
per request and uncovered some races in this area). So testing those
would be beneficial.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
