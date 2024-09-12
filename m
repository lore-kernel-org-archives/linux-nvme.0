Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96250EEB587
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2RoqrV2owKMzFndq0dkWctxLbax1mnYbQcG0j4blwM=; b=osnvRocNezbSz0j2S5NR0s4fNK
	/wUv7RrYSxNHjtEfx2QmkxfGwsF7ph/RqHqY6HGZu0ZzSVdUZ8b1gBFudCaR9um2Gkxlz7LkplsQu
	Saz7149SHCaz1AUyCkIHr9kKdHqDOCkrlDTu8YDCs/cfesJwJuglHqMktxuu7rmwZI9raGme+/zhw
	SqA6h8AgwuXZd+r9aeoIZjn0xpCUte6Cb1r/FDyngKwDc6npKi1REMVwTuqhJTEONaftLA9Fh+WpH
	NUEw200ldrs2uBaz6PcCP/q4v3p0bRTAJehxd//gC9EZdRNYNB21bQpim9p7cJ6f1Z87rCTUy89lB
	HPJK+Jlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soh4W-0000000ChhI-0iy3;
	Thu, 12 Sep 2024 10:29:08 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soh4T-0000000Chgo-21vo
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 10:29:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c7e64b60so540393f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 03:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136944; x=1726741744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2RoqrV2owKMzFndq0dkWctxLbax1mnYbQcG0j4blwM=;
        b=XXinZ3qJ9GOO08+LpHiW/4t5q22ook9afRJXU6R3ipNZca70VHH7czFf61Z8A3/Wcr
         0RwwfFYVgrpSlIjEJaEmtl2wXG8sHbPGtgNQ5Drir5Bf+x63L7wlC2rsU7/zB0HcFo5q
         3Qf2LNgCmU/gyoVIZ2AJrNH1Cm7FQcsJqcIYKqpP5O1hSvauSSHDHB0spPnGC8cj4Gwe
         7ESpaqFKJHvzw0XBhn4BGu8TV9R95QEyE6oZfJo3kfyeYfvZ9lc+5N0y1Qr4QJStZx/b
         g00WeDjJqQdDMh0fgKJ2bQmjkXLy3qX+YRKnPjVqalg2EdUXeWj5hkJhvVCg9fyzbeDd
         pUWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGqQjOfVWAH86yar54uv/774ATn8jUfXNtMZFdd9Tiyvj4Gtsl0TkETKLrn9acPRioaW4nWFbnqH7W@lists.infradead.org
X-Gm-Message-State: AOJu0YwhFxEST7svlgDIKkHeWTRguIyFUW5Md+Dm6re+bSZtsQl5zMBz
	QLaxSLw497R+6eCxWNGtQvMZjK8Ym652UDqJeUh60IuAVV0n5blCaNnwbU5m
X-Google-Smtp-Source: AGHT+IGFC0Xc4RP5JfRlFoN5IndsV/E/Nz1N20wp2zLd06xsRKqC3E2hQP0Z06CPjN//SFVQZseYPA==
X-Received: by 2002:a05:6000:1f09:b0:371:8ca4:1b76 with SMTP id ffacd0b85a97d-378c2d12989mr1257149f8f.32.1726136942756;
        Thu, 12 Sep 2024 03:29:02 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de3aesm13923167f8f.110.2024.09.12.03.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:29:02 -0700 (PDT)
Message-ID: <40050af2-f056-4e4e-b1ea-d3bf6c7bc13a@grimberg.me>
Date: Thu, 12 Sep 2024 13:29:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: stuck partition scan on inaccessible
 paths
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240911124610.81615-1-hare@kernel.org>
 <20240911124610.81615-4-hare@kernel.org>
 <2193b894-2999-4450-a221-19045c2b3e53@grimberg.me>
 <0acc13ea-50d9-4975-8859-dded066527e3@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0acc13ea-50d9-4975-8859-dded066527e3@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_032905_557584_CC393290 
X-CRM114-Status: GOOD (  25.40  )
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




On 11/09/2024 19:10, Hannes Reinecke wrote:
> On 9/11/24 17:20, Sagi Grimberg wrote:
>>
>>
>>
>> On 11/09/2024 15:46, Hannes Reinecke wrote:
>>> When a path is switched to 'inaccessible' during partition scan
>>> triggered via device_add_disk() and we only have one path the
>>> system will be stuck as nvme_available_path() will always return
>>> 'true'. So I/O will never be completed and the system is stuck
>>> in device_add_disk():
>>>
>>>      [<0>] folio_wait_bit_common+0x12a/0x310
>>>      [<0>] filemap_read_folio+0x97/0xd0
>>>      [<0>] do_read_cache_folio+0x108/0x390
>>>      [<0>] read_part_sector+0x31/0xa0
>>>      [<0>] read_lba+0xc5/0x160
>>>      [<0>] efi_partition+0xd9/0x8f0
>>>      [<0>] bdev_disk_changed+0x23d/0x6d0
>>>      [<0>] blkdev_get_whole+0x78/0xc0
>>>      [<0>] bdev_open+0x2c6/0x3b0
>>>      [<0>] bdev_file_open_by_dev+0xcb/0x120
>>>      [<0>] disk_scan_partitions+0x5d/0x100
>>>      [<0>] device_add_disk+0x402/0x420
>>>      [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>>>      [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>>>      [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>>>      [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>>>      [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>>
>>> This patch introduces a flag NVME_NSHEAD_FAIL_ON_LAST_PATH to
>>> cause nvme_available_path() to always return NULL, and with
>>> that I/O to be failed if the last path is unavailable. But
>>> we also need to requeue all pending I/Os whenever we have
>>> changed the ANA state as now even inaccessible ANA states
>>> influence I/O behaviour.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/multipath.c | 15 +++++++++++++++
>>>   drivers/nvme/host/nvme.h      |  1 +
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c 
>>> b/drivers/nvme/host/multipath.c
>>> index f72c5a6a2d8e..0373b4043eea 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -422,6 +422,10 @@ static bool nvme_available_path(struct 
>>> nvme_ns_head *head)
>>>       struct nvme_ns *ns;
>>>       if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>> +        return NULL;
>>> +
>>> +    if (test_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags) &&
>>> +        list_is_singular(&head->list))
>>>           return NULL;
>>
>> This is wrong too Hannes.
>>
>> If you added a live path, and when partition scan triggers your path 
>> becomes
>> inaccessible, but then after anatt it becomes optimized again. You 
>> just ended up without discovering partitions...
>
> But we will be getting an ANA state change AEN in that case, seeing 
> that we have enabled ANA state change events and the spec states that 
> we should be getting them (NVMe 1.3, section 8.21.4 Host ANA 
> Transition Operation explicitly has an 'or' between point a) and b) ...).

That is too late, you already failed the IO...

> Which is what we rely upon anyway, otherwise we would have had to 
> check for INACCESSIBLE in nvme_update_ana_state, and not just for 
> CHANGE as we do now.

I am referring to the fact that you fail the io and not simply queueing 
it for future requeue.

> Plus the situation will be exactly the same if one uses 'persistent 
> loss' instead of 'inaccessible'...

That is a side point, that needs to be addressed separately.

>
> And incidentally, the same issue happens when you disable the 
> namespace in nvmet just after the namespace got scanned, but before 
> device_add_disk() is called. So really it's not about ANA, but rather 
> about any path-related error here.

Right, which is transient semantically. You are making a decision here 
to FAIL the IO, and it needs a strong justification. We can
just sporadically fail IO...

The way that I see it, for as long as there is a possibility for an IO 
to be executed in the future (i.e. a path exists) we queue up
the IO. IMO if you want to fail it before, fast_io_fail_tmo is designed 
to address it.

