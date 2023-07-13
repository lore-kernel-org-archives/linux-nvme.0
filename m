Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC3C001DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLcqHPinnwkmlRMkJbo6RrqEQRdQP4WvNtNACwBOh7Y=; b=oMtO9Y0QJbRpjfWu15G1ippyUk
	ibf2llgglrtrj2Mbk3127UOWXZWbBVRJ2a/IbSM9qot69Nosz2CzAwIDYBvQkb87jh3p2wLtYeyYd
	727+8DGLk30dUcTw9jtGwa508ICg0k7w70ohspKE+RhXY4G9PJyJ0tIQ2FqyqCW6cABH0yI1HcsoI
	wa2OP8EA3y/eD1ZpOs6d4ocA7Bo9TWfXP+2glAe8UPri6LYsNzQeAfMfeE210YdZOcXSxYppeRfGY
	zx0daZI5bDFjs9rqr7KfCDmwF8ak11g0J0RZAkFDuXiqLubnOboO7HmGFDqu4JTk1u8/Bxe2UnIQF
	UkUH8OXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qK2ye-004Jaj-0v;
	Thu, 13 Jul 2023 20:31:52 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qK2yZ-004JZk-3A
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 20:31:50 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6748a616e17so229637b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689280304; x=1689885104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLcqHPinnwkmlRMkJbo6RrqEQRdQP4WvNtNACwBOh7Y=;
        b=TvlwoC6AxCvpmLv0lj34lOCsIrifRV2b2H46l+sbQkWvvNL2C4M/7/YZNZOKvh4pGM
         0PvUo/8uGa49eta/iJFNlGqepf16zQhDHaZZ8BsAw5Y+ITmIaCphnBlK4ZOtfe7XUkt3
         VbbMJ05hlRkFWE2imV+2eN6boVpAcam59NgCjjCaWxG1Nod2fv3K10zroW2JoloGUBMF
         yc1glxDxbAVePnUwezSmDdnnLiFzodTOEl176GXdB39gOdFSfvO2Ng5k2aVAZa62wPUY
         Yc3yqLiCfLuDYpn1GdUuNmf1hb9G7+XeBCkCVvMxWsmDGY2Don0ixPaewVO6xiyuXXAf
         ZZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280304; x=1689885104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLcqHPinnwkmlRMkJbo6RrqEQRdQP4WvNtNACwBOh7Y=;
        b=KProNmdjR9uQjLLxDhdXYe6wX7lZAL/1XPJr5IgTV8pBHBGkh+0wWqa175A6dcvVhR
         4mIfXvGW56kPP52mOY18rU8LrJhO2HS9F4GXhddZiLBwsGrlumTIuSV8a9s507YvYm2z
         6kL9nCe2cIpIjqrHciRtG0E9xsE6S0cbZLEejqxUhkoO+d0fxXDW8Tx2l4M5VGHyDEIq
         pvtr851ei8zC2jpYdlh+fkJbNJuW7JYyVWV4+u8tnvdCyWKh9zacrOG/SZhran1WVik8
         Gnr4aGuNd+D1mzIzcj1byIYckeJKndKKhzpjEwaaiM227GpU9bpsrxfT2//AWUv4g9Px
         lsYg==
X-Gm-Message-State: ABy/qLbsemxQPttXMheslADWzr5yWVYMZzOjGt7O4JHmHnGYLqlcghXt
	0smzLo7jqckJnJVqLn7wmcfIXQ==
X-Google-Smtp-Source: APBJJlFtl0C2+MJ48CigWgsBvfYmxoARvtbGGnPpfcm3NW338Cn8c9+RWdIqBO3GzmToxUCGys7uFw==
X-Received: by 2002:a05:6a00:2daa:b0:668:834d:4bd with SMTP id fb42-20020a056a002daa00b00668834d04bdmr3736093pfb.0.1689280304216;
        Thu, 13 Jul 2023 13:31:44 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t16-20020a62ea10000000b0063b898b3502sm5783273pfh.153.2023.07.13.13.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:31:43 -0700 (PDT)
Message-ID: <e1df21c6-1bf5-ab8c-d66c-7d55eb6df9c9@kernel.dk>
Date: Thu, 13 Jul 2023 14:31:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.5
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZLBdlPjrbvdex1Hq@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZLBdlPjrbvdex1Hq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_133148_237061_D4BC20F3 
X-CRM114-Status: GOOD (  11.38  )
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

On 7/13/23 2:24 PM, Keith Busch wrote:
> The following changes since commit 2fb48d88e77f29bf9d278f25bcfe82cf59a0e09b:
> 
>   blk-crypto: use dynamic lock class for blk_crypto_profile::lock (2023-07-05 16:36:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.5-2023-07-13
> 
> for you to fetch changes up to b8f6446b6853768cb99e7c201bddce69ca60c15e:
> 
>   nvme-pci: fix DMA direction of unmapping integrity data (2023-07-13 08:16:07 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.5
> 
>  - Don't require quirk to use duplicate namespace identifiers
>    (Christoph, Sagi)
>  - One more BOGUS_NID quirk (Pankaj)
>  - IO timeout and error hanlding fixes for PCI (Keith)
>  - Enhanced metadata format mask fix (Ankit)
>  - Association race condition fix for fibre channel (Michael)
>  - Correct debugfs error checks (Minjie)
>  - Use PAGE_SECTORS_SHIFT where needed (Damien)
>  - Reduce kernel logs for legacy nguid attribute (Keith)
>  - Use correct dma direction when unmapping metadata (Ming)

Pulled, thanks.

-- 
Jens Axboe



