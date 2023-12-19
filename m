Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEFC46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLoUoPBfaxkZ5hfvGkssr6NJ7T/e0QMYajZwOrdYmT8=; b=IxkGqQV2Nk4NjbnfYr2TPaMo7O
	Cn25MBepBkcBJb8GZ/DkoaThGNywn0jwInmAClyw5hz3rh/Aq0SQSWPpg3Kfyqsun7xyDTxPZzTrk
	U3qF3qYTOJ4kLPGbDF0dOQWS+zMoAHPTsfNW+oi5Uv1gFDHK/ly6phu2unzEZmmmtZAM8XeV+AUWR
	UHU5wAlUUL5b5YLznRwV+dYNAfIKoDal3qlvIl+3rXdfn6qWj4AzOh/t69tusBm63f70mGJFU6JYh
	w6N5fQ5NUYCswpW8ku7j4XEdpLEzfgDAwha8DFUqJIg7sCc+H3bqedkmJwB47GMv2fbaMP0I5IWGv
	otTVrmKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFapz-00EJQF-37;
	Tue, 19 Dec 2023 14:12:47 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFapw-00EJOk-0I
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 14:12:45 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso8239965e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 06:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702995161; x=1703599961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLoUoPBfaxkZ5hfvGkssr6NJ7T/e0QMYajZwOrdYmT8=;
        b=Du6eKqpWzCluEOmxJrrq1f4KZyjKyfFDWKp9b+YzoCdw3HuRJQKZtIz46QjEyocPSh
         DgisNFQlAFuwsHzsH3FCv6Te9Cpk/783ZBcLzv26KS2saA262GwEhxS08Jns7inIfsXJ
         Aa8V84Lf0xvmmXGugYg7k6tZcbSq6bDhGipLtxmRdwW6aq5uJdO4/aa61BZ4owEttIGc
         xmk8oW6qtagMDZtVYmJduyQvwhNBHf5o3wmWD757DwYB5Tx+0MZrsJJzH9xqHKb7/MYj
         fQW7bA1i/NyBrPqkPmUNbIjg6kWb+jk0rPjs0BUmSvF48f9VzlY+7ev1ej/FRovR/abz
         GzHA==
X-Gm-Message-State: AOJu0YzDteWvEcEso3rrfPeYsnlVxg7uE80M15Uc2SkuVsApkkgAf8Tq
	kGePn0HAuKRLZJ74Truzjfw=
X-Google-Smtp-Source: AGHT+IFhnL61OLzM+khIAXPajjk3d7nKSFH/G5VLsmXam3hUP0m2wuhvcDPAZnOWq7K00utJJDuAuQ==
X-Received: by 2002:a05:600c:3587:b0:40d:2e06:7a23 with SMTP id p7-20020a05600c358700b0040d2e067a23mr495915wmq.0.1702995160750;
        Tue, 19 Dec 2023 06:12:40 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040d1774b4e4sm3009652wmq.42.2023.12.19.06.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:12:39 -0800 (PST)
Message-ID: <e31bdaf0-311f-4bfb-aa01-9e8c85f72f57@grimberg.me>
Date: Tue, 19 Dec 2023 16:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jeremy Allison <jra@samba.org>, Jeremy Allison <jallison@ciq.com>,
 tansuresh@google.com, linux-nvme@lists.infradead.org,
 gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com
References: <20231215000358.1203338-1-jallison@ciq.com>
 <20231215000358.1203338-2-jallison@ciq.com> <20231219053318.GA559@lst.de>
 <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation> <20231219062102.GA1702@lst.de>
 <4f3084d3-10ce-49b9-8219-70dbf504cd6a@grimberg.me>
 <20231219135653.GA29757@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231219135653.GA29757@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_061244_128389_6C51742A 
X-CRM114-Status: GOOD (  16.46  )
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



On 12/19/23 15:56, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 03:49:18PM +0200, Sagi Grimberg wrote:
>>>> I could change this so that the existing shutdown() method
>>>> is always called, and the device is only added to the async_shutdown_list
>>>> if a shutdown_post() (or as requested below, shutdown_wait())
>>>> method is defined for the device.
>>>
>>> Yes, that's what I mean.
>>
>> I think its usually better to separate sync vs async interfaces. However
>> I assume that the suggested interface exists elsewhere in the kernel, so
>> its not a big deal.
> 
> I don't think we have async shutdown anywhere else.

I meant the case where an interface is either sync where it needs to
complete inside the callback, or it can be async because it is also
paired with an optional _wait|_post|_end handler.

> It's also not really an async interface is the classic sense, but more a
> fire now and then wait for completion later interface, i.e. no notication
> on completion but pure polling.

It could have been waiting on a notify/completion for that matter.

I find the above a bit ambiguous, but maybe its just me, so I don't
care much about it. Your suggestion is fine too.

