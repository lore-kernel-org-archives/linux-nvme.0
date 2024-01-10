Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F81C4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4cjUFpAaxNghmr8LUZ7v5C5NqE2mQJ+A+Isez+wOf0=; b=Jb82Dl7bn4M4+gZRtM299SLHrx
	kDFAkgoUc2VJja6qaUM0bZPrqc2sf9U9nJIU1UdGZUfAYBoO5NX+LhYkB9M3ziZOUkbe38rSPH7XY
	H6M8L+RL3jNUEdWNMEsYk6baOq3D6OQw288yYVPkR5uvKjWKB0KweeVcgRUAAkOJ3b4uNVEHN19a0
	IoJWzx42dfMpTSLS7rJBOIGZzU5q8ZIcG1FpaQj6qb/nczSPYgT3EPCiBiecGTXorHPLgLYzBkzmZ
	h2CSmWVYmIijzsQkkigb8oTQeOAsqxBN0VCftJPED+SkThGDUYdzg9jtRfGhfXJ+34i3odUtvUKK3
	ZlnRt4qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNh31-00ETOM-1M;
	Wed, 10 Jan 2024 22:27:43 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNh2x-00ETMo-2E
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 22:27:41 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2866b15b013so1225067a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704925658; x=1705530458; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4cjUFpAaxNghmr8LUZ7v5C5NqE2mQJ+A+Isez+wOf0=;
        b=yrmiDlCsMI4UZeZ89E6qIOCHsLKMp8cvEybuaJ+no55RWdu8NYJ5qqCAas9srpq0H/
         IwLObGB2cx5hu49jJ/6oGlAn6aMOQgq8j9kRkofx7M5uZWiXOCOsHcU3n0vuX9PHW9to
         uOk0g62Nuu6YNSBg1wvmbwSKvW8pQkBhejohYjrXUmH3NGgRV1v6i2PNfDKY79vRaLcJ
         8x4Nc/ohau0Fa9YH0wkTrIXsWs4UKlNY46VArpblcv3hk8h5UepnDfyokz1Q6eWxvsBt
         ku2nSVifiOsEDRkkFgPZeDJxv/RKC15coavgG+PhCarhDelGi9xMGvUp4l2k3qpPK/6P
         Stsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925658; x=1705530458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4cjUFpAaxNghmr8LUZ7v5C5NqE2mQJ+A+Isez+wOf0=;
        b=hFbMZbmZfFqC2OQgXyqF+51U2856aPscIWHQLAp+el1BDL/Pt7qnLkPrnqu8u/Zqwo
         SNaIQlKxO0fueFWHbQbjae7q9paAjj+rnRNRnX2ftDJsKIQfXEv15QVzRdYVL2wDxtoM
         Hi1HSZHQ8qV3PMv6pAPfVCBVoTfcxAvT8/tM169CfDmdHTiS8fJRttBzc+DH7eaVRcrW
         6u8t9vBjzXC5sIngy61pl7j3ioijQfm+kQnLBIZd7LPYtyEWVDsBst53sj4Jokhsh3++
         BEWKbGpCuVu7h1UbWhXvGWVu70TokaO5Xv+MMTbROuenhPLF/roTv0vt9kbL7NYetvSZ
         fMNw==
X-Gm-Message-State: AOJu0Yzi8K/dWiyx7BUCA/OUIGzhWKp6vA/huX1QdOBogC5lgVKOkSTC
	fURCnjw4gdtvhOckKSYVIK39CtEm/OIv9w==
X-Google-Smtp-Source: AGHT+IFkWxef9Hn2rbsysq8VBuFtIuVLbCJ3G9oN7JOQnRKqkKDG5Cdwbs0EAdijE+/RPAHYifEwjg==
X-Received: by 2002:a17:90b:3903:b0:28c:fe8c:aa93 with SMTP id ob3-20020a17090b390300b0028cfe8caa93mr420792pjb.1.1704925658323;
        Wed, 10 Jan 2024 14:27:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jw3-20020a170903278300b001d3ec25614bsm4136214plb.24.2024.01.10.14.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 14:27:37 -0800 (PST)
Message-ID: <04c37721-8abe-4795-a601-145eeaa16ffa@kernel.dk>
Date: Wed, 10 Jan 2024 15:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme follow-up updates for Linux 6.8
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZZ8O2rVaFSnPQoGG@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZZ8O2rVaFSnPQoGG@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_142739_958133_2CB59E0C 
X-CRM114-Status: GOOD (  10.18  )
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

On 1/10/24 2:40 PM, Keith Busch wrote:
> The following changes since commit 31e4fac930814f2f92eb6ebac9c4d4e3b09f7aaf:
> 
>   mtd_blkdevs: use the default discard granularity (2023-12-29 08:44:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.8-2024-1-10
> 
> for you to fetch changes up to 31deaeb11ba7a885116c9c30892b9f763c04d59c:
> 
>   nvmet-rdma: avoid circular locking dependency on install_queue() (2024-01-10 13:27:45 -0800)
> 
> ----------------------------------------------------------------
> nvme follow-up updates for Linux 6.8
> 
>  - tcp, fc, and rdma target fixes (Maurizio, Daniel, Hannes, Christoph)
>  - discard fixes and improvements (Christoph)
>  - timeout debug improvements (Keith, Max)
>  - various cleanups (Daniel, Max, Giuxen)
>  - trace event string fixes (Arnd)
>  - shadow doorbell setup on reset fix (William)
>  - a write zeroes quirk for SK Hynix (Jim)

Pulled, thanks.

-- 
Jens Axboe



