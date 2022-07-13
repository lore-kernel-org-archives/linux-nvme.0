Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5522DC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wMWvo3aqyEI7TmJb8vYfAXZZ5CDUizVFnSJsD42xBo=; b=YItGTMfpgcjlGyC1Zro36j4qsi
	y10t4j4IszDNxF8nRBm66OdnZqs9iYz6B9dIbeHjsGGixHSmrx43qKRd6HlDKvKmm/k3mDIDDreek
	gxaU37GACfB8KOcyCIOW9OurcIwZZi5OTYCN2S2M4HaOB5G9gigjLlcu3npSXszOsDBAlimUl3z8L
	C2RgOok30H6fI2I4JxRcUWlZAHyu/w0w3g+FMLatSGKPNmCrhkCQboV36s908GyW8EiKuYW9coWEg
	1ga0F3fmxKFlr4MdafN0wZyDyxDr/KgycCdMQVmuEHhs33Pndf++/hdCxFPSDCpeQKyEuF+tAl5v/
	ytpi5zbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBcck-0041wh-HO; Wed, 13 Jul 2022 13:41:54 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBcch-0041tt-KC
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 13:41:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id a5so15557397wrx.12
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2wMWvo3aqyEI7TmJb8vYfAXZZ5CDUizVFnSJsD42xBo=;
        b=mdIwcHTFCk3mjCQysJdcr1lDvd+PjToqjB+/qrGeNgjIe8KQadXTmWF/x6IuhGY6Ag
         K/o+1kMmB2/L6f8iBlarGGgVquMMCyTFduKZAWi3rTGwssY3R9kQTTDO9qC9kYHjGZc8
         6z99H5OmnPL/UF55x5ROvGkd3kl2kyiEtpGNMNovyRoliiLcpmCWOaMg8tEbhgkNW5YW
         D/BO3E7ylLPDwnvOMwr28yMpYAxVh2ro+eX/gPDtPWg+Sx6NJ4qKYDnNZdFO8Fh0h6Lf
         6fJY+6XLtOiWQGbJI6OZpCqhghMNYarlWEXk0qEW6D6KqHqAlekAv2fmvuMh1mazw4aH
         KAYg==
X-Gm-Message-State: AJIora+w1QCV/jGEB+tA61FSgV9HPOMMrOpQUNvfyPmcGK2r0DE1iVeP
	fUbMBOwRlWdS7Vc1c/R77U0=
X-Google-Smtp-Source: AGRyM1t4tNVMaDjtuqBQTZsVAzP48bzvn9smWT7c/5dh+G/HN0X7C49Rm4TOsxmJtWzo5v6V9REbyw==
X-Received: by 2002:a05:6000:2cb:b0:21d:7760:778c with SMTP id o11-20020a05600002cb00b0021d7760778cmr3529489wry.329.1657719708242;
        Wed, 13 Jul 2022 06:41:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a2ec73887fsm5648079wmq.1.2022.07.13.06.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:41:47 -0700 (PDT)
Message-ID: <66322f2d-fbde-7b9f-14f1-0651511d95b8@grimberg.me>
Date: Wed, 13 Jul 2022 16:41:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
 <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
 <20220713101235.GA27815@lst.de>
 <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
 <96f47d9b-fbfc-80da-4c38-f46986f14a43@suse.de>
 <7c7a093c-4103-b67d-c145-9d84aaae835e@grimberg.me>
 <04b475f6-506f-188b-d104-b27e9dffc1b8@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <04b475f6-506f-188b-d104-b27e9dffc1b8@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_064151_684725_E12596DC 
X-CRM114-Status: GOOD (  18.45  )
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


>>>>>> Maybe the solution is to just not expose a /dev/ng for the mpath 
>>>>>> device
>>>>>> node, but only for bottom namespaces. Then it would be completely
>>>>>> equivalent to scsi-generic devices.
>>>>>>
>>>>>> It just creates an unexpected mix of semantics of best-effort
>>>>>> multipathing with just path selection, but no requeue/failover...
>>>>>
>>>>> Which is exactly the same semanics as SG_IO on the dm-mpath nodes.
>>>>
>>>> I view uring passthru somewhat as a different thing than sending SG_IO
>>>> ioctls to dm-mpath. But it can be argued otherwise.
>>>>
>>>> BTW, the only consumer of it that I'm aware of commented that he
>>>> expects dm-mpath to retry SG_IO when dm-mpath retry for SG_IO 
>>>> submission
>>>> was attempted (https://www.spinics.net/lists/dm-devel/msg46924.html).
>>>>
>>>>  From Paolo:
>>>> "The problem is that userspace does not have a way to direct the 
>>>> command to a different path in the resubmission. It may not even 
>>>> have permission to issue DM_TABLE_STATUS, or to access the /dev 
>>>> nodes for the underlying paths, so without Martin's patches SG_IO on 
>>>> dm-mpath is basically unreliable by design."
>>>>
>>>> I didn't manage to track down any followup after that email though...
>>>>
>>> I did; 'twas me who was involved in the initial customer issue 
>>> leading up to that.
>>>
>>> Amongst all the other issue we've found the prime problem with SG_IO 
>>> is that it needs to be directed to the 'active' path.
>>> For the device-mapper has a distinct callout (dm_prepare_ioctl), 
>>> which essentially returns the current active path device. And then 
>>> the device-mapper core issues the command on that active path.
>>>
>>> All nice and good, _unless_ that command triggers an error.
>>> Normally it'd be intercepted by the dm-multipath end_io handler, and 
>>> would set the path to offline.
>>> But as ioctls do not use the normal I/O path the end_io handler is 
>>> never called, and further SG_IO calls are happily routed down the 
>>> failed path.
>>>
>>> And the customer had to use SG_IO (or, in qemu-speak, LUN 
>>> passthrough) as his application/filesystem makes heavy use of 
>>> persistent reservations.
>>
>> How did this conclude Hannes?
> 
> It didn't. The proposed interface got rejected, and now we need to come 
> up with an alternative solution.
> Which we haven't found yet.

Lets assume for the sake of discussion, had dm-mpath set a path to be
offline on ioctl errors, what would qemu do upon this error? blindly
retry? Until When? Or would qemu need to learn about the path tables in
order to know when there is at least one online path in order to retry?

What is the model that a passthru consumer needs to follow when
operating against a mpath device?

