Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602A5C61DA4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUWduaTEORlTdr6b6lGX3FP80Z/jTVOl4IvFBbpklUc=; b=T1PlmufOh0LQCJr0vWXeulRFpq
	OGOcDGUBPRURFyQmuF2e2zSmEqJeH8g3fxUYM51KL4cIOfpf7CTA9s1/gZTEvN5Y4kDnZilye1Cg1
	Z5ZJPKufXcj0rseQROJCF9XoJP5g9RJeIttyyzJ8a6RqCWQUfmLSbR7Y948P4u0neBEzTXafUxXuC
	71WyZ68Zgx1mbBhmqJcKg7MZ+QnPVZcV3xxMP9zgKcgzvxjYy1Juwv5UfHLfbU9X4cdN7TUzHdhi2
	bNhFm6E6M58RoFxXLKUVY7aKtSC3KsHncsYsRRZs8AqlnqXyKN7fN47A8ow3LKK+20ayXx6C1WdeO
	yDSVqtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrSF-000hC1-F5; Tue, 14 Feb 2023 09:18:27 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrSD-000hAi-EK
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 09:18:26 +0000
Received: by mail-wm1-f48.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso711178wmb.4
        for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676366302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUWduaTEORlTdr6b6lGX3FP80Z/jTVOl4IvFBbpklUc=;
        b=kJvqU1qSMQ/BHCz5xoHILf1kolQgqS/i9T2oqu8UzTsWzWl+vBc9A8CXB0bkKg4eqs
         w3qFKjAzM0cKmJB5WDluFat+bw9p3RpNRx+q4u4QehiSkkeazfXQMC4LeQ7D+bXEyOGl
         5bXTm1fhqwV25RZgzYizMvmjBQMbsOzjQQFnK2hiTyYdew3E7f5nm6mP0DjTRjQnT3zM
         Hz7ISnXgjUFgF/Q51qdAf37zn+7lShBWuEwVhKxCqugiEEFn70jOYCs8GaD8SAyrjlvR
         OXz8CLkJNaXI9GCXjhg6NPqEAFVPqVQRzHgEe50oaCh5JYt2ztV3V2YFQmAjf9A60LJY
         P9Iw==
X-Gm-Message-State: AO0yUKVFIdRph0aFihwkducnhwoiPOTLinPAvYfC7kn5Pv4KevRWWkRm
	0fdii10tf0i9XPpwfZdj1sE=
X-Google-Smtp-Source: AK7set/Iccv8D6Gu6UWq9WVnaPYs22kSNL4lY2CbjpvFGV6Ra2eNfSUvhbPnKsNCfyEpjI4HE4Fzcw==
X-Received: by 2002:a05:600c:4f8d:b0:3dc:54da:ba3e with SMTP id n13-20020a05600c4f8d00b003dc54daba3emr1703421wmq.3.1676366301970;
        Tue, 14 Feb 2023 01:18:21 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d608d000000b002c54b6382c8sm9939834wrt.82.2023.02.14.01.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:18:21 -0800 (PST)
Message-ID: <eeac5e24-a9f0-e6d4-0eda-0706d5ceb28c@grimberg.me>
Date: Tue, 14 Feb 2023 11:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme/pcie hot plug results in /dev name change
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org> <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com> <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp> <Y+rQBgZTklub++cx@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y+rQBgZTklub++cx@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_011825_521968_45AE58C3 
X-CRM114-Status: GOOD (  16.22  )
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


>>>> Also not sure if this is going to work out, but it looks like a good start to
>>>> me.
>>>>
>>>> Instead of user pinning the virtual device so that it never goes away though, I
>>>> considered a user tunable "device missing delay" parameter to debounce link
>>>> events. New IOs would be deferred to the requeue_list while the timer is
>>>> active, and then EIO'ed if the timer expires without a successful LIVE
>>>> controller attachment. The use cases I'm considering are short bounces from
>>>> transient link resets, so I'd expect timers to be from a few seconds to maybe a
>>>> minute.
>>>
>>> Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
>>
>> Similiar, but generic to non-multipath devices.
>>   
>>> We can keep the mpath device around, but if not, what is the desired
>>> behavior from the upper layers?
>>
>> I don't think we're looking for any behavioral changes in the upper layers.
>   
> That also means no matter if the nvme mpath layer is added or not, upper
> layer still has to handle this kind of failure, so what is the
> difference made from the added nvme-mpath?

What do you expect from the upper layer? The device went away...

The suggestion is that when the device comes back the upper layer will
detect it and reconfigure it (restore it to a raid/dm or remount the
FS)?

