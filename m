Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A93DC43217
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQa4eGbEVBeAKBGzZEdWdAqwKEPR/qyaUUpn0AQUmcY=; b=1oNTMCIukT3JnF19Bm3VFtJnSG
	2eusWsWJRRVGyd17pcoCSdmTcpIqGJxtkm2Hi4BlLM7YKwj8bUfISqPX+edcRFCqDUUL9zzdbsqX+
	gk1Dy8viJEqm/H2hcz/fhudXSf8R7P7CSVccsrpRs5W5gaX2K6lmJ6g6U7/LRqfnQ2ET1XmiRYWIQ
	TdPr9Zq21HWCckU+c79QCX2tEWWphDU9rcacVaKlf1l1mlPXTwSitO7eD/+Ukl9MpigILP87kNXTo
	73wb+enqaLKF+/cCFyFNRfBEa1b5PqKDBRHVzLQpC84NO7nuE5Wl8ytwOMvHPXpqIpvJT5Yr4XILo
	nHGYEehA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeNV5-00BcGV-Cf; Fri, 30 Sep 2022 21:24:51 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeNV2-00BcFl-DM
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 21:24:50 +0000
Received: by mail-pg1-x529.google.com with SMTP id u69so5182178pgd.2
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gQa4eGbEVBeAKBGzZEdWdAqwKEPR/qyaUUpn0AQUmcY=;
        b=3EURTjXeklkLflGUj4iVrCFJLZ7OcWMFSStfiFCwgJII/1WImuD2se4G66ta21P6Da
         vFoTglIBbGNORBQWbWTCDuqtqxaO+HPnkTQTzYC1dhwW92sS/v7QWSB1rIA5TUm6h0E5
         jsb7sBRYK8arp+hv/lW94rlgekF6bYM1d7eL9MJrDFF4Jk6jfeNFYeFJdnUSlPMr0Aro
         8ecBCzitkMgDwf6dYdV/gZREORLjH+l1NiJuWBUuGWTpxnLT8s2Lknz+mn3Ff8tLqPUd
         rAi/qyTW2/CzAM7vCQAK1RkNXW4p2AVdxEwZ3EcAgVJEn+e9yv2o+6CMYbSmoBlDdJ7+
         631g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gQa4eGbEVBeAKBGzZEdWdAqwKEPR/qyaUUpn0AQUmcY=;
        b=eNvFNA7X+rVhfLTH1vq3tLdN/xyvRAaoBME1ci5FxYxPICWu6Z+1ZLbigGXLcIHkWA
         L2ZoFrECPw6KXmmkFxZyjkZ0lZil202O6PpyHSgUWdbHhc/ty+0C1ZG4K1AE9ntqkdtW
         PgiobkAZY0vBAKJ1YXPelfKci0gwy9O5Ec1CFWmaf6XfoiBMWKtBJaElN4qcxrxcJ6GT
         0c2GG1+akrOHvX9+ZLH9y4m1KSwBeSeyA4BFaLTNpiRVfW92TwR5id/DH9L3tukCjWu7
         1x7t6bP/A1vsieQoAcJkOcLW6OZHma4uhccbVMDHgrKSu5PyKDJ74u4X0CB4iBMQjY4F
         TxyA==
X-Gm-Message-State: ACrzQf2GayvVFEl3sthbFDpRoH+ud/4Cv0PUbUaEgRl2W/OB4uLX6Kuz
	AhKB+JMrXAWLdzofjQlxErIktw==
X-Google-Smtp-Source: AMsMyM6bH8LWTyKM8E6TZPLLzzJcAnhCSq843METl4dQR8aOBKDpfMXeY2d7Z+NB8UVtrtjnFjkUSQ==
X-Received: by 2002:a63:d603:0:b0:43c:6762:20d9 with SMTP id q3-20020a63d603000000b0043c676220d9mr9108628pgg.68.1664573086605;
        Fri, 30 Sep 2022 14:24:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00209a12b3879sm2028502pju.37.2022.09.30.14.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 14:24:46 -0700 (PDT)
Message-ID: <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
Date: Fri, 30 Sep 2022 15:24:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Pankaj Raghav
 <p.raghav@samsung.com>, hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-kernel@vger.kernel.org, hare@suse.de, matias.bjorling@wdc.com,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_142448_673350_BCECF6F6 
X-CRM114-Status: GOOD (  18.63  )
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

On 9/30/22 1:38 PM, Bart Van Assche wrote:
> On 9/30/22 08:13, Jens Axboe wrote:
>> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>>> Hi Jens,
>>>> ?? Please consider this patch series for the 6.1 release.
>>>>
>>>
>>> Hi Jens, Christoph, and Keith,
>>> ? All the patches have a Reviewed-by tag at this point. Can we queue this up
>>> for 6.1?
>>
>> It's getting pretty late for 6.1 and I'd really like to have both Christoph
>> and Martin sign off on these changes.
> 
> Hi Jens,
> 
> Agreed that it's getting late for 6.1.
> 
> Since this has not been mentioned in the cover letter, I want to add
> that in the near future we will need these patches for Android
> devices. JEDEC is working on supporting zoned storage for UFS devices,
> the storage devices used in all modern Android phones. Although it
> would be possible to make the offset between zone starts a power of
> two by inserting gap zones between data zones, UFS vendors asked not
> to do this and hence need support for zone sizes that are not a power
> of two. An advantage of not having to deal with gap zones is better
> filesystem performance since filesystem extents cannot span gap zones.
> Having to split filesystem extents because of gap zones reduces
> filesystem performance.

Noted. I'll find some time to review this as well separately, once we're
on the other side of the merge window.

-- 
Jens Axboe

