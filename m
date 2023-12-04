Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7147C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xRi/X8VvdL6/zrZyk/rOcO/bijGWDBloSn8wJ+9KJrY=; b=3JVLuwCBrI54jNSxt7aL9NaAEY
	kSkEcWP52qWJKPSO3E4LjCtilZR29wN9e8Qza1icoVMcpELOvspKUVLauyi8cFkApORvdmpArQbGZ
	bektl7SU/pMx2jxGloROoOY5tzX1408iwKKgq+zZZv0MwQmScmVMoDG92e9uicF0gj7J1llMrA+rB
	L+78VxkzIH+5YRURHAOlW1/qVC6+h0jUVkyXfvGJQvAzBpYCL+mgmFNQjOW4PDt5U4Qyf4XjdFDWB
	wtZK1zA2NV9vd3BbBnf8YGFHk+AZZNUqaAv5nsIXVEFMnLkEsknuykSAGEOJFhKcda2YxCFt5DeRG
	pPa+XlMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rABY6-00540C-00;
	Mon, 04 Dec 2023 16:11:58 +0000
Received: from mail-lj1-f175.google.com ([209.85.208.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rABY2-0053zV-2u
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 16:11:56 +0000
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c9f575d4b2so5502331fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 08:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706313; x=1702311113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRi/X8VvdL6/zrZyk/rOcO/bijGWDBloSn8wJ+9KJrY=;
        b=LQRJKYyS/AuokTBK8LX2M6sDCfKBmYWEBJdaS1bhaOspwhvXNQUoZ3b4m78s64GLgJ
         oQaBsmHaj2aw3ExzT/Cb8V4QnJbkK7SSnXY3w+Sb3uZviPiIIFpgEUM7JPSPds0J6Lk5
         hgM+xlUk84l8P9ykkBPLoZFKXqKpde5zwWCyk+HyT/DQ/QRn5GiYVbirHwAce0A7pG4m
         VW0gr/JnZCXfpqkUyfQwzBwHPAZIGsY/HCozO8w3XYNBQHDMUKqGMhYHvv2wLFaNR3+f
         eEjYOX/f7hX0JXhFxJBZq99qehYN/lzovcaWGqq9zxPoEOV8jjL/lRkfGOdmVdgnb8XA
         UCUw==
X-Gm-Message-State: AOJu0YzKfcmN3ZiS8xpOFRUHeQToJya/cliNthpVjohUiGwuJByAjs/m
	Vm7TxsiiUTp2ZyBwkQC0GEOKgNCEX4o=
X-Google-Smtp-Source: AGHT+IF8skf2OJoGKc0AKveAkPcjZ+j/Eu/d53Zo/KSwC7K41TRWnIsLpADjILETF2RRvaCxf8Qfbw==
X-Received: by 2002:a05:600c:257:b0:408:3836:525f with SMTP id 23-20020a05600c025700b004083836525fmr22586683wmj.1.1701706292253;
        Mon, 04 Dec 2023 08:11:32 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3829eb50sm15514039wmq.20.2023.12.04.08.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:11:30 -0800 (PST)
Message-ID: <e3157a6e-c4d9-4ea9-8386-d185468f905b@grimberg.me>
Date: Mon, 4 Dec 2023 18:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
 <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
 <116f765d-a94e-4da7-ba81-9f9c7dec04b7@suse.de>
 <349c1dbe-82c3-f5e8-2158-211772e73771@grimberg.me>
 <b7b72df8-917c-4d4e-8440-47f85c50973d@grimberg.me>
 <765a21bd-e876-4e0f-a5ff-dd25fa7265fa@suse.de>
 <c0721f45-0615-4d06-9be2-b0edb2713dc7@grimberg.me>
 <92367bab-4d56-42bb-a82e-66fc984a2894@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <92367bab-4d56-42bb-a82e-66fc984a2894@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_081154_946079_78C7636F 
X-CRM114-Status: GOOD (  37.80  )
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


>>> Argument here is that there is a race window between command timeout
>>> triggering (ie the call to nvme_tcp_timeout()) and scheduling of the
>>> 'err_work' workqueue function. If you have a burst of commands all
>>> expiring at roughly the same time the first command will set the 
>>> controller state to 'RESETTING', and schedule the 'err_work' workqueue
>>> function.
>>
>> Yes, that is correct. It is also the keep-alive itself that can
>> trigger the timeout handler. In fact, it is the more likely one
>> because it will by default have a lower timeout than IO commands.
>>
>> This is a part of where I lose the trail here, because I'd expect
>> the keep-alive to expire far before any of the IO commands, especially
>> with the latest changes to expedite the keep-alive execution pace.
>>
> That's not necessarily the case. We don't have any checks to align 
> command timeouts to KATO, and we don't mandate anywhere that command
> timeouts need to be larger than KATO.

Was this the case? where io timeout lower than kato?
What were these values in reproducer?

> And even then we can get pathological cases where commands take up
> to the timeout for processing, and the last keep-alive was just sent
> before that.
> So I'd rather prefer to fix the race condition.

My assumption was that the connection (transport) was torn, not that
the controller processing time exceeded command timeout.

>>> The second command will timing out _before_ err_work is scheduled,
>>> will see the RESETTING state in nvme_tcp_timeout(), and directly
>>> complete and retry (via nvme_tcp_complete_timed_out()) without
>>> waiting for KATO.
>>
>> That is something we probably can address by analyzing the controller
>> state a bit deeper. We've always failed IO commands quickly in the
>> timeout handler because these commands can be part of the ctrl setup
>> sequence, which means the error recovery will not run and fail the 
>> commands on their behalf reliably. I also think there were issues with
>> issues in the teardown stage (shutdown or disable).
>>
> Sure. That's what I tried to address with the first patch.

Don't think we need to look at the running state of the err_work (looks
racy to me). Perhaps we can suffice on the ctrl state alone, but we also
need to check that it is an IO command, so we can address when the
setup/teardown admin commands can still fail without relying on the
error handler.

But overall I'm fine with this patch (1/3).

>>> That is the issue the customer had been seing, and that is what is
>>> causing data corruption on their end.
>>>
>>> This patchset is an attempt to fix this issue.
>>
>> In your patch 3, you take nvme_keep_alive_work_period(), which is
>> either kato/2 or kato/4. It is not clear to me why these values
>> were chosen other than "the issue went away".
>>
> Yeah, that is wrong. The idea is to ensure that command timeout _always_ 
> start error recovery at least after the KATO period expired, but that an 
> actual KATO timeout would schedule the error handling directly (ie 
> flushing the scheduled error recovery workqueue item).
> That way the KATO timeout is the upper limit, but will be started 
> earlier depending on the timing between command and keep-alive timeout.

So the correct patch was to delay the error handler for kato?

>> Also, what happens if kato (which is user configurable), is arbitrarily
>> long? This means that IO failover can take say 60 minutes? Do you think
>> its reasonable? This is where I'm concerned about the unconditional
>> delay.
>>
> Yes, unfortunately that's true. But that's what's mandated by the spec.
> We could add an option to stick to the original behaviour, though, as 
> one could argue that this is what users are expecting now.

The only way kato is an option to add a delay is only if we prevent or
limit what users set it to. That is a discussion others should comment
on.

>> I think that the idea was that an appropriate delay would be indicated
>> by the controller, rather than being determined by a user controlled
>> variable.
>>
> Yep. The standard will be updated to cover that, but we're not there yet.
> 
>> Regardless we should limit to exactly when such a delay is actually
>> needed.
>>
>> Plus, I haven't seen anything for nvme-rdma and it is unclear to me
>> why this is a host specific to tcp.
>>
> That's because the testing had been done on TCP only, and I wanted to
> resolve the discussion before posting a full patchset.

I see.

>>> We'd be happy to pick up this thread, it just had been pushed back
>>> internally as we put in a band-aid for that customer in our kernels...
>>
>> Well, my assumption is that we want this addressed upstream. Just a
>> matter of how.
> 
> Agreed.
> 
> Cheers,
> 
> Hannes
> 

