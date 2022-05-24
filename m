Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A09C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnVEOyNsaCcyBo6nYwnJiSRhMJ9li9Let4GVv2zbG7Y=; b=M0UPTj1I0G7pfGcha4aUIRNSOS
	uYS94l3cYxqo9NWgbmhZhc5x9F85Hjgp5UbvdbNOWZq0XmyCCQnreOiymSwxt5pCLvqEdsKhzxPOE
	4wuPAPnVOadIF9+9afp0klOq4U6EBNp8SMd0nA76I4jjAE8ThIJrsttYErd86GJDLdRvnpAv5xCJi
	4JQc2Hmq7XvglVJOdaqh22VP4Hi+Zf5T0mHcfiWxobXCm1AioM6qfd91jpMC0QiyxGx59SN1b7QOm
	tgBxHhjd3bAk7fPaEvPklF4omKUg6qsMrNxpRW4IDX9Ms5aQsCcQZMa4FEz7n4n6icPgxHigtfh8G
	ptvfqkvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntPQX-007AS5-8Z; Tue, 24 May 2022 07:58:01 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntPQT-007APn-OB
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 07:57:59 +0000
Received: by mail-wr1-f54.google.com with SMTP id x12so231068wrg.2
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 00:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jnVEOyNsaCcyBo6nYwnJiSRhMJ9li9Let4GVv2zbG7Y=;
 b=kVmzH1W3YbsJtnDx4u0F+Wp2crluPdGP+XPX7aeY/9ZwwKkAz+uRCyf4iEJw5920EU
 kFRLVffVzzCiM2nkOznxcJQVF1vwEEMBs12ObpadvE+W/5ioA6mtkWiEf4y87IXJcLgI
 WNGG+5EVY2yg6uBs/0lA943OwiCX2F76IkXXQUSQPYZFTtZsKUi8JL3UCwfnaZFhzQmf
 bR+2X18BSbZf8dEAT6L1Ik3MUqepzZsenYraPuWBG3SMhz/se98/d7wKWRtCwp2rXTJh
 0a2c6Sle1eSjdVIn4KowVhPUt93pbSrbUVv1m6gGgqjOl9jAsZiK5WH3dXGCBGG8fYEC
 lvJw==
X-Gm-Message-State: AOAM531gtsJF+ypwhAr1nkUaWA0M5S1uZA+p5+NY0FYY4nULz7x1nJ78
 NRwB1exmXdtvA9mvVoyqjkpfGRifh1o=
X-Google-Smtp-Source: ABdhPJyQHUexwCVcIV09kB/JWwfxRJWbjH0C87OLmBLpNIIVfqIKaAkh52lYj7+tSAP2IhC7j++t6Q==
X-Received: by 2002:adf:ebce:0:b0:20d:7859:494d with SMTP id
 v14-20020adfebce000000b0020d7859494dmr21673457wrn.590.1653379074946; 
 Tue, 24 May 2022 00:57:54 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r9-20020adfa149000000b0020e62feca05sm12401008wrr.32.2022.05.24.00.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 00:57:54 -0700 (PDT)
Message-ID: <02805f44-6f2d-b12e-c224-d44616332d5a@grimberg.me>
Date: Tue, 24 May 2022 10:57:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
 <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
 <96a3315f-43a4-efe6-1f37-0552d66dbd85@suse.de>
 <96722b37-f943-c3e4-ee6a-440f65e8afca@grimberg.me>
 <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
 <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
 <919bfaa2-a35d-052a-1d35-9fdd8faa0d3f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <919bfaa2-a35d-052a-1d35-9fdd8faa0d3f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_005757_834125_1F9A7789 
X-CRM114-Status: GOOD (  27.64  )
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


>>>>> I'm open to discussion what we should be doing when the request is 
>>>>> in the process of being sent. But when it didn't have a chance to 
>>>>> be sent and we just overloaded our internal queuing we shouldn't be 
>>>>> sending timeouts.
>>>>
>>>> As mentioned above, what happens if that same reporter opens another 
>>>> bug
>>>> that the same phenomenon happens with soft-iwarp? What would you tell
>>>> him/her?
>>>
>>> Nope. It's a HW appliance. Not a chance to change that.
>>
>> It was just a theoretical question.
>>
>> Do note that I'm not against solving a problem for anyone, I'm just
>> questioning if increasing the io_timeout to be unbound in case the
>> network is congested, is the right solution for everyone instead of
>> a particular case that can easily be solved with udev to make the
>> io_timeout to be as high as needed.
>>
>> One can argue that this patchset is making nvme-tcp to basically
>> ignore the device io_timeout in certain cases.
> 
> Oh, yes, sure, that will happen.
> What I'm actually arguing is the imprecise difference between 
> BLK_STS_AGAIN / BLK_STS_RESOURCE as a return value from ->queue_rq()
> and command timeouts in case of resource constraints on the driver 
> implementing ->queue_rq().
> 
> If there is a resource constrain driver is free to return 
> BLK_STS_RESOURCE (in which case you wouldn't see a timeout) or accept 
> the request (in which case there will be a timeout).

There is no resource constraint. The driver sizes up the resources
to be able to queue all the requests it is getting.

> I could live with a timeout if that would just result in the command 
> being retried. But in the case of nvme it results in a connection reset 
> to boot, making customers really nervous that their system is broken.

But how does the driver know that it is running in this environment that
is completely congested? What I'm saying is that this is a specific use
case that the solution can have negative side-effects for other common
use-cases, because it is beyond the scope of the driver to handle.

We can also trigger this condition with nvme-rdma.

We could stay with this patch, but I'd argue that this might be the
wrong thing to do in certain use-cases.

> And having a workload which can generate connection resets feels like a 
> DoS attack to me; applications shouldn't be able to do that.

Having a workload occupying all the tags all the time is also a DDOS
attack.

