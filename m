Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E3C388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:36:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3F9206E3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4XbfNCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3F9206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pmViikdOhgAoZmIo/c5D8jC8FLnIUaYpzUPSprVY0ss=; b=U4XbfNCK/XfRSzfohDo4fgkUi
	5oXUNlHhNyrVoX51TVx2NtgJDZTBPw7HOf0sZ2nlZM2vZ84in433brMsR5letR1VXiRdZ59jk5b37
	rljo3HzhNIWprb7udHa5gL69d9iU34WBpQdD9Gh9t5qanJ9tVHxOeTYzvyJ20w+0JRfqYHFmHalcf
	oVGkfHYN0s4ZXYqfhsAL4cbOcZ/fscg3BcqRJMyUYVGigRx6oTGR8pycS5wX+jU7OG7o6llxHEdVg
	lIPwy3oxp8p45vhgXVeQlq7PyZ0MJbRVnSBqvVVZ/Tg3s2e5XSHeRmbgmGl43f/Y/GH3D80ZC90Ke
	Fbd8n8M5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kclcI-0000V5-HS; Wed, 11 Nov 2020 08:36:34 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclcE-0000SY-IL
 for linux-nvme@lists.infradead.org; Wed, 11 Nov 2020 08:36:31 +0000
Received: by mail-pl1-f181.google.com with SMTP id x15so622451pll.2
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 00:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z7ZIZUJlYrCIASsZIPaS/o5ulY2e3LdHJbfoMN/Tt7I=;
 b=UEgDdEcEy8uv8Aca0ZD03Nzyv1IJptP4+5vRlfHbZEE11biBv4QALZu/0yD35sh8AP
 kLymZvIm5hxmm7CIEyQiysdYxcQzRPxzfHvuSQuxrbA11CMB4tEcJfw40jqqZwA2xoc9
 GY4SGgD/VU2Ei3326bdVOWwmXXU20UAt8iPHi/Ypt9RKbkYYUKcaXOMs3rSjDRB0GdLR
 TeodtOaW/4hOxFQtuI7ohc/cXqvWneOapWcDRGle6sN+4oNUrlX0r4tTxWbt//Cl6emP
 mja8JvefwakadUJNIboxxapJnIBzKZo2nSbWVytkK9yKWMIonmxVHxEvSsMuzR7ggGKH
 CNQw==
X-Gm-Message-State: AOAM533HtPq8MnlAoIxra/x/IxdcUntfKjzUU1UH+KwxwsgNx370TCVO
 CnAw9DJvJtrC/qvcORpalME=
X-Google-Smtp-Source: ABdhPJzMgwlDSM2QG0rtgJV3wgocFi2y7labto7PdNBi9UlF9GY17s6LU1RK1oD9VwDs06fG1gXKqQ==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr2881297pja.66.1605083788967; 
 Wed, 11 Nov 2020 00:36:28 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:47ee:2018:3e3c:f9be?
 ([2601:647:4802:9070:47ee:2018:3e3c:f9be])
 by smtp.gmail.com with ESMTPSA id j13sm1654647pfd.97.2020.11.11.00.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2020 00:36:28 -0800 (PST)
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
To: Christoph Hellwig <hch@lst.de>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
 <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
 <20201111081530.GB23062@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
Date: Wed, 11 Nov 2020 00:36:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111081530.GB23062@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_033630_661529_A09D0A76 
X-CRM114-Status: GOOD (  13.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, javier@javigon.com,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>>>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>>    		set_disk_ro(disk, true);
>>>
>>> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>>> is later cleared, nothing clears the disk's read-only setting.
>>
>> Yea, that is true also for the non-force case, but before it broke
>> BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
>> well I think...
> 
> Let me prioritize the hard r/o setting.  mkp actually has an older patch
> that did just that which I'll resurrect.

Sounds good.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
