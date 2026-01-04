Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C73C2A069
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUgDKVPn+YFfGqwPp9REJ0w41hLQ/FYtGA0Uo1d7q08=; b=YdFYsBPDqBFJ4tcjwnFX4myGv/
	h7JDgmx8Old818o/BkeXcCNlH16DGV0WUGsTN0eQHoWKILagLh4N11r1Ip3T7nA3YcnvMvtZEbn9J
	nIEecQJjLThvTQaByM3sVYrV51bOYG9JLkr6hMvM724UWgyPfa5xKZKzrfmDcCcSVDnI5rjJ5QIWf
	pJcfF3K1k+paGFFdoaObAZeAZz91En56N0IZB476VMplKDyZWc+3woqjel9Nes6nw7w7cKIS9nDom
	rLMmIeAKwI6l22RDmNu56VjjAVhGSjwbu3t8St5pi3YbESGfNvDksOGACAaLDBzsuoWwek9QZOzRR
	hHSpvYAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVMQ-0000000ASBz-0QEG;
	Sun, 04 Jan 2026 21:10:02 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVMM-0000000ASBG-0YAE
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:10:00 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47a8195e515so80927265e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767560996; x=1768165796;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUgDKVPn+YFfGqwPp9REJ0w41hLQ/FYtGA0Uo1d7q08=;
        b=kIAQIBOIr3qoT1Xr+4SItj949Q0ktYHvtKuy41lU06bByKWWAALI8Q6I2SlZ/LfEMG
         QBylyW+kBxkEeq8DtlTcmtm3SqaoivCcl39vfQbJOHcyGhyqDFfqg3iS1ormi5kH5TNV
         9mB6zDTLHBxZPeX9Xu8QnN18LH+VY1YqYypaXfj+WeUlEJSbusF5Geb9JJ+nUf6d75ZJ
         +DGIQ8okW4M5kvHo/S0DmMmNs271e7f2NU0xbWNbvx1dUK7vpuAwGZS3W2Ufxxj0rrcm
         R3oTFG1QjoWZxERQZxEOppMyUQEyt+BIiyv/CTf2a2AKli6+w8qRWaiO98vY60upLKfD
         S6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWEAAI5To82XiGkDtO6RgZKoUzHxU4HoK0YLcFJsCdwRx/N9rxwyEUT4dfBJdI44TXUuokUBRm+sAZ3@lists.infradead.org
X-Gm-Message-State: AOJu0YwKdcfwaZ4EZbhcCyvid+0cQlYaXriM+wy4SAErkB7kpA767ZKY
	Cp20GrIJV4kMH45wqWtZ80N+z3qMxBaBMfXo+pbf5u6Gn/692ZaTzRWY
X-Gm-Gg: AY/fxX7vdq5Jnd7yjfhY+NBfvyXZonoPti0Gu7v9YBfoNSlScL8IMBIpUYOflfdJ5kn
	RJut0tQNud8BUOY6jUppqN2jTxJHTaSI8GP8X0I9/saiW+vYuyJnm3Hu+4CKoH5VRGWcSECxhmc
	ygGYb4i0ZYDdhj0f4T4cvOFQamdVZBE6wQBNknbckTaJs5EfgM7SbnZTrqY0sv33E1dHPVyGO2W
	f4Uf7BFD9bLzEFJHugEzvidI1uc81PUVufI3DiGOEbURfzFSMYclJEL7xeqyxUJxVyToRaW6Tia
	/9uSBJGmn7Xq4tPlz8+Q+F8SofzGLJPcyQG6eSu9y/7f8138EX0JTtypy0BRc3WIO8a+lkdYJSW
	lgQ9LRNqwsMlMflamyS6NPZEmlWh5c90nxuwNvpBONgKFC1nFh9BosTN1aeNJnSn78yz/axVefN
	6/K4guM+GSwfi2IwAWlVP/BtyLsCk/5yCg/JJDLeu5G+cXtM/2hna0Og==
X-Google-Smtp-Source: AGHT+IGjID8fAKga5il/Yl7B7CoAOZ6yJVG/Qfc3GXXDnwzUeo/ITanKO04dMMfnT/W7Wm9LNQek5g==
X-Received: by 2002:a05:600c:4f42:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d19556d02mr672588075e9.14.1767560996239;
        Sun, 04 Jan 2026 13:09:56 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed3fsm108966195e9.1.2026.01.04.13.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:09:55 -0800 (PST)
Message-ID: <06f365d8-9861-4c22-a226-06c8c3b2cc5e@grimberg.me>
Date: Sun, 4 Jan 2026 23:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com>
 <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
 <20251225181313.GC8129-mkhalfella@purestorage.com>
 <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
 <20251231220020.GK3864520-mkhalfella@purestorage.com>
Content-Language: en-US
In-Reply-To: <20251231220020.GK3864520-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_130958_201751_A3DEA451 
X-CRM114-Status: GOOD (  35.73  )
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



On 01/01/2026 0:00, Mohamed Khalfella wrote:
> On Sat 2025-12-27 11:48:49 +0200, Sagi Grimberg wrote:
>> On 25/12/2025 20:13, Mohamed Khalfella wrote:
>>> On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
>>>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
>>>>> Send an AEN to initiator when impacted controller exists. The
>>>>> notification points to CCR log page that initiator can read to check
>>>>> which CCR operation completed.
>>>>>
>>>>> Signed-off-by: Mohamed Khalfella<mkhalfella@purestorage.com>
>>>>> ---
>>>>>     drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
>>>>>     drivers/nvme/target/nvmet.h |  3 ++-
>>>>>     include/linux/nvme.h        |  3 +++
>>>>>     3 files changed, 28 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>>>>> index 7dbe9255ff42..60173833c3eb 100644
>>>>> --- a/drivers/nvme/target/core.c
>>>>> +++ b/drivers/nvme/target/core.c
>>>>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
>>>>>     	nvmet_async_events_process(ctrl);
>>>>>     }
>>>>>     
>>>>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
>>>>>     		u8 event_info, u8 log_page)
>>>>>     {
>>>>>     	struct nvmet_async_event *aen;
>>>>> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>>>     	aen->event_info = event_info;
>>>>>     	aen->log_page = log_page;
>>>>>     
>>>>> -	mutex_lock(&ctrl->lock);
>>>>>     	list_add_tail(&aen->entry, &ctrl->async_events);
>>>>> -	mutex_unlock(&ctrl->lock);
>>>>>     
>>>>>     	queue_work(nvmet_wq, &ctrl->async_event_work);
>>>>>     }
>>>>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>>>> +		u8 event_info, u8 log_page)
>>>>> +{
>>>>> +	mutex_lock(&ctrl->lock);
>>>>> +	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
>>>>> +	mutex_unlock(&ctrl->lock);
>>>>> +}
>>>>>     
>>>>>     static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
>>>>>     {
>>>>> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
>>>>>     
>>>>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
>>>>> +{
>>>>> +	lockdep_assert_held(&ctrl->lock);
>>>>> +
>>>>> +	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
>>>>> +		return;
>>>>> +
>>>>> +	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
>>>>> +				     NVME_AER_NOTICE_CCR_COMPLETED,
>>>>> +				     NVME_LOG_CCR);
>>>>> +}
>>>>> +
>>>>>     static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>>>>>     {
>>>>>     	struct nvmet_subsys *subsys = ctrl->subsys;
>>>>> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
>>>>>     	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
>>>>>     		mutex_lock(&sctrl->lock);
>>>>>     		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
>>>>> -			if (ccr->ctrl == ctrl)
>>>>> +			if (ccr->ctrl == ctrl) {
>>>>> +				nvmet_ctrl_notify_ccr(sctrl);
>>>>>     				ccr->ctrl = NULL;
>>>>> +			}
>>>> Is this double loop necessary? Would you have more than one controller
>>>> cross resetting the same
>>> As it is implemented now CCRs are linked to sctrl. This decision can be
>>> revisited if found suboptimal. At some point I had CCRs linked to
>>> ctrl->subsys but that led to lock ordering issues. Double loop is
>>> necessary to find all CCRs in all controllers and mark them done.
>>> Yes, it is possible to have more than one sctrl resetting the same
>>> ictrl.
>> I'm more interested in simplifying.
>>
>>>> controller? Won't it be better to install a callback+opaque that the
>>>> controller removal will call?
>>> Can you elaborate more on that? Better in what terms?
>>>
>>> nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() when
>>> we know that ctrl->ref is zero and no new CCRs will be added to this
>>> controller because nvmet_ctrl_find_get_ccr() will not be able to get it.
>> In nvmet, the controller is serving a single host. Hence I am not sure I
>> understand how multiple source controllers will try to reset the impacted
>> controller. So, if there is a 1-1 relationship between source and impacted
>> controller, I'd perhaps suggest to simplify and install on the impacted
>> controller
>> callback+opaque (e.g. void *data) instead of having it iterate and then
>> actually send
>> the AEN from the impacted controller.
> A controller is serving a single path for a given host. A host that is
> connected to nvme subsystem via multiple paths will have more than one
> controller. I can think of two reasons why we need to support resetting
> an impacted controller from multiple source controllers.
>
> - It is possible for multiple paths to go down at the same time. The
>    first source controller we use for CCR, even though we check to see if
>    LIVE, might have lost connection to subsystem. It is a matter of time
>    for it to see keepalive timeout and fail too. If CCR fails using this
>    controller we should not give up. We need to try other paths.

But the host is doing the cross-reset synchronously... it waits for
kato for a completion of the reset, and then gives up, its not like it
is sitting there waiting for the AEN...

Generally the fact that the spec states a capability/flexibility, it is 
still Linux's
choice to choose weather to implement it. I'm trying to understand if we can
simplify Linux host and controller in this non-trivial error recovery flow.

What is your expectation to happen in general? what are your expected 
kato/cqt
values? how many attempts do we want the host to do?

> - Some nvme subsystems might support resetting impacted controller from
>    a subset of controllers connected to the host. An array that has
>    multiple frontend engines might not support resetting controllers
>    across engines. In fact, TP8028 allows for subsystem to suggest to
>    host to use another source controller in Alternate Controller ID
>    (ACID) fied on CCR logpage (not implemente in this patchset).

It is not a case though where the impacted controller will be reset from 
multiple
source controller at the same time...

I'd also say that if indeed there are subsystems that require specific 
controllers to do
cross recovery, they won't be able to use this at all... Are there any 
such arrays?

