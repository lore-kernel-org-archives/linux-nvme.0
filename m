Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E712DD24470
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zWsbC5zYwFjIQpjAKyMSFH5NvTQw8vDDAjcLz2511K4=; b=Gl5J8Px0Z7qr+2XSKLXGlfcJl2
	2+QyU6qGxM0zJc/HkmHFTtaEqM8bY/V75a/lreM4GX/H7WBIUgb+g8gPXW4lrxa+xpJXfwj8Nf2aX
	kLIFnBbrENkFP6Z/Ikx703YdFIwpTErwaisIlPJTch+GmHTv1F8gM5vLHSeBBL8+Fzg2aAw7OcDgf
	opP9FyHZ5dr278T7I637vm4FpNAAyvfDxVM3tcjeFxkfLQfe4AHggpnEemHq9k5S7brBqjhxUX+LB
	B/Y7+OhmP6F4rk706De3Ljrv9hUQIT2q/o4CKkL7jUA/saP5kE3ZB6rx4/0RzwSs0C1Ke+nA4BFkj
	GyMtunGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szJ8R-0000000H3bu-1cmS;
	Fri, 11 Oct 2024 17:09:03 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szJ7u-0000000H3SN-08US
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 17:08:31 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-835393376e1so124313339f.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Oct 2024 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728666508; x=1729271308; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWsbC5zYwFjIQpjAKyMSFH5NvTQw8vDDAjcLz2511K4=;
        b=1KNmzKiyOskPalr7IBSHecox6zJBXXP2gNKEx0L2pbRB3J7W9krEFQXO3WHzPerrMd
         gvObOa7lwUhVSuyv4oRzB9uGADZWr8NV2g+yZqOj6Io6ip3l4C4UlfXF6YnEktQblE98
         jWPvFCZSGrSjQ9uBN40c4nmWBVgAvh2auqlheAkW3Wt1ExY5yOrQu42V2G7bQzvfcclo
         ByQWoyX6uJB6hUEnnwoU50MR76Fpv1dD+pZxvwGLIi1PJU2K1pUNHKQ/YYDIKESwzmQ3
         aIT6WeL6RhmVJVQYf1BuNm/NSnNnc54Y/juOVLeHaZjl51+atP4YT3xiC6Ct+e9cUHw+
         rHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666508; x=1729271308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWsbC5zYwFjIQpjAKyMSFH5NvTQw8vDDAjcLz2511K4=;
        b=S4HStJjBzw5cYtBkQqEB2O0ZP8ScItcvSMSBEpTFfyxmfEdhz4PI1LcibxYTYYmsIC
         SMOzqfBvjYBbowfHxBQKVUFcSQAIFeiBke+tZRElNU1P5McvB4zoRGzGJ2EjyumubnVb
         LwJq0C2PuFC7vpDBLNb1x64lffisuxaWe/PqRBA548tmS1JyH8CnAO7qLTf37iuL4Ft1
         ESoAa4ek8led32HR0vyMgkbDXZgrzcjPAkWsaupNzCs3cZ9B25jPLxhPal2HrDatvmjT
         2bKuCiQ5xTgIKanCaoEjYWjLh27+jeCXJg8z8QNMSd+A2u9QAfCEo3ykGv1O5p+w5xsA
         zJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg7tuhDzH6OUJSSBtj4WuqTFiSrQ1tVxHqc2N7ilAX3NNhQ8O282pquODVIHrbZ5qxjBD//MWMACZO@lists.infradead.org
X-Gm-Message-State: AOJu0YyyisUvmRRvlOrT+H4AfPWcJUD4Fk9Cmf+QjgQOTPx7jyctKumQ
	C0ynlhpxJ1+F2kL0mji2XOCynC3H5H6xVrmoIRgkSl2I4BwwzTMe7wTsrxQTR6k=
X-Google-Smtp-Source: AGHT+IHFPvgcQvxvJOZSrVRCZbyxjluKSsk/HoPp/vuJuEff6o04MxOCGz5P4UynejEHp6ALDdoREw==
X-Received: by 2002:a05:6602:640b:b0:82c:e233:15bf with SMTP id ca18e2360f4ac-83a64ce3d46mr24956339f.6.1728666508526;
        Fri, 11 Oct 2024 10:08:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8354b9932absm77655639f.31.2024.10.11.10.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 10:08:27 -0700 (PDT)
Message-ID: <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk>
Date: Fri, 11 Oct 2024 11:08:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
 asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com
References: <20241004123027.GA19168@lst.de>
 <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp>
 <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp>
 <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com>
 <20241010070736.de32zgad4qmfohhe@ArmHalley.local>
 <20241010091333.GB9287@lst.de>
 <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local>
 <20241011090224.GC4039@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241011090224.GC4039@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_100830_310988_E511A134 
X-CRM114-Status: GOOD (  20.70  )
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

On 10/11/24 3:02 AM, Christoph Hellwig wrote:
>>> As mentioned probably close to a dozen times over this thread and it's
>>> predecessors:  Keeping the per-file I/O hint API and mapping that to
>>> FDP is fine.  Exposing the overly-simplistic hints to the NVMe driver
>>> through the entire I/O stack and locking us into that is not.
>>
>> I don't understand the "locking us into that" part.
> 
> The patches as submitted do the two following two things:
> 
>  1) interpret the simple temperature hints to map to FDP reclaim handles
>  2) add a new interface to set the temperature hints per I/O
> 
> and also rely on an annoying existing implementation detail where the I/O
> hints set on random files get automatically propagated to the block
> device without file system involvement.
> 
> This means we can't easily make the nvme driver actually use smarter
> hints that expose the actual FDP capabilities without breaking users
> that relied on the existing behavior, especially the per-I/O hints that
> counteract any kind of file system based data placement.
> 

I think that last argument is a straw man - for any kind of interface
like this, we've ALWAYS just had the rule that any per-whatever
overrides the generic setting. Per IO hints would do the same thing. Is
this a mess if a user has assigned a file hint and uses other per IO
hints on that very same file and they differ? Certainly, but that's
really just the user/app being dumb. Or maybe being smart, as this
particular one block is always hot in the file (yeah contrived case).

The point is, if you mix and match per-io hints and per-file hints, then
you're probably being pretty silly and nobody should do that. I don't
think this is a practical concern at all.

-- 
Jens Axboe

