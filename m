Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1CBC636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6izr0FTIuihqb+eAJP9v/yPwmpRh2emPzmIszJ6NnY=; b=s2kGxDOa7BEDXizKKcIj2vwXTU
	iNujcZVcBIag9XjselHLhADt1k4Cx7w90Q0nEQElT2KFjNzD323WIJcczQH7g09+f+qvWPmWq2QPN
	D80m01cWniDR8aMrHHS0UWHDRxFOGaQOxVBlnI8qoucSiJ4LEh1lxUpDG/Mj6sSBBW8B4tFngrMDm
	dW5IFuRIBXjqFpZJaaQe3kFwvWHEoIru+2zNFXe2/cVLF5ssx6b47Drdy5dyop7J35u0ZDvVL2zq1
	h/m4jfRuxuyKjvsIU5Az2qrR0qqM6N4k6FhbibvxJ/q20tz2Q54R+6q1ywnih6HN5W2isV5pCaxqF
	BklabqpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZON-00EtYr-BY; Mon, 13 Feb 2023 14:01:15 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRZOJ-00EtXX-DM
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 14:01:12 +0000
Received: by mail-wm1-f50.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so9107522wms.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 06:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6izr0FTIuihqb+eAJP9v/yPwmpRh2emPzmIszJ6NnY=;
        b=UJ1U4cx58ZgZmlumXKydFouCSpv5oI+OatJqEl26ftmKpaqyoZgOTJBqmkIei7Ak+2
         /fbLY70XOnnZYyCGud6DofQ3BophuduB0zA1PSihG3hFq1kQlmREJMDM0k4bztVarlgU
         +zLSmZPGsWRmgda0ogP6wxZTaVEDDkr3LK1n5J4mvuld4LYnh/tz+2EKGePpJt6nNsk4
         NWJk/Ygw74JLwr5oIqLw9E3f7t9yqAlSfmyaAGeVFV8ooQP7AaHApuP5euJlN8xtvWb8
         aj7h7ZmEPQLEcpUd9dLaBeVRLi1VknKyJWcCRsNukGlc+gwd4IgTT5uSM+oREHwELG8S
         m5ig==
X-Gm-Message-State: AO0yUKUXCsz+zS/IhNegD3ShWXZffhrhx8XcTayUA3L9ZW6OkAInXX7T
	zA/0wNlR/hP4Yzonx5KZBSJ3Oo2MvMM=
X-Google-Smtp-Source: AK7set+/uJSOmeyB9OlE4qzMxzQqwvmD3j6JQhOEruqqucDDPZh31VuVwjV3yWyEOmTKBWf3S+gGaw==
X-Received: by 2002:a05:600c:511c:b0:3e0:b1:c12d with SMTP id o28-20020a05600c511c00b003e000b1c12dmr25235099wms.1.1676296865412;
        Mon, 13 Feb 2023 06:01:05 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c2ca400b003dc51c48f0bsm17812847wmc.19.2023.02.13.06.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:01:04 -0800 (PST)
Message-ID: <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
Date: Mon, 13 Feb 2023 16:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme/pcie hot plug results in /dev name change
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org> <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com> <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_060111_527375_E0E800A2 
X-CRM114-Status: GOOD (  16.39  )
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


>>>> The native nvme multipath looks like it could be leveraged to improving that
>>>> user experience if we wanted to make that layer an option for non-multipath
>>>> devices.
>>>
>>> Can you share the basic idea? Will nvme mulitpath hold the io error and
>>> not propagate to upper layer until new device is probed? What if the
>>> new device is probed late, and IO has been timed out and err is returned
>>> to upper layer?
>>
>> Attached is what I did, but I'm really not sure it is the right final
>> approach.
> 
> Also not sure if this is going to work out, but it looks like a good start to
> me.
> 
> Instead of user pinning the virtual device so that it never goes away though, I
> considered a user tunable "device missing delay" parameter to debounce link
> events. New IOs would be deferred to the requeue_list while the timer is
> active, and then EIO'ed if the timer expires without a successful LIVE
> controller attachment. The use cases I'm considering are short bounces from
> transient link resets, so I'd expect timers to be from a few seconds to maybe a
> minute.

Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?

We can keep the mpath device around, but if not, what is the desired
behavior from the upper layers?

