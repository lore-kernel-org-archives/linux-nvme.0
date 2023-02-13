Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A91C6379F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9299vnkMkb34Iu4ht0i0Ni1by6fFHgPX565ZljBH4cE=; b=2ubG5tFd660zmzsA0FBlxmLqkR
	rnhfzJLNCfPXVdP8uaH8DSIMRz/V2T+iD1UkTDgthOwEVRLuyNXhSoJx3e5Vhf+1g4DOs70+4CW6B
	1SBwbeW5Ll+sLhJfT2bUJvYqtd5nTAskl3Un7BtYg+NrwCbDZdqpgkkUn4Z2UQLJe5cH34uKjG8at
	HPQo+Nf31YhWgWZgh/7+basKXKxdNfP+c3bf5T9Zoez17w+rm1TRbknz+o5zanXpsVf/qw51VjSUg
	5jw0RW5z8Qgv74TtnvOgFq5REaDicRAq3PVq5Hlz9CAvgUibNkIlHPR5q9hCS1GXKSURyMTC9668p
	yAMDAmJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZAm-00ErQQ-Ih; Mon, 13 Feb 2023 13:47:12 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZAj-00ErPc-Lp
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 13:47:11 +0000
Received: by mail-wm1-f45.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so11311374wmb.4
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 05:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9299vnkMkb34Iu4ht0i0Ni1by6fFHgPX565ZljBH4cE=;
        b=zX8zzunqCB04i4PQ1uCNiA0wZM3zTNWGhPj1/OiaslIj+74aR4kzyeEgB00KC08vdK
         ZXJv+XvdiZmO4IBzsMXlI1NyrBLNrlecEFYAAFHxQDpFVr8SR5J+Jqn5Xz9HKAbuCdm7
         2w/bg8r5fTdqzwfmiOdyldPZ7Dm/+qz+tptj/G0/1xzWcxUU1QBKuHiRP40ZRjIctlGQ
         72uOW+HGlki1yHY+2mGuSDgVsr1E4DyDlRVKT/KpSTGCz0XREaljpC12swRypMvTgevH
         j3w8ULfWmTKNgxbrEuDyUIrW965PxcHDMg3AELGpQhry9/rB+Rvh2+Ga5qrogdKjvjro
         1iEA==
X-Gm-Message-State: AO0yUKVyB/YKhAn1i/DicFVSVP5800Diwpft5ckYNFXKF5QU1jyrAPxd
	GAoHAvVgLQCR7DLyt5efKWs=
X-Google-Smtp-Source: AK7set94CSiPwACcj6P9+iO2mNjF+vOymjhgSxKOrpoNkV1ev5Ibqn7JoapbjVA9P+KKZGlrvQFLxQ==
X-Received: by 2002:a05:600c:4f8e:b0:3dc:5032:2895 with SMTP id n14-20020a05600c4f8e00b003dc50322895mr23353342wmq.0.1676296027804;
        Mon, 13 Feb 2023 05:47:07 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003e00c9888besm17040644wmj.30.2023.02.13.05.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:47:07 -0800 (PST)
Message-ID: <3ba9e61a-d73d-508c-734a-dd1c0707588e@grimberg.me>
Date: Mon, 13 Feb 2023 15:47:06 +0200
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <504fe9d1-befc-868e-9e5f-8471bec81902@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_054709_739466_969C0E18 
X-CRM114-Status: GOOD (  30.20  )
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


>>>>> Clear the FAILFAST_DRIVER bit for authentication commands
>>>>> allowing them to be retried in nvme_decide_disposition() if the DNR
>>>>> bit is not set in the command result.
>>>>
>>>> Can you please explain what is this fixing? and is there a test
>>>> to reproduce this?
>>>>
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>>> ---
>>>>>   drivers/nvme/host/auth.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>>>>> index ef5dcd885b0c..935f340607a7 100644
>>>>> --- a/drivers/nvme/host/auth.c
>>>>> +++ b/drivers/nvme/host/auth.c
>>>>> @@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl 
>>>>> *ctrl, int qid,
>>>>>               "qid %d auth_submit failed to map, error %d\n",
>>>>>               qid, ret);
>>>>>       } else {
>>>>> +        /* Clear failfast flag to allow for retries */
>>>>> +        req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
>>>>
>>>> This should come right after the allocation.
>>>> But what makes this special than any other fabrics/admin command?
>>>> Why is it different than connect for example?
>>>
>>> It is not different; it does, however, introduce a difference in 
>>> behaviour.
>>> And hence I didn't enable it for all commands, as previously we 
>>> didn't retry, and it's questionable if we should for things like 
>>> 'reg_read'/'reg_write' and friends.
>>>
>>> But you are correct for connect, though; we really should retry that 
>>> one, too, if the DNR bit is not set.
>>
>> I'm not sure. if the transport is unavailable, we cannot set DNR, which
>> will lead to a retry of the connect (or equivalent) command. Today the
>> host will schedule another full controller connect within
>> reconnect_delay, which is what we want right?
> 
> I knew this would be coming up, which is why I left it out of the 
> initial patchset.
> 
> Long explanation:
> 
> Thing is, connect handling is not _just_ connect handling.
> With linux we only have a single (ioctl-like) entry for the userspace 
> 'nvme connect' call.
> 
> That really does several things:
> - Setting up the transport
> - Create the transport association for the admin q
> - Create the admin q
> - send 'connect' over that queue
> - Create transport associations for the i/o qs
> - create i/o qs
> - send 'connect' over those queues
> 
> And my point here is that the actual 'connect' commands really are 
> straight NVMe commands. And as such should be subjected to the normal 
> status evaluation rules for NVMe commands.
> The problem here is the strange 'half-breed' nature of the connect command:
> 
> _Technically_ the association and the 'connect' command are independent, 
> and as such we would be entirely within spec to allow the 'connect'
> command to fail without having the association torn down. But due to
> our implementation that would leave us unable to re-use the association
> for further connect commands, as that would need to be triggered by
> userspace (which will always create a new association).
> 
> Consequently I would advocate for having any non-retryable failure of 
> the 'connect' command to always tear down the association, too.
> 
> That would be a deviation from our normal rules (where we always retry
> transport failures), but really is something we need to do if we enable 
> DNR evaluation for the 'connect' command.

How the host handles connect or any other request failing is entirely
the host choice.

In this patch, you decided to effectively to retry for transport errors,
which will effectively retry nvme_max_retries times. Can you please help
me understand what is the patch actually solving? I'm assuming that this
is an actual completion that you see from the controller, my second
question is what happens with this patch when the transport is the
source of the completion?

Once we understand this, we can discuss any difference between auth and
other driver generated commands.

