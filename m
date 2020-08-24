Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A7EC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 20:00:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3860820578
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 20:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4WMUSwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3860820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4JWIWRPq04BhEDi9yYzfoNjeWnFttGK+811FrjIi4ls=; b=d4WMUSwJhxUkL+uu4mPdpi11Z
	skLteUW7VpGDZvaue4WzSAwwLWjBWwBZz2LKgtSRcQly0M0qN92spIChb7m7cn96HLqa2p1+njF8n
	tXZIDjUoJ+u328+3ihCTKe4fIEgG8aicE5AltXnlzrC9lWChVS+UhMOkawjK4emk+jCrDXtgHJiMI
	UVosc+ksBtcOh+6ReFnMck4EGFU2LtDVyjU9AaO5+Y3aQdL21QAARvjmvtu2HqDb6rXiWG9/q97+I
	vcqgGS81pM5ucFKOEZOZ81pENTo5ofpprfRn8t0OkEUH/b0BMBMmNyu9q9oCjczlTECLOsa4gpMbY
	AMNdeiiCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAIdd-0008EQ-HY; Mon, 24 Aug 2020 20:00:17 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAIdb-0008Dt-5x
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 20:00:15 +0000
Received: by mail-pj1-f65.google.com with SMTP id mt12so4875109pjb.4
 for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2020 13:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oLMQNel22K0XPYFA+YJ2r/SjoNNOFVt/AXP7lcsHH6E=;
 b=gukegshd/dOzPIOn+VqxkwSUjSgVGYfrCo4Gd7bIdTM+57CLHnCufhHumaRPxzgzTM
 81Pi45T3AgBRZRTG+0iTHCJJ+1Vm0YxAnVS/9HL5YwQu2qQg3mIrquycd1spHinHkPRJ
 x9bs+KKCEUXtn9LnS09yCvwmn694ph94P+DK23Onl/IbBOQPm1BK3EYiwj2N18ZaCtYo
 Ymzr7XOT6DFTWoVlY6jA8Ls8jNus60/BTss8TS2L8BSqVhmjpj2qpnBlXNfvUJ22O5qv
 xN7NkfdloSQo6sJIYiX4ML9zU2+ZhQcvyLNIA9cLMk2nIT3G5ss4OsmzQjYXapdHxWHT
 cnrw==
X-Gm-Message-State: AOAM533ordAQfdsV3P5G8vxxiSQV1NyTayB5XeUhkbfTgXCD1K0xoTNl
 isESP6gk5T6y+xS6FVe1vREXXRNkbkBfJw==
X-Google-Smtp-Source: ABdhPJxkXtPnQIfoqZclGU1KUvAU1SWFGHzEauVD8GGFzTLF4PgIbdKtItlflQtR0lu+x3wVtk9pGg==
X-Received: by 2002:a17:90a:fe82:: with SMTP id
 co2mr755235pjb.216.1598299213590; 
 Mon, 24 Aug 2020 13:00:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d?
 ([2601:647:4802:9070:cda6:bf68:c972:645d])
 by smtp.gmail.com with ESMTPSA id r186sm13677304pfr.162.2020.08.24.13.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2020 13:00:12 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in
 'nvmet_fc_fod_op_done()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 james.smart@broadcom.com, hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
Date: Mon, 24 Aug 2020 13:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200824_160015_249366_EBB456E4 
X-CRM114-Status: GOOD (  21.74  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> in this function.
> 
> Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> interruptions are disabled at that point, according to surrounding code.
> 
> Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not tested, only based on what looks logical to me according to
> surrounding code
> ---
>   drivers/nvme/target/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 55bafd56166a..e6861cc10e7d 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>   			return;
>   		if (fcpreq->fcp_error ||
>   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> -			spin_lock(&fod->flock);
> +			spin_lock_irqsave(&fod->flock, flags);
>   			fod->abort = true;
> -			spin_unlock(&fod->flock);
> +			spin_unlock_irqrestore(&fod->flock, flags);
>   
>   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
>   			return;
> 

James, can I get a reviewed-by from you on this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
