Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C753ED15DB7
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4G33DRMtPm23BbC189biiKlGJhxd9tSyy0FqMwL+Fc=; b=GyaNMSN/8LaaGVfeYCkEY2l5YV
	aMcirrvCdGe/aM/2ut6Oxuv7TqAUeCn5ZXtfO3LUedDy2ggnV6kCLy5yMaug4yrsiX2sEPIHBcL09
	lrhcpq/qaEgfuMkGpSvZM+lK3Zw9pOqhlY4Tzw4j0NgUsevbmTQUoW4+rwy+m9/o4K3M4k5rRtAUQ
	eFyXP9S8YQQ9OBazoS6DKIDXmb8DXIljR7mnmT1pcJROy59rh0BYt2T1tjlvhPhg3qTBKLScn+tsB
	k142Z8Ka0VX0XhK0WQsmM90pNs7AftNKRGwzprdlGYEDPECBJN9NWJIiu8HCnomIY3+p3FqHzvnkn
	OfzS20Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uxK-00000007ubU-2MKj;
	Mon, 21 Oct 2024 16:08:30 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2usI-00000007ttH-2jLn
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 16:03:19 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-539f1292a9bso5608234e87.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729526596; x=1730131396; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4G33DRMtPm23BbC189biiKlGJhxd9tSyy0FqMwL+Fc=;
        b=UuTRUjS0Xxzc0jCqfiAQd7F+Js/4X4fjiDzUAa/W2xJgAsuLTUDI4zfTJu206E9sUu
         MH4H4Gt+z63Mp21DPbLdvmejeAIN5OsGHkyuTKmFu7uW4C6QV2V2okQcPQpbNTonIXpL
         sjsBi77vN3p7xNZ7QWK1RDrFBsofE1hYj+yf9ibzxoDlx+LQL/jpD519StBb9FHc72qK
         TTOBSEHRR6ZPg38iJ+t8pSYciPgSDoZ76Ekea8JY7vHyXbfKQFQ6fJAseyFOpKmRIuOL
         K2PrzHPfxQZYVgvt6/KulhyrZlSxSoxKaHvlp8Y98QiT+HyrqS39U/q3gtT1ju17A7BS
         xSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526596; x=1730131396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4G33DRMtPm23BbC189biiKlGJhxd9tSyy0FqMwL+Fc=;
        b=BIt/uKM1owqiRqx/WQBZwBoKvvpvl6UeQT/FLT1gCZoocKg/9ST1AZUh8ce/yLSb+C
         mIfodJYNpgcdZMgeNER8RVM0Yikfc8cdQ7Zk8drdnAcv2KgLOWynp1Qg7uKANvW8yQJy
         4Cx1M3Usd8DWsKLMIUbfve9qTVIOdkCb7vD5gGzKmI6Wa2AJ5eqoCaRGwhJQ8Y98jvvc
         43xSZeo4teVFU7YJ8C3I7PZHsCRsdWxbDu4BNFRzssuq5r2uDSPxjw1CQsShawWFvgtP
         Enq6JClxqNTcDaof2JzP0Yain1ztpJ5QOfZCLABuDawfhga/56aXBxYoTqIS65rQ1E+B
         3rJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXchBDWqyj7LkHGNgND1FeoRNhfANJQ/K+sjMo1cXKLFPRDZt/Ix2qLgeoGxia+UBg797Ec1cb/k4r+@lists.infradead.org
X-Gm-Message-State: AOJu0YwuTNV44v4Sotji3sMqKciqjYOkK0PK8FPwrqNAZhe97tNsoRNS
	i1FkTjdlQgk7oNcKXDWjfSeUDY22sRrqpOQysodTLqmpwxD8hUUldhjpNg==
X-Google-Smtp-Source: AGHT+IFoQoQoEaud+eLTStEY9OPyvLF0VdXmN7ecMR/CgXdkr/3qTpxTs+6uQ/4yCk25IMLxxyA4QA==
X-Received: by 2002:a05:6512:2813:b0:533:44e7:1b2a with SMTP id 2adb3069b0e04-53a154b2d95mr5538344e87.40.1729526595551;
        Mon, 21 Oct 2024 09:03:15 -0700 (PDT)
Received: from [192.168.42.158] ([185.69.144.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f580069sm61177885e9.14.2024.10.21.09.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:03:14 -0700 (PDT)
Message-ID: <106bc650-a79f-4408-b096-76d49a495195@gmail.com>
Date: Mon, 21 Oct 2024 17:04:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] nvme: use helpers to access io_uring cmd space
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <c274d35f441c649f0b725c70f681ec63774fce3b.1729265044.git.asml.silence@gmail.com>
 <b82b36c3-5ab5-4e99-941b-b099020d1b36@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b82b36c3-5ab5-4e99-941b-b099020d1b36@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_090318_724225_F04C5774 
X-CRM114-Status: UNSURE (   7.33  )
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

On 10/19/24 01:44, Chaitanya Kulkarni wrote:
> + (linux-nvme)

My bad, lost CC nvme. Thanks for review


> On 10/18/24 09:16, Pavel Begunkov wrote:
>> Command implementations shouldn't be directly looking into io_uring_cmd
>> to carve free space. Use an io_uring helper, which will also do build
>> time size sanitisation.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

