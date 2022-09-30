Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57307C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 01:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cg6k590d1gYe1qvzLK8US59eUH7WJXJdcnukMaAq5JQ=; b=wYDOiUTEzImlrpzwUlY9d122Hn
	+gE7t7plnekHApEwQBQmR5OxWsK60AsCX0DYfsB4yo2J2NCbdEQzjdYHb8RpILpwZiYu8FY1JktUk
	x+o0Szgc1h38eaM7alBIId+Ch5cmwvqLsY4+jC7TkVQ21lj8m+2K+z9hhX370s5b8m1MBU2sU55Of
	/fNSKkAiY05Z0GLMWWvUHsERM19JQBnwT/0FzzosiNk4i3shyLbaX4DSDtnrd2kui0ufAnxjIStJI
	ZaZSkPcfqEytT/1mr15WOhN1lokWEhhPyuAHhenmviynhVqU28y9R2Az21SCVzWlRoH7HQoBTpaA4
	z5OCqOsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe4nR-006Z79-M8; Fri, 30 Sep 2022 01:26:33 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe4nP-006Z5e-8a
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 01:26:32 +0000
Received: by mail-pl1-x62d.google.com with SMTP id w10so2685549pll.11
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Cg6k590d1gYe1qvzLK8US59eUH7WJXJdcnukMaAq5JQ=;
        b=h1bgzldX+/L9fXhKSk/XewnvXXMCnpgpXGG+N2Vrmw1HCHa2Ue3P1gJ7lte3NhLNQQ
         opK+geSBRBxre64a+lTdmBjopIL/SaVrmYu2tOsXNhLUrZzsi+1uC/7omK6b5UzWoMrU
         0s+n2Jt5Y7fRUSttfrhG9F9OFaCS+v/BB4zpkWDUFBPy7qgp0BYAj0/rj4sUlDwL5mqi
         lf6Dj936AuSMLz8c2Ts/9Gp1dt93hERti9oZ7/X4OSGNgSrMxOaiDlqtnUbMvvbdaS98
         8LuBaifjg5iqEfMuaYIueKFg4evNfIFH/KNja02Zt80LaLRRT/RSyj0XAI3hKP5OV+gV
         vUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Cg6k590d1gYe1qvzLK8US59eUH7WJXJdcnukMaAq5JQ=;
        b=GZkUOAFYr5AuxYM1kf84QqspDCuI3w/rveYiosMszElWKUqeNEJAlRLRVqmmXQ9nSF
         uvxcb5+nImstbaI/90usUlEUp5Voaew3Ha2z7W/cz/6NSMwaYDJGOZteFOVcwk7wV6Fk
         VnsFz/PijTguqBAV2SsSZ5zdASPr8/rBDPAFQ8N25/N0zR6eseMKX09WrH8QWfz+FhHo
         soFq2/6uYWiYpXpwIkvys5daeJVr1wCrCRhlcd323sePOjpy7g/hzBO0wu3KJf0EMLDt
         +XUvONcUEyV9g63//QQ8IxescbRR8UJLP/hDHXt3cM86We+cGJAPwGeJ5JszMdnkRloL
         FqUg==
X-Gm-Message-State: ACrzQf1rM2acWV5Sb1NAWTP4bUESEm9dQrTV2eHAVuM3L4EQK91nfBSt
	uBForpLPUUYz0tO3bfmTlJxExw==
X-Google-Smtp-Source: AMsMyM54XYNL60ZKYJnXrSIFgmbWTCJkL3I8OdtaVHNuzxN6EhKViW84Cz8nyS9OLFnrbEHSDcY+kw==
X-Received: by 2002:a17:90b:3b47:b0:202:a81f:4059 with SMTP id ot7-20020a17090b3b4700b00202a81f4059mr19768268pjb.150.1664501188259;
        Thu, 29 Sep 2022 18:26:28 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm558361pgh.37.2022.09.29.18.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 18:26:27 -0700 (PDT)
Message-ID: <eaa47591-10e0-426a-6345-2881963be080@kernel.dk>
Date: Thu, 29 Sep 2022 19:26:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v11 02/13] io_uring: introduce fixed buffer
 support for io_uring_cmd
Content-Language: en-US
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20220929120632.64749-1-anuj20.g@samsung.com>
 <CGME20220929121637epcas5p2ff344c7951037f79d117d000e405dd45@epcas5p2.samsung.com>
 <20220929120632.64749-3-anuj20.g@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220929120632.64749-3-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_182631_552946_CFE235A3 
X-CRM114-Status: GOOD (  12.94  )
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

On 9/29/22 6:06 AM, Anuj Gupta wrote:
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 6a6d69523d75..faefa9f6f259 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -4,6 +4,7 @@
>  #include <linux/file.h>
>  #include <linux/io_uring.h>
>  #include <linux/security.h>
> +#include <linux/nospec.h>
>  
>  #include <uapi/linux/io_uring.h>
>  
> @@ -77,8 +78,21 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>  
> -	if (sqe->rw_flags || sqe->__pad1)
> +	if (sqe->__pad1)
>  		return -EINVAL;
> +
> +	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);

After reading this and checking for IORING_URING_CMD_FIXED, this should
have a:

	if (iocmd->flags & ~IORING_URING_CMD_FIXED)
		return -EINVAL;

to ensure we can safely add more flags in the future. Apart from that,
this looks good.

-- 
Jens Axboe

