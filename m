Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC46C25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ri8Hih/g0N1z7TAjVx4AbJ27UV4uJ+etMnMuQG9+gbw=; b=ogeMqM0KsO25scTdHYR0WU/Fz4
	0zeQDglvfdv0Rx5I0BuYr9Gu+g3CooicuOtul1VaIj/l6FuL8xAUlOq3cRgyEl50SoJhBgC+bMeGC
	yC1RntD6jTH5NTp50mfPBBBkUE2QpWpTyva3JiXJqyApHrTDbofkfhC7kvFsc5cnvZs8FzE+XZjVZ
	RNsQTjLLjaWTrg2FDa8DnoNwzLRS+Lee3VwCDstWubHKlQD+m+ODm+UBp+pqCy/3h6njOBTQ9QFSR
	uhzL0zsKvZANxHPrDCjbS7DGjPXoCwQ1VmSFI0Y74sBDMVNytuT83dTHLlcCFGBbqKKQs9ue+A1PU
	3UTUgX8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOL97-003MxW-0V; Wed, 17 Aug 2022 15:39:53 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOL93-003Muz-6h
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 15:39:50 +0000
Received: by mail-wm1-f53.google.com with SMTP id j26so4623114wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 08:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ri8Hih/g0N1z7TAjVx4AbJ27UV4uJ+etMnMuQG9+gbw=;
        b=W0W6z0ZGBBUHgPqKT8qITGUS/zjfKUXvOHtFzOTMQPGtuxCwz4HNdm32Dv+nTzWR6f
         RpEKRrTLMYPvH2t95BjCIFkgW4TS0iozbcjx321g0Ea+DPWOS85PXFmU5P9iWqKXtJIP
         gCAp+YpdsOduT4LKba/RaEL5JxrETSTs/knOMAVqZiGQekO4v617LrQn1AccOGJ3kmCA
         l4wdKZOgx3NBqxLx2vRUkpwGK3NDDabqoxxUz36pvl9UnQYSE/o+m78tcqXAA/xjfaDe
         rTJfCO6w4tKxCId96yIUZN9A/NxDnqu16KOwOL7m2m8dinneyT8BYhkC7L8/zKySFj7g
         GfKg==
X-Gm-Message-State: ACgBeo2HWdHNnXWOT+7JYEhRIwu0P0u8NgODd31kd06Wx8Aht8iFGMkI
	5Z6RCcnSAvH2x5p1/SmeP+Y=
X-Google-Smtp-Source: AA6agR6rnwR4y6N/C94dmp3HIitjKTgExAKmXLGJQBigrdxdXIqnQkmAeBOLKX13x08wwGAIWnIzWQ==
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr2585434wml.51.1660750786516;
        Wed, 17 Aug 2022 08:39:46 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id z17-20020a056000111100b0021e4829d359sm1872237wrw.39.2022.08.17.08.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:39:45 -0700 (PDT)
Message-ID: <07488a82-10aa-2d06-f7e9-fab7bcaf5e8e@grimberg.me>
Date: Wed, 17 Aug 2022 18:39:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@fb.com>,
 linux-nvme@lists.infradead.org, hch@lst.de,
 Jonathan Derrick <Jonathan.Derrick@solidigm.com>
References: <20220812182147.1564958-1-kbusch@fb.com>
 <e034ba1d-b43e-6813-37b8-7b341dbdb573@huawei.com>
 <35b13f23-25fd-cff6-1e79-7f8d5ef3790f@grimberg.me>
 <Yv0ETKzC9QUDUvKI@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yv0ETKzC9QUDUvKI@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_083949_367297_C7F8CD36 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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


>>>> +    /*
>>>> +     * Ensure the namespace inventory is up-to-date before returning if
>>>> +     * this command can change it.
>>>> +     */
>>>> +    if (ret >= 0 && effects & (NVME_CMD_EFFECTS_NIC |
>>>> NVME_CMD_EFFECTS_NCC))
>>>> +        flush_work(&ctrl->scan_work);
>>> Maybe it is better to move nvme_queue_scan together here.
>>
>> I agree, why not move the scan here as well?
> 
> Then I'd need to duplicate this to nvmet_passthru_execute_cmd_work(), and I
> didn't want to do that. :)

Got it,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

