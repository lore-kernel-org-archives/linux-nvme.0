Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F075C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lVZKStYUL3aqr2H+ry9zP6Hg8QuXRhbNdAiPhAUSJ4o=; b=c9QCWjPVnUrbJiPnI3fuB2y1JR
	OCOMIhHB67W1oAi3mJrvTW/V7Ni06WHQ06jbSkin5a3K+ECB3ZuPvfm9RasfZ63ubiIlOYjQVMgqy
	zv9rxRSd6uk2Txh/dMdpglCCYycLmqODr3nKL7m9eC5X6uY9uZkufASNKcilbWcaMtnDhUzroPNrM
	7bYOMQaG5tG8Jw9Zt3o+9fl/hhdRstYNCltow0D143oBlID5ueVV2m06Ad1cobDG00v+70K2la7ca
	Ydiiph1skxQxF/w76iQs8QzfGFNHR4yOzcsMyR2Zm6bVMQELb56jeWkRB7nUFtqqMU6m5k58HNaCR
	rzPjp5dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFOA-002Hh1-0g;
	Thu, 21 Dec 2023 09:30:46 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFO6-002Hg3-37
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 09:30:44 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33686565c35so50391f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 01:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703151041; x=1703755841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVZKStYUL3aqr2H+ry9zP6Hg8QuXRhbNdAiPhAUSJ4o=;
        b=LHuj3PgoRN7cz6BHCpH80ebbkyZCNjCQCh77271/ULWJq2faPprRlWVuKW4Qj0Ozba
         xOa75mNAUYQLaYY/boUs7ulXsJb1lfKULiMhOWK/wR97RV3COJpAoBKeCpqwva85eGWO
         EG3fT4ghPmiwNGEgvPLnFUL0aakaKevBPqArIpsahpQHHMnXIqHKOMM/LPU2yTZTHKUn
         zrAhCTNXE1fORXKZHfO8K5HDvKP8PxDqu8WznZHutUwwsBWSIhbTR3ZvteNUyZ4PwFfO
         wVDz4RqKdG5E16splvI4ZaVR910dCzEFj1aLMICQj3892SFHkHEO07lLFeLfOnXZAZdH
         c0yQ==
X-Gm-Message-State: AOJu0YyX3berUfSSo1RPfmkj1vnSyqYKLnTsbmiSGdH3JeA8vOhWWS1v
	PfTuajJE0Q7d4DnJMC2uGnE=
X-Google-Smtp-Source: AGHT+IHLDiO7/uwT2ZAKPKCBOOfAp8nLkWIijpamp6Px6NuUd74pq9hyNGpjPJP5jDZXjl0HY0nmpQ==
X-Received: by 2002:adf:f20a:0:b0:336:4355:bb46 with SMTP id p10-20020adff20a000000b003364355bb46mr15397073wro.1.1703151040998;
        Thu, 21 Dec 2023 01:30:40 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d53d2000000b0033671314440sm1587217wrw.3.2023.12.21.01.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 01:30:40 -0800 (PST)
Message-ID: <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
Date: Thu, 21 Dec 2023 11:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
 kbusch@kernel.org, axboe@kernel.dk, james.smart@broadcom.com
Cc: alyssa@rosenzweig.io, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20231221084853.1175482-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231221084853.1175482-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_013043_001209_F8FAA026 
X-CRM114-Status: GOOD (  24.27  )
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


> NVMe PRPs are a pain and force the expensive virt_boundary checking on
> block layer, prevent secure passthrough and require scatter/gather I/O
> to be split into multiple commands which is problematic for the upcoming
> atomic write support.

But is the threshold still correct? meaning for I/Os small enough the
device will have lower performance? I'm not advocating that we keep it,
but we should at least mention the tradeoff in the change log.

> Fix the NVMe core to require an opt-in from the drivers for it.
> 
> For nvme-apple it is always required as the driver only supports PRPs.
> 
> For nvme-pci when SGLs are supported we'll always use them for data I/O
> that would require a virt_boundary.
> 
> For nvme-rdma the virt boundary is always required, as RMDA MRs are just
> as dumb as NVMe PRPs.

That is actually device dependent. The driver can ask for a pool of
mrs with type IB_MR_TYPE_SG_GAPS if the device supports IBK_SG_GAPS_REG.

See from ib_srp.c:
--
        if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
                 mr_type = IB_MR_TYPE_SG_GAPS;
         else
                 mr_type = IB_MR_TYPE_MEM_REG;
--

> 
> For nvme-tcp and nvme-fc I set the flags for now because I don't
> understand the drivers fully, but I suspect the flags could be lifted.

tcp can absolutely omit virt boundaries.

> For nvme-loop the flag is never set as it doesn't have any requirements
> on the I/O format.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/apple.c |  6 +++++
>   drivers/nvme/host/core.c  | 11 ++++++++-
>   drivers/nvme/host/fc.c    |  3 +++
>   drivers/nvme/host/nvme.h  |  4 +++
>   drivers/nvme/host/pci.c   | 52 ++++++++++++++++++++++-----------------
>   drivers/nvme/host/rdma.c  |  6 +++++
>   drivers/nvme/host/tcp.c   |  3 +++
>   7 files changed, 61 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 596bb11eeba5a9..a1afb54e3b4da8 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1116,6 +1116,12 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   		goto out;
>   	}
>   
> +	/*
> +	 * nvme-apple always uses PRPs and thus needs to set a virt boundary.
> +	 */
> +	set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &anv->ctrl.flags);
> +	set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &anv->ctrl.flags);
> +

Why two flags? Why can't the core just always set the blk virt boundary
on the admin request queue?

>   	ret = nvme_init_ctrl_finish(&anv->ctrl, false);
>   	if (ret)
>   		goto out

