Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E852DECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5tzJ4ReKP6eq04nAKaMHwBadIHLw3GiNm3WEVtoMSZ0=; b=Fr8L5LT/ZuhVYKZ/Yq7CHvZUfr
	Qu/BNx+V2W2tc2PN9qs13goLN9u7+HeqqQSI6gg/qBXZ7em+jardF6PcGV6DGhnXQJk6F7zbI1dSa
	74gkc/R2zCqQ77lzfn/ttzQGqUKOwNlcMpDG8Pm4z/ZQH/hbOQ5m8mkYTG9oFdVcdu1iwmOpJuGfC
	sZI9Cwqe0O1W10+FKTSzQadv8917sNWu280VcFyYMMH4xcfkGY9mqRzKPdEfGXZpkUJCaTkC3Hyc4
	B3Oe6b1DFSpNyGus9BF2NgkBHGgOTdENoVWGIH+XehfD/lNmQ7it59B30LtM5+cmPkNjfo6/5xUPd
	MNEHDj+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvHR-00Edsu-33; Tue, 30 Aug 2022 07:03:25 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvHN-00Edna-CL
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:03:22 +0000
Received: by mail-wm1-f42.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so348177wms.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 00:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5tzJ4ReKP6eq04nAKaMHwBadIHLw3GiNm3WEVtoMSZ0=;
        b=MS+4CZ0147e4oEL9fYYBvTL8+JqTxl3hojcv7KprLalQj5GWqgZm0jZPsP/l0fOkWm
         rUtmLvvsixKPZQjY2Wm3pdUb63Dw63GlQSHpM5AGlcKqkTmL2RAuCyN387z6CCvhAHxZ
         N/PhTe+N3P6+KAnSKoE3/86nZfA4c0WtbqhoTISblJl0WFbqJO+H1IqBm5geYGtixD3U
         1bclsUmWhwa+/AUxq2Cs+Zr1AOFO7vEQDgJ+S+M57c5b/SLCl6xcBbWwSxRctHU/VCFR
         dP5wNhMX3vPsqHq6Q5Skzc8EWO0Amoncdv5MO51KWEuJxiZ9nNTwbRkMJYZ7Pb+ML82M
         5fzQ==
X-Gm-Message-State: ACgBeo0jx/Oz6eR48ct6t69yt+2iK7N4uQyaSB0rZhi5KG+7ipuvx7Lo
	VK8hn6FbFxgkiMkeeEYLIBQ=
X-Google-Smtp-Source: AA6agR6TOJcTkScSSpwucbHnxN6O1zo2OJEaxwN4vPOmcCtgzAI2eltM71YGvqzIceNhoDRsjcLVEA==
X-Received: by 2002:a05:600c:490:b0:3a5:a6aa:bf2f with SMTP id d16-20020a05600c049000b003a5a6aabf2fmr8659701wme.17.1661842996263;
        Tue, 30 Aug 2022 00:03:16 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b0021e5f32ade7sm8632659wrq.68.2022.08.30.00.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:03:15 -0700 (PDT)
Message-ID: <6f605465-95a9-01f2-21a1-a15c37c602da@grimberg.me>
Date: Tue, 30 Aug 2022 10:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Regression] Bug 216400 - Firmware activation starting AEN
 processing prevents further AER commands sent to the NVMe controller.
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Christoph Hellwig <hch@lst.de>, lixingyuan@inspur.com,
 linux-nvme@lists.infradead.org
References: <5e8c01cb-2dc1-e460-6bb2-c9861080154f@leemhuis.info>
 <dfe23fad-671f-f3fc-4a99-52690b2c1bf2@grimberg.me>
 <YwzpZpBgXM/U9GEP@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YwzpZpBgXM/U9GEP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_000321_453480_380049D4 
X-CRM114-Status: GOOD (  20.23  )
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


>> On 8/26/22 15:19, Thorsten Leemhuis wrote:
>>> Hi, this is your Linux kernel regression tracker.
>>>
>>> I noticed a regression report in bugzilla.kernel.org that afaics nobody
>>> acted upon since it was reported. That's why I decided to forward it by
>>> mail to those that afaics should handle this.
>>>
>>> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216400 :
>>>
>>>>    lixingyuan 2022-08-23 01:14:50 UTC
>>>>
>>>> This bug is related to these two commits:
>>>>
>>>> 1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=4c75f877853cfa81b12374a07208e07b077f39b8
>>>>
>>>> These codes will set the controller state to NVME_CTRL_RESETTING while handling the firmware activation staring AEN
>>>>
>>>> 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d
>>>>
>>>> When submitting a new AER command to the controller, this code checks if the controller state is NVME_CTRL_LIVE. This caused the problem. When the firmware activation staring AEN was processed before, the controller state was already set to NVME_CTRL_RESETTING, which resulted in no new AER commands being sent to the controller.
>>
>> I see.
>>
>> I can modify this code to check in the drivers instead of the core.
>>
>> Keith, pci does not risk submitting an async event on a freed admin
>> queue? if not, I can add a proper check there as well...
> 
> I don't think we'd attempt to issue an admin command while the queue is down,
> at least not in pci driver.
> 
> I think it should be sufficient to requeue the ctrl->async_event_work after the
> activation work complete, no?

I don't know, don't have access to hw to test this at the moment...
Care to send a patch?

