Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9209C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=; b=KjVrF1FtE1kUcDhvnKlg7x452T
	S0D8wjuIG60toGRVeshazqgWYBv+cm6gXKz7Nq7ayzRtdmw8rVd0vMlnykV1yLryGArQ9we3sx3CP
	Yqw96lnfkdgRytc9kJMpKCBgNRVe5Pp07O78M9M5uKPfY88/EWvb/M/+elz1kd9v0mOCFnpQvvvTv
	1JPgDHrCfMv7JeJBPXkbKDghpvYlNuEN1bgpK7ttfz1f2nmnnlwaxQlUcvFVd03gx914t+w/h9Mxl
	jxwIeXyhrpcCiCJ/0D5XAeI+ZscFUtZWWuMjZARBuPp6srBpepiqVnfN4wLWksK5i6Qo2aZp7yc/y
	2lhXsZ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHiy-00A5eV-A9; Fri, 30 Sep 2022 15:14:48 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHiH-00A5Gw-Nf
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:14:07 +0000
Received: by mail-io1-xd2b.google.com with SMTP id z191so3489049iof.10
        for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=P9WWNQtWlB5f/IfBNtwL4w5+xcZ6cZI0BVKiGfdweWgPvQHQEQESV3CnmEnXNXiU+U
         vp+xXcUEit+8B9sj9Hh6xdpeXWF+P6xAL/QS/2JUGxfs6ia29xDNYZN4USoUdbcCO+B3
         2egNXSKAYMBg8zUmbPfKgrHXmfZ2/feemYNI3gL7/71mJEbGW3bABE4qDEBKJe15hThf
         HVTPHWHhvFTL1eubX12elfdIi8vvHFzKCFs9WVn3Pi7pLNPzNL9294YBAquRnqs2KKaO
         rbw92cJxck6GdkD/dmmDOaLcK+VZcLXWLOXJkaiGGcX4OCwgWbbSrC/fLR/t5al86cv8
         Syyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=l5dGle5b0Bl4IUBEPpQTWhNMwHq107XBwQzI4elyJoAYPu545733J8GN0YF/CBmIm5
         SM9B9YfblwCKZUgA3tL+UOBlkdtm8xk6q8AgZ5d5EL1gGUCQ+lAd8H2g5+0DkCcLZtVC
         08o8NNQGPwvZ/oD1fEZabnTXd6XcSpGhvX9jo3fNaaQtNfymzBrAam6AionrukQfZAde
         soVjS3WTlXCr6ZYRgJGPGCYt6VwJHG07uMBPdAQ9qbPtDPHzznqfTUfexrjNmy43EtS1
         89jhvbhkVmljD4KA5BDnWMmmZlJBMoPSPVNU3EirjGqUMrUc+map6gy4VOTAAoJzVjfl
         OePw==
X-Gm-Message-State: ACrzQf3U0imrMOE7ITEuaJ9W8wjwIDko8KRyuxLpDJbWTHKSTsQ+x0VP
	AkkIQfQ0+Lm7eg6sLVmdXLUn5g==
X-Google-Smtp-Source: AMsMyM56qoijmhJXnYPF8kxaWuSK3ez2mfK6ZmVjsiLUqUdOlYO1SRhJq4es+Rf++wuS3uh8BhpzXw==
X-Received: by 2002:a6b:b80a:0:b0:6a4:949:4681 with SMTP id i10-20020a6bb80a000000b006a409494681mr4032792iof.96.1664550843041;
        Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02060200b002eae6cf8898sm1052303ils.30.2022.09.30.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:14:02 -0700 (PDT)
Message-ID: <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
Date: Fri, 30 Sep 2022 09:13:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
 Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
 linux-kernel@vger.kernel.org, hare@suse.de, matias.bjorling@wdc.com,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_081406_057589_52E21602 
X-CRM114-Status: GOOD (  10.66  )
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

On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>> Hi Jens,
>>   Please consider this patch series for the 6.1 release.
>>
> 
> Hi Jens, Christoph, and Keith,
>  All the patches have a Reviewed-by tag at this point. Can we queue this up
> for 6.1?

It's getting pretty late for 6.1 and I'd really like to have both Christoph
and Martin sign off on these changes.

-- 
Jens Axboe



