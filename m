Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A3FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNMC/3Y222wyoKA7v6O7b+cHa4iOVKAKb6ZmRJn1LgM=; b=419s6B7pbevvrdmkofGCSW8n4X
	X5QOatU/GITgAcwq0iwx+FMIaNOgt0TCESY97RS0UDeAsCIMfLtZnS7W11VM+D7W22rKh+hUOsLpj
	yBRQ95PljWYGUtXkXAoYA0mNVQ1k/cUm8gduU3HC/LpmsbEwSPTs4Vmhu6z5cltt5XQ7Ekws2xecw
	8Ek8F1HyH3A6qcbrHzxhA+8d9cuaat8nvjvLltmcsg6rsn0OvF9FKgMKr6PVZ37hBTF/1UXpsQwAX
	dFDTYVkmVvbyyf8HQteZceKdQstFHbzIz97dqvI3E7a/0uvJKGxgIwiJL0+xJyAUefVAgXFOLZJuD
	tiXWAWxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nt9d4-004qVE-2H; Mon, 23 May 2022 15:05:54 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nt9d0-004qTI-Kf
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 15:05:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 i20-20020a05600c355400b0039456976dcaso118585wmq.1
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 08:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iNMC/3Y222wyoKA7v6O7b+cHa4iOVKAKb6ZmRJn1LgM=;
 b=B/GPDA6pwpyH/rmA2LWMiiuO3Ud2Tr/Sjow+BqqSkhEnzDB+vO4RYaaHjKd5O2mqCa
 vvbYSbQeZwFRpvVokawjSrEhgH6tZU9Yz2aTvTzFjMFEZ8tveh15gxQwFfss76TnfBzq
 JG0hIzauswovrwtHoLPfditNt+vdzBCt3/DUiNXDMofDdJ/JuzHKsq77brIJIB04fxza
 FazPUvUZn3IH/+zGrHOx9fU1NjEzpthtEySVYI7BnWayGvnrS+903CGD+sRTNpN0HDL1
 4GFuGG/qhySm91KDsA+Ydjzkm728Iq4mK9hPxA27BnTyuyuQ4rmAPJ64Btzz3OjyHBMf
 9ccA==
X-Gm-Message-State: AOAM531hNfyadiwlz9Pkv21I5o0fNFFUWnO51PfunW0U9C3amAo8F8/O
 RWL7iY1lc5gaxblilT9sKxY=
X-Google-Smtp-Source: ABdhPJzK0x8a07hLROOuyOJ8+BHLw/a2xlrGDzlYdGhruqqW1ENqgRdibaPB7DpTZGF6TylwCIEGRg==
X-Received: by 2002:a05:600c:268a:b0:397:48d4:f6ad with SMTP id
 10-20020a05600c268a00b0039748d4f6admr6510224wmt.134.1653318347241; 
 Mon, 23 May 2022 08:05:47 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfaa0e000000b0020d02ddf4d0sm10217401wrd.69.2022.05.23.08.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 May 2022 08:05:46 -0700 (PDT)
Message-ID: <7ec792e3-5110-2272-b6fe-1a976c8c054f@grimberg.me>
Date: Mon, 23 May 2022 18:05:45 +0300
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e749bb3e-2ff7-23f5-9f5f-974c986845b6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_080550_744766_683508F6 
X-CRM114-Status: GOOD (  35.03  )
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


>>>> The patch title does not explain what the patch does, or what it
>>>> fixes.
>>>>
>>>>> When running on slow links requests might take some time
>>>>> for be processed, and as we always allow to queue requests
>>>>> timeout may trigger when the requests are still queued.
>>>>> Eg sending 128M requests over 30 queues over a 1GigE link
>>>>> will inevitably timeout before the last request could be sent.
>>>>> So reset the timeout if the request is still being queued
>>>>> or if it's in the process of being sent.
>>>>
>>>> Maybe I'm missing something... But you are overloading so much that you
>>>> timeout even before a command is sent out. That still does not change
>>>> the fact that the timeout expired. Why is resetting the timer without
>>>> taking any action the acceptable action in this case?
>>>>
>>>> Is this solving a bug? The fact that you get timeouts in your test
>>>> is somewhat expected isn't it?
>>>>
>>>
>>> Yes, and no.
>>> We happily let requests sit in the (blk-layer) queue for basically 
>>> any amount of time.
>>> And it's a design decision within the driver _when_ to start the timer.
>>
>> Is it? isn't it supposed to start when the request is queued?
>>
> Queued where?

When .queue_rq() is called, when it returns the request should be
queued.

>>> My point is that starting the timer and _then_ do internal queuing is 
>>> questionable; we might have returned BLK_STS_AGAIN (or something) 
>>> when we found that we cannot send requests right now.
>>> Or we might have started the timer only when the request is being 
>>> sent to the HW.
>>
>> It is not sent to the HW, it is sent down the TCP stack. But it is not
>> any different than posting the request to a hw queue on a pci/rdma/fc
>> device. The device has some context that process the queue and sends
>> it to the wire, in nvme-tcp that context is io_work.
>>
>>> So returning a timeout in one case but not the other is somewhat 
>>> erratic.
>>
>> What is the difference than posting a work request to an rdma nic on
>> a congested network? an imaginary 1Gb rdma nic :)
>>
>> Or maybe lets ask it differently, what happens if you run this test
>> on the same nic, but with soft-iwarp/soft-roce interface on top of it?
>>
> I can't really tell, as I haven't tried.
> Can give it a go, though.

You can, but the same thing will happen. the only difference is that
soft-iwarp is a TCP ULP that does not expose the state of the socket
to nvme transport (rdma), nor any congestion related attributes.

>>> I would argue that we should only start the timer when requests have 
>>> had a chance to be sent to the HW; when it's still within the driver 
>>> one has a hard time arguing why timeouts do apply on one level but 
>>> not on the other, especially as both levels to exactly the same (to 
>>> wit: queue commands until they can be sent).
>>
>> I look at this differently, the way I see it, is that nvme-tcp is
>> exactly like nvme-rdma/nvme-fc but also implements context executing the
>> command, in software. So in my mind, it is mixing different layers.
>>
> Hmm. Yes, of course one could take this stance.
> Especially given the NVMe-oF notion of 'transport'.
> 
> Sadly it's hard to reproduce this with other transports, as they 
> inevitably only run on HW fast enough to not directly exhibit this 
> problem (FC is now on 8G min, and IB probably on at least 10G).

use soft-iwarp/soft-roce and it should do the exact same thing
on a 1Gb nic.

> The issue arises when running a fio test with a variable size
> (4M - 128M), which works on other transports like FC.
> For TCP we're running into the said timeouts, but adding things like 
> blk-cgroup or rq-qos make the issue go away.
> 
> So question naturally would be why we need a traffic shaper on TCP, but 
> not on FC.

If I were to take an old 10G rdma nic (or even new 25G), stick it into a
128 core machine, create 128 queues of depth 1024, run workload with
bs=4M jobs=128 qd=1024, you will also see timeouts.

In every setup exists a workload that will overwhelm it...

>>> I'm open to discussion what we should be doing when the request is in 
>>> the process of being sent. But when it didn't have a chance to be 
>>> sent and we just overloaded our internal queuing we shouldn't be 
>>> sending timeouts.
>>
>> As mentioned above, what happens if that same reporter opens another bug
>> that the same phenomenon happens with soft-iwarp? What would you tell
>> him/her?
> 
> Nope. It's a HW appliance. Not a chance to change that.

It was just a theoretical question.

Do note that I'm not against solving a problem for anyone, I'm just
questioning if increasing the io_timeout to be unbound in case the
network is congested, is the right solution for everyone instead of
a particular case that can easily be solved with udev to make the
io_timeout to be as high as needed.

One can argue that this patchset is making nvme-tcp to basically
ignore the device io_timeout in certain cases.

