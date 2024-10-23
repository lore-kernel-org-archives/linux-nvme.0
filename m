Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163BACDDE49
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBpqt7O1UVowxWQhdRzPD2AUA5xa75SUt7TL+T99+jU=; b=tX4vqCl2Q4vU53EiSc4C2pAjLx
	XuwuKWbooaLQ36Xc1pCt3BgjOia/tgcNYyFCVAhrS7J98N7UOZOvOo5WLaEI4Imv0y8OakhJdTHIk
	qnl5cceEgdgh9xf3NQcVesE/lmLwE4XT3FL9DfCXW4P8N6H20zGm9h0sWP1vwnG9pRrOhi2MHG7px
	hxOHO+4P4SZwA4ZL5l8TDBBUcbczF0jhKYfX4ZOdtz/3yFKWu0Gcr5903krTvmXDMfaxSmDRQtc5w
	i626KeOdsja+QQgwCNMdSJW71xWqLm04tQHVjjEEaJkfR0iGmJ6zpi1esxjqNVgDwl1kTqsbIKpV9
	uTWtgR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YAR-0000000Du6T-1dzn;
	Wed, 23 Oct 2024 10:00:39 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xwf-0000000Dr4L-0zks
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:46:26 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cb6704ff6bso4539702a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 02:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676784; x=1730281584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FBpqt7O1UVowxWQhdRzPD2AUA5xa75SUt7TL+T99+jU=;
        b=EzvkREugCQqQXqZc7pluy/rJyhx1Yb514YGfnn8lr2MSjh080ffCHGQ546Scd1b4lL
         EZsseGZ47AVvevAlSMpQhrzttazm0sj3maSsKZ1ISFNyf3uD9Rv424lJWVDycvf/Ekwp
         iWyahjNsdUiPDhDKedVD0jIAZod2EMt/g2ruEhRrckqJ7fdtkMC0Ny9ylhPojfKn7E6Y
         wAZAHWl7mO+Ru0WOpoiNCtfO4ytE2LyQt2HGaNXAeIa7vr/58YsONpqoWNLzic6Jx2Yn
         hZnzdvn4Auy97h1+asdBYsJrqQUN/o4l73XcyJNjffut5qZ6/1ZvLzk39cD2MsPrXonc
         y44A==
X-Forwarded-Encrypted: i=1; AJvYcCWMUR52evu8LbSnJCwol31vR+4QdzDHD1PjZPdtS81dw/Kt/31LbwtbVE3uwXxE7HLCmTeNalSnXKW4@lists.infradead.org
X-Gm-Message-State: AOJu0YzchazrBkP8vED+ebdXxx1khIYJ3CCJLMjGXlfcemgXfVgBGKDF
	kAHsaCCv7Fgq9ohDU8dtitp4fhPPNPOVT9DADq0V8BmwsT1J9W31
X-Google-Smtp-Source: AGHT+IGRZlRgRkyJtIDZdMdsrw1KKYaTyrzKxbx8XqOmFjRdlUXYJfrbO/clap8pTJnoJhes2xhzGA==
X-Received: by 2002:a17:907:7247:b0:a9a:33c:f6e1 with SMTP id a640c23a62f3a-a9abf851e2dmr181732466b.5.1729676783442;
        Wed, 23 Oct 2024 02:46:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370723sm450767366b.100.2024.10.23.02.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:46:23 -0700 (PDT)
Message-ID: <8a1e78e9-c064-4fce-9ab4-f2beea053d97@grimberg.me>
Date: Wed, 23 Oct 2024 12:46:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp> <20241023052403.GC1341@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241023052403.GC1341@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_024625_316763_E41AC61D 
X-CRM114-Status: GOOD (  20.84  )
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




On 23/10/2024 8:24, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 08:53:47AM -0600, Keith Busch wrote:
>> You'd may want to know max_sectors_kb, dma_alignment, nr_requests,
>> virt_boundary_mask. Maybe some others.
>>
>> The request_queue is owned by the block layer, so that seems like an
>> okay place to export it, but attached to some other device's sysfs
>> directory instead of a gendisk.
>>
>> I'm just suggesting this because it doesn't sound like this is an nvme
>> specific problem.
> Well, it's a problem specific to passthrough without a gendisk, which is
> the NVMe admin queue and the /dev/sg device.  So it's common-ish :)
>
>
> Note that for the programs using passthrough sysfs isn't actually a very
> good interface, as finding the right directory is pain, as is opening,
> reading and parsing one ASCIII file per limit.
>
> One thing I've been wanting to do also for mkfs tools and similar is a
> generic extensible ioctl to dump all the queue limits.  That's a lot
> easier and faster for the tools and would work very well here.
>
> Note that we could still be adding new limits at any point of time
> (although I have a hard time thinking what limit we don't have yet),
> so we still can't guarantee that non-trivial I/O will always work.

Makes sense to me. Although people would still like to be able to
see this value outside of an application context. We can probably
extend nvme-cli to display this info...

