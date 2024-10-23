Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F14BCDDE61
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qyoSN8NWyZbqeYGJwRTAb0I5uCs95hTQl+3aYxOXG24=; b=P1y6zmQONWLaQ1A761c2K7DCNr
	HLZUkFdK7WjX44+8C+q9tYp7zUN5iYPNKfw9xM3tFg9IWwJrfGs+ysP+HGtt9zGjxhYEDvdD5cNJu
	ti0koZXbJpzgM/VmojCs9moTGoUUlCz8H0o04PUxH1hDGWjeuAv2y4/hYPFIXvmt/GYCBCKGM4s3y
	b1YJ7vHE9DXboTkERiEtuIFtlD76meH/xSgL9eWaYTyK1M9kEIQyr8u621wFFC/k/n0vay0WTTCKw
	YYhfPRRcc29+au2KurHciGFcsAShCjXZMioM6bM54NN/F5Jo0BQaS0rlFME9noBu2kW0vq7foqwAI
	npez1FOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YA6-0000000Dtxg-0nYj;
	Wed, 23 Oct 2024 10:00:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xqq-0000000DpnS-14VF
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Oct 2024 09:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qyoSN8NWyZbqeYGJwRTAb0I5uCs95hTQl+3aYxOXG24=; b=X4gNh76WqJUQxoyw8g7Ck2X842
	0L2+45QzDsgC3eZcXoFWiAhaY2ahf5aH+zznmmMaEDhnBXdZDJtsvcJ0LoUe06EulooRfG6CgsV75
	zSCcpuxU2RO6wWmMLYdzOwIRjTh7HoqfgP5i1ZlMgugBz4ImBI3QBwsmjjHsbq1T1g8pPd6waJBt9
	8OqeQ1c3TlBbLf97yBEpdi0d7OPynKOcrsTMlnKFq4P+YDbdgvcHRgAbDZH7yIfX3NySwshBAgoZL
	kYrRLNkGCKuLg5bxR0nycCw3RCtfpNq5EH7KXaQ2Xwk5fkwsyLh1R8Y8OWAq88ryu4M5F51LEzSjn
	nT4qpw1Q==;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xqm-00000008MyY-2ldJ
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:40:22 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a4031f69fso950837566b.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 02:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676418; x=1730281218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyoSN8NWyZbqeYGJwRTAb0I5uCs95hTQl+3aYxOXG24=;
        b=DAx6wm8OVsHoszg2FG3iKtKZu17SHJ3BHH4kkx/XggOwckyG4RAkqbUYDWiV5aRlV2
         QI+Mnfh6FU9IdxxkD10Iu9RcqCcPaSPILIPLkG9L7HS7RPFAelR+MQXehM/xujR7Zi2y
         iIuQFimNVqgRx+DmMcwDo1OGVHHymITy5WsZi2nZUgHPPDqVJfUCGCF4ePDlsv/DMOXF
         EFSFlxMtFqKxXBfLY7dMHboDJtJZgLQw2WtTAR07QWWkbh36uxDMWUTOe9r7lZpdW8+x
         IQsYFHTWRN1Wj7/Ss62/x8/gU/2/bGPdoZuXk7ckTuVfrD3loH4COPGTHqfxOC4rM7hB
         L1fA==
X-Forwarded-Encrypted: i=1; AJvYcCUlkwsK4+9L6m3J1lNQB6W3wKPQa74gPeD48JpFORI8S9lHsfHVCDTp8H6WreMb3znP9oFkUvoW15CK@lists.infradead.org
X-Gm-Message-State: AOJu0Yww+CfCoK4rbYH2Xo7amPb0cXoYSOLIRwTtec8cUeIn0rXXq3ci
	smQsHT4NOVYfM2wBrZrKAemfHWFw2U2XVP7kQKO65lF5Ou82YE4d
X-Google-Smtp-Source: AGHT+IENQKt7x+YpezbdSdRYvoUEz0jCySIkIrUVc7wYLY6NT/Dqj+wiaeUt6+J1L04rDnmwJ9YTMw==
X-Received: by 2002:a17:907:a41:b0:a99:fc9a:5363 with SMTP id a640c23a62f3a-a9abf84ad3cmr173141966b.9.1729676417342;
        Wed, 23 Oct 2024 02:40:17 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee061sm449765966b.63.2024.10.23.02.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:40:16 -0700 (PDT)
Message-ID: <196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me>
Date: Wed, 23 Oct 2024 12:40:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-3-nilay@linux.ibm.com>
 <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
 <bd0bfd18-b5bf-485a-9891-20974557d740@linux.ibm.com>
 <f8b03260-9792-4612-aebd-52db4458b949@grimberg.me>
 <b03863b2-8816-48cd-aa18-436f1c49ec8c@linux.ibm.com>
 <cf53da15-ed73-4aa9-9f0a-46202529f0a7@grimberg.me>
 <f584d0da-7329-41e0-9976-b76f244e47fd@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f584d0da-7329-41e0-9976-b76f244e47fd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_104020_869675_13F4AB3C 
X-CRM114-Status: GOOD (  55.15  )
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




On 22/10/2024 16:28, Nilay Shroff wrote:
>
> On 10/22/24 15:13, Sagi Grimberg wrote:
>>
>>
>> On 22/10/2024 9:54, Nilay Shroff wrote:
>>> On 10/21/24 20:44, Sagi Grimberg wrote:
>>>>
>>>> On 21/10/2024 14:58, Nilay Shroff wrote:
>>>>> On 10/21/24 03:19, Sagi Grimberg wrote:
>>>>>> Hey Nilay,
>>>>>>
>>>>>> First, can you please phrase the patch title to describe what it
>>>>>> is addressing, not what it is changing, that can come (as it does)
>>>>>> in the body.
>>>>>>
>>>>> sure, how about naming it as "nvme-fabrics: fix kernel crash while shutting down controller" ?
>>>>>
>>>>>> Second, I don't think we want to spend a thread waiting for
>>>>>> synchronous IO for the purpose of keep alive. Is this the only
>>>>>> way that this can be done?
>>>>>>
>>>>>> Third, was this observed with non-loop transports?
>>>>>>
>>>>> Yes it could happen even with non-loop fabric transports.
>>>>>
>>>>>> On 16/10/2024 6:03, Nilay Shroff wrote:
>>>>>>> The nvme keep-alive operation, which executes at a periodic interval,
>>>>>>> could potentially sneak in while shutting down a fabric controller.
>>>>>>> This may lead to a race between the fabric controller admin queue
>>>>>>> destroy code path (invoked while shutting down controller) and hw/hctx
>>>>>>> queue dispatcher called from the nvme keep-alive async request queuing
>>>>>>> operation. This race could lead to the kernel crash shown below:
>>>>>> What is different about keep-alive than any other command?
>>>>> The one difference is, of course, keep-alive is async but we may have
>>>>> other async requests running while shutting down the controller. I found
>>>>> that, when compared the keep-alive with other commands, the keep-alive
>>>>> runs in the worker thread context but other commands (for instance async
>>>>> read/write) runs in the user context and that uses the blk plugging. When we
>>>>> use plugging, the call path for issuing request to driver is quite different
>>>>> from that of issuing request using blk_execute_rq_nowait(). This subtle
>>>>> difference is probably the reason not causing the kernel crash issuing
>>>>> read/write command while shutting down the fabric controller.
>>>>>
>>>>> The call path for blk plugging for issuing the request to driver:
>>>>> __blk_flush_plug()
>>>>>      -> blk_mq_flush_plug_list()
>>>>>        ->blk_mq_dispatch_plug_list()
>>>>>
>>>>> The blk_mq_dispatch_plug_list() first increments ->q_usage_counter before
>>>>> dispatching requests. Basically here the queue dispatcher (blk_mq_run_hw_queue
>>>>> function) is protected from the queue being destroyed on other cpu thread.
>>>>> So that means that even after a request (assuming the only request in queue)
>>>>> is cancelled or flushed off due to fabric controller is shutting down, the
>>>>> blk-mq destroy code path would not be able to forward progress until the
>>>>> ->q_usage_counter is decremented and becomes zero. And we can see in
>>>>> blk_mq_dispatch_plug_list() that it decrements ->q_usage_counter only after
>>>>> the blk_mq_run_hw_queue function returns.
>>>> Sounds like an issue that is not related to keep-alive at all.
>>>>
>>>>>>> Call Trace:
>>>>>>>         autoremove_wake_function+0x0/0xbc (unreliable)
>>>>>>>         __blk_mq_sched_dispatch_requests+0x114/0x24c
>>>>>>>         blk_mq_sched_dispatch_requests+0x44/0x84
>>>>>>>         blk_mq_run_hw_queue+0x140/0x220
>>>>>>>         nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>>>>>>         process_one_work+0x200/0x4e0
>>>>>>>         worker_thread+0x340/0x504
>>>>>>>         kthread+0x138/0x140
>>>>>>>         start_kernel_thread+0x14/0x18
>>>>>> What is the "crash" here? use-after-free?
>>>>> yes it's use-after-free kernel crash.
>>>>>>> While shutting down fabric controller, if nvme keep-alive request sneaks
>>>>>>> in then it would be flushed off. The nvme_keep_alive_end_io function is
>>>>>>> then invoked to handle the end of the keep-alive operation which
>>>>>>> decrements the admin->q_usage_counter and assuming this is the last/only
>>>>>>> request in the admin queue then the admin->q_usage_counter becomes zero.
>>>>>>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
>>>>>>> queue()) which could be potentially running simultaneously on another
>>>>>>> cpu (as this is the controller shutdown code path) would forward
>>>>>>> progress and deletes the admin queue. So, now from this point onward
>>>>>>> we are not supposed to access the admin queue resources. However the
>>>>>>> issue here's that the nvme keep-alive thread running hw/hctx queue
>>>>>>> dispatch operation hasn't yet finished its work and so it could still
>>>>>>> potentially access the admin queue resource while the admin queue had
>>>>>>> been already deleted and that causes the above crash.
>>>>>> Again, it is unclear to me what justifies the cure here. Every command can
>>>>>> race with the shutdown, and it can be sync or async.
>>>>>>
>>>>> While I was researching on this issue, I figured that the nvme keep-alive is
>>>>> probably the only async request running in worker thread context and not well
>>>>> synchronized with the fabric controller shutdown code path. Yes we may have other
>>>>> async request (for instance async read/write) which might get-in the way of the
>>>>> fabric controller shutdown code path but those mostly run in the user context and
>>>>> hence have a different code path than keep-alive command for submitting/queuing
>>>>> the request.
>>>> This sounds like we papered around the problem. is it not allowed to call blk_execute_rq_nowait
>>>> from a kthread?
>>> I didn't meant calling blk_execute_rq_nowait is not allowed from kthread. It's allowed
>>> but the side effect it causes is what I just wanted to highlight.
>> The point is that any kthread using it would potentially trigger this bug. Hence we should
>> treat the disease and not the symptom.
>>
>>>>>>> This fix helps avoid the observed crash by implementing keep-alive as a
>>>>>>> synchronous operation so that we decrement admin->q_usage_counter only
>>>>>>> after keep-alive command finished its execution and returns the command
>>>>>>> status back up to its caller (blk_execute_rq()). This would ensure that
>>>>>>> fabric shutdown code path doesn't destroy the fabric admin queue until
>>>>>>> keep-alive request finished execution and also keep-alive thread is not
>>>>>>> running hw/hctx queue dispatch operation.
>>>>>> I'd want to see exactly what is causing this race because we already flush
>>>>>> the keep alive work when starting the shutdown... so it only means it is
>>>>>> incorrectly firing again?
>>>>>>
>>>>>> What I think we should do instead, is given that we already cancel_sync the keep
>>>>>> alive work before making progress with the teardown, we should just make sure
>>>>>> that it doesn't triggered afterwards again if it does.
>>>>> No, keep-alive doesn't incorrectly fired, however once a keep-alive request is
>>>>> allocated but before it's queued,
>>>> The queue teardown quiesce the admin queue first, which should prevent the dispatch.
>>>> You probably mean that it runs a little later, after the dispatch passes the quiesced test...
>>>>
>>>> The question is, why did blk_mq_quiesce_queue did not wait for rcu grace? which should
>>>> have ensured that there is no dispatch going on? at least that is what it's supposed to do...
>>>> something doesn't add up
>>>>
>>> This issue manifests when the keep-alive command sneaks in after the admin queue is
>>> unquiesced but before its freezed.
>>>
>>> nvme_unquiesce_admin_queue() <<< we unquiesce admin queue
>>>
>>> <<< here keep-alive sneaks in and it starts running dispatcher
>>>
>>> nvme_remove_admin_tag_set()  <<< we freeze queue and wait for ->q_usage_counter to become zero
>>>
>>> So as mentioned above, we have time window between queue unquiesce and freeze
>>> operations where async keep-alive could potentially sneaks in and causing the
>>> observed symptom.
>> The problem here is that keep-alive should not be able to sneak in after we unquiescence
>> the admin queue.
>>
>> What I'm seeing in the code is that the teardown flow does not call nvme_stop_keep_alive()
>> in the teardown path.
>>
>> This seems to be caused by [1], so it makes sense that we can even trigger this race.
>> If nvme_stop_keep_alive would have been called from nvme_stop_ctrl() which is called
>> way before we quiesce/unquiesce the queue, then this issue would not have been encountered.
>>
>> I think we could make an argument that both call-sites to nvme_stop_keep_alive() should co-exist
>> with a little documentation to why.
>> Can you try and reproduce with [2]?
>>
>>
>> [1]:
>> -- 
>> commit a54a93d0e3599b05856971734e15418ac551a14c
>> Author: Ming Lei <ming.lei@redhat.com>
>> Date:   Tue Aug 13 09:35:27 2024 +0800
>>
>>      nvme: move stopping keep-alive into nvme_uninit_ctrl()
>>
>>      Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
>>      moves starting keep-alive from nvme_start_ctrl() into
>>      nvme_init_ctrl_finish(), but don't move stopping keep-alive into
>>      nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
>>      after failing to start controller, finally use-after-free is triggered if
>>      nvme host driver is unloaded.
>>
>>      This patch fixes kernel panic when running nvme/004 in case that connection
>>      failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().
>>
>>      This way is reasonable because keep-alive is now started in
>>      nvme_init_ctrl_finish().
>>
>>      Fixes: 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
>>      Cc: Hannes Reinecke <hare@suse.de>
>>      Cc: Mark O'Donovan <shiftee@posteo.net>
>>      Reported-by: Changhui Zhong <czhong@redhat.com>
>>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>>      Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>      Reviewed-by: Hannes Reinecke <hare@suse.de>
>>      Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>      Signed-off-by: Keith Busch <kbusch@kernel.org>
>> -- 
>>
>> This patch was introduced as a fix for:
>> 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
>>
>> [2]:
>> -- 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0dc8bcc664f2..275af23dda6d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4612,6 +4612,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>   {
>>          nvme_mpath_stop(ctrl);
>>          nvme_auth_stop(ctrl);
>> +       /*
>> +        * the transport driver may be terminating the admin tagset a little
>> +        * later on, so we cannot have the keep-alive work running
>> +        */
>> +       nvme_stop_keep_alive(ctrl);
>>          nvme_stop_failfast_work(ctrl);
>>          flush_work(&ctrl->async_event_work);
>>          cancel_work_sync(&ctrl->fw_act_work);
>> -- 
>>
> I tried the above patch[2] and ran nvme/037 in a loop for quite a long time and
> confirmed that with this change I don't see the kernel crash. So I think we shall
> restore the above change.

Yes, and we need a "Fixes:" tag because it solves a regression caused by [1]

>
> Also please note that the earlier changes where we made keep-alive synchronous
> operation has been already merged to the mainline/Linus' kernel tree. So should we
> create a new patch reverting the changes merged in commit d06923670b5a ("nvme:
> make keep-alive synchronous operation") and then on top of it add the above
> patch[2]?

Yes, one revert patch and one patch for [2]

>
> Moreover, I would adjust the new patch so that we can keep this change 599d9f3a10ee
> ("nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function"). I think
> changes implemented in commit 599d9f3a10ee is a logical step forward to avoid using
> ctrl->lock and instead use helper nvme_ctrl_state for retrieving the controller state.

That is fine to keep.

