Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28095C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RfVrqt2734olqsQiYAdhKFpYTQ8WaXQ2R8q370Ut3XI=; b=DDv+U8VGYCISYWtLsEYpqgYinR
	9d3N5s9G35aqMrFBgLBH6Wuqk2GpKuzde27ew/qcJFYSCthc54PchdZyxfpmKTC8PzLDMXYkgDppg
	1EDaR9C9ik3pcztS7yZ6/JxqfI48j/sTK0v4ONo2YYnhB+MvaxU23OWPUEPNR3iJYyyrqe4C+T5IQ
	kuxKASCQSWuXRxALpwnJkF3hrGGbBMdm9vqHhn8PBC0NXh2uGBS+bUSXF9zILQXP0w8ZS4CbN50Vq
	Cazsz2AMT5NGMKfj3/l9rILQBWS4wdN30jZmU6uOFqo9Ry6buBisRZiAt2vJrpxD5eBYqeyLqnybt
	ct/Wiu4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh8d-00ASRX-17;
	Mon, 25 Dec 2023 09:20:43 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh8a-00ASR9-39
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 09:20:42 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3367f8757d0so652051f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 01:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703496038; x=1704100838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfVrqt2734olqsQiYAdhKFpYTQ8WaXQ2R8q370Ut3XI=;
        b=kDSGA5fuWjFKuR0X61ggJv3uy6lVImmow+2/7/n2HK6kNL58+5vikagIM1v4/Gdv4b
         ME4JTix7eX2bdkfPn5q+xCtIQB3PGJYds3znYQPnlfGZYiDXGJ4RcUz5CDFtnOogbwbn
         40ghAjv1ZpxaU9pA3kMaI/PGS+Am9Ty3O2wt71xksXIWUYf6eiT7NTcJrzNGcjdq17CS
         dEpYPT9bdlDpCvbbZwiPg7Zmb3J0K6ko067IFh3ebQA6HPLl8YppAO7o2T7VGnvdsOeo
         gTFMDF3+Tg3UWFGW3y+PIGbDfhIplyC4AB/QcMvrZNRCGiLe7YfAZ5ruEdZCbxXjMo72
         6hEg==
X-Gm-Message-State: AOJu0Yw1sfbLWYmcAINp5HmO8z1xJDZDr2Lq07KzFSVMxhOBGgl0yM75
	XCExIaniBYFa4D6rGWHmIyo=
X-Google-Smtp-Source: AGHT+IF2vI5ZpST5f3uf4EayUZBIV2vxqzdSbaFVa4+yajOCYOz5QOcmfMOup5POVUYjZuObohk/2g==
X-Received: by 2002:a05:600c:3584:b0:40d:5329:96a3 with SMTP id p4-20020a05600c358400b0040d532996a3mr3586405wmq.0.1703496037765;
        Mon, 25 Dec 2023 01:20:37 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b0040d556513d0sm4129139wmg.39.2023.12.25.01.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:20:37 -0800 (PST)
Message-ID: <22aa64db-f282-446a-b905-f93b590e6e24@grimberg.me>
Date: Mon, 25 Dec 2023 11:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: marcan@marcan.st, sven@svenpeter.dev, axboe@kernel.dk,
 james.smart@broadcom.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <20231221121746.GA17956@lst.de> <ZYRv7Fo6oCHgETyk@kbusch-mbp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZYRv7Fo6oCHgETyk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_012041_032994_DEA53AFF 
X-CRM114-Status: GOOD (  13.08  )
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


>>>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>>>> block layer, prevent secure passthrough and require scatter/gather I/O
>>>> to be split into multiple commands which is problematic for the upcoming
>>>> atomic write support.
>>>
>>> But is the threshold still correct? meaning for I/Os small enough the
>>> device will have lower performance? I'm not advocating that we keep it,
>>> but we should at least mention the tradeoff in the change log.
>>
>> Chaitanya benchmarked it on the first generation of devices that
>> supported SGLs.  On the only SGL-enabled device I have there is no
>> performance penality for using SGLs on small transfer, but I'd love
>> to see numbers from other setups.
> 
> It's the larger transfers where it gets worse. To exaggerate the
> difference, consider send a 2MB write with virtually aligned but
> discontiguous user buffer: 512 folios.
> 
> PRP fits in 1 prp_page_pool block.
> 
> SGL needs 3 prp_page_pool blocks, tripling the command's memory usage.

My assumption was that in large transfers the memory overhead is
negligible and the controller dma streaming dominates the performance.
The threshold was for minimum transfer to use sgls.

In any event, I think that we are talking about theoretical gains/losses
here. Unless anyone shows a real loss here, we should go with the
simplicity.

Theoretically the driver could add incremental optimizations if the
request buffer can use either prp/sgl, but this is something that
should be explored with real device(s) performance measurements I think.

