Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F077C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQcUc9FJFnuSGgigK1OXNdUejzf10xDAxgnfkuEbAPQ=; b=RmkWHM4h+OTy00/IywQNhrSWjj
	sXwUf0DFBBX8UHUPL7unw2MfzNxaxK+4XHSYH9GLY1oBFQaZu+3uVyIQM1r+BdWci6iokds67KEcr
	X2fQVcjLbTuTcUfJmnjA+VZMj42nwL12uivA4Rmt4w6yNA5XXp+w6gUCCFL3gbKZqE2Relb54ofFp
	tuOmBq095PuVlXS0q1TR75VNysQwBXQ/nSZiw4/xhoAIqqk7gNgQ7SO1cAWnSSzhuWiayPQGYu/QB
	e0EWRB3H59t1YNir9dXI9R4xlImkwh/Eu/FGinclDaTaLpqRRTUarI8tq0ta8jgAQVRgWttDIizTg
	f/DIL++g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVJ0-0072HX-KD; Wed, 12 Oct 2022 06:33:26 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiVIx-0072Gc-O1
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 06:33:25 +0000
Received: by mail-wm1-f54.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so613748wmr.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Oct 2022 23:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQcUc9FJFnuSGgigK1OXNdUejzf10xDAxgnfkuEbAPQ=;
        b=PP6sNgy32jWQsemAtM55/6362U7klVBylyrgO1xcVtCupU4XogcRqw25vNVJYxkVPS
         MTh83UBs8etgzrwqJTSqINFIcX/qvxaWpy99WVLkNqUO3/6a+k+vV8Kx4lpUnJygVQIT
         qiRihVNiWY0ouhH5N0fYK7W26nwMfEJ156LEZZqTAelPq7rP7+mxdbxzel7ylvtGg5jm
         B6vdO6IMP0rmFcT3KzYh0SAz+56PFNkgRhawmUtmcYoYRL4zdsMwuyK9//h109JX0I6a
         t3fpR9Pci9s+0SjSqLtOWtMQihd/aa/Gq2mGu/O/VIRwTxN2CFV7H+F4aGPY9vKKiPmk
         7cyA==
X-Gm-Message-State: ACrzQf3/i/81W53ZrQdQ51IbAq2LH9WGinEtLJc6EQxhJxls1pUKTSwj
	d9hrsVqKE0F468AppV1QfT8=
X-Google-Smtp-Source: AMsMyM7La/ZSLE98nsh2foxsSnagrqU4jVPEYTuDY/1s6+Ef0fypeCfgPJmDKjq3UUG6MbbAlIXlLg==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr1667274wmb.89.1665556401122;
        Tue, 11 Oct 2022 23:33:21 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d5192000000b00228dbf15072sm12925939wrv.62.2022.10.11.23.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:33:20 -0700 (PDT)
Message-ID: <f7b44962-09d3-c724-89bc-453c86f4c1eb@grimberg.me>
Date: Wed, 12 Oct 2022 09:33:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nvme-tcp request timeouts
Content-Language: en-US
To: Seth Forshee <sforshee@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
 <Y0XUFGXHciDCXRTs@do-x1extreme>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y0XUFGXHciDCXRTs@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_233323_809963_4A2C12E7 
X-CRM114-Status: GOOD (  19.66  )
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

Hey Seth, thanks for reporting.

>>>> Hi Seth,
>>>>
>>>> On 10/11/22 08:31, Seth Forshee wrote:
>>>>> Hi,
>>>>>
>>>>> I'm seeing timeouts like the following from nvme-tcp:
>>>>>
>>>>> [ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
>>>>> [ 6369.513283] nvme nvme5: starting error recovery
>>>>> [ 6369.514379] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514385] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514392] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514393] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514401] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514414] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514420] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514427] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514430] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514432] block nvme5n1: no usable path - requeuing I/O
>>>>> [ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
>>>>> [ 6379.761015] nvme nvme5: creating 128 I/O queues.
>>>>> [ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
>>>>> [ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)
>>>>>
>>>>> This is with 6.0, using nvmet-tcp on a different machine as the target.
>>>>> I've seen this sporadically with several test cases. The fio fio-rand-RW
>>>>> example test is a pretty good reproducer when numjobs in increased (I'm
>>>>> setting it equal to the number of CPUs in the system).
>>>>>
>>>>> Let me know what I can do to help debug this. I'm currently adding some
>>>>> tracing to the driver to see if I can get an idea of the sequence of
>>>>> events that leads to this problem.
>>>>>
>>>>> Thanks,
>>>>> Seth
>>>>>
>>>>
>>>> Can you bisect it ? that will help to understand the commit causing
>>>> issue.
>>>
>>> I don't know of any "good" version right now. I started with a 5.10
>>> kernel and saw this, and tested 6.0 and still see it. I found several
>>> commits since 5.10 which fix some kind of timeouts:
>>>
>>> a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
>>> 70f437fb4395 nvme-tcp: fix io_work priority inversion
>>> 3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests to time out
>>>
>>> 5.10 still has timeouts with these backported, so whatever the problem
>>> is it has existed at least that long. I suppose I could go back to older
>>> kernels with these backported if that's going to be the best path
>>> forward here.
>>>
>>> Thanks,
>>> Seth
>>
>> Can you please share the fio config you are using ?
> 
> Sure. Note that I can reproduce it with a lower number of numjobs, but
> higher numbers make it easier, so I set it to the number of CPUs present
> on the system I'm using to test.
> 
> 
> [global]
> name=fio-rand-RW
> filename=fio-rand-RW
> rw=randrw
> rwmixread=60
> rwmixwrite=40
> bs=4K
> direct=0

Does this happen with direct=1?

> numjobs=128
> time_based
> runtime=900
> 
> [file1]
> size=10G
> ioengine=libaio
> iodepth=16
> 

Is it possible that the backend nvmet device is not fast enough?
Are your backend devices nvme? Can you share nvmetcli ls output?

Also, just to understand if things are slow or stuck, perhaps you
can artificially increase the io_timeout to say 60s or 120s.

