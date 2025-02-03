Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9450EC02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=; b=4nnLfrV/n0r3sFdaU1qlrCNCko
	FYSzA+3qSYz2DaCRlnLMBx8rrrlarZ96TN6dMw5KSnWWzTcvI+dB9iGKcWnlCrrmIPCc3Apt94GZC
	iRuGPtGbixi/y20ZApvMsZS5dD9Kg1dJsl+DtJgG8NVMzV7b90c9bNaSnq2bCijQbtAev1gYhAYA8
	zoSmu9RwpEithAMi1BvQ02NMyxGycXduP2ueoyx/LSPQwnwyz/aJCtLzG08sVIg2MQQFyh3ZnZbgS
	3K+Hk05jGitEqGv/gSKxI3+BdKeLdT5dbWVhYLfvB0hLLsePlBaeMO92S6TKDwkngG14okxD70UGV
	LR9ymejQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tey7O-0000000FpEs-3zxS;
	Mon, 03 Feb 2025 15:12:10 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tey7L-0000000FpDs-2NKZ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 15:12:09 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3cffbcd520aso13869095ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738595526; x=1739200326; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=VHiB8aWlbNfWkXqlKVdEUbGSs1glsoC5JU9kAghIkbpY1IEuc7e+AaecLmSs45GOdw
         Ho5T8ULJSc3xDqU+XyIQvz86U9LHNYde8paPlz4uu9mobldllkpPbTw2FE8uxPWpNO6I
         lCVoRP9KJJvN/5TT33oURwaiVv7yrFsKrmyJxhYt7ITeImTViP6nfxSWZzyNZPSPhy/L
         f9XNOqJEBwuLDRX+OGLPHEXuh57kcc62Be1Y4tik7G6DlREhYHj1/PaD/RFtd7Zf8dtd
         s8GYo5aQzzX2J/8e3RolWIZsr2E6lfpdyqDmhmtimBj3p0EpT0/r4wnrZIPGeR605AJa
         5f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595526; x=1739200326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRfpPZzgAZa6Zak9GDas5XD80wl2C6NIA/57szE4cSk=;
        b=ObCQ85eE/harY2AqVxrYIp3eak/z0Mw6opQZmwRaksX8g4CRh0fE8HwxeVboNK0Ik9
         AsOCuQV/rl9kPCnidcE3jPaoW5rTjk3EqlngzRjY1hEGHKEIR2pTwu5z/opQx8LV+A1k
         FT7fOWExGmRhFCmCxBSbKAxgiM/7XX7Cs0jjF9HF/kFq7nygUr3mQBPIVKyaOc3QUjt4
         X2K7royxfH2wsv3aRVh8Sy/B25Dfz5VbV3Xo7mIs56q/QmMxjiKf4wlqon7ewCb8A/w9
         KvhglNPSz6P/90MfjCiV02E3IVtQFziecXgZI+eh0CnQYXB+3IMt5hnSZ7KA6BZ8gCj/
         Lvcg==
X-Forwarded-Encrypted: i=1; AJvYcCXhxd/lOTn4IsdFjmwoK3h2hzTJ6KH3VBmwZhCfkwq3pCONfFiQplHwIfB0zwm7FHilFale9iMo+213@lists.infradead.org
X-Gm-Message-State: AOJu0Yxrvongf3kobLJc/fuoHBn3FjFa4XlciQ53Tz9fKTE87w2kjkFz
	PFjrGOrWksGnBKqChEuK/iyxkhicSe3qaZwKhcZ2oqqKa/1Y0trw2iCynDwr5Qo=
X-Gm-Gg: ASbGncsD1SslXYbPx92ldSE/emEWup0k2Mclrp0DASrGkV4MdQ1FSH0FBkK/rPtR8JU
	1koL+mqJZJV8d1EgaCmgmVoIdhlrseymOnScQWC9gVvOXizNnipfW9apvu0i7aofRSelG3GxXIb
	pxIzSC/DP5sqQTgXBliBOTXz80UCYsTaG86DSaAQH3K1MRH9xtN+rl2UKrlZLzh8BEPHT3sM4s3
	dnemNKBUqFP1KRcUTxxg6t2fmdGbau3CEkUnDM0UlIme9uR0y4fHkwOMyPqJI7jJlCeqZzBGKzT
	Oqg/YvVzIqk=
X-Google-Smtp-Source: AGHT+IExPksUoM3E6ty6LrIuS+bUTXtJbAwi3WKcho/2VPhbuSKK1HIuLb1aeN5jPmbZBIOOLKzxHw==
X-Received: by 2002:a05:6e02:2688:b0:3cf:b2ca:39b7 with SMTP id e9e14a558f8ab-3d008e71836mr145248235ab.3.1738595526174;
        Mon, 03 Feb 2025 07:12:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d01c433734sm16125455ab.14.2025.02.03.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:12:05 -0800 (PST)
Message-ID: <262032e2-a248-40aa-b5bd-deccc6c405ca@kernel.dk>
Date: Mon, 3 Feb 2025 08:12:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: force noio scope in blk_mq_freeze_queue
To: Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20250131120352.1315351-1-hch@lst.de>
 <20250131120352.1315351-2-hch@lst.de>
 <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2273ad20-ed56-429c-a6ef-ffdb3196782b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_071207_816532_39A07E63 
X-CRM114-Status: GOOD (  14.74  )
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

On 2/3/25 8:09 AM, Guenter Roeck wrote:
> On Fri, Jan 31, 2025 at 01:03:47PM +0100, Christoph Hellwig wrote:
>> When block drivers or the core block code perform allocations with a
>> frozen queue, this could try to recurse into the block device to
>> reclaim memory and deadlock.  Thus all allocations done by a process
>> that froze a queue need to be done without __GFP_IO and __GFP_FS.
>> Instead of tying to track all of them down, force a noio scope as
>> part of freezing the queue.
>>
>> Note that nvme is a bit of a mess here due to the non-owner freezes,
>> and they will be addressed separately.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> All sparc64 builds fail with this patch in the tree.

Yep, Stephen reported the same yesterday. The patch is queued up,
will most likely just send it out separately.

-- 
Jens Axboe


