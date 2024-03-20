Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700E3C54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ic1nLAZlOIEz8qJZURNZoS0hfHmBW2vxO0Mxv1zSKM4=; b=PciAfapZKBhea2v84T6aDDqeMx
	DtZqJSVcUkS28oekhNIjp9FmqHgmkMbgKH9Yfsv70D+ImPZz+U2V6Q0FfdQQdkyb4MGPdMYWVZkHl
	MQKBML7brtOGv5Ef4FexzgWa6xn9n2N3cHsyH0sr9MXIiAD9W7qzFEjkbT/GpbtZxenzRcwMvXK1J
	9eHKAmf61yQZhoC3qZRcMa8ugMGL93aRmOESHgGo78JHpXiRcbpa36u6d/x+Roml0r50i6+D7qmzG
	oqU71c2B2mW/+tGixxaNHPd67P6f3QvD1C5Ueac2BnwopmSEHxU56zmTzuPl+6YJEvYbg89FYTQcA
	pC2lR6ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmrys-0000000GPrz-2WRM;
	Wed, 20 Mar 2024 09:11:30 +0000
Received: from mail-lj1-f173.google.com ([209.85.208.173])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmryp-0000000GPpG-1qXd
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 09:11:28 +0000
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4801ea689so16582891fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 02:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925878; x=1711530678;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic1nLAZlOIEz8qJZURNZoS0hfHmBW2vxO0Mxv1zSKM4=;
        b=ZDPe8C0f4EAzPH/LKD6d0wTb3+cAa4yw/RQ5XraiuWb83YUT0qGJInE5yNHlu4dg3y
         xZUV+z4wWOuBtG07A0u1a2Akvdhv63MlxaI2QoJKh3++wby1MvHA23UtxFaPbSjugfx4
         I+CactwafKT0qynVRIaw38UtxjMz/BGjRPW5Yh0+XBelhbFyEVNylPrZVYzG2MUti9oE
         14us69a3p7+A6Y1ELKN0EEYwrR4MziBANFQQ6bk84FvpylxxNS7uM0X16WRVRQRT65KU
         bTKSjspdQZCjDimKDFWVRspo4K3pFwkYKAsVCg5CcIwG7UouMGw7g5e/7RW6u4Zl7VAn
         yRQg==
X-Forwarded-Encrypted: i=1; AJvYcCUP7s+L6GjQ8+gJV4vWxJW24Zljto74ku5wiCm0mdZNvWpD/6ib17AfGQ1fhe8jjWQ8xkb5kn3t+RXRQ5D9o7eXzYEstGnBXrrEzM8h4Ro=
X-Gm-Message-State: AOJu0YxSqRH18VH/P9pZfA8Q3kzVwZfKECEFg5EvYathQwYWybFPkR9N
	P5G62i9G2bbtLEYKWesuX4Qar4CUrOjt6M04LVFynCfB05nOdaBp
X-Google-Smtp-Source: AGHT+IHuIGZmvxQyYFiZryw0Ofph5rR4aa1Rc8TH0jQHfwdyjSFp9UHdVF7zdFnNwwSVwQHZ+8j4qw==
X-Received: by 2002:a2e:b1c5:0:b0:2d4:7458:b65 with SMTP id e5-20020a2eb1c5000000b002d474580b65mr3346780lja.2.1710925877737;
        Wed, 20 Mar 2024 02:11:17 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00414109c66f7sm1572006wms.38.2024.03.20.02.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:11:17 -0700 (PDT)
Message-ID: <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
Date: Wed, 20 Mar 2024 11:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
Content-Language: he-IL, en-US
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_021127_504890_D699FD7C 
X-CRM114-Status: GOOD (  14.90  )
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



On 19/03/2024 0:33, Kamaljit Singh wrote:
> Hello,
>
> After switching from Kernel v6.6.2 to v6.6.21 we're now seeing these workqueue
> warnings. I found a discussion thread about the the Intel drm driver here
> https://lore.kernel.org/lkml/ZO-BkaGuVCgdr3wc@slm.duckdns.org/T/
>
> and this related bug report https://gitlab.freedesktop.org/drm/intel/-/issues/9245
> but that that drm fix isn't merged into v6.6.21. It appears that we may need the same
> WQ_UNBOUND change to the nvme host tcp driver among others.
>   
> [Fri Mar 15 22:30:06 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [Fri Mar 15 23:44:58 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 09:55:27 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 17:51:18 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 23:04:14 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND
> [Sun Mar 17 21:35:46 2024] perf: interrupt took too long (2707 > 2500), lowering kernel.perf_event_max_sample_rate to 73750
> [Sun Mar 17 21:49:34 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND
> ...
> workqueue: drm_fb_helper_damage_work [drm_kms_helper] hogged CPU for >10000us 32 times, consider switching to WQ_UNBOUND

Hey Kamaljit,

Its interesting that this happens because nvme_tcp_io_work is bound to 1 
jiffie.
Although in theory we do not stop receiving from a socket once we 
started, so
I guess this can happen in some extreme cases. Was the test you were running
read-heavy?

I was thinking that we may want to optionally move the recv path to 
softirq instead to
get some latency improvements, although I don't know if that would 
improve the situation
if we end up spending a lot of time in soft-irq...

>   
>   
> Thanks,
> Kamaljit Singh


