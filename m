Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5213CC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S0LWMSW91BKmYTBJ9lfdYwXbefS1vXRlwARwbeGG/2I=; b=g72rM+HOykUxevWJ6Qm79EYyen
	fP8Yon/1Rkx9M6tbPJObN+7spToi8LUcrEpqs8YkYObDG3mwR5reVFV9ysKSMqYT/75YYh7JeN3V9
	KAM1+VxkHlUjBYq/PpkHG8gs6gPCzrlNUpt3X1w74G8L8GzyeQCKlkyyhfiZPtlkeO4sk9+lefEBv
	iHZRpo0AaAOXgZewe1ou6jbV6fSAeX4C6g7i6YBGePdkJ5RTJJ+Ua3qz35ewBvGc2Y1Wmps/hz3Vg
	tD1b3qfAvwg3N41ScSDp7UtVXUxfg0TqKZJKVdsreaNbMfgw5y3ZmMSsr6+iyMfvU3f5WTapcihLo
	s3CcA9gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBHW-008bi6-0j;
	Wed, 17 May 2023 07:09:06 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzBHT-008bfD-0u
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 07:09:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f42379d553so956495e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 00:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307338; x=1686899338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0LWMSW91BKmYTBJ9lfdYwXbefS1vXRlwARwbeGG/2I=;
        b=KixYHSQZPQRxF3PjmSmm1jl4Tu1UL54zDZAALZ14km+7PdSsu3zXoLL+Bi59qwAR5D
         laPQe6Xw5/qAhmE70H1iLAMRJeIR1yvQiGF5HFHLUX28+5/BjXKXTchvGV5wRx6u0sdI
         5GXkWpElrXxWlP/IuvvMqCz/R9eI4fctcC7ERwjmFNyBYPZohptRTPm2tN2wPYD27tmI
         n1qyzcdjpxBlC2IXhU49JMYGuet/SzMwK86fr8EkvMKvo4OflyZHHbLzMesmZEGPoOzq
         7saBDO/v3tzifOVEmbE9zBAsOvwwG0yPG3WBsuwMDnziu7KDCS3R4GoYDhibEAFqwa54
         a87Q==
X-Gm-Message-State: AC+VfDypZsThWy+drgkWFkVh/8iF6I09o6cLgyeh9wPjv2ZAEj04ByGr
	prAIebr3I/0UPDDSpydG3FKtnLnV0UE=
X-Google-Smtp-Source: ACHHUZ5E+RAjJIsHG7d8j7XnYxQcGxXN43zLZvhYmZ36qpJBr6j0yZIjMqSC0aUfmNnTpSC4WHLF3w==
X-Received: by 2002:a05:600c:4455:b0:3f4:f66f:c10d with SMTP id v21-20020a05600c445500b003f4f66fc10dmr1321039wmn.3.1684307338029;
        Wed, 17 May 2023 00:08:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003f4e4f51f64sm1231796wmi.7.2023.05.17.00.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:08:57 -0700 (PDT)
Message-ID: <31fb7aa0-79bb-8a42-b606-722154bca94d@grimberg.me>
Date: Wed, 17 May 2023 10:08:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Irvin Cote <irvincoteg@gmail.com>
References: <20230503150925.863308-1-sagi@grimberg.me>
 <20230512150709.GC6005@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230512150709.GC6005@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_000903_319446_84A3F43A 
X-CRM114-Status: GOOD (  18.49  )
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


>> -	if (!ctrl->discard_page) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>> +	if (!ctrl->discard_page)
>> +		return -ENOMEM;
> 
> Can we please pre-load these cleanups in a separate patch?

OK.

>> -out:
>> -	if (ctrl->discard_page)
>> -		__free_page(ctrl->discard_page);
>> +	ctrl->instance = NVME_CTRL_INSTANCE_UNINITIALIZED;
>> +	/* pairs with device_initialize .release method will cleanup */
>> +	nvme_put_ctrl(ctrl);
> 
> Err, no.  We should not go through .release with a partial
> initialization.

But that is already the case, even if nvme_init_ctrl completes,
it can subsequently fail in nvme_init_ctrl_finish() and the
drivers already simply release the final reference on the
device and go through .release on a partly initialized dev.

> Please do proper unwinding before the device
> is added, and make sure everything is in a proper state by the
> time ->release can be called.

I don't see how that is possible.

The reason the .release is used in the patch is because device_add
allocates internal resources that are freed when it is released
(see device_private_init called, which is exactly the memleak
addressed in this patch).

So we can't know from nvme what to unwind. The only alternative
I see is to move device_private_init() from device_add to
device_initialize() and introduce device_uninitialize() to
unwind.

