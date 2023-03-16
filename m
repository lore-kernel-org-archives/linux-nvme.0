Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C73C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HusC61I5q9JLQBYzvd96FMDitNE4iymTn8ayNS0WLIc=; b=p1qyBPQn81lKPKh0PDCouQKLU8
	671x6XRxUtxpyjoyuOldUO/HcqCzLOMdU/n2Twc1GFxcwcu+u0idnhojOkD4BTNC/rK3JxDjD7NfV
	qBFxDKZY4jBVOiq9ighxe3QL+TE+iASLs8jX0mfXQG22da1ePJgPcpes/NwxJcJwEx8aDhFCSiLep
	SvKLHnJ/j4WBhO8ckI7yUzbFszoOcIOp6VTMQwvRkCBszCGYmuMKvuB7ks2RnoV14DN0zfuHiUiVV
	AG8klORSi/ujFJyS5xmf435NZQHpJD7txy7ktutFgqsc7G+D71curY701fRPDH1iUnba7/cNdCcUO
	MqO9FKKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjQJ-00FnLE-0N;
	Thu, 16 Mar 2023 08:57:23 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjQG-00FnJl-0Q
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 08:57:21 +0000
Received: by mail-wr1-f44.google.com with SMTP id p4so774660wre.11
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 01:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678957037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HusC61I5q9JLQBYzvd96FMDitNE4iymTn8ayNS0WLIc=;
        b=j9PHZ8eNSAc+/ZkrkPIFSMt8pvvljoMJTcCI+PU/68n4XMMF6cjnHTajKJuZUXotLV
         4dL6BAc3CRpvHZ2dBewsjTghdF5TrrLXnOZaoyeg8F/PiVh+m96FLlA83xbI+nlMrfQv
         3XPsxN8DCsPj115Pag+Zmmy3BkCPha9CuNCI+QEyIPO6Xf60Y5Cq4ZtT0PN+KGHqtJjW
         ey7JmbQyDKHSZh895MEdZ+c4Rg4Xwoe5WJ8Eg4M9U9lV8zCXq2ii80kcrpKqVIoXN2F5
         w7VItQUKAVjBqd1A4yqaRaijku/LQR9uWqeqVh0rTEGG9AX1zYEaoZlWX50S3Khf/5JM
         LUZg==
X-Gm-Message-State: AO0yUKVRQ2EZs0/0ASSLyN2KugPxI8ai/SyO8u4bagmr5Zq0AmIrj43J
	O0vEx6GPGFQ4vvXLqaRIR4o=
X-Google-Smtp-Source: AK7set+ZAYwO9aB780iusXsCgXqz6akbKfdf6VQQgKeWJOiyQzzZJ5sLCGipaAUt8+LQrhsC3Up5rg==
X-Received: by 2002:a5d:55cb:0:b0:2d1:21a1:742d with SMTP id i11-20020a5d55cb000000b002d121a1742dmr1580814wrw.6.1678957037010;
        Thu, 16 Mar 2023 01:57:17 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d4a8d000000b002c5534db60bsm6707203wrq.71.2023.03.16.01.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:57:16 -0700 (PDT)
Message-ID: <897f4c54-0870-caea-55ba-dbfe768d0c8e@grimberg.me>
Date: Thu, 16 Mar 2023 10:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
 <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBIe2H9J7XDs/zoD@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBIe2H9J7XDs/zoD@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_015720_172305_4FBEB00C 
X-CRM114-Status: GOOD (  19.75  )
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


>>>> I'm running tests where I connect/disconnect to/from a few I/O controllers
>>> using the nvme_tcp driver. I use nvmet_tcp with a null_blk device to simulate the
>>> target. The kernel module crashes (trace below) while trying to connect over
>>> TCP. This happens on Fedora 37 and Ubuntu 22.04. I also recompiled the kernel
>>> using the latest nvme-6.4 branch and I'm still seeing the crash.
>>>>
>>>> I'm not sure how to debug this further. Any suggestions?
>>>
>>> Never seen anyone try to use poll queues with nvme tcp before. It doesn't look
>>> like that would work for a connect command since there's no bdev at this point,
>>> and polling needs a bdev.
>>
>> Thanks for pointing me in the right direction.
>> I wrote a test program that exercises all the different options available.
>> The crash went away once I removed "nr-poll-queues=4".
>> But this begs the question: should a user-space program be given the ability
>> to crash the kernel by simply providing the wrong (or weird) arguments?
> 
> Right, we certainly don't want to let an easy kernel crash like this exist now
> that we know it's there. I'm just consdering a couple different ways to fix it.
> We could just reject user polling options for nvme fabrics, or we could make
> polling work with just a request_queue instead of needing a bdev.

Polling used to not need a bdev, but the introduction of bio_poll made
it required.

We can't just reject user polling for fabrics, it exists for RDMA as
well as TCP.

