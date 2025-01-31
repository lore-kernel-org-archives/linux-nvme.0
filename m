Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21616C0218F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLgVfLufT0Dz7fmITpTavyms3uvW8wyIfB3nNEHYWps=; b=TyKUOfOPCdEvuyqBWKW07HgUnE
	TZ7plL6m8uss+EKJ23sq6YILDNPQ7RcSQC5ALobMX1nH+/G1j9wASlmjnRO6kOBEnIJxr8/tTTmYp
	DWmj1+6QgREIJqTK/FFmFCjPCar5WrHAe2Rcae3md2lUzAcuARXQ7azPEKmV4IRy0M/AP6tCjxqlo
	EuHVQ53eU+2/goPzdplLZ5UZQE6GNJCEE7ytO8ZmcaVeDF3Xadt4bEvlbU2gUv/PO4h8FJiDU+G0f
	WId6pjlttPq2WP5MVb8UoD4vhr1Wr7BNVnwL6GHwGWIr6KGkaD+xbeDaEBwW97h0D0uhvJMUGq4WI
	AUAEo94w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm2q-0000000AADj-1LS1;
	Fri, 31 Jan 2025 08:06:32 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm2n-0000000AAD7-0aqk
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:06:30 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so16439795e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 00:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738310787; x=1738915587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLgVfLufT0Dz7fmITpTavyms3uvW8wyIfB3nNEHYWps=;
        b=LWOqNXKnMDSNCfE0t2sfL8Gg17ZLb2xM47MFc2pQ9GNSfcK+HwP8wmujQGafNuSZ4w
         32daiKrsCrEG54A2iFphHIxNkN4yy6OBqveUnAGntCZqYO37BU8Q78+TsLwdAgBpmUZB
         JUj1uJcg6I1AApjlU8HbqCV6wONHKwCZ2TnEwdaXibk7Mp6zz0eaCjXBu7g8+mbAQygK
         t6z0VjiSkFSlvoCXvWabHA/TVlUNNs+WrPiy/tycJL04KYS29DuVLXSMkHkboxpEwFY9
         ZFfhzPLkcbI5HcAyDgQbHzdGw7XvwTa/q7An5mbARLUUHzdI1guOq3/2AvxAdL6LbJ3H
         Zc5A==
X-Gm-Message-State: AOJu0YydH3gqZNAPifGeRbqFKjJv93CR3XC+Nkg4ZOP4zKOASXXddLoY
	rtpH5H3sZ7yc7O76cWXREgu3LBlUjFBITZ3eUYdf4BK7hFHxj0Gx
X-Gm-Gg: ASbGncu3OCE4K6z5GWqlhbB1ULGFX19l6Be4u84J0ppMw5tsvRCshDHkiLkk372Uy1U
	ZYYH3/vZWCPl1B8xtQEfGLa4cMafBx1FW9uGpMMGrH/hRlGeq89MPoMPpWxFahTToGmrIVPtnJg
	VA9qyO/XwXgPcNgbAXChru5dkpPvKVqn5UkHfwsfu2K8xnLaeAX6V/3h5OR7R0mqrlZNZuIvfrE
	VZkl+O2XLlOMnYO0WxUHv35fAvvXw7cpN4CD27+/4TWmpGhHGsnEbwxaE5WJ8iVoRvjfNnulFvW
	GrI3kl8CmYfZG8GiCx1hJj6mbaoPVKwCAwo5eT3qKDDhYd6BGow=
X-Google-Smtp-Source: AGHT+IE5+gWvTesaPgijnrTSYVBkLqC7YfNV8GfATXM46apSItuz5N3dbh9uyGa9aivhSIp4FtdLow==
X-Received: by 2002:a05:600c:5119:b0:438:a432:7c44 with SMTP id 5b1f17b1804b1-438dc40b281mr80435015e9.21.1738310786452;
        Fri, 31 Jan 2025 00:06:26 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2c4ddsm82089725e9.17.2025.01.31.00.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 00:06:25 -0800 (PST)
Message-ID: <676bf767-44fc-4930-905c-292360d9c8b5@grimberg.me>
Date: Fri, 31 Jan 2025 10:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: replace lazy sgl warn with informational
 message
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, pmenzel@molgen.mpg.de,
 Keith Busch <kbusch@kernel.org>
References: <20250130175131.3613423-1-kbusch@meta.com>
 <20250131074828.GA16628@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250131074828.GA16628@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_000629_191082_9D244B83 
X-CRM114-Status: GOOD (  13.44  )
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




On 31/01/2025 9:48, Christoph Hellwig wrote:
> On Thu, Jan 30, 2025 at 09:51:31AM -0800, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Instead of warning about the device's SGL capabilities the first time we
>> consider using them with a passthrough command, print out what the
>> device is capable of during initialization. While we're at it, print
>> other interesting capabilities that may be useful to know when you just
>> have a dmesg. The ouput format was inspired by other existing subsystems
>> like pci.
>>
>> And example of the new message when used with a default qemu nvme
>> emulated device:
>>
>>    nvme nvme0: sgl+ meta-sgl+ sed- vwc+ apst- dsm+ wz+
> Printing out the capabilities sounds really useful.  But I don't see
> how this is useful for replacing the warning about the unchecked
> passthrough?
>

I agree, I'd keep the warn_once messages.

