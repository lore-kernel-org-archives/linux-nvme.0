Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B6AC52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fQoIXFejIk+HTZolIB39e5fTCBygcLZpzBojTUm7LM=; b=GSxOYnSpWOUBK0h2rmH6HDSpR3
	RvShLN0pDjN6SOU8ZIXhf3R/GKiYqAqXAWipxDlGppZmFlnnPRD0ni1wVKPh6N2/iftsNRtrRDgHO
	YbA5XuvlWm6hlTD5iajV/Jy7HDSwYgyqyrk9W0r1K/ITsHZpkCU9UZeShEicQaJPKSN3nS47GDPWM
	LH4w4oCGC0SsU/s9DFzwEmEc+Cc+yr8L88FPsJlQMr9sntSc9QTuaZ1LgWomIVlX43z+jMPmIBx6R
	zIl2sH0ZgiC8pTXrYUvoPZ0QSjDMmZnM0CKQJLZnR/jrP55ym/sPr7Vw3/w1obxfjWf1R9danKYHn
	o1ai0grg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxDR-00000004l4f-2tbA;
	Tue, 13 Aug 2024 19:29:57 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxDP-00000004l2g-0c5Q
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 19:29:56 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36874d7f70bso754971f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Aug 2024 12:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577393; x=1724182193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fQoIXFejIk+HTZolIB39e5fTCBygcLZpzBojTUm7LM=;
        b=AkKns0Mzc5bDD7vQm9U01WqqffaIV0eaSX4/RCLSAQakq7vIOcjR7wy12kUexkpjIk
         1GBDk/xqO8rKnkxkfc73vpufZluT3r8WJ/LyQDpkxgB60sANYwf6xVXGN0gvXQcUuRs3
         anOhogISHfaaGyzQFxJvcXxMs2EsBYlXXqePPO5OeCv1eItTY7ZTTJfZ/BKiHZbJK/rJ
         o3rkoXhcLkU2VSC5xVgcllNl0pYbSb9nMbJPVA3SxFu/beujEb2KjMdn9M9j6ZeX0eSD
         U//UEIFuvH+IiDODyagGTFRoXZQiUcwFkrvY4KWnkdm6f7N9Yal3uKXbPeHZOf/Egtau
         u/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0vKxPkXLeuvKybOg0y/exdTNyESPymMjj8n5EclnSD0NxYj0mj1heoTfKjVDy8+DnnMAmXuXEjOmS@lists.infradead.org
X-Gm-Message-State: AOJu0YwCkT90yQKIV+TWcMypqeCWf9OtpTszAM6jBCAtKZZ2zUe3qKoF
	5fkAOxGaerReJ4i7So7s0AGhW7yOGpCDrATb33iHwhSxLbn5I6/4
X-Google-Smtp-Source: AGHT+IHoVKlf+CBAXnYqpUcK9s7kbHsvLzFQdcrwliQQpEptpmKdEaxjbqe4VAVnOknMl0oTY3nqsg==
X-Received: by 2002:a05:600c:3b11:b0:427:f1a9:cb06 with SMTP id 5b1f17b1804b1-429dd2a0f39mr2063545e9.0.1723577392439;
        Tue, 13 Aug 2024 12:29:52 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm155253095e9.29.2024.08.13.12.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:29:52 -0700 (PDT)
Message-ID: <dfaa3f8a-4328-477e-ab52-7ffc702ffa03@grimberg.me>
Date: Tue, 13 Aug 2024 22:29:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-4-hare@kernel.org> <ZqeqqK3XBk_eoyZb@kbusch-mbp>
 <9192ada0-0be6-4fad-8d2d-a26bebe934be@grimberg.me>
 <659e9317-9f68-4264-b976-f8f13184c4da@suse.de>
 <e9d1d499-8491-4883-bdf5-01aa28e42c7c@suse.de> <ZronlWGQ81fa6XSx@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZronlWGQ81fa6XSx@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_122955_220237_5C3D42AF 
X-CRM114-Status: GOOD (  12.76  )
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




On 12/08/2024 18:17, Keith Busch wrote:
> On Mon, Aug 12, 2024 at 04:09:01PM +0200, Hannes Reinecke wrote:
>> Should be fixed with:
>>
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index a3caef75aa0a..883aaab2d83e 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -109,6 +109,7 @@ config NVME_HOST_AUTH
>>          bool "NVMe over Fabrics In-Band Authentication in host side"
>>          depends on NVME_CORE
>>          select NVME_AUTH
>> +       select NVME_KEYRING if NVME_TCP_TLS
>>          help
>>            This provides support for NVMe over Fabrics In-Band Authentication
>> in
>>            host side.
>>
>> Will send an updated series.
> If this is the only change you have, no need to resend. Looks good on my
> end, I've pushed this out to the nvme tree a few minutes ago.

Nice.

