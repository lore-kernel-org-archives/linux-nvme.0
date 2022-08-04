Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B855AC19F2A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Aug 2022 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CnBeoe7uqEcxaB+1aAe8bKxhqf9IbvpUHHTGwUqr4U=; b=Z3erSGhHHgMcDNlsgqeexyGS8b
	EXI8209X6gPFxpznMvmw1IKnOAeSciVUMESQlhw4TJeqch/zmAYK/oTg60Voa6FatgCLa3Jz5Zvv7
	Xf2WorIKZLXWyU0qwblFI8G85oKZO0DOv2U47/zKyA0XTevv+oaQo+hLEYsy/bcTFYqqBuVsMbOVr
	fsJACCPMlY+5El0esnWAHNAVAuvanNCUz+e0xmyFUT0L83A3Pg0MnPu6plGOqOqS9Wr2xi0U0H44V
	5GqNUxAVqvzgJMV1fmChSU7oTOTSE3sE6n5i58sNL6379lQjMW2pqQOAAgm1dnO3yHfUMRnNcQBgX
	rkEzB3ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJdva-007alV-NZ; Thu, 04 Aug 2022 16:42:30 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJdvX-007ajM-Pg
	for linux-nvme@lists.infradead.org; Thu, 04 Aug 2022 16:42:29 +0000
Received: by mail-pf1-x42f.google.com with SMTP id 130so12002615pfv.13
        for <linux-nvme@lists.infradead.org>; Thu, 04 Aug 2022 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+CnBeoe7uqEcxaB+1aAe8bKxhqf9IbvpUHHTGwUqr4U=;
        b=WmRCslE9kOuIR6KnPHmII1JL58W/uouaQW7Tcin9RLlyJDDrGFhgfwB1M8A5f3tMAf
         Aw41mRetrEtddPH+vaIptXu8+gpN1C7OlGiMoXSm9a5QgNzUpBt7XodP79FPPQmegTNr
         hkgUSOE7Lpj4XmSo7rksCTRKaD2kvBQ13I8sKOYpu/iFPLFofommLFjx9+DEntWY7s47
         OLbnacVu6uy2MY34Qq5d6L6EoUtBTEFaheopOEHNog0y5QeQCkZmz0/TKyC38y8YBkt2
         3h1Ab7b9GkCKg5PuFmOLIThaSSll6kXXslvaSgKdYWMHNv59lC432ht+tAV8ug48Ebfn
         CU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+CnBeoe7uqEcxaB+1aAe8bKxhqf9IbvpUHHTGwUqr4U=;
        b=oDvvUkengl/Pjp92Lah6fdY9vY7MPNM/UR+B/YZbJLIlCFalUO+8vSkDnteGGA1KWP
         2NBGikxHkeqNpQlgSWdLXBoLp0cMthy7Btk4oWSoe3zYVSIuTRKaVA+gTeEChiU/clBq
         kMZn2u4hVBLMMd81tTbHuQ5e66MUyPr2UgV6Y6CWo6azbtL0skzGcaBTkqHVyQd41CDD
         yP+gUlauVRYyHYijIKQER9YhiyFzD3Rerfhe5jjtZ+768LuQKv+cDgUR68BS1bAPpput
         M8PRu/d29J2RlGUQM9a3DYNLanERrq+9DAI+XhaWkbXhALHozX9AKbjk+Z4xh4B4NlGR
         vHnQ==
X-Gm-Message-State: ACgBeo30lY4S5sOhAgItWaoKif8BQ0xHijezxeqqpmI/JXtt0aL1pbem
	msLUc3JpVYCqnQGTFgUK7tx+6w==
X-Google-Smtp-Source: AA6agR6kMtN9endtZcnUlYAQ+oFGuA9Xrr1w70/pFRQoDTBxqaqU9fUwrglmB1vgkcAfMZVmAWfUrg==
X-Received: by 2002:a63:5353:0:b0:419:f140:2dae with SMTP id t19-20020a635353000000b00419f1402daemr2253734pgl.526.1659631346066;
        Thu, 04 Aug 2022 09:42:26 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s25-20020aa78bd9000000b0052e0b928c3csm1132114pfd.219.2022.08.04.09.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 09:42:25 -0700 (PDT)
Message-ID: <d72ea27d-ba80-2b9b-11e0-7fff11c8bf3f@kernel.dk>
Date: Thu, 4 Aug 2022 10:42:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCHv2 0/7] dma mapping optimisations
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, hch@lst.de,
 Alexander Viro <viro@zeniv.linux.org.uk>, Kernel Team <Kernel-team@fb.com>
References: <20220802193633.289796-1-kbusch@fb.com>
 <5f8fc910-8fad-f71a-704b-8017d364d0ed@kernel.dk>
 <YuvzqbcXwGUMtKmm@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YuvzqbcXwGUMtKmm@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220804_094227_862519_83A11E9B 
X-CRM114-Status: GOOD (  14.27  )
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

On 8/4/22 10:28 AM, Keith Busch wrote:
> On Wed, Aug 03, 2022 at 02:52:11PM -0600, Jens Axboe wrote:
>> I ran this on my test box to see how we'd do. First the bad news:
>> smaller block size IO seems slower. I ran with QD=8 and used 24 drives,
>> and using t/io_uring (with registered buffers, polled, etc) and a 512b
>> block size I get:
>>
>> IOPS=44.36M, BW=21.66GiB/s, IOS/call=1/1
>> IOPS=44.64M, BW=21.80GiB/s, IOS/call=2/2
>> IOPS=44.69M, BW=21.82GiB/s, IOS/call=1/1
>> IOPS=44.55M, BW=21.75GiB/s, IOS/call=2/2
>> IOPS=44.93M, BW=21.94GiB/s, IOS/call=1/1
>> IOPS=44.79M, BW=21.87GiB/s, IOS/call=1/2
>>
>> and adding -D1 I get:
>>
>> IOPS=43.74M, BW=21.36GiB/s, IOS/call=1/1
>> IOPS=44.04M, BW=21.50GiB/s, IOS/call=1/1
>> IOPS=43.63M, BW=21.30GiB/s, IOS/call=2/2
>> IOPS=43.67M, BW=21.32GiB/s, IOS/call=1/1
>> IOPS=43.57M, BW=21.28GiB/s, IOS/call=1/2
>> IOPS=43.53M, BW=21.25GiB/s, IOS/call=2/1
>>
>> which does regress that workload.
> 
> Bummer, I would expect -D1 to be no worse. My test isn't nearly as consistent
> as yours, so I'm having some trouble measuring. I'm only coming with a few
> micro-optimizations that might help. A diff is below on top of this series. I
> also created a branch with everything folded in here:

That seemed to do the trick! Don't pay any attention to the numbers
being slightly different than before for -D0, it's a slightly different
kernel. But same test, -d8 -s2 -c2, polled:

-D0 -B1
IOPS=45.39M, BW=22.16GiB/s, IOS/call=1/1
IOPS=46.06M, BW=22.49GiB/s, IOS/call=2/1
IOPS=45.70M, BW=22.31GiB/s, IOS/call=1/1
IOPS=45.71M, BW=22.32GiB/s, IOS/call=2/2
IOPS=45.83M, BW=22.38GiB/s, IOS/call=1/1
IOPS=45.64M, BW=22.29GiB/s, IOS/call=2/2

-D1 -B1
IOPS=45.94M, BW=22.43GiB/s, IOS/call=1/1
IOPS=46.08M, BW=22.50GiB/s, IOS/call=1/1
IOPS=46.27M, BW=22.59GiB/s, IOS/call=2/1
IOPS=45.88M, BW=22.40GiB/s, IOS/call=1/1
IOPS=46.18M, BW=22.55GiB/s, IOS/call=2/1
IOPS=46.13M, BW=22.52GiB/s, IOS/call=2/2
IOPS=46.40M, BW=22.66GiB/s, IOS/call=1/1

which is a smidge higher, and definitely not regressing now.

-- 
Jens Axboe


