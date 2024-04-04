Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF30CD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 19:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wYwDsAchKS4zG8D1U4KROTDFOY4M6nXnpltEg+PH2H8=; b=Xpk1ZxqXmTA6A3+8pBfvEhOBC5
	lPjnzKIJ3EBRqdLW8iC6+aLmHnOwLQxl72mdTtOBeIH7Q5UzLh09LvmHk5kUyNJr0BAoa8e52yUV8
	pKFlXgjQoTcEVOGo7AVpcqb50xfbQ8cdzgTiHFS7nnqCmoqjrGTjjfkMue6SZ4n3QsrpWDGWUYcdJ
	jeWxlygHND0lcEzfAEEPz9Fmk6VwybDII0oscffB0OccuTsRQUkzKjpfEgdPb8rVWhq0P0PweL6c1
	G9NNW0rz3A06rZScJaa/RCEworREXd7oCPvr7V8qXVMfVCfTi2Hb6npYlHbrGDUzLQVlvgOAzZzie
	Ls9+UzAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSgl-000000042i4-0gIb;
	Thu, 04 Apr 2024 19:23:55 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsSgi-000000042hG-0Kiy
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 19:23:53 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso28458339f.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Apr 2024 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712258630; x=1712863430; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYwDsAchKS4zG8D1U4KROTDFOY4M6nXnpltEg+PH2H8=;
        b=q21XnRaGYUGxDbmYo2iolnmTNkEqZy98gQzcKWWtcHKkxZt0VZ6PHq003Jw6s3mmYj
         BUatNF+2V3kPUcPQFYFIVVwkKd56Qm6lsYqngsRa0E/okmrQ3Om7muA23xuIjcEa5RFd
         M4RvTYvuqLgIxWOHmALw1YWQoVmx4IQ2FGybghGXwsEm/OzCzLgTQmR16iWWnX6T+fZG
         cjp7HkvCnTLdtaw5PimcFzMsFnGJThL834ePq8jvBDtcEOTUWgC1egroQUb/ABTHI12j
         xa+VjAWRwzk9R+lXnGjwyYARqYSd+lnu2oU5zH5/nNaOCJYVejHnqVh+TNtKlMvtyj4D
         mUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258630; x=1712863430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYwDsAchKS4zG8D1U4KROTDFOY4M6nXnpltEg+PH2H8=;
        b=pYpTIntdgrwBHrVuiOAddyICxWV7XarUpC2iwpXR9fF567f/3QaIaPr14NaXIY7bCE
         SF6YTr6JEgGBJGjeLsM3LLgyBz99/khTwV+Je+zkjC5S+XAdDbIq8avituWJl4tk0hi0
         2/0JanzrZGKO4ZVJ3yZAPVc6zjexJFG+lxsKpb1SRugyM1kB50pauIoQVmUGif3hZcTj
         nHYXRKjHvobdUpZ1Mgloisw9vZiZn0Y4kBZNSgu6Iz3m0OH8XMbAqj/2JkdgcqieMT+S
         V4OVhEPOxO1glga8pKNazmkZuC60d8SaxCBWZA+2RMxhex+xrxAr+2JtUryWFaNSaG+A
         UvQg==
X-Forwarded-Encrypted: i=1; AJvYcCVei3QsW2Tzv1UoOI78D0JldfXpAy0hxgmP7Vr1Xe9UE4Gpz+kKi1xBeQhzgyv3Rzra+t2wv6C0/X/YLa5UT9ncqHAz1lN5e1lctr2LGYw=
X-Gm-Message-State: AOJu0YyAPvQfdY+0tTu31Q8oglq7sZMbt3/FBvaPFkJJBP7yF5PVWe6J
	oBCHPfG+LPDvq0fV1Nv80Zd7TI4B/CrEClE+Eni72TJtsNxApWa6aMC/MDe1kxw=
X-Google-Smtp-Source: AGHT+IG9cf4zMscVdHSdcAqAEsXNW9I24qngMC8InkscwwYqZgdqtRYKJbwNtCIwG875ebLJlSLwAA==
X-Received: by 2002:a92:ca8e:0:b0:369:e37d:541f with SMTP id t14-20020a92ca8e000000b00369e37d541fmr3657162ilo.1.1712258629736;
        Thu, 04 Apr 2024 12:23:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e9-20020a63db09000000b005dc98d9114bsm6598pgg.43.2024.04.04.12.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:23:48 -0700 (PDT)
Message-ID: <ed31d60f-9373-4438-b739-4b5efa7f9ed2@kernel.dk>
Date: Thu, 4 Apr 2024 13:23:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.9
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Zg7cW1X932Tz8iw2@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zg7cW1X932Tz8iw2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_122352_277303_E7446BE8 
X-CRM114-Status: GOOD (  10.35  )
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

On 4/4/24 10:59 AM, Keith Busch wrote:
> [resend for the mailing list]
> The following changes since commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155:
> 
>   block: fix overflow in blk_ioctl_discard() (2024-04-02 07:43:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.9-2024-04-04
> 
> for you to fetch changes up to 205fb5fa6fde1b5b426015eb1ff69f2ff25ef5bb:
> 
>   nvme-fc: rename free_ctrl callback to match name pattern (2024-04-04 08:47:56 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.9
> 
>  - Atomic queue limits fixes (Christoph)
>  - Fabrics fixes (Hannes, Daniel)

Pulled, thanks.

-- 
Jens Axboe



