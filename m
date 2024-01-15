Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8156C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/L/zwohTcGyvL5vBEEgFc7QhY9G2Dg+wMzy4dnhdmnU=; b=dSjou910nS+7xXEP+ii8kjWE57
	B7iS8GcDnfFV6TdVdKf4uHO1o8gKleI+vgvvsyhj4WyvE6Rf8mtgPaX2TH+4RLUwKSNx5ogV2H80+
	RPv4I7rdNUNPs3pR1isVyrju6QGZuHjPr+ZADfqoKhe3iYkbfeW0RTGDMu4vBnOB8ocIGGdjEdDUM
	/O8ay+Oeih4ex0LkrmsXNqvYWJ8numdROsG3CX3583mYWC12EpIyXxspmZvg86DTxv4mmmwNrU5f5
	bLOuJW/Za5TXMA/qPAXNT7Cju4aESmkN5N16+fyNBXW6y65CQKotNYfXgjD5n+gdbwa+gEfWXO85r
	I3jjrhIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPInA-008Kq9-2T;
	Mon, 15 Jan 2024 08:58:00 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIn6-008KnY-2g
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 08:57:58 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555d89bf8f4so2206981a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 00:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309073; x=1705913873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/L/zwohTcGyvL5vBEEgFc7QhY9G2Dg+wMzy4dnhdmnU=;
        b=gcMTQ0+SM7w5OfV/trWR7dKrzCt4+X363sei6Pihef0caKAWRFct9TpqfyRySYshes
         5XzLeZSKLZhgwX7oWvipM5sQTVRU19kfzaViFOgFitGTdbCa86lKBy3BPzPHoNZb6u93
         B+uEAbvbGfwVJW1xaKuv5dkwcjQYNwXmD61GmARiCSmJ4bp2TYQpGYIxO8qzra4k0sK7
         6Q/Uwi7gWadtZuk6rG6j4vPeaLBz+B8uCXNn12wF7MpGtPFNmmp0aXRLHcS+tHUHXuOi
         4wl0d2uJ6jXe62WJBdt79SqgLX53m4ZcgGOWbYQ6TnmP1BCDwzIP/BwO4MhisMj/Yean
         fZPg==
X-Gm-Message-State: AOJu0YxaBqpdB+A9lFgonI34/bwb/mZ4NP1H4wIk2T3syoRs1ESU5V1d
	8Dt0q+0lfjglKL+lbcnX2+o=
X-Google-Smtp-Source: AGHT+IG6QzG64dtMZQpPuMAzHkybfMi9AugABDo2uAVmjw4I0ZwsdFD9zmZBf+cDnLr7ntZ9qNlsMQ==
X-Received: by 2002:a05:6402:513:b0:557:e527:f799 with SMTP id m19-20020a056402051300b00557e527f799mr4928407edv.4.1705309073352;
        Mon, 15 Jan 2024 00:57:53 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020a50ed0e000000b005550192159bsm5178732eds.62.2024.01.15.00.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 00:57:52 -0800 (PST)
Message-ID: <6c87384e-36ee-4050-863d-63345a6951d5@grimberg.me>
Date: Mon, 15 Jan 2024 10:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Content-Language: en-US
To: =?UTF-8?Q?Sa=C3=BAl_Valdelvira?= <saul@saulv.es>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <20240113213012.30898-1-saul@saulv.es>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240113213012.30898-1-saul@saulv.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_005756_865949_E928048E 
X-CRM114-Status: GOOD (  26.47  )
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


> The WDC PC SN520 SSD hangs on boot when APST is enabled, unless the
> nvme_core.default_ps_max_latency_us kernel parameter is set to a lower
> value. Add an entry for this drive to the 'core_quirks' table with the
> NO_DEEPEST_PS quirk to fix that.
> 
> Signed-off-by: Saúl Valdelvira <saul@saulv.es>
> ---
> This patch fixes an issue I've always had when running Linux on my
> Acer Extensa 215-22 laptop. I think it might be useful to other people
> with the same hardware as mine.
> This is the first time I submit a patch to the kernel, so I hope I did
> everything correctly and that I'm not wasting your time.

Does this issue have a bugzilla link?

> 
>   drivers/nvme/host/core.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0af612387083..496563704c63 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2626,7 +2626,17 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>   		.quirks = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
>   			  NVME_QUIRK_NO_DEEPEST_PS |
>   			  NVME_QUIRK_IGNORE_DEV_SUBNQN,
> -	}
> +	},
> +	{
> +		/*
> +		 * This SanDisk SSD hangs on boot unless the
> +		 * nvme_core.default_ps_max_latency_us kernel parameter is
> +		 * set to a lower value.
> +		 */
> +		.vid = 0x15b7,
> +		.mn = "WDC PC SN520 SDAPNUW-512G-1014",
> +		.quirks = NVME_QUIRK_NO_DEEPEST_PS,
> +	},
>   };
> 
>   /* match is null-terminated but idstr is space-padded. */
> --
> 2.43.0
> 

