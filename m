Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5084AC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUaV+ypb8fcjrJgH2caRqC78IMqKEDTyzPgZJWj7fnE=; b=X8Vo4UHmhght9TEYiOv1w24Lnk
	RbZlwQ9pWT/H+QFq6hOLOHhvJcNJKMWn8vC1U81ZCnalORNKI+tFj151AVHp8gUeB3MH0BeIRmKib
	SLNdN2XzODd68+Ym707EEfEoOgQOdMmhi86a9wikyET6cvJbyQylfVjSkeHGhJYjMstKrOwLT+Rk+
	wu8LbanImIDB5zAD6ttIpguhPrjwiw0ItAaAUtqct3hz+Z2NLlYMikAkl+m2icC/IvC+UwLk0VKtC
	FKYMfOA5s4Mev+CXCyr/Q+X19kQ3k0qMfsTZfUmGuhROjjE2IKCr3G9PyFwBQcjbMZLQaO8tZvzxS
	LsdKHPwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDb1-005EcZ-9I; Wed, 15 Feb 2023 08:56:59 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDay-005EbK-90
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 08:56:57 +0000
Received: by mail-wm1-f50.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso927077wms.4
        for <linux-nvme@lists.infradead.org>; Wed, 15 Feb 2023 00:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676451411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUaV+ypb8fcjrJgH2caRqC78IMqKEDTyzPgZJWj7fnE=;
        b=zLc2A9KWbf8yUS9N+sYVfI3HP4aQ/+H7bShykEZy2ppcDdT1I+FA9alDvbLYsNQQJ/
         G/v3UMwjjX22O7RUhtv+CGFbZpdU82jJMkxy7rwV1BAW4wUDfR3iEpqCqcGusSiYRcDA
         h8d/jUVjwVfQXuvqpqmEEVRvzOLj0+7R1EglHIJxlQ6dcf0c/K8rAAu5R6tLSdclGcg8
         oVSLq+uCd4AYXFRdn2qVFZTlQoHgEdmuRoDWEJcTUcQwXOQt0wdqmoknAer8z3PLYweG
         hB0aCn90e1OQ/CxMhCxBthuJDTXF5T1/lroDmAhPX6fTlpWbOP/OQuHoy5xAmOf0VqW2
         BAbA==
X-Gm-Message-State: AO0yUKXTnMFt/CUYct1zCI18VTsdgW2Ot7sSk7E5Ql2NtQ6u0jljCJot
	f5eF3S/gXuWZymjGtaBbUcMIRh/KyIM=
X-Google-Smtp-Source: AK7set84+xx+PDcrpApFMH+m2xfUO0NapliPTQCvnDrB76mWED3FgR7kKKi7wdB2wyba37BdGFm2kw==
X-Received: by 2002:a1c:ed12:0:b0:3dd:1cd3:5d75 with SMTP id l18-20020a1ced12000000b003dd1cd35d75mr1563702wmh.0.1676451411124;
        Wed, 15 Feb 2023 00:56:51 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b003de77597f16sm1489103wmq.21.2023.02.15.00.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:56:50 -0800 (PST)
Message-ID: <7e8467d4-a004-33ee-da98-c263f6f43111@grimberg.me>
Date: Wed, 15 Feb 2023 10:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme/pcie hot plug results in /dev name change
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org> <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com> <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp> <Y+x5KLpMrurxcnc5@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y+x5KLpMrurxcnc5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_005656_342808_2A2B5F4B 
X-CRM114-Status: GOOD (  20.94  )
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


>>> Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
>>
>> Similiar, but generic to non-multipath devices.
> 
> Exactly!
> 
>>> We can keep the mpath device around, but if not, what is the desired
>>> behavior from the upper layers?
>>
>> I don't think we're looking for any behavioral changes in the upper layers.
> 
> There's really two different things, which would both a problem:
> 
>   - make the device not go away if we expect it to come back by using
>     the multipath code

How do you know in the driver what to expect? how can anyone know
what to expect? There is also a question of what to do with the
I/O coming in, queue it or fail it and when...

>   - tell the upper layer that a devie went away when it actually did

Don't we already send a udev event KOBJ_REMOVE when a block device goes
away?

IIRC LVM already removes its stuff if the underlying block device
goes away (although I do recall that the dm did leave the device
handle open)...

> Right now if user has a block device open, it will keep a reference to
> it forever.  If we send a notification to the upper layer not only can
> it release that refrence, but it also knows the device went away.

--
KERNEL[520130.230115] remove   /devices/virtual/bdi/252:0 (bdi)
KERNEL[520130.230261] remove   /devices/virtual/block/nullb0 (block)
--

> This really helps to e.g. rebalance data in a RAID or RAID-like setup.

I thought that RAID already tracked these sort of events...

