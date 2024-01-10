Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3703EC4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dj+sj/oKRc7hT1H8t/r2ivhN2ji2w5hSbMTw3TnFD0w=; b=owr1b03fRnsQ4j+Fi9E2hPcNyC
	yIW3dI5+DuE5HHLrXilDKN5q33PI4lrW7vLX+i/M9HbSeiFFCs2StWo6r+R1NPnDKpeYDL9Z5K14p
	NHZ2yJ/N2U2qm2HmVN2VlTJy9BPQWW7v8aGeGucMlK8pkE48fELaBXP86oZ/BO8KIP/QA8N00J10e
	A5FiAZ6w2+r/+FKCCBFSMurxtH4cv/n0c9VVRdlUvN9T0jmznFFYcNF+2gk2LRpwz1S2Iwf4mlWtE
	rT+zs9tR1P3uNeXG0DCNQBANPdB0hawZJG4mtLB3d5firKENpUbowyIoWsUF+o1Q7AvK9079Ai0gC
	7Wp0uewQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNa3c-00CT6W-1L;
	Wed, 10 Jan 2024 14:59:52 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNa3Z-00CT5X-0s
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 14:59:51 +0000
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3607c86896eso2613535ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704898787; x=1705503587; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+sj/oKRc7hT1H8t/r2ivhN2ji2w5hSbMTw3TnFD0w=;
        b=nFBIz54NYbu55PBSf360SJJ2YpgrA0UcmfJcSuDqKInH6LVbGVb+R3DrEiTF7YMfun
         POyLVezOoUom8pKocLB4HI7FkLu3VaF/8Td9OaKasqJ05cKJ/vns06oruNnNGjwehFb9
         orMzO+ws8GKzEaNMkm1wTNvQ6vv0X/cX1nLXKmjrDDS/U4yzN/cSQYUFN0hDG7SLN3QS
         DXYjepynreu2Bm+9pnYlGNcl+SRZK4DLftaN2qhyNQe/GwQhH57JtunkZsX3iTiT791F
         b1Wp+FA+30jPHPAIi2SVjZORSYoAupagwFDKlyUABnNLWyeJAF0owd/JIrpB1RAz/fT4
         2ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898787; x=1705503587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+sj/oKRc7hT1H8t/r2ivhN2ji2w5hSbMTw3TnFD0w=;
        b=jMmHfAt5WbAL3zkVFoei+2EHHEDKtuIEHkY/3NOWI5R8rqxLEHR9SyHuPFghIq2PWi
         KEqqf9RMJOS12mGi5PLAUa+JPEfM5/gdGRg2Xp3JDTkOHL/XjRGtidaLbuko55RapHou
         My5D1iaCprXUOFPZPw8othgyWOLGRtjtJJBAeRiRz6lNewdgjs/ge659B4Vkv4eP4Xfl
         TNjknmtx6GWScONFnORPS+U65IMDY2fsYYkF/kohAJ+D2TPieIdmVnivY+VopTA0jJ+E
         Gt7fXnES74CPrUIbPJ5nDH/uaZHN59gO/vg7pPkQaOjmL+9T/yI1Iff6/gXT8qpvke0C
         uO3w==
X-Gm-Message-State: AOJu0YzcdwM1eUXemIbBp55wRkerlrsPGNoZ3+A0CzKDP92Cdf1p/L8n
	B/LKa0MVmZSZFGGX+AJLmE7PLhdymjG4zw==
X-Google-Smtp-Source: AGHT+IGgvvy0Axb70/0h2CEq+xODe3ibT4d/qp8S5Q8rds9/724CAIOhf0wBwZfr26iD/nkzprOUow==
X-Received: by 2002:a05:6e02:1d94:b0:360:64ad:cf39 with SMTP id h20-20020a056e021d9400b0036064adcf39mr2758665ila.2.1704898787398;
        Wed, 10 Jan 2024 06:59:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a922c02000000b0036007e0eabcsm1249415ile.78.2024.01.10.06.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 06:59:46 -0800 (PST)
Message-ID: <d921a213-df5d-45dd-bc37-99f3034a1a03@kernel.dk>
Date: Wed, 10 Jan 2024 07:59:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_065949_501632_B4377581 
X-CRM114-Status: GOOD (  12.26  )
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

On 1/10/24 1:12 AM, Chaitanya Kulkarni wrote:
> 
>>>>
>>>> Should this be TEST_DEV instead ?
>>>
>>> why ?
>>>
>> My understanding of blktests is, add device which we want to test in
>> config files under TEST_DEV (except null-blk and nvme-fabrics loopback
>> devices, which are usually populated inside the tests).
>> In this case, if someone do not want to disturb nvme0n1 device,
>> this test doesn't allow it.
>>
>> Regards,
>> Nitesh Shetty
>>
> 
> it is clearly stated in the documentation that blktests are destructive
> to the entire system and including any devices you have, if your
> system has sensitive data then _don't run these tests_ simple, when
> you are running blktests you are bound to disturb system you can't
> prevent that by using TEST_DEV.

It should very much be possible to run blktests on specific devices
ONLY, the intent of a test suite is not to potentially mess up
everything around you. It should ONLY operate on the devices given, not
poke at random devices in the system.

-- 
Jens Axboe


