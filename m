Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:44:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED7264F41
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7264F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9PmQcpJM5/t8ns3WI0V/SPigX2nfq3wdtsIGkJHyOM0=; b=LbWb2gCXIEYKg1Ma/UqBf9S4D
	jXS2sWYfr4O3L36s5LTRQRYhpp/IlkRAG0lUUlblv+p1kZE9GDl6Fvbihdq2KdJnQ4sPe4Cv38759
	hrIUMEUrLlTFhp8u2v+Z5naKtX6kCKONUP58T/0WWvFPlOQ+Q/x4DQPZ/neGEMBPC101z3jeZ+pcs
	KoPxOD/dRb86idRtkSeNVf8dv2BEuYtwRpQz3DW9M+VX5dBRwsLJMlGlfJErlV6jQ9OVQO72WNcbJ
	2cH0bZil+TKWe3yOcU7AEgXxrR64l6576j59Im+OyALKdyC1UK8lyRV9S4rNSQ0QNgQgg/Dm8p3Wb
	rF29iLiAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ZJP-0007uZ-FK; Thu, 04 Feb 2021 07:44:23 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ZJN-0007u9-Qd
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:44:22 +0000
Received: by mail-pf1-f180.google.com with SMTP id x23so79406pfn.6
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 23:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TUBT+WcoMr9SHftwkIAqoW42cTywPlqgj+N5HUNuQks=;
 b=OPal3tJxUsiYwYQ/sFgz22BDr9oj7/n/PzjnYA7AqMxZ7sjpw7z1NLc0DKieiNQqQK
 xjjMnbMmdQtAuBTL14wiqKWvEFQjBMHhaB4jHeAH0u54thvCcmngHLCHltWnB2VD6c6q
 2PnqmBVRyX+r78lg5aa3yEVH4lTwJwirbbpXuH7iqaZrtEOSQJjJ/V6DNwyl1XArb4oG
 ZW8q8ukjjJebCXnjhOvnhtaEKQHEqGDX7ibJOTC3eoyqB3UAydPVlJc9YzY9E2qGaaMD
 tGxtuZP7/B11PKJXnOPXT+ShWqopfFe6I4tjgRk3Do6JY09nOJ51xCzsB0Daw7eF7en5
 XDxA==
X-Gm-Message-State: AOAM532dH0xWZ2boRkQ5wkn+SZ6SQzjreMK2SWg6P0Zj1rN9R5TDUWtR
 FNlen3o/EqNtI01urDrI20c=
X-Google-Smtp-Source: ABdhPJw1dsPALg8rSlnr3SO9OhkLv7qstBZmBTphLm8mPn/6ksFqS+5apFy/JH12jiQfD82Xu5nhmw==
X-Received: by 2002:a63:f21:: with SMTP id e33mr7779800pgl.84.1612424660226;
 Wed, 03 Feb 2021 23:44:20 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:9e2b:41e5:65d1:d6f2?
 ([2601:647:4802:9070:9e2b:41e5:65d1:d6f2])
 by smtp.gmail.com with ESMTPSA id b62sm4825802pfg.58.2021.02.03.23.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 23:44:19 -0800 (PST)
Subject: Re: [PATCH v2] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
To: Keith Busch <kbusch@kernel.org>
References: <20210202005951.26614-1-mwilck@suse.com>
 <20210202075828.GA12160@lst.de>
 <a7f3114e22a07e60abfd98155df91dea3a83b386.camel@suse.com>
 <20210203165203.GA2182779@dhcp-10-100-145-180.wdc.com>
 <8b1fc5ef-4c6b-4fa3-7cb1-b42ed71e7413@grimberg.me>
 <20210204024220.GE2182779@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82855b31-6698-6991-35b0-d0496b3de70d@grimberg.me>
Date: Wed, 3 Feb 2021 23:44:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204024220.GE2182779@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_024421_886618_BB690F41 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> I think Christoph is suggesting just wait until we have all the
>>> properties the driver exports rather than specifically exporting only
>>> during a 'live' state. Something like this (untested) should do the
>>> trick:
>>>
>>> ---
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 1a3cdc6b1036..4c0258d7eb91 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3069,6 +3069,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>>>    		if (ret)
>>>    			goto out_free;
>>> +		ret = cdev_device_add(&ctrl->cdev, ctrl->device);
>>> +		if (ret)
>>> +			goto out_free;
>>
>> This happens on every reset, we should probably just do this once?
> 
> Right, and while the function is invoked on each reset, the above code
> sequence happens only once. You can't immediately tell from looking at
> the diff, but it's in the 'if (!ctrl->identified)' code block.

Yea, you're right...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
