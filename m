Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A6CC05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lm7BcYZX1ERtq+6ocv5m8y7RS6XM7FAO9EfAjhWsRak=; b=tulgdM9ZJnIns3Ld0VAcDRMYHt
	ydQo+gjVILPKdeCtdjyPSyaQdVliqu5xOte3l9ZFfXq6hIM2R8uavBtqQDN3rArP5DnfgPMuE78D5
	+AYnYwSjy0g6eEXrDkrAz4eBqlUX22JbFP8kqKeR2C9cdewh2an0D05vfjiO1WHnnxoRtUEuTOMge
	YrDebkLNt0rZJlEgA86+SjGDLtnOA1Ohf7jLOxyMzx13c1OkoWstboD1TkWQzkWuKKT2JhMzDOvdb
	n3+5cVsTsMPtVlcZjY3AQwFQDfoREEvC9Z2bJ3b0IogJHJgzV7+2AFdvNs2hvwylULRxhCUFFLO/5
	dag64Iiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrmb-000kgY-6G; Tue, 14 Feb 2023 09:39:29 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrmW-000keY-IM
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 09:39:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id m14so14937071wrg.13
        for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 01:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm7BcYZX1ERtq+6ocv5m8y7RS6XM7FAO9EfAjhWsRak=;
        b=7Rqll/6aE+DlO3kBUw91JEoJ7EMPXW3hINy3cOw9ZB+xwu6XlpSnDGJkpSL13X2FvI
         y3NtNBDLFrqGObxzbMhNUHm7QfivxHGlHq+XpcHVOvf96KJzIWoDCX4VZ4CWZvPbeu90
         /93fZLPUk8/2fNTU7lyspqE3fnqHXjE4SPxG4ofqqhlCHHaeJB9g+trfmjYveulgQ77O
         HDD5gMnIgJh3ExP+HLFc6ZEEhcTo8yiAhMC5FKOLK9Clw0xDXjgYcUuSV9FyKB1hKUb9
         8ox0sazVhoRi+7i0TcoFKEKUK/5IAtVCope7xoaHvkR4EfQEs+n8qVHa6vofB3OJkREp
         d+oQ==
X-Gm-Message-State: AO0yUKVMrsryN81jJP9fFyM9ECLP3p3Rt3oj5/wV075h9VuP4rkmCym9
	SYRtmd3dRwy7DfGByqT7nXkBACohf54=
X-Google-Smtp-Source: AK7set9wTKtL9Z8RYZAkk8a9nQ+nXfZn+wkk35vJGMV7+WttngbpAnMg5ptntVNz9vvQ/1p0o492gQ==
X-Received: by 2002:a5d:5951:0:b0:2c3:e666:6d18 with SMTP id e17-20020a5d5951000000b002c3e6666d18mr1328428wri.6.1676367561610;
        Tue, 14 Feb 2023 01:39:21 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b002c54c9bd71fsm9374707wrc.93.2023.02.14.01.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:39:21 -0800 (PST)
Message-ID: <e98280fb-b295-037d-c693-de58d1d7b960@grimberg.me>
Date: Tue, 14 Feb 2023 11:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] nvme: retry authentication commands if DNR status bit
 is not set
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "George, Martin" <Martin.George@netapp.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-6-hare@suse.de>
 <43e6c4b4-cb58-0873-2d0e-48499fcc1e31@grimberg.me>
 <42618eea-5a4a-f0cf-9e6d-e1ae36357847@suse.de>
 <7126416a-0839-4b47-0aad-1ac1a1875681@grimberg.me>
 <504fe9d1-befc-868e-9e5f-8471bec81902@suse.de>
 <3ba9e61a-d73d-508c-734a-dd1c0707588e@grimberg.me>
 <52c8330d-2cd1-73fa-e360-0c7b233dec93@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <52c8330d-2cd1-73fa-e360-0c7b233dec93@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_013924_651712_21AAA007 
X-CRM114-Status: GOOD (  30.52  )
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


>>>>>>> Clear the FAILFAST_DRIVER bit for authentication commands
>>>>>>> allowing them to be retried in nvme_decide_disposition() if the DNR
>>>>>>> bit is not set in the command result.
>>>>>>
>>>>>> Can you please explain what is this fixing? and is there a test
>>>>>> to reproduce this?
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>>>> ---
>>>>>>>   drivers/nvme/host/auth.c | 2 ++
>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>>>>> index ef5dcd885b0c..935f340607a7 100644
>>>>>>> --- a/drivers/nvme/host/auth.c
>>>>>>> +++ b/drivers/nvme/host/auth.c
>>>>>>> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl 
>>>>>>> *ctrl, int qid,
>>>>>>>               "qid %d auth_submit failed to map, error %d\n",
>>>>>>>               qid, ret);
>>>>>>>       } else {
>>>>>>> +        /* Clear failfast flag to allow for retries */
>>>>>>> +        req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
>>>>>>
>>>>>> This should come right after the allocation.
>>>>>> But what makes this special than any other fabrics/admin command?
>>>>>> Why is it different than connect for example?
>>>>>
>>>>> It is not different; it does, however, introduce a difference in 
>>>>> behaviour.
>>>>> And hence I didn't enable it for all commands, as previously we 
>>>>> didn't retry, and it's questionable if we should for things like 
>>>>> 'reg_read'/'reg_write' and friends.
>>>>>
>>>>> But you are correct for connect, though; we really should retry 
>>>>> that one, too, if the DNR bit is not set.
>>>>
>>>> I'm not sure. if the transport is unavailable, we cannot set DNR, which
>>>> will lead to a retry of the connect (or equivalent) command. Today the
>>>> host will schedule another full controller connect within
>>>> reconnect_delay, which is what we want right?
>>>
>>> I knew this would be coming up, which is why I left it out of the 
>>> initial patchset.
>>>
>>> Long explanation:
>>>
>>> Thing is, connect handling is not _just_ connect handling.
>>> With linux we only have a single (ioctl-like) entry for the userspace 
>>> 'nvme connect' call.
>>>
>>> That really does several things:
>>> - Setting up the transport
>>> - Create the transport association for the admin q
>>> - Create the admin q
>>> - send 'connect' over that queue
>>> - Create transport associations for the i/o qs
>>> - create i/o qs
>>> - send 'connect' over those queues
>>>
>>> And my point here is that the actual 'connect' commands really are 
>>> straight NVMe commands. And as such should be subjected to the normal 
>>> status evaluation rules for NVMe commands.
>>> The problem here is the strange 'half-breed' nature of the connect 
>>> command:
>>>
>>> _Technically_ the association and the 'connect' command are 
>>> independent, and as such we would be entirely within spec to allow 
>>> the 'connect'
>>> command to fail without having the association torn down. But due to
>>> our implementation that would leave us unable to re-use the association
>>> for further connect commands, as that would need to be triggered by
>>> userspace (which will always create a new association).
>>>
>>> Consequently I would advocate for having any non-retryable failure of 
>>> the 'connect' command to always tear down the association, too.
>>>
>>> That would be a deviation from our normal rules (where we always retry
>>> transport failures), but really is something we need to do if we 
>>> enable DNR evaluation for the 'connect' command.
>>
>> How the host handles connect or any other request failing is entirely
>> the host choice.
>>
>> In this patch, you decided to effectively to retry for transport errors,
>> which will effectively retry nvme_max_retries times. Can you please help
>> me understand what is the patch actually solving? I'm assuming that this
>> is an actual completion that you see from the controller, my second
>> question is what happens with this patch when the transport is the
>> source of the completion?
>>
> Hmm. All what this patch does is to enable retries by modifying the flow 
> in nvme_decide_disposition().
> And nvme_decide_disposition() only deals with NVMe errors; if
> nvme_req(req)->status would be an error number we'd be in much worse 
> problems than just retries.

Hannes, can you please describe the flow that went wrong here and
you attempted to fix?

My assumption is that the host got a non-zero nvme status with DNR
cleared. Is that correct? This is not described in the commit msg, hence
me asking.

> So where do you see the transport errors being retried?

Effectively, all transport errors do not set the DNR bit, and will
be retried within crdt, until nvme_max_retries is reached. My question
is weather this affects the reconnect flow given that we go and
cancel all inflight requests (NVME_SC_HOST_ABORTED_CMD).
Does this mean that if now the auth is inflight, it will retry?
causing the teardown to block?

Same question applies to other driver requests that you say that
should comply to the DNR bit.

> And I need to retry as some controller implementations temporarily 
> return the authentication commands with the 'DNR' bit set, presumeably 
> to initialize the authentication subsystem.

That is unrelated to this patch set though.

