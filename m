Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D32EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:24:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3AB64EB8
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3AB64EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iuzTP6DWiyiWjgfZlJBaE/OUTBjSo2aWfEEApOCpivM=; b=Hxb/noN3Oqygu9tULebgDR6T6
	53OKfn8qr+7fBKxlsXs1KUptkrfq4PIFyARA6nzvG+RikwevPznViPreJ9I2gWPCDUaibo49mhRlw
	WlSRyR4+VQoOwbxBTLqJYIEGCSnNVkYB5EqkwGkZsdaP9EDb8GszLQmaH2fKu7aq0cEFJ5V79vrlx
	PPTiqbwNDyZM1wnNkY36CEUDZ3exNFj6d3pWrhyvekERSCWNBVDHfPJdUPGQB4N/8nJTkb4N8qus/
	uDzH2Jpszh0u8LLvseBdWStOi0svXYphHWFgsGxN7Nvk2/DvnZBRqRLGjlysg8eNbGNJJ7C+DspXb
	8p7Vu7J0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9UsI-0007yl-UV; Tue, 09 Feb 2021 15:24:22 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9UsF-0007xK-He
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 15:24:20 +0000
Received: by mail-pj1-f52.google.com with SMTP id z9so1832245pjl.5
 for <linux-nvme@lists.infradead.org>; Tue, 09 Feb 2021 07:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=37Z4UhrvMzcvcOVCr4dWCA4WTFN/RJwoB3lMaoN4Pd0=;
 b=IO6b6RZchz6rQhY+mTFZ3CRXbTQ/P57paq1huXSWcUinNaDa89uaxnycNeOprCLkRy
 2EN6tqYgFUXsUuO6KUELqIdX0vVxza6YWHkcWAG+dGgfo36O+A5hneU/xiLuFMSiNeob
 yFXhWMtcJmYH5Vy2TRKIm62/5BhTr189yAkUVuux83Fiew6rKv16jn43Si2TUcrziurv
 BwHB5GcJjk+jUGqYLtoTrhwor1jns7EMW2ZbFMCXMYQM/OwjFQxCVceiaJZT4o0nMWZL
 FdI8Nmr0i5HcAxTL8Pv/1WksOy6qj3jCHfo9blA2tTy8Q1ZOUjlZ9QDK5CEkejovaj/d
 vrrQ==
X-Gm-Message-State: AOAM530HqUkvbRkobS4vYtVC/iX8l05uIMQJ28ky61u5Cml9Ii6pip2y
 Y/0Mb2OVpprvQLrDvKyqknA=
X-Google-Smtp-Source: ABdhPJzhlIRcZPCssPv/Ya5sFitotI3tij1ofKcDPDpQUTtbZnAefyk+EAqE1g2yEXz4dLVQRWPrQQ==
X-Received: by 2002:a17:902:be14:b029:e1:bec9:f4a7 with SMTP id
 r20-20020a170902be14b02900e1bec9f4a7mr21895197pls.21.1612884256272; 
 Tue, 09 Feb 2021 07:24:16 -0800 (PST)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id u68sm2663115pfu.219.2021.02.09.07.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Feb 2021 07:24:15 -0800 (PST)
Subject: Re: [PATCH V2 0/2] nvme: Support for fused NVME_IOCTL_SUBMIT_IO
To: Keith Busch <kbusch@kernel.org>, Clay Mayers <Clay.Mayers@kioxia.com>
References: <20210105224939.1336-2-clay.mayers@kioxia.com>
 <20210125195844.1390581-1-clay.mayers@kioxia.com>
 <BYAPR04MB49650B6342C736B5268F833686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b5c179e3eb904800931712d6b92cfbeb@kioxia.com>
 <BYAPR04MB49652EA8F4CF06D41C708E2386BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b2a0593cd1fc4f239bbd44f3f43d4bcd@kioxia.com>
 <20210209031252.GA97526@C02WT3WMHTD6>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <d2bc1899-3660-c0af-e5c9-dca7af8d2c0d@acm.org>
Date: Tue, 9 Feb 2021 07:24:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210209031252.GA97526@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_102419_663663_42AA73E8 
X-CRM114-Status: GOOD (  22.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/8/21 7:12 PM, Keith Busch wrote:
> On Tue, Feb 09, 2021 at 12:53:17AM +0000, Clay Mayers wrote:
>> Is there any other feedback on V2?
>>
>> My main concern I have about my implementation is how fused requests
>> are tunneled through the mq request layer.  The 1st request is marked as
>> started but it won't be in the device until the 2nd command is queued.  As
>> Keith pointed out, a device reset can split the two so care must be taken to
>> correctly handle this case.  Despite this, I thought this was a better approach
>> than modifying mq requests to be fused.  Especially given Christoph's
>> concern of cost vs value.  This is the lightest touch I could come up with.
>>
>> Further consideration of this patch may need a more compelling use case.
>> I've worked on a proprietary storage systems that relied on fused NVMeOF
>> support so it seems compelling to me.  There's a comment in target/core.c
>> that there is "no support for fused commands yet" implying it's been
>> considered.  Is pci only support for fused too soon or too little?  What would
>> make it more compelling?
> 
> The complications it introduces to the IO path and error handling for an
> archaic feature has me on the "Nak" side. NVMeOF was introduced well after the
> spec define Reservations, and the kernel has supported that capability for many
> years. I'm not aware of any other use case for fused commands, so it appears to
> be dead weight in the spec.

Hi Keith,

Do you agree that NVMe persistent reservation commands apply to an NVMe 
namespace in its entirety while fused compare-and-write commands allow 
to implement locking for subsets of the LBA range of a namespace? In 
other words, I think there is a valid use case for fused commands.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
