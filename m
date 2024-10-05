Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D740ECFB43F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UmK9Xs58S08yxjMtYHm+HrNkToU7fdzXxnd+5Lv0Xns=; b=F57ORUaaOVYAaLIIq0EwpsVi8K
	0tnJVHCcAImTR9u0r09GlyXFoof/s+ESE42OFnIThw9HmMHNDyDWG8YSTJqCPDiKTupMTvch/AJjt
	NnhuDezjy6dTIbia5rvPi51d755BMLN/bSL1npmRLE1Eo2VbHl9xlcGGVvsYGineO5mTUv0x7vLwQ
	SPm6y/r+pQFpFhypWrGGF62jQOCy/tVqxaUwK6GNyQT/DHQeta8y7aIvu0m/nlwGT7zmZv79hFaWy
	xWznMA8SoeLXHiDXsOJSA2woXj8neYKqevw/hF4TpTny2GIElnwfQSiLn00ehz1CACvtcOSA/P7Rh
	7tgrOU3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCb8-0000000G0rA-09ec;
	Sat, 05 Oct 2024 21:45:58 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxCaz-0000000G0qn-2A6w
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 21:45:51 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2666554a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 05 Oct 2024 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728164748; x=1728769548; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmK9Xs58S08yxjMtYHm+HrNkToU7fdzXxnd+5Lv0Xns=;
        b=p+0hAhAlKqVcMLi4QBNiH4R/UiE7+JTRpnAHdfokqB9HxetSe0toG7ny8gbkuHZHQ1
         Y8WB10LtXV8FTswnSf11aX5LOae19aP5D75gifeCXlF9pPnB4gptTPFNU3DzTo6EQcP1
         rWmzm6MEZ4YbiBdsIBiPg3IbCKNcifhccAv9ui/cW3Skw2U8+fh2dvkEQr5s8lPerYJu
         LRXjmVEg+6sCNhTGl6/eTitbhVZPpBK/r6vgEthoN/LfDDDGtri2Jb8v7iOASXrv3OAE
         qZlytXaFjRa93m84ntGxvsCl+T/Ohz5r6+I8Ig0wpNlq95FgGmIrK5oRkGD/3kEf1Vvn
         9Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728164748; x=1728769548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmK9Xs58S08yxjMtYHm+HrNkToU7fdzXxnd+5Lv0Xns=;
        b=Rjp1Cpo/MoO4xjihmd6VsTzCzPO/IOe/ndbElbw/eHRZV0U5QvUm01Sq7XvXQ1yCaa
         jOUUXEWaVSSpKoVVXrAyEz6tMd1XeXpayAzqfZ6nEUdjpMAh02jTgJtWq84V2s8llPej
         4tguB4RXiqMmDKPtnrqRc3CVTZMwoUvGM+NlYSHUpXRrZn00mTYf4w600hb3ApIf+fLw
         ja7eqpJXiTEZUrc0BjZnIaK6rH9WfjhUajznBHtNswyreWy82etYHdpYTpJ0bZfhMHu3
         4OJ5vYNiCuGgJGjfSGGalgabMTGMBKc2eEjCCxKIx3grtISu2Dtdc9QNy/UwaO4NSFKf
         jiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVb116ZqKKevrU1UOeCo4QOtMXzidXNyM60gSuwvkfkMIHqmmp9/KAf7FLNVyxhOSUrEvLrLETTiIFQ@lists.infradead.org
X-Gm-Message-State: AOJu0YwtmvmK/jilV87N438/pItHJwjsiuk1QktaVWaZoSRslO+Rge91
	ZAi1hsAb1Ts5KnkzxU9p1A3T5AQ1zCF986V+SxCUMWGGXsubFIjmX2KlxN814GI=
X-Google-Smtp-Source: AGHT+IF2CIeoWIaR7M9L7MG4cg5BH98dJB3GOpxAS+7PQNC9MiHoMI9+gMzk9ipUOljcrFRhvDz1NQ==
X-Received: by 2002:a05:6a20:2d22:b0:1d2:e504:52ba with SMTP id adf61e73a8af0-1d6dfabb7ebmr11814308637.38.1728164748471;
        Sat, 05 Oct 2024 14:45:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d69246sm1882056b3a.182.2024.10.05.14.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 14:45:47 -0700 (PDT)
Message-ID: <dd003ffd-c63a-496a-8585-52fbb08c2189@kernel.dk>
Date: Sat, 5 Oct 2024 15:45:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
 <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
 <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_144549_858617_9B0C09B7 
X-CRM114-Status: GOOD (  10.73  )
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

On 10/5/24 3:36 PM, Bart Van Assche wrote:
> On 10/4/24 6:41 PM, Jens Axboe wrote:
>> That seems over-engineered. Seems to me that either these things should
>> share a slab cache (why do they need one each, if they are the same
>> sized object?!).
> 
> The size of two of the three slab caches is variable.
> 
>> And if they really do need one, surely something ala:
>>
>> static atomic_long_t slab_index;
>>
>> sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));
>>
>> would be all you need.
> 
> A 32-bit counter wraps around after about 4 billion iterations, isn't
> it?

I did use an atomic_long_t, just forgot to use that for the pseudo
code inc and return. Though I highly doubt it matters in practice...

-- 
Jens Axboe


