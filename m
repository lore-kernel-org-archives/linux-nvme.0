Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03AC4BA2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:12:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CD9222C2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKzHPWl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CD9222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zLaVwzRqmU49YXXOQGQiZ5SGWnUDYA7RO0s7uF3wpyo=; b=oKzHPWl40NSxZI2rqx6Zbb+1f
	1IAyvmG6NTs3yy+3lSn9MK3D5QrtY5unhKZYDQJzpczNHtGejp6tzaAi8qhpa81k4GnCk2T0pXi7U
	W1pC3orXVOq4ewf1pfNKITL0GUFCJR2DbcH2vncnaghq/qNTLisl3HbPDPYRvP58PGcYxnlql5tJD
	Z4yoQZoQ44DXjPjwmmw4O8HMOtOeJkTy/GEcfMJa2W9B1t5VHD6WQdvGvRXqwUuhTbITHGvWrLiyO
	lKp7UfeqmI5+4kyLSI/phAvJ7lQLXinvcPmNYkIEodWFzXrqZtJKQJvGbCuHSwm9n38mJjBjEuwim
	GO8QsUWPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j75qh-000305-NK; Wed, 26 Feb 2020 23:12:15 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j75qd-0002kt-BO
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 23:12:15 +0000
Received: by mail-ot1-f66.google.com with SMTP id p8so1103959oth.10
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 15:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xT/4YHu6eXt57o062HOZgaUM2lsiqS+nuNgzgWv1QG8=;
 b=YNSvVp95OJ3cB5xyiBKMC8bz2qtD3SOQQgFA7cxWaMsExR6f3LgSVE9S8IepIzf9zP
 CV3ttjUbf8KIO20bUM3RaYSDI287rG++R1kjMDn0jGk7h7KDcVnapmTHqANyoCHbA0TO
 KPll3MLLZIKWvhET3N5JgRdlSHPFdthZz9fbXcCQYIZ/4WoAkHY9ITAuCqxCP6lGhYNN
 hqfd7XlVy1tG0ggX48GhwHOhBMAKqi5hpC3Zf17rYjzdOfTA40rVCh8GLAGjD4rXJ30m
 27E+GU+qUD/vj74lBOW2eNZ3u85ZLFISqLVMozK7jxp3Q0/7ZzjOH/4oWOCdLnaC7JtW
 jctw==
X-Gm-Message-State: APjAAAVKWLOrxVcQg/8YoFLloKPnFHCG0DQCGh7LlhpO/3nZ+R7g8jqK
 JqNg7VF/ZSkyA2foFLOABds=
X-Google-Smtp-Source: APXvYqyjxPkX16QhKV9RUQjlv9snQckBzObEW4Lp2XOmmkq3Rrz8VlOnaA+0LZGkemt8F7aKcz4HMw==
X-Received: by 2002:a9d:6a53:: with SMTP id h19mr1038729otn.120.1582758730729; 
 Wed, 26 Feb 2020 15:12:10 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id c10sm1264405otl.77.2020.02.26.15.12.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 15:12:10 -0800 (PST)
Subject: Re: [PATCH v11 4/9] nvmet-passthru: Introduce NVMet passthru Kconfig
 option
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-5-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1cc35d6-faa3-42bf-ef44-dcf8ac7791f9@grimberg.me>
Date: Wed, 26 Feb 2020 15:12:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-5-logang@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_151213_758685_5A7AE4A1 
X-CRM114-Status: GOOD (  12.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> +config NVME_TARGET_PASSTHRU
> +	bool "NVMe Target Passthrough support"
> +	depends on NVME_CORE
> +	depends on NVME_TARGET
> +	help
> +	  This enables target side NVMe passthru controller support for the
> +	  NVMe Over Fabrics protocol. It allows for hosts to manage and
> +	  directly access an actual NVMe controller residing on the target
> +	  side, incuding executing Vendor Unique Commands.

If unsure, say N ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
