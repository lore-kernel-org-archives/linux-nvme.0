Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9FDC6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FaMmgvN463wn8/4vPI+oqIbv/Zy1HNYnDfVcekpYeZc=; b=fDonODBhNL2JNOhP9038/HsqhD
	pstBJ2PFLya62RtNpb/KQRTsU7hcrXrMFi5Fr77V6GDRRt9TKUmuZ8fArlnwDRIy7kTqM56Nm/39r
	gf0cd/W2gTKp9xQyVhw/qX88lgYU4DA55WEaBbsugI6P2YAdJXf2Cp/PLqXbmWuXncnZcf0saLD1z
	oWsC775sdwIsGwui/t45lS+0UgJIn8fY0LCPvm9dHr47zdLhvKzBWBZvd+nX3SmjPq1uSE9Mr3JSq
	49NpVaA6ia8kLRkMStmnu02GcVwW5jc6ktpg+S7d0QT6JYoItIsPKNUDsWA/YX0PPcCgXJoePFLfO
	pjt7YaAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXM3-000iIf-2s;
	Wed, 29 Mar 2023 15:04:51 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXLw-000iGf-1f
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:04:50 +0000
Received: by mail-wr1-f49.google.com with SMTP id t4so10842078wra.7
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102282; x=1682694282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaMmgvN463wn8/4vPI+oqIbv/Zy1HNYnDfVcekpYeZc=;
        b=cnF7iPGbfbkV74iHNciFF7wlGo5bP7XvgAZr2IIS94kNuZz3UWFANI6RnXKWgd7KS4
         2q45R6hpH4m2W5btYuc5BgvqJzIvlhGxoAj7FdToXloZdJcwsQu230pBLhKX+xA+SphN
         Z8a5HzVIbS/Ng1Uv+rlGejvhOxRokFbeTg93waLui6DfpvhFwc72mQ74gRYQTJNJsNto
         D1IU8kEmWRHyMbaleAiJ+eG6vzx0IM7tANZs2sn9Np1+ote2EtlVod0zQboQa5GcZ8jd
         +ZC+UbfjkxaxPjpkPNrGic8aYVPNblpximWZQtC/iawIOyJuHh2Z2kcV9+M8cRELodDK
         nUjg==
X-Gm-Message-State: AAQBX9cILMc0U0p+1aTe7Q6FnwBjMTlCpiZEkW1FQS8GDD0KSL1Cl3T8
	EIRWNjQklm36aa2LeGV+bWo=
X-Google-Smtp-Source: AKy350a/ybQEwx5CIpXlxwAzQAbA4x7eork5uF7n3MsqZYaXUcTKFwn/qz9QQLbUVyeGkWiWuwRthg==
X-Received: by 2002:a5d:4d88:0:b0:2c7:1c72:69ac with SMTP id b8-20020a5d4d88000000b002c71c7269acmr11567152wru.2.1680102281899;
        Wed, 29 Mar 2023 08:04:41 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d5646000000b002d2f0e23acbsm30333482wrw.12.2023.03.29.08.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:04:41 -0700 (PDT)
Message-ID: <2cfb1620-a09e-87ed-9224-5e94afc0747f@grimberg.me>
Date: Wed, 29 Mar 2023 18:04:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/18] nvme-keyring: register '.nvme' keyring and add
 CONFIG_NVME_TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_080444_552145_EFE79A51 
X-CRM114-Status: GOOD (  15.79  )
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


> Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
> add a new config option NVME_TLS to enable support for NVMe-TCP/TLS.
> We need a separate keyring for NVMe as the configuration is done
> via individual commands (eg for configfs), and the usual per-session
> or per-process keyrings can't be used.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/Kconfig   |  9 +++++++++
>   drivers/nvme/common/Makefile  |  1 +
>   drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/core.c      | 19 +++++++++++++++---
>   include/linux/nvme-keyring.h  | 12 ++++++++++++
>   5 files changed, 74 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/nvme/common/keyring.c
>   create mode 100644 include/linux/nvme-keyring.h
> 
> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
> index 4514f44362dd..b6fff16da1fb 100644
> --- a/drivers/nvme/common/Kconfig
> +++ b/drivers/nvme/common/Kconfig
> @@ -2,3 +2,12 @@
>   
>   config NVME_COMMON
>          tristate
> +
> +config NVME_TLS

Better to call it NVME_TCP_TLS... although not a biggie, should be
well understood this is tcp

