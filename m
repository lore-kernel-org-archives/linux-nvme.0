Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71657C021A1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 19:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsIvwEcUTBMStw2MMLLuDVcTGQeCcLwOBqA9S/j+YXs=; b=BXBsAT32WAHb+nBFBnyMMfLagI
	Q0mU2TUaKRJZW7PJIJbP+E+OBr/YiUvPYA8JZf1PEIJ1YyEWLG65Og5rs27dVYQpbyHG5pxJt2Qnp
	/qwLoRdsghHZjaZl3f2tvOR386dPMR3tXVNLu/YchCMDjQK33GGr1X/iPr/WG8zKP7gwBDeryKsuH
	ZLy7VPa4OGs7WtNQ3TM0XE4JVemcqMvPOu2wz/SyWKGlzbzEChxykdTerQZDDuaauKimmAcqLMgcb
	p5jsRK1JI1At4A9RV2UN+hjDdVjapnXt0WKMwqVpr+EMOt5FTw6uR858OTW2pCkFLJWWcMAD5e9h+
	C3+Us2mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thwJ5-000000056XK-0kzv;
	Tue, 11 Feb 2025 19:52:31 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thwGj-0000000560N-3aqg
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 19:50:07 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-854a68f5afcso136562239f.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2025 11:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739303404; x=1739908204; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsIvwEcUTBMStw2MMLLuDVcTGQeCcLwOBqA9S/j+YXs=;
        b=VgRq+F4pK9j/IBU+z9vLcqpc6pXeJsmlRaR6k3hWF8IvrDXHdS63vuxdYAXqzd7Gp6
         JaAdFf9P4sbM60KarzmYbNM/Pp1sqo7ffsP+EC4HdBc0IbHiNrfjP30Ej1tRRoZ0R57i
         RKfqSebJv+HhaFvbaSiCh2fF+l0ZDo7YEiLz3ih2IIFAaS1Wu5MyCQeJN0r/10ll2TJ+
         3rJ3MBAb6HcSs/Oq8SRVKNa/6hK88t8nDLHxkCjvoa78nAiGigvs5XAwfK7O2iFjwIGc
         6J2JOVRTvpxl9mZR8orUBGhCoFCOGQDJjKT6kkIm68GoQ61zKJz0ubHlgfp44spWv3Ox
         k7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303404; x=1739908204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsIvwEcUTBMStw2MMLLuDVcTGQeCcLwOBqA9S/j+YXs=;
        b=OzlCksKvKZDTwhsfXesyMw6sNdnvmUKfrDh/ROWwR+mzVhzxdkZ7EuXyimeEA8sSGm
         xFUioVi0hcNDbVWni4FWrqY77dtlV1hvEwzre+mCo3VlRP47C2IaAC2BokbboLL5YZB/
         XVOci8LITW92+WY1mWzDp6OvOm8WNO9E/c/c2yM0jJbXS+5D3eLrdHcdYTDk568j+1QD
         sb5mLOZPJ2/+IcBrr4dwvVFOIEhmSGpzKq8N5oV6GB2E86N0KETtdDZ0C0vwompvqI/3
         wiMwk7XMOc3irlFGAISG9lRPAQNpiRQrnk6fHjU8sgg8KmALgWUrZ1GUbnNM5X9nRgIj
         Mb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXThHoYYZN7jovPdwbRfUvY7NW8yOGuyoxeiuOlUYy0GlX8W+8DTd4PrtK3UjyXu/OgY0dtRnwSOiVO@lists.infradead.org
X-Gm-Message-State: AOJu0YygOCkh9AdKIrD029L6CU7muuj99Px78Qcg79CyFr6c95To1ZLj
	MansfE7K6/jwTB3sINMoj/WBh3jSjyKQFnLszcDjf/r2AXMyc/cnN8dZKugDldn4y0TLYIo2+85
	P
X-Gm-Gg: ASbGnctr7agCoy8sX6YV5M3eQ5DI+5MbXX2jcZWjA3kLRdX+0pIPgofRqOqvBrlu62e
	gNpqtBChtyXvCHwkzEJTTipPUv77YQmdNBHq7g1QEB5FcPaZwoJRA2EgIOaej/rg2j1yipRH2Un
	F4zvNm8ASmmog3QXXS//Czwx+8f/M5e4cAM7kJfStTjbu1xLk/ob9C91fta+HUzrIauJfoQS2Gk
	RxkIzyKPvKl+8gJ4FR8gyWT3koU7miupLgfMDC0eRfFKKq4JHkHeqRp+PtC7DdmmFqAJmGLZWxb
	ejmBwIA8OG4=
X-Google-Smtp-Source: AGHT+IFrTVAEGiw2EoTh/b9YW5R/KtzW2+Oh2EsbSrKLQH+zV7TjtxzGKsJ/H8T6kpwj7fxcn/baxg==
X-Received: by 2002:a05:6602:14c3:b0:843:e667:f196 with SMTP id ca18e2360f4ac-85555c8c4eemr91680639f.4.1739303404598;
        Tue, 11 Feb 2025 11:50:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed1885b085sm77104173.69.2025.02.11.11.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:50:03 -0800 (PST)
Message-ID: <84447986-6cd7-499c-834e-9aa01fad98da@kernel.dk>
Date: Tue, 11 Feb 2025 12:50:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified amount
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
 <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_115006_081985_BBBAB6C5 
X-CRM114-Status: GOOD (  15.94  )
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

On 2/11/25 11:25 AM, Alyssa Rosenzweig wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> complete. This can slow down workloads considerably, pure random writes
> end up being bound by the flush latency and hence run at 55-60 IOPS.
> 
> Add a deferred flush work around to provide better performance, at a
> minimal risk. By default, flushes are delayed at most 1 second, but this
> is configurable.
> 
> With this work-around, a pure random write workload runs at ~12K IOPS
> rather than 56 IOPS.

I knew this one would bite in the ass at some point down the line ;-)

I do think the feature is sane, and to my knowledge we haven't had any
issues with it since I originally wrote it 3 years ago. But I also
think it should probably go in the block layer proper, as other
devices might benefit from it.

That said, I'm fine with parking this in the apple nvme driver for
now, as we don't have to deal with multiple namespaces etc. Can
always get migrated to a core feature later, if desired.

-- 
Jens Axboe


