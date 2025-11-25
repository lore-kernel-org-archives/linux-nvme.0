Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B99D0EE13
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 19:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUfqGNY8yNMCOlzV27bzhMu4chO9eJxWxW9kWFtTcZI=; b=AsFcLG3mpEIg//SVWXiDPcNtQI
	92GhKEqWwIXKpWaS9Tzd545de8J+LRULSzbThl45QpEQ0RCWpV3Vru36xke+WNVSA9m+9cuPPmQVQ
	+HLj69M1Ew0QHlyPzddCpsa2pnV6Mr9XU/BwtZeVQwWEdGBySrRmWDZilag7qmoHJKRotFieGWH7D
	mxOi4nP7Glgpz1VAewAht6Gz+uIP2PdroU1pBVgaY7dY8gCriTc2HdmJLAyF0k9lvTKxFzKVBf6GQ
	jrGHYlsJJJYKbZ/PcXzkqO3G1xpF71aKKOVL/Zh5s8I+jvNPG3km3yP0jcHv+OuCa9+JB/RixMq+e
	1RFB8x4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNyZI-0000000Dp4T-1h9R;
	Tue, 25 Nov 2025 19:19:16 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNyZF-0000000Dp3y-2TbO
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 19:19:15 +0000
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-434709e7cc9so27433665ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764098352; x=1764703152; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUfqGNY8yNMCOlzV27bzhMu4chO9eJxWxW9kWFtTcZI=;
        b=06k5oVmPrXForbWC8SRqmHC7GBmLiiy138c3p0gh2VdLQS9Zl6ys/rrTayswYjMzY4
         umv5FEAlSJIjVvLdcGBWf39BDgaPwjOOP2n4ReivJQ6uMEwARtE8FGJsMMZ+J/B46WdY
         7tTqE4vRpq9CHYvopB2sXS14U1tQJWV8hgtTEIAt16GL7iH23luB5TV4gRo1jmZPD40G
         Ch5/RvUlPqIJYiVcJE0f0pxiNPbe4ESIQBBFeO6GVwbORVw5AUJG0ndFpTU4tpLsqIMh
         l1U7G629jUPCISrm9LoVJtcCooulz4FArZCWHOEdeZGifIbfKaP64/pC7DSQdllELKxx
         4dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098352; x=1764703152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUfqGNY8yNMCOlzV27bzhMu4chO9eJxWxW9kWFtTcZI=;
        b=LAzemIWY9dB/SUqQ8XKpKJh6nN05gtOe6aUKVMiOoaFzFkxUczV+c/QnLAzV9GF00Y
         ASiPhUxSCbZt++W6HfcTi9m2NH2vXdx3XlgvriMxhSefqGvJmANQhPMBV2/y9QW+9NcN
         uox6phE/c/H5zafxNYZ4XzzZt4veKnFkgrk6Jr2qIF3aJMxrHiciyX/HszzEuWXMnV3h
         yJo/wAhPJ4pR2IhA1soeq/74yUo5QZB+4fKCQ+WvELNsgwethJxQOzWE86a2wCbnGaOL
         l8WRKsXZ9oI1UgrYzgfCOb8FnIRE7/j5mOWcZ2kH7aOokYZYtPE8qN4iz11J2r5MU7hU
         9rWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGIYeHBoQRX9Y/bfA4gDNf+PrrFRJRUtCJUNPY6ssyVmU69QC7hAMsMIQ/E2nWsKQf9K0ELL79R6co@lists.infradead.org
X-Gm-Message-State: AOJu0YymLjtUxYqF8asvCcLo0ZIcHj49gVwBPUfZCbLvQzlv/soiA4Mu
	j8iIW+QEzJxY2h5qXDU735jXmHDAtASgQg4Xiwnv6FzbeSjLe9U9SLADOMdPZj4qSnI=
X-Gm-Gg: ASbGncsF2gSyY9lUaMjNd5Cs6E2NEdAm666WRNkmjjw2zgW6M2dSZSa/zfaQVsoV3jY
	3Q2BOQFYX+4zXwTB1mJ30Ku67pk3TtJNe9XW9t8I56OeGdwfsY6YHakXYxVejMkWycG9W95Ddfk
	8BQpiieKorrhRdykzpmP4+hyKAtqs1+4XyCkoGTxXbTLHAZhvuW31ntY+gy7bfIZEZeGqCFJ5fE
	h3nsCtHTHPbavf4XGZwoilHaNu0P+CHeCSSh8f9Q8CtF+BL5YTt7Z9Cn3plW6727SoNYt4WANao
	vmThJoxVWKniqfm925O3qMyasmAFKXcBAq5r0iWaPTcvjQMu8giRIc5g1pTqYpaWndsJTxm2uIb
	lq8QY4EroO4IsNQtulDmKaPFtwA+RzWHg9MUrOFjYn5imVzPw0A+tAX7Aa9eJO0rx1xUWNM502E
	RFuY/OZw==
X-Google-Smtp-Source: AGHT+IFQEaswkUqFfWJbDMiqY0I1VozYHdfo1ZahjMrEfHe7a5FmQfgVW6+5KRthy6ytF5ENx/5MzA==
X-Received: by 2002:a05:6e02:330e:b0:434:70cd:e27d with SMTP id e9e14a558f8ab-435b8e6957fmr145921635ab.24.1764098352527;
        Tue, 25 Nov 2025 11:19:12 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48ed9sm7452092173.50.2025.11.25.11.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:19:11 -0800 (PST)
Message-ID: <a192b8dd-6d67-475c-972e-a88d6d8b8e5a@kernel.dk>
Date: Tue, 25 Nov 2025 12:19:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
 chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
 <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
 <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_111913_759743_7A1796F1 
X-CRM114-Status: UNSURE (   7.71  )
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

On 11/25/25 12:09 PM, Chaitanya Kulkarni wrote:
> On 11/25/25 09:38, Jens Axboe wrote:
>> On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
>>> __blkdev_issue_discard() always returns 0, making the error check
>>> in blkdev_issue_discard() dead code.
>> Shouldn't it be a void instead then?
>>
> Yes, we have decided to clean up the callers first [1]. Once they are
> merged safely, after rc1 I'll send a patch [2] to make it void since
> it touches many different subsystems.

OK, that make sense. I'll queue patch 1.

-- 
Jens Axboe


