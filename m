Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439ECC77B75
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 06:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TUuOELykJLvoBNlwM1dpgZztQitWxecGEQ9gvFSSQX0=; b=g+d5SrAjki7iCf+FTFVyKvOLG4
	V/qiuhXeFyNQQuODWG2DTi0dNfFd7qCyVSfo6Ns4e5sW65VlAmwVOvn80aG1mZnD2xPWqlXKeboPP
	Yd232xnsks4HJwJg1jMxx7s31VSsuMpuuKF4PoodSaTIGlxaahzQpr5M6DD6NFW7cH6T4bn5OMpSs
	GjK5KfTaTwF8355RCBAe8F0IzGXTUcHwTFDkfygq8HKtOcBoBIwi97CpMaPLu3dtNn5jpfyQkwJe9
	GFrh3+RLoF3Q5DpahBlQD7ArxAtTlMVLvmxj1hNnW1tia53HSx5rf4dIp49c5TzFy7Oo6rEO83lR7
	m8hNUKJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0z2T-005VMK-0P;
	Mon, 22 May 2023 06:29:01 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0z2P-005VL0-2a
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 06:28:58 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f5dbdbb477so2629805e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 May 2023 23:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684736933; x=1687328933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUuOELykJLvoBNlwM1dpgZztQitWxecGEQ9gvFSSQX0=;
        b=GzwMoPxS31V6tfJ7jJjFoWnqduNVCozKkvZpBIKDxf66HC7r1bq07Xw8BvBKStl5GA
         Xp1swLS3ILLBqu94r3EI/PxihH8qYZ7htejhqMRjee1gD+OxGM12/nioz4HbYRTE4OuZ
         qybEDDwKu3YXax221kgbaJ+sRVNo63k4rZI9JKeX6RhbQIx2bhWQLOTrZUs57rjE/foh
         +ykeo0Fawox7nOWOwYCOvu1Ri0uUxXl1QEyxlp5cp31TAKz0m4JOi/5uRo6aw4kCJvNv
         EhdlGsbhZ/ssAX/RCPj9DK1KvC0Fr+sL+1uD3PMe6b1ReaNiUqYLqx+uaLf0QaKkThzU
         YbAw==
X-Gm-Message-State: AC+VfDzyp8trjSfdaTdYdMxeLhz0+k4TNJzwkH551zu2dIVEkRamOB+y
	UsTZORyl5OfzHZF7fpH8hzk=
X-Google-Smtp-Source: ACHHUZ5NbZH4gPy+Fm3wW1M9VyouCxu6Cm62SeRRIPtH1cgBTYy47LgjCq0Wb7X50OelURdvWf3g7A==
X-Received: by 2002:a05:600c:3c86:b0:3f5:f543:d81f with SMTP id bg6-20020a05600c3c8600b003f5f543d81fmr4696258wmb.3.1684736933069;
        Sun, 21 May 2023 23:28:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z11-20020adff1cb000000b0030789698eebsm6534335wro.89.2023.05.21.23.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 23:28:52 -0700 (PDT)
Message-ID: <d38f274c-b9f1-29e0-2c70-d5a6049861a9@grimberg.me>
Date: Mon, 22 May 2023 09:28:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: nvme host complete request tracing
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CO1PR19MB488584F51B17C06C58E8E84FEE7E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <9c867339-2c79-ab45-4ff8-cfdfe4af2abc@grimberg.me>
 <4ff73000-e25e-fc9e-708b-f89b6504d0db@nvidia.com>
 <CO1PR19MB4885D8C4834416E820A17E6AEE7C9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <bb0f7100-1875-3416-0534-ff4093dba510@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bb0f7100-1875-3416-0534-ff4093dba510@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230521_232857_860388_C94ECB3B 
X-CRM114-Status: UNSURE (   8.47  )
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


> Sagi,
> 
> On 5/19/2023 2:18 AM, Engel, Amit wrote:
>> Hi,
>>
>> I would go with [2],
>> optionally printing disposition value only when disposition != COMPLETE in the trace_nvme_complete_rq()
>>
>> Thanks,
>> Amit
>> -----Original Message-----
>> From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
>> Sent: Friday, 19 May 2023 12:00
>> To: Sagi Grimberg <sagi@grimberg.me>
>> Cc: linux-nvme@lists.infradead.org; Engel, Amit <Amit.Engel@Dell.com>
>> Subject: Re: nvme host complete request tracing
>>
> 
> Are you okay with this ?

Yes.

