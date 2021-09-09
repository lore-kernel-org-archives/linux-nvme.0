Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87015C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 06:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397E161183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 06:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 397E161183
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1lrFgNfFUf2wMAHMr5rpaZYqVhb1gBu3tzcxD0WJCA=; b=BlCCIWtfsZNSLG3V/wPKc239+Q
	T3zeFFICYGhmxpRuO8Z3Q/C5jg0huWgTBkaoPtfAQ8ekGkFT3ULd70VXu+ZPIBB+TM9G/1tKpHNEa
	eDa/Bn1ose4TX3muIyLF25sfDCRxxE7JhgmvUhMf6KqPTXmSK73IirfZalvV26oT60zrH9JSBVh7Y
	VebWlBoW0k06EYRsXsMKvgJU+KclPLqYSuExMS9wuQ7nmZfcQAs7oyfp0WBn4GtudKFf+M6GkL6Mu
	C6L9zRfzNQEm9bi/OVDi4gWVnxEv4OzxX09hsT1NuzLYQD6YWRqMbS/SR7OqSic9L7YPspKR+4enL
	7ROQ0FDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mODgA-008M8W-Jm; Thu, 09 Sep 2021 06:36:58 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mODfm-008M7a-9m
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 06:36:35 +0000
Received: by mail-ej1-f50.google.com with SMTP id a25so1390810ejv.6
 for <linux-nvme@lists.infradead.org>; Wed, 08 Sep 2021 23:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YrfhVL+YJ0vQD/dPnWpjvaaNXxrK25Q7RalxgR5PpIc=;
 b=glkCRE+ozRih2elyc+0TKQil1yiGoONE8rx0Xb+iOJYo5TaPNautDek/m01Cxn5pUk
 CgRkHyHy3op13GbeVRwLwu6Bx1QUoyZc7CdHoFyYitBokZepnwmqDnh2VZHytMY1A48L
 8XFMwwO4oFiBLB6zT//f1sbPrEpW+09fhRKQthYOue/dMUREcouXFPOwgtjwCtEcP3Ua
 iCPocjWqhp8O7Svu2T78BGwI0BsG9FwsQRtP3/KeN8WWfXHxf/ElGAFLdaTPnyDZ5TaX
 6w394H6+M+KT6jjSBAd50NTxgAR/cXKVUWMQfW1HCtNlZKS32WJopyg0x5TNlnoFFXHJ
 NkPg==
X-Gm-Message-State: AOAM530nm0fOm8ElkHjVBBV7CIMDxHxjKwvFVPWduxGQ+jKp0Iz1fxC2
 KQe+8AMFKYygT7Ca1v3erwZo7UbqS70=
X-Google-Smtp-Source: ABdhPJygpLbegkaPy9815BMEfUzhQgusT0Rafu17TX/njn7ycaxjlVJlFXCdgBuSqjRo8HUqzFeWhQ==
X-Received: by 2002:a17:907:1c1f:: with SMTP id
 nc31mr1645165ejc.371.1631169392474; 
 Wed, 08 Sep 2021 23:36:32 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id p23sm454094edw.94.2021.09.08.23.36.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 23:36:32 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Keith Busch <kbusch@kernel.org>
Cc: Samuel Jones <sjones@kalrayinc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
Date: Thu, 9 Sep 2021 09:36:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_233634_406351_8E9C3194 
X-CRM114-Status: GOOD (  34.93  )
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



On 9/9/21 12:50 AM, Keith Busch wrote:
> On Wed, Sep 08, 2021 at 11:55:59PM +0300, Sagi Grimberg wrote:
>>
>>>>> 1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
>>>>> 2. Userspace context is descheduled.
>>>>> 3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
>>>>> 4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
>>>>> 5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.
>>>>>
>>>>> This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:
>>>>>
>>>>> 1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
>>>>> 2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
>>>>> 3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread
>>>>>
>>>>> Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?
>>>>
>>>> Sounds possible. The "pending" check on the req_list was to fix a race
>>>> condition where the io_work could miss handling a request, resulting in
>>>> a different command time out. It sounds like that could make the io_work
>>>> spin without having anything to do, while starving the lower priority
>>>> task. I'll try to think of another way to handle it.
>>>
>>> Instead of relying on io_work to determine if there's pending requests,
>>> the queuing action can try to re-schedule it only after the send_mutex
>>> is released, and I think that should address the issue you've described
>>> while still fixing the IO timeout the "pending" trick was addressing.
>>> Can you try the below patch?
>>>
>>> Sagi, does this look okay to you?
>>
>> It looks OK to me, but on the other hand the former
>> one looked perfectly fine to me.
> 
> It's a priority inversion. The .queue_rq() task is holding onto the
> 'req_list' resource via send_mutex, but it can't schedule in because
> io_work is higher priority and will remain in TASK_RUNNING while
> 'req_list' is non-empty.

Yes, I understand the issue.

> I think the user must have pinned the .queue_rq task to that specific
> CPU, otherwise I believe it would have scheduled somewhere else to
> unblock forward progress.

Yes, I agree.

>> Basically now the last request in the batch will not trigger
>> unconditionally (if the direct-send path was not taken), but only if it
>> sees queued requests, which in theory could be reaped by a running
>> io_work, that would result in an empty io_work invocation.  On one
>> hand it is undesired, on the other hand should be harmless as it
>> shouldn't miss an invocation... So it looks reasonable to me.
> 
> I can change the check to the same as .commit_rqs(), which just
> consideres 'llist_empty(&queue->req_list))'.
> 
> That should be just as safe and have fewer unnecessary io_work
> scheduling for the same reasoning commit_rqs() uses it. In any case, I
> don't think an occasional unneeded work check is really that harmful.

What we need to think about is if there is a case where we miss
scheduling the io_work

>> Sam, can you run some more extensive I/O testing with this (different
>> patterns of r/w and block sizes)? Also Keith, can you ask the WD folks
>> to also take it for a spin?
> 
> Sure, I'll request this patch for their next test cycle.

Great.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
