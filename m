Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A867C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byYOG+DizdHWax+owTvUVbIlVKhh71b2LPVRCuPxMcI=; b=Yg17QOtaQxaXqmvhW/RIuQ6fEu
	ggBvtxuhTtj0Kw2bkgYrQZEOQD2EDEPGrRGyvtOFFIoJ0Mp3vFpN053Z6SJMJOPywO+AgI/zaz6Nr
	TMcEuSX4bxFXBPuUNlLg2f4wjEURyyeDR9kvSNvC6N9YhJdTmx53GSnR99OX6EgB8U3rCPu8/ZIOa
	ejZGRtqnEMus70ClfVjujvANW4wNrOUnI6DJjWWymAEDcaSgIWArCpBGtCWSu/daMy/zbynOkgnDk
	yZGH3h+GoMeM53RqVZyFLYHl8k925RH0izToUG12IIDi1mw5tQP8s6mbLLNwtSyQD2IS/wZ1De9wA
	6639o/2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOWY-000000065es-1UcM;
	Mon, 13 Jan 2025 17:46:50 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXOWT-000000065e9-3RV8
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 17:46:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=byYOG+DizdHWax+owTvUVbIlVKhh71b2LPVRCuPxMcI=;
  b=tJvnY0ijUdY7EThnLeRX8/jX86ZzbQhcg74qcIlfZQSE8qaiouHgPu6q
   jZ5UvRHdsB5dI2dTsE/sJwRoZUfo4vdNc89mhXieHEVzs5QpaYhy1V6Y7
   2b3eiE5hXHUl9BQtUB68o92T4/r3l12CUMSamKAPFExqr3H8C1PsdjWxy
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202887518"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 18:46:38 +0100
Message-ID: <680677f4-8976-4028-882f-45f1e63fdbd3@inria.fr>
Date: Mon, 13 Jan 2025 18:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix bogus kzalloc() return check in
 nvme_init_effects_log()
To: Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <9516d209-712a-4a48-9dda-b270e80e3abb@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_094646_231420_C0087CFF 
X-CRM114-Status: GOOD (  13.77  )
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



On 13/01/2025 18:30, Jens Axboe wrote:
> nvme_init_effects_log() returns failure when kzalloc() is successful,
> which is obviously wrong and causes failures to boot. Correct the
> check.

Sorry, I should have checked more carefully here... Thank you for this fix.

Keisuke

> 
> Fixes: d4a95adeabc6 ("nvme: Add error path for xa_store in nvme_init_effects")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Caused a boot failure on the first test system I tried. Not sure how
> this got this far without being seen...
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9e7f1bb81973..0d21258e2283 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3182,7 +3182,7 @@ static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
>   	struct nvme_effects_log *effects, *old;
>   
>   	effects = kzalloc(sizeof(*effects), GFP_KERNEL);
> -	if (effects)
> +	if (!effects)
>   		return -ENOMEM;
>   
>   	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);
> 

