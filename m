Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E56C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aaMUNyqon5aG9BmkC40yJDgKJGxouLrsmpbZZ7+6PKM=; b=2HlUfvRQKIXnKi51efnTy1XHFR
	Scx8UrUAC3envNQolDIu9lc+JdEp7BHkBaxhDdadG7Au3U8TOTkCHAESVoQN4qcYehnFeXix17viU
	buoBpnxPncjUw28jFqvt3lh3dMA2EOpRoeXAf73/aMHK0UKxmQPIWQa3qtoqsoczIZzMsWoq8bhpY
	RAcFxTTTN5J65tnjeTZSPavuhjYn6GgYwFm3P2e0WncfMpLTIKiRNRGfy8MljnlCo18yLs2vBxByR
	0Or90VEqhZFnMwNDPGEKn6XTEWpPMNIEbv60GnqLEPStsa7M6tj9PoM9fvq8DkTQ1byxVw1Aq2rah
	Jj2k3qcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXpy-000oMQ-0N;
	Wed, 29 Mar 2023 15:35:46 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXpv-000oJl-0g
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:35:45 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3edc2294fb4so8226435e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaMUNyqon5aG9BmkC40yJDgKJGxouLrsmpbZZ7+6PKM=;
        b=agm48n/cr+yzgl8fmpLXfsSd94Auo5191jQDNu7EGHxZe3HMRqWdm1XyXuJ96TFinB
         vmkDAihaXUOK0Acpr0NTUk/q77pPwx4lwbQkRgtsRHj11Uv4CU0lIAjDul7wUvG3if3h
         ezp67SosPUR3DXWh003GfbkgI9YrrifaaJ2OX0NXiO/1eWmvAJyj5F/WUZmaWyR2TsXm
         bPwOsL8uENRGPon5b506pCjB6NYIyXgJJEAuLmSCXWhnNanyevL5uzodu601p9xrq8i7
         1+A3Wp7R9EpqCy0+JLWyrXdFs5fQObS1E9fvy+hC5Y1Dt22zpksTa53ipZcx5zn49/Me
         tCbQ==
X-Gm-Message-State: AO0yUKXah96egLYUlDdxwRaE4QKusJCwLn47TLF9ZxusDX113TBo6JxP
	rmd9Vymo6nsGTgucI7BOwHs=
X-Google-Smtp-Source: AK7set9LlGViGLAllZqbmx6Q+2o+JLtTSopPe9B5CUX0TkxQ3YJuVyogfBUTmcejvr8bIysQ43sIYg==
X-Received: by 2002:a05:600c:1d03:b0:3eb:42f6:ac55 with SMTP id l3-20020a05600c1d0300b003eb42f6ac55mr17154992wms.1.1680104139009;
        Wed, 29 Mar 2023 08:35:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003ee5fa61f45sm2976683wmq.3.2023.03.29.08.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:35:38 -0700 (PDT)
Message-ID: <ea017b62-2b01-c655-823e-c3dfefca59a1@grimberg.me>
Date: Wed, 29 Mar 2023 18:35:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/18] nvme-keyring: implement nvme_tls_psk_default()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-8-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083543_249409_4D816B76 
X-CRM114-Status: GOOD (  16.43  )
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



On 3/29/23 16:59, Hannes Reinecke wrote:
> Implement a function to select the 'best' PSK for TLS.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/keyring.c | 47 +++++++++++++++++++++++++++++++++++
>   include/linux/nvme-keyring.h  |  2 ++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 4ac33538f839..ca36a061bd48 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -103,6 +103,53 @@ struct key *nvme_tls_psk_lookup(struct key *keyring,
>   }
>   EXPORT_SYMBOL_GPL(nvme_tls_psk_lookup);
>   
> +/*
> + * NVMe PSK priority list
> + *
> + * 'Retained' PSKs (ie 'generated == false')
> + * should be preferred to 'generated' PSKs,
> + * and SHA-384 should be preferred to SHA-256.
> + */
> +struct nvme_psk_priority_list {

nvme_tls_psk_priority_list

> +	bool generated;
> +	enum nvme_tcp_tls_cipher cipher;
> +} nvme_psk_prio[] = {

nvme_tls_psk_prio

> +	{ .generated = false,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
> +	{ .generated = false,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
> +	{ .generated = true,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
> +	{ .generated = true,
> +	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
> +};
> +
> +/*
> + * nvme_tls_psk_default - Return 'best' PSK to use for TLS ClientHello

s/'best'/the preferred/...

