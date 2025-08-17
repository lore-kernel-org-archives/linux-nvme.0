Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80715CA0EDC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=; b=F6RWMtA3T/WwkUKNHFu2ekPlCQ
	zA/rCBTF3NL+0T4fRx+dStG8u01vY+hXAZEXsk99MbhEM0hFGdImVFgdxAwQjtbvvD2CEc09EMGim
	Eur48p+78o4R+Y+xNRauVhxlncH+7TQcILnKW3WawTVGzjklDNwuy+/b8Kze0etNIWBVdcAZ0503E
	TRTexrwxMr7mPlp6DhI/5j7UZBVOS1o+H8gXEPFgZsJAHWs+r/MjsvCHfDtjYWoDekee9enYIQ3le
	3UDhDEaMfmWaF0MAMzbkkEy3eTmVHyHsXRizzvYO3xJI6GIohDLumrIpM6s72VG7fKul+fYGY7t4d
	bpU10ICA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ungQA-00000005rAA-0Fc9;
	Sun, 17 Aug 2025 16:39:50 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ungNV-00000005quh-0aDl;
	Sun, 17 Aug 2025 16:37:06 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-24457f43981so21643085ad.0;
        Sun, 17 Aug 2025 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755448624; x=1756053424; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=j+XyuC+Y4FMIV93R6QRFSVPUpAZw+QcUEObsfnp+y7uhxjdB3Fq7i91912FGYj4RL4
         KqkrghaqFfXzfZQmK0hFLRe/jIrHu+Kk43HL66qslpHIrK50i7SSBh3Y644qmOxS+0W4
         C68hs51KeUI8dNlEh28hOAP28eop3BfpC4/rlh8N92dVo/PNi3uuCooblkGEMzHfzec7
         w/72Qw8CCwkuBYrge1YmBY9Vi8zz66iOezNt0Fqhh2uaFWyI8C7d88p2me/aPrADKiXk
         sX4lEnC5WFp+82BZ9AfpmPtCQajEasPDt+cMXVgJQ+UuJOq1Lm+MNCO0MmTePsZ/gbZB
         dICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755448624; x=1756053424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu8NtR3SA6w/CY24HT9I4ClMud60N/2LWQULRPh/3no=;
        b=klk9OEj8bHv2EpS9ZRQx1amvDfsaODGecjgHOSE/Kedx1Sdw4TX00OEtY0OuTwaRrC
         rDmNe1cUkLark8B1JTT6BP6/DCh/h5EPwVEFt6OQgLwgKU756uq3FG4eLdHMNGg0z+gR
         +hfgKgijWmi3FOPU+YHm4I8OV6yPRhsK0BKssEIgEDeTCu5crQJH5ZSjlTtAh9NFY1Pw
         QtE/sGaXV6v871iFq6s7B9pYu6WH8NjRVVUnaZL3nncJRJNWVLOWnNnc2sUy8+YhkSmA
         dLYpvlsyPKYbV5DRfH9kg/+6ev4JFW+vPtqfC4zG5d8+OoIytP9NfF36hl5ImUzcaB/J
         3ZDA==
X-Forwarded-Encrypted: i=1; AJvYcCVma3u9EJgD8qfgJTW6gtwlDu5OFIGsESemzy1jWV/DeQ1tgYaq9oy3wko38GI+O6N1N33A9MsNnmIw9QDDJzOh@lists.infradead.org, AJvYcCW0uFftv6Gr4tCk0JNx2IZHvKZB5bxG1Jiv0hFhk0xTyW7mGXcqWLR7juKQR3BwrOLbq7/NBt5Ya2r7ag==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEn8hzfoJfheWGGeTXuk/mM0pIYWPt3Om0RNMY8JXeqd3mxnTa
	sOjbRLL5a/pNlPbGTm8JiYjNN3Ut1MX8stzoOJeWYm26bgLH3b8F2FxV
X-Gm-Gg: ASbGncu1nJNhb+5pbkyWRkEGT+UMvhBEN9m/wj3tljcjUcFC0uonUa2Uzqjz/iA4dVx
	klpCYuhIWXjuKTCOEpb7FAQJdK2Z1wJ83t19x15Jym545pkJ41iqigVnqAlg89GhSPwXCA5igLr
	fxAkggiUi9TThwA9omVdJeVYre5mkVEv4iQUeYbDJo7wpV+ny8t3GW7+Ipa+PLS08Ujj8xo+XdK
	evlyeWz8EGSSlm8b7yV22YSFz8nA1pq9dDh17fsUw6BoNrwcigDGmGrzy4U8sapTqUoujf6rqrF
	OsU/lyk/qwk2/wx62SrQilD0Tk+tpmk0i7pjQk3bXUfVpWWxDIczV/dSrKi6MS1PFptN55C1Cw0
	ltAGGxWEBzjy4/QzGVZRHyxwnTNPvo+8X2WcaqT05Uq9oKMrpYh3Y
X-Google-Smtp-Source: AGHT+IFolnCZsYxa8DXtlqeL7svE1Vm9qN7zDI4nNsqND3PhWkhOt0P90tLwWgS8I5+brb7rz1uJHw==
X-Received: by 2002:a17:902:fc4e:b0:23f:f074:415e with SMTP id d9443c01a7336-24478e3f823mr71496235ad.14.1755448623914;
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323632812b3sm1612946a91.13.2025.08.17.09.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:37:03 -0700 (PDT)
Message-ID: <e67860f1-bec4-4a55-91e8-61ade069f0a5@gmail.com>
Date: Mon, 18 Aug 2025 00:36:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme: apple: Add Apple A11 support
To: Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Jens Axboe <axboe@kernel.dk>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
 <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250817_093705_186372_9168A118 
X-CRM114-Status: GOOD (  17.79  )
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



On 17/8/2025 18:47, Sven Peter wrote:
> On 11.08.25 15:50, Nick Chan wrote:
>> Add support for ANS2 NVMe on Apple A11 SoC.
>>
>> This version of ANS2 is less quirky than the one in M1, and does not have
>> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
>> SQE.
>>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>   drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------
> 
> [...]
> 
>>   }
>>   
>>   static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
>> @@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
>>   				  struct nvme_command *cmd)
>>   {
> 
> Please just create a separate submit function here.
> There's just not much code that's shared between the two variants.
Will do in v2.

> 
> [...]
> 
>>   }
>>   
>> @@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>>   {
>>   	struct apple_nvme *anv = queue_to_apple_nvme(q);
>>   	struct nvme_completion *cqe = &q->cqes[idx];
>> -	__u16 command_id = READ_ONCE(cqe->command_id);
>>   	struct request *req;
>>   
>> -	apple_nvmmu_inval(q, command_id);
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		cqe->command_id--;
>> +
>> +	__u16 command_id = READ_ONCE(cqe->command_id);
>> +
>> +	if (anv->hw->has_lsq_nvmmu)
>> +		apple_nvmmu_inval(q, command_id);
>> +	else
>> +		command_id++;
> 
> This entire block here looks weird. First you decrease the command_id
> directly inside the shared memory structure, then you read it with
> READ_ONCE to a local variable only to increase it again. Why?
Thanks for spotting! Looks like this is merely an artifact of how the code
is hacked to work that slipped under my radar, so I will remove the useless
codes in v2.

> 
> 
> 
> Sven

Nick Chan


