Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Apr 2023 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9aZlcZq1OAKX3QNMjBitKqvjfGR4DT30Ooj7feOkbs=; b=AiGzbsP9Ayqa31BHRWeq5i502r
	uDNqjUzBytQ1QpgjesY0kWEsG025kzn3iPsvmRjESANCDu6ux7oZO2UoZBpSF4yuMvLyreRq35UKk
	kW85z0mZicsCCBUg2oCpOH4q/mjA/UnxaGs4f7nOhqlCnEZaMK4+lzvxJPewJ1vCtdQPeM+xdGsq/
	H2RD6eFiVvrkPxjb/qNTwdlSrgIWCTbACCGGaUPtMux/YzzKcqNvWsh3BFBKD6xdGjUeFUTGFOfSg
	82dULO9WWW7EJiOEE1xgKhBDLuzEGV+y17EhD5CBzuIbOYjacaQLrv2uhT2w54m1AQ5r9FxZ8QGGf
	REcErafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjiLv-001wqL-1k;
	Tue, 04 Apr 2023 15:13:43 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjiLr-001wpE-29
	for linux-nvme@lists.infradead.org;
	Tue, 04 Apr 2023 15:13:41 +0000
Received: by mail-lf1-x133.google.com with SMTP id c29so42801564lfv.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Apr 2023 08:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9aZlcZq1OAKX3QNMjBitKqvjfGR4DT30Ooj7feOkbs=;
        b=QtaYRqxulg/3jicp6v49thsG5qMI1RXKu/2TzBFqrXlW9/EHINmoErmREAUScr8Bc2
         lLgOtmARBcmoZtWzSjWfTtMQrp5UqOVcFJSc4VqIkQ8gXpPh64BG0vqVH92iwj4m6jKT
         BB+kEq3E4lr4mHmTCrT4hb25G96mUUo9eMADP7xud8Icxc9xna+SH/nlcFq1S5+XZmg9
         DIH+Aqyh06Tb0EZt2Ue8JNE4nG6ObVWOpu6p7reXF5qzuNm5hDjGbEYB6Gs9JG4P5O+z
         XYpmtjackvFUTPZ4SQNLdLsXmvaMLy8OKH8/Y7xBaFMYL/t8a93EketUWBV5MAeroKk0
         abTg==
X-Gm-Message-State: AAQBX9eIyhhrjarlbDyVsdHauZpEIx1pVmdMIp8XaQWeNtw6FjGTzebN
	XeeIsvN2t+mY1Tw3iYPVdLc9rZ0WZ2Ltow==
X-Google-Smtp-Source: AKy350ZJWJwHmiz/p7rBKQD/CdGNmsUQX2RFUgUQjtaCuLQZQzUgfCiTPseD72iJ65bKojX6t6Y4Aw==
X-Received: by 2002:a05:6512:49c:b0:4eb:3149:cbe1 with SMTP id v28-20020a056512049c00b004eb3149cbe1mr789943lfq.10.1680621216629;
        Tue, 04 Apr 2023 08:13:36 -0700 (PDT)
Received: from flawful.org (c-a3f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.163])
        by smtp.gmail.com with ESMTPSA id d27-20020ac24c9b000000b004db2b54714bsm2365876lfl.67.2023.04.04.08.13.36
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:13:36 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
	id 7CA22895; Tue,  4 Apr 2023 17:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1680621215; bh=VdLcK+ZudRdgb6Tz8CNtxK/uW5cYcnsd/0hK/mDN7Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOEGq+QidfhS/g9uMlHubsPq0j06+9kUS+QtnJyn06mKveMIWAuVZj2S5kF1OZNMk
	 xJktJEzHPoPYSz94ZD/iutJ7Kx0b1DJQVX4zifJsh+JPjq86VfmpKVRZsnip/HRcXf
	 AAhaPRyjNjJhE+6z1oCt4zsH+eo7W775L5Xcez64=
Received: from x1-carbon (OpenWrt.lan [192.168.1.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by flawful.org (Postfix) with ESMTPSA id 919A32C0;
	Tue,  4 Apr 2023 17:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
	t=1680621193; bh=VdLcK+ZudRdgb6Tz8CNtxK/uW5cYcnsd/0hK/mDN7Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuTYSm5YdaO/rHMQ/KUfvgJLdjQ5HOL0pooCH0Zc/so2wQwcvvCUj1kfarfRlvNnr
	 IavIk7l+WoAXvOqbLTnLd3oBShHZ194ybI3BBWOfQ4dAuqo8xOTOXJfr6mBX8oo2F8
	 hMF/kFMneGJsOnS9j9Nr4psPGf5+SoS2VL1WhfRc=
Date: Tue, 4 Apr 2023 17:12:47 +0200
From: Niklas Cassel <nks@flawful.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Tom Yan <tom.ty89@gmail.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] nvme: fix discard support without oncs
Message-ID: <ZCw+b9dpTp/cnms9@x1-carbon>
References: <20230403200925.1641963-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403200925.1641963-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230404_081340_489534_DFCB3C29 
X-CRM114-Status: GOOD (  24.08  )
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

On Mon, Apr 03, 2023 at 01:09:25PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The device can report discard support without setting the ONCS DSM bit.
> When not set, the driver clears max_discard_size expecting it to be set
> later. We don't know the size until we have the namespace format,
> though, so setting it is deferred until configuring one, but the driver
> was abandoning the discard settings due to that initial clearing.
> 
> Move the max_discard_size calculation above the check for a '0' discard
> size.
> 
> Fixes: 1a86924e4f46475 ("nvme: fix interpretation of DMRSL")
> Cc: Tom Yan <tom.ty89@gmail.com>
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c61..d6a9bac91a4cd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1674,6 +1674,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	struct request_queue *queue = disk->queue;
>  	u32 size = queue_logical_block_size(queue);
>  
> +	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
> +		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
> +
>  	if (ctrl->max_discard_sectors == 0) {
>  		blk_queue_max_discard_sectors(queue, 0);
>  		return;
> @@ -1688,9 +1691,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	if (queue->limits.max_discard_sectors)
>  		return;
>  
> -	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
> -		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
> -
>  	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  
> -- 
> 2.34.1
> 
> 

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

