Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6668C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3z3AlvTe0jvDWLamOTbCF+PlolncdhX1PAZ/UrbCzI=; b=p9bXeDRVZ19S1VsKwY0Jhpa61h
	7sTNiJjdyYhagrDomNXh8zRsqbruuAU51j5pz43n3dVe9R1EqYWuOTvuip1ANFxysU3ip3o1jlN8C
	439T8wXMPj3I0DFFugdrea6tDwl6XgBDLeIkpKWz0TBTlcIB3Oy73FAyn5yHEdj6Gp09SE+ss2AqK
	3BOidsV2AlCCijMfOHMZaHDkK71FRw7LMNnzkmGXmC9s05LwpW9I/omSj0nCqfDcI7tRyVhJDwJ45
	mXo/Uc4NBzyZRShmBeyvFPuI/FDhVw/pjj/HCWczY+cH+iOFadr0oePRY+u0yZ6Oho79sJjHEFvm6
	qkZr0pUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntQHw-007KKI-SB; Tue, 24 May 2022 08:53:12 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntQHu-007KJ4-3r
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 08:53:11 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 h19-20020a05600c351300b003975cedb52bso516209wmq.1
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 01:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=j3z3AlvTe0jvDWLamOTbCF+PlolncdhX1PAZ/UrbCzI=;
 b=z3ygP74DQwtTNvaHrkvkIiOZ0+VXMmgR/QMLAXOXdWpca89kRUWN9HqFHoM7HoIJnx
 7QyDyrTQcRiYB4YVSnI2dBUh2/nmRX2yLGzBTfnVijMUPWh9Em6mMngRTvsMa5G4V3Z9
 1XVlIzMwzlYNPuKO8wtQde5BirjYi6o6xZ4kGxcwy3Yh8Sn5caSywF2w/f86xLU5tl02
 Sni6juvWCJgVpfRTupAuUKBmNGayB4cgqeKe5bfXa3GQOjrzTr0BjI6p4YOm8Mw9g+JH
 32FyLjPy0pWbRlv9LSuzTpLQXHfhG0ir+dfrHOiCg+yn9Zsec+l7Xn09yIxLwsAxFpWe
 qElw==
X-Gm-Message-State: AOAM531IDceeQFfykc5WQCJdQ6eZuSWJzvuTaba/PI700jcIYqNHxpgN
 r0uXD28KDPcWwZUwwGwArY9cUvu+ED0=
X-Google-Smtp-Source: ABdhPJyaLDWm37m9z+i5W9Yf+czgjk2YfZ/6cxgupmreOXKk2+aqQPLBRW67dppMZPR5JJI2ubE8GA==
X-Received: by 2002:a05:600c:4ed1:b0:394:8352:3ea1 with SMTP id
 g17-20020a05600c4ed100b0039483523ea1mr2663122wmq.153.1653382387094; 
 Tue, 24 May 2022 01:53:07 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 q7-20020a1ce907000000b003942a244ecesm1413916wmc.19.2022.05.24.01.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 May 2022 01:53:06 -0700 (PDT)
Message-ID: <ec08bc32-3ad3-fade-0acd-ae5d5ca3812f@grimberg.me>
Date: Tue, 24 May 2022 11:53:05 +0300
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
 <02805f44-6f2d-b12e-c224-d44616332d5a@grimberg.me>
 <76475e4f-13c7-2e0c-8584-f46918f5cefa@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <76475e4f-13c7-2e0c-8584-f46918f5cefa@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_015310_205957_439D8415 
X-CRM114-Status: GOOD (  29.35  )
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


>>>>>>> I'm open to discussion what we should be doing when the request 
>>>>>>> is in the process of being sent. But when it didn't have a chance 
>>>>>>> to be sent and we just overloaded our internal queuing we 
>>>>>>> shouldn't be sending timeouts.
>>>>>>
>>>>>> As mentioned above, what happens if that same reporter opens 
>>>>>> another bug
>>>>>> that the same phenomenon happens with soft-iwarp? What would you tell
>>>>>> him/her?
>>>>>
>>>>> Nope. It's a HW appliance. Not a chance to change that.
>>>>
>>>> It was just a theoretical question.
>>>>
>>>> Do note that I'm not against solving a problem for anyone, I'm just
>>>> questioning if increasing the io_timeout to be unbound in case the
>>>> network is congested, is the right solution for everyone instead of
>>>> a particular case that can easily be solved with udev to make the
>>>> io_timeout to be as high as needed.
>>>>
>>>> One can argue that this patchset is making nvme-tcp to basically
>>>> ignore the device io_timeout in certain cases.
>>>
>>> Oh, yes, sure, that will happen.
>>> What I'm actually arguing is the imprecise difference between 
>>> BLK_STS_AGAIN / BLK_STS_RESOURCE as a return value from ->queue_rq()
>>> and command timeouts in case of resource constraints on the driver 
>>> implementing ->queue_rq().
>>>
>>> If there is a resource constrain driver is free to return 
>>> BLK_STS_RESOURCE (in which case you wouldn't see a timeout) or accept 
>>> the request (in which case there will be a timeout).
>>
>> There is no resource constraint. The driver sizes up the resources
>> to be able to queue all the requests it is getting.
>>
>>> I could live with a timeout if that would just result in the command 
>>> being retried. But in the case of nvme it results in a connection 
>>> reset to boot, making customers really nervous that their system is 
>>> broken.
>>
>> But how does the driver know that it is running in this environment that
>> is completely congested? What I'm saying is that this is a specific use
>> case that the solution can have negative side-effects for other common
>> use-cases, because it is beyond the scope of the driver to handle.
>>
>> We can also trigger this condition with nvme-rdma.
>>
>> We could stay with this patch, but I'd argue that this might be the
>> wrong thing to do in certain use-cases.
>>
> Right, okay.
> 
> Arguably this is a workload corner case, and we might not want to fix 
> this in the driver.
> 
> _However_: do we need to do a controller reset in this case?
> Shouldn't it be sufficient to just complete the command w/ timeout error 
> and be done with it?

The question is what is special about this timeout vs. any other
timeout?

pci attempts to abort the command before triggering a controller
reset, Maybe we should also? although abort is not really reliable
going on the admin queue...

