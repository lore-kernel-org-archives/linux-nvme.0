Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F44C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFv2DXNGP7+TwfqtcxKjZ1YQUTflSUL1IVygY4MFlKI=; b=FXgVyemV9HCGrWnXlltUwooR4h
	28IbeIQ8iSlZjfKwhtBsBAaGOVrl51jwSfQQKrP/b941pPQNTeqaJ0GRF3jCVypZ+wWZAO+Mfn3U3
	GGyM8pIbr1U1ZwM4w5w8JIjJQIsen27ioWUs6Cce7uiSjH+nq6GPfQ3sDIkyGhTAK0FtY0GQ6kCBw
	ttoywDNVwWt9W5BL6jivpOg1dM9HzVYSkZnr55DwEuit6uwIxHPRwbo09Ln/vVG527UILnqCA11Bx
	v72ti/dh/goKv7RlzGM2c4HHhhlWyvYcAzZEdcPzViCrDw7bG2vjUGaLIuzH3RcAz52LN0oqYb6sT
	Lvo9Tt2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe3hV-006JDb-O5; Fri, 30 Sep 2022 00:16:21 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe3Zs-006Eyw-Ks
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 00:08:30 +0000
Received: by mail-pf1-x42c.google.com with SMTP id e68so2836879pfe.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 17:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=eFv2DXNGP7+TwfqtcxKjZ1YQUTflSUL1IVygY4MFlKI=;
        b=EzbUiSPk7hYCUrgM2gkMLGOVcVpSMYimXtZhvk5gP7RH1nRcXLWrndO/vOVGdWsINu
         /KNLbNUN9TYIfk7mZZRKrsK3gg9rV3Rgpk54omqRIZjFLSxbh2OZFj+il/y6ds79dGHL
         yuWzJ7sJlafrDrkkzWFNU3n4fjK8IjVBrZIYTa9kLpgx94X7Y+PltKbOPn4a0Z/FTAO1
         xw26yuuzi+c5rTHnteHZKZlwVJBmdqHnePuMQRt2OWihGJlMPiu+8aJ8KDsgqqtE4C8L
         FpE0dcUmvy8hMb0Hwqz2hkQMXGLfQqU62DuUB/JDCMLit85uI9qeDXbps6xKkaAywwJU
         Qlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eFv2DXNGP7+TwfqtcxKjZ1YQUTflSUL1IVygY4MFlKI=;
        b=YkeGNkZEmadPdIGMnlwdCbCouTqbASUbtn1N3xxna9KM7bQ12FGOQD6Plmm/4WrZHM
         Sq5HEfX1xbmDazE12PkjSpIiXmI5Z3nUU/gt/8lSmo3fiU6Tbq7WY54En8bjJztUpgyv
         jjH0dak1cEpp6vFkE+8ytIjtgNlAaja9j2fz1raVDAn4bm7+poDZoOlRKi7aG/Hplfli
         yoiLUuICdBru1goKySsL7jMtxnGZNYdgdAJjj6Xmldjhr7bkrKJcHBzSSiV203m37+ru
         lUslqx67TzQwvJqp1Xum6SLsDntqLmJf7l9IMZMxDmBQTw9Qz5x3ro28vl2pj7T/GnO/
         i1lg==
X-Gm-Message-State: ACrzQf3Tg2CgV65pSqJ9OU0yqr8vd8BQlNagZ+TfHPke0r+L5cx1H8kT
	VeF3+bt/u5b6uykEe5a6kKSCpA==
X-Google-Smtp-Source: AMsMyM6cMdM75zBZ/1Nn5XH7fjOX1viqcgRH3OX6Sra4iYSVWg5ZonhXFUyjJLvtx1lM53UFTaIKBg==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr6111006pfo.33.1664496498640;
        Thu, 29 Sep 2022 17:08:18 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001755e4278a6sm445046plb.261.2022.09.29.17.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 17:08:17 -0700 (PDT)
Message-ID: <c2cab5be-658d-3c50-b1a0-1d7d86e12e0b@kernel.dk>
Date: Thu, 29 Sep 2022 18:08:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
 <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_170828_730937_408E05E6 
X-CRM114-Status: GOOD (  23.84  )
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

On 9/29/22 10:25 AM, Sagi Grimberg wrote:
> 
>>>> 3. Do you have some performance numbers (we're touching the fast path here) ?
>>>
>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>> preemption disable. This is a very small price to pay for what we gain.
>>
>> Is it? Enabling IO stats for normal devices has a very noticeable impact
>> on performance at the higher end of the scale.
> 
> Interesting, I didn't think this would be that noticeable. How much
> would you quantify the impact in terms of %?

If we take it to the extreme - my usual peak benchmark, which is drive
limited at 122M IOPS, run at 113M IOPS if I have iostats enabled. If I
lower the queue depth (128 -> 16), then peak goes from 46M to 44M. Not
as dramatic, but still quite noticeable. This is just using a single
thread on a single CPU core per drive, so not throwing tons of CPU at
it.

Now, I have no idea how well nvme multipath currently scales or works.
Would be interesting to test that separately. But if you were to double
(or more, I guess 3x if you're doing the exposed device and then adding
stats to at least two below?) the overhead, that'd certainly not be
free.

> I don't have any insight on this for blk-mq, probably because I've never
> seen any user turn IO stats off (or at least don't remember).

Most people don't care, but some certainly do. As per the above, it's
noticeable enough that it makes a difference if you're chasing latencies
or peak performance.

> My (very limited) testing did not show any noticeable differences for
> nvme-loop. All I'm saying that we need to have IO stats for the mpath
> device node. If there is a clever way to collect this from the hidden
> devices just for nvme, great, but we need to expose these stats.

 From a previous message, sounds like that's just some qemu setup? Hard
to measure anything there with precision in my experience, and it's not
really peak performance territory either.

>> So much so that I've contemplated how we can make this less expensive
>> than it currently is.
> 
> Then nvme-mpath would benefit from that as well.

Yeah, it'd be a win all around for sure...

-- 
Jens Axboe

