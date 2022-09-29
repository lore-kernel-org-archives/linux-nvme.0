Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0032C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYbtzHif06/3tQxCA5g6x4C88SBbIXzQVcj5ae7YDxM=; b=lN3BzJjn3yivmvUyCDQDuj4vsZ
	TZtFytq+yG/bmRcxNNPUUHAYrv7smII9Ztozh497XFaUjLOboyoAqSdpTBhbKpcHqGDGWb1nSgrNW
	P/Ccw0tSqmsuFcb9V3Ka/BBjBtJ6EliCV5MDpJp1zY/4Y75UPgGaNT1f18uxqGs8Q+IFxqN3+b+bI
	u/iO96uWH329JLqUXlk1o2t6DluZy7opjsn+S/lZa8fPSI0f8w6BpUgc+q1Op7/D5CBr10izPdByU
	wQOPd9tm+QBnWeQhFRepUqgfv1LN73NCiSVQV7T65efLPtjggPSus3UwN/BjVrCrCKZd8q15O4ABO
	/2q8BhKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odqKf-002GXB-Mb; Thu, 29 Sep 2022 09:59:53 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odqKc-002GVz-UR
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 09:59:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id l18so1327619wrw.9
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 02:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nYbtzHif06/3tQxCA5g6x4C88SBbIXzQVcj5ae7YDxM=;
        b=n7VildSvo7WAGuKtjIr2vJ80OXV2Q93WpvChjIG6zNmv2rOzikKV67ZRbnlQoawuh+
         /TxnwSTi+HkVy8TW8vhfln3b5wWDjV2ZkUuwxEWhshBfIVTkyn3VCHHYh1rIvEBoDdUz
         i5Xy/SOoq6he9KeB1Up7N2J3HAMegMASwJoFFqIjwuAHkM6dpfXbFxFgrMoru2H3OWE4
         RD1mAKwJYGChssbtnCsHksAk3GyBKbgaPbrlW+RymQIz2gkw3uQNawypYJnvGaiZ2KQu
         uDWq7vrHOilcAhiHPoFiZYMVpj1eU/OCZw8f1Ioxe/gXvjBgCjhjpeAjiUMVV5sfB13D
         Z9ug==
X-Gm-Message-State: ACrzQf3EhGBg9+ZEGQufKzuGcTgJnvzPVeHdAoV5V0KIFHGxxGEEmiNy
	hV5CC9TH684eUmM9SLeTURWIr//tQaY=
X-Google-Smtp-Source: AMsMyM63dNWiAQIVN/uoqelib/KyLefzzTMUVovzw+ymlibssRdzgXsIl7gqZb9jtzNCJNKhXsIM2w==
X-Received: by 2002:a05:6000:78e:b0:22a:7e99:da93 with SMTP id bu14-20020a056000078e00b0022a7e99da93mr1535565wrb.20.1664445588746;
        Thu, 29 Sep 2022 02:59:48 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c3ac300b003a844885f88sm3824475wms.22.2022.09.29.02.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:59:48 -0700 (PDT)
Message-ID: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
Date: Thu, 29 Sep 2022 12:59:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_025950_998880_62FFFDF1 
X-CRM114-Status: GOOD (  26.54  )
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


> Hi Sagi,
> 
> On 9/28/2022 10:55 PM, Sagi Grimberg wrote:
>> Our mpath stack device is just a shim that selects a bottom namespace
>> and submits the bio to it without any fancy splitting. This also means
>> that we don't clone the bio or have any context to the bio beyond
>> submission. However it really sucks that we don't see the mpath device
>> io stats.
>>
>> Given that the mpath device can't do that without adding some context
>> to it, we let the bottom device do it on its behalf (somewhat similar
>> to the approach taken in nvme_trace_bio_complete);
> 
> Can you please paste the output of the application that shows the 
> benefit of this commit ?

What do you mean? there is no noticeable effect on the application here.
With this patch applied, /sys/block/nvmeXnY/stat is not zeroed out,
sysstat and friends can monitor IO stats, as well as other observability
tools.

> 
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/apple.c     |  2 +-
>>   drivers/nvme/host/core.c      | 10 ++++++++++
>>   drivers/nvme/host/fc.c        |  2 +-
>>   drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>>   drivers/nvme/host/pci.c       |  2 +-
>>   drivers/nvme/host/rdma.c      |  2 +-
>>   drivers/nvme/host/tcp.c       |  2 +-
>>   drivers/nvme/target/loop.c    |  2 +-
>>   9 files changed, 46 insertions(+), 6 deletions(-)
> 
> Several questions:
> 
> 1. I guess that for the non-mpath case we get this for free from the 
> block layer for each bio ?

blk-mq provides all IO stat accounting, hence it is on by default.

> 2. Now we have doubled the accounting, haven't we ?

Yes. But as I listed in the cover-letter, I've been getting complaints
about how IO stats appear only for the hidden devices (blk-mq devices)
and there is an non-trivial logic to map that back to the mpath device,
which can also depend on the path selection logic...

I think that this is very much justified, the observability experience
sucks. IMO we should have done it since introducing nvme-multipath.

> 3. Do you have some performance numbers (we're touching the fast path 
> here) ?

This is pretty light-weight, accounting is per-cpu and only wrapped by
preemption disable. This is a very small price to pay for what we gain.

I don't have any performance numbers, other than on my laptop VM that
did not record any noticeable difference, which I don't expect to have.

> 4. Should we enable this by default ?

Yes. there is no reason why nvme-mpath should be the only block device
that does not account and expose IO stats.

