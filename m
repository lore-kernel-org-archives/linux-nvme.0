Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441FCC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9go9IG9URxLN2HqHgnFiQ9sjN3QP0XouBIGfE0bjtak=; b=0cT4PhG2QkOHWESutY5cyUotGD
	8CT8FbX/1KvPVreD2nttuUHwAHMiLUbgS5zd9aeCEWR2wo0FtNgAadDsv1gt5Miu/f3EMYT5mHaKb
	Ar+8ha2xph0pqjc6CNEC7y58NAZeAZtLLvUcjqaahVQB8njcuCtJvaYF55Lu6apf1KDFtUKRce5s9
	0RSbh4MZZIJH1wKb7nyvMq9yzs5hG4DVGGVjF6H5MzUGumWOiKLr0Qhys5K9VH//VQm9XwC4tB0kg
	zjU4fu65wztN58G84iXTKhw5q4qjoR+EHvHQWlbKE9SdPSPp2kTEraAcL+xHGAZGuQzl/9qHy9Q7/
	dFQ6ddMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGjtU-008PNq-JK; Sun, 06 Feb 2022 15:56:04 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGjtR-008PNQ-G8
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 15:56:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id w11so20733910wra.4
 for <linux-nvme@lists.infradead.org>; Sun, 06 Feb 2022 07:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9go9IG9URxLN2HqHgnFiQ9sjN3QP0XouBIGfE0bjtak=;
 b=oaoVVGCKWbVw+oFQwbLslr1/YSFEQk2oeAANmhAk2zhyvTpaPcelQSbIRhTpElhfXk
 rPFvoLRvMrC5+tmL/FcApAi+WFHiT2PliJXxptiBjeFKZ13HdoFHPj3aNKraLHISICzx
 0b4aHIbpVB7OgkFFmN0jbk187IPEXZ9Dft4ffG13+TzfCcX/VK7Z2CFIHza547AjZVdo
 Q9O8x0x1OZJLhvnTz1jB/vytokErLggiWgTcEbHeGY3Yx3JVXuV9mCpG0TT0PYcDo/Qb
 5fRwkBSdlD+ayUKPpEZTX3DwoF6BZhuaq25N/cmCGrztEC1acIq4BCcnZSRnHuudZY+X
 P+Dg==
X-Gm-Message-State: AOAM53368WMAQG3CveAZB7qlVt7AhPc3Jtcdj3gFLZyM66hKU97WixnM
 AH0QHejYSNeREjsnqt4n13M=
X-Google-Smtp-Source: ABdhPJzVwJg/W8a/S06O8v+1fISFhNS8XMrxQjkwFV6T7ksxXt5FvW4ocY6VXSVLVMLU4v45J4kb8g==
X-Received: by 2002:adf:f710:: with SMTP id r16mr5391381wrp.327.1644162959638; 
 Sun, 06 Feb 2022 07:55:59 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id ay3sm14598642wmb.44.2022.02.06.07.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 07:55:59 -0800 (PST)
Message-ID: <779728d6-ad10-0c98-643b-453f5baafbe9@grimberg.me>
Date: Sun, 6 Feb 2022 17:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "Rose, Charles" <Charles.Rose@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <Yf0yq3wXzvkPf5Wa@kroah.com>
 <b10f199e-83eb-7088-f9ea-44057b59b6cc@grimberg.me>
 <Yf+4zhofzutXLVih@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yf+4zhofzutXLVih@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_075601_596249_A8D06647 
X-CRM114-Status: GOOD (  23.80  )
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


>> The idea was to add a separate udev announcement that would tell
>> userspace that these attributes are stable (it actually serves
>> a different purpose, but it does come after that point).
> 
> like KOBJECT_CHANGE is there for?

Yes, that was the point, to add a change event (patch 1 in
the series).

>>> So there's a reason you are being forced to add a driver-core change
>>> like this, because it's not something you should do :)
>>
>> I do agree that its a bit backwards to do this update. But the device
>> even today is not fully usable when it is created, so we know no
>> userspace program relies on the creation announcement.
>>
>>>> So now I'm in a bit of a pickle. Sagi suggested this current patch set, but from what you're saying this is not a good approach. If you could suggest a solution that would satisfy all parties, I would greatly appreciate it.
>>>
>>> Wait to create the device when you know the device type.
>>
>> The initial proposal was to defer the device creation to after the
>> device is fully initialized. That though is a heavier lift because the
>> device initialization is something that happens on every reset or
>> reconnection after connectivity loss,
> 
> That's fine, what's wrong with tearing it all down and bringing it back
> up then?  That's what the hardware just did, don't fake things out by
> not conveying the same stuff to userspace.
> 
>> so if we move the device creation there we have to now check if this
>> is the first time we are doing this or not, and also error recovery
>> becomes more opinionated...
> 
> I still think you should not create anything until you know what it is.

We probably should take a step back and understand if we can delay the
controller device creation. There are some corner cases that I'm
concerned we might introduce if we do that, but it may be the right
thing to do...

Or, we can expose this specific attribute via a different interface like
ioctl, or embedding it in the uevent that we send anyways...

