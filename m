Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC76BC001B5
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P71PQXWfMeET9rAMhMnbA2YOGMCwyBz9FWAbE+ia6CM=; b=jNFlkmvr6THn7H3JZv+2k6/e4S
	L7hvuVhl+Jk0Q7owBQk+Jz5v9aJLCxM6uPARKK7X8tGDeVdSMRsY9/qnNn4WI62VItHcvSHKlUIFz
	NMX67Cu6cyYYXTZeuwSrqp5xpETEVNQ+eVksgiyDdyQWKErScNh9GtpdBvPaYtble2S7tPjSFv9w9
	Yy4JwqO96Xvfa5loOrxqbJLwctISpXeQshhp+BpKqzlQeYzPCJXm07r4WTJy45MAgxkmMendxmqWg
	aL3/rtkdnnDufIHmPS6wpnHvGzK7+h/NfJsQ+AZw2BkU4GTK8MfxkMgfA5K0IO8FXTmt3eR3+sOjx
	lT7leHiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU9ai-0073uj-V6; Fri, 02 Sep 2022 16:32:24 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oU9af-0073me-MU
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 16:32:23 +0000
Received: by mail-io1-xd2b.google.com with SMTP id i77so2044868ioa.7
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=P71PQXWfMeET9rAMhMnbA2YOGMCwyBz9FWAbE+ia6CM=;
        b=vbLAECgY8YiLQlt98OatJfJLII0Jpj11iKaaL+5iZa7pJ+fq+GMSMzHOJWXgUc0/7x
         JPLzIVnctYIOeCRSj2M2bufoGd/6YbirudlP4T9rX48BRZZ3KxMSgBLnaZEcYkCeVzH8
         n7Qn6WTQuawON+uwEYrqPAX/sO25n9yiIPujWt5nP7dtx3JxXqEO9DqHGXsjoxRozvGb
         Ucybbzq152zLm/aRUTYOwoo+vy3RmtM+mRuRAxfzJhZgZn3wYRYktiZDUSSVGWGSH+El
         NBxm23v80X3GtUDd7JbbCHza2U3vj40A184b2LKyG4jCFbOTs90HxJ8/pNlzQo67qbfy
         dKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=P71PQXWfMeET9rAMhMnbA2YOGMCwyBz9FWAbE+ia6CM=;
        b=jcRUiuY9ugoLqpBaKvcCmz5+13rBR2iifyo4PLmgdlqV/7OoIsT0TXEqW7n7qUe+PW
         rhaFisZ27ZEjjYdBhE+MCvgUtn8dap9+ve+rEzpHvm1pJDEqM2HVOV23hd2khfmOiMNP
         0X82wxqVziJPztWeKOvv8H2ZSUjDEDAOEltnLQCG0bJkUGwsjtfBabjHvE1+1zBFk8f0
         +nTJoaVjCRO6hRoWUB39uqfEB/mXyWSxhr5Vgqq+OTQ0igg4JgspU9ypRnXIPEIOHtdi
         3Qhn173uRYnO8sBYlv0BpYecD3dE0V/PrI78emdBe0M4xiHv+YVC1YkXuJnCxkbomT5i
         mPHw==
X-Gm-Message-State: ACgBeo02AbTFPNuludl7N+wXxdrcpi/sdYu3/ge9N4/KfJGKQtOy1dZP
	d9dkS19rHqD5rMfaNwkVOmYYcg==
X-Google-Smtp-Source: AA6agR5t0hiYdcQSzlOQvgxYMtgGqRrkAxAwKlh2pBZDsfLxA9RcQtKvtayVkimGdSxSjCsZrltZWw==
X-Received: by 2002:a05:6602:14c1:b0:689:34d0:a0ef with SMTP id b1-20020a05660214c100b0068934d0a0efmr17291360iow.69.1662136338200;
        Fri, 02 Sep 2022 09:32:18 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n33-20020a056602342100b00689007ec164sm1004408ioz.48.2022.09.02.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:32:17 -0700 (PDT)
Message-ID: <2b4a935c-a6b1-6e42-ceca-35a8f09d8f46@kernel.dk>
Date: Fri, 2 Sep 2022 10:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v3 0/4] fixed-buffer for uring-cmd/passthrough
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220902152701epcas5p1d4aca8eebc90fb96ac7ed5a8270816cf@epcas5p1.samsung.com>
 <20220902151657.10766-1-joshi.k@samsung.com>
 <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
In-Reply-To: <f1e8a7fa-a1f8-c60a-c365-b2164421f98d@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_093221_990260_3C6781F3 
X-CRM114-Status: GOOD (  19.91  )
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

On 9/2/22 10:06 AM, Jens Axboe wrote:
> On 9/2/22 9:16 AM, Kanchan Joshi wrote:
>> Hi,
>>
>> Currently uring-cmd lacks the ability to leverage the pre-registered
>> buffers. This series adds the support in uring-cmd, and plumbs
>> nvme passthrough to work with it.
>>
>> Using registered-buffers showed peak-perf hike from 1.85M to 2.17M IOPS
>> in my setup.
>>
>> Without fixedbufs
>> *****************
>> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p0 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
>> submitter=0, tid=5256, file=/dev/ng0n1, node=-1
>> polled=0, fixedbufs=0/0, register_files=1, buffered=1, QD=128
>> Engine=io_uring, sq_ring=128, cq_ring=128
>> IOPS=1.85M, BW=904MiB/s, IOS/call=32/31
>> IOPS=1.85M, BW=903MiB/s, IOS/call=32/32
>> IOPS=1.85M, BW=902MiB/s, IOS/call=32/32
>> ^CExiting on signal
>> Maximum IOPS=1.85M
> 
> With the poll support queued up, I ran this one as well. tldr is:
> 
> bdev (non pt)	122M IOPS
> irq driven	51-52M IOPS
> polled		71M IOPS
> polled+fixed	78M IOPS
> 
> Looking at profiles, it looks like the bio is still being allocated
> and freed and not dipping into the alloc cache, which is using a
> substantial amount of CPU. I'll poke a bit and see what's going on...

It's using the fs_bio_set, and that doesn't have the PERCPU alloc cache
enabled. With the below, we then do:

polled+fixed	82M

I suspect the remainder is due to the lack of batching on the request
freeing side, at least some of it. Haven't really looked deeper yet.

One issue I saw - try and use passthrough polling without having any
poll queues defined and it'll stall just spinning on completions. You
need to ensure that these are processed as well - look at how the
non-passthrough io_uring poll path handles it.


diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea2..cba6b1c02eb8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1754,7 +1754,7 @@ static int __init init_bio(void)
 	cpuhp_setup_state_multi(CPUHP_BIO_DEAD, "block/bio:dead", NULL,
 					bio_cpu_dead);
 
-	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS))
+	if (bioset_init(&fs_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS | BIOSET_PERCPU_CACHE))
 		panic("bio: can't allocate bios\n");
 
 	if (bioset_integrity_create(&fs_bio_set, BIO_POOL_SIZE))

-- 
Jens Axboe

