Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D2FC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hMXTlifNwEtyhjKQwEWg4nneH/CSI2ufV3qFNsdJu4=; b=NCVye+Z/+f1unoMI2ECc+2LDhh
	we2FCuu+iWwdczvzUYHgPk+zO8WoQ8Z98XFUteYLl00so28Q3QXyJAEBeR2rjNZfg4LzcQaPmUOOT
	yZLhfdEId9ZNEjrkl/5USmshiPOhvI3YdlN7y2CQWcd8QcfZW0S3VbZMzOC3uF2S/kNmSLMcm5oPK
	/X0KeYFH03e0RePcFj5GEL8SUtbSlieLHI5zbo9JqjJX/hINsV2/gp2yanQb8BXZsZSgKzHJqp6vQ
	oTgvDUSPeP4o8APltleydl96++9KERV/ZIVSxEDWssSG6Q/Zhgi9qc6uhhv1DMzQegQBlKlK8xiWB
	aK0xuHbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBK8-000000049zn-1zlz;
	Thu, 07 Mar 2024 10:50:04 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBK5-000000049xs-0b1U
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:50:02 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33db19538d0so176043f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808600; x=1710413400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hMXTlifNwEtyhjKQwEWg4nneH/CSI2ufV3qFNsdJu4=;
        b=X98e9cLLWXz3yPVUtV3j9x6KwBrAztzvyYll8PsU8XaT/blryb98ml5eGoSOrF80ce
         3Qtvt9VGnFxg1I8VQusaeH0XdGHRebmAgx3Q3ViLFPy9anCqubspI21i2L2hHdEBkh64
         fsZAr0ypKJ4AMSwM2wO6qYiZ/PvWXHv5zVcDtCUVq+PV8bBae2KykT+7T6WN2AZOHECQ
         XujQDK1bAAn05qdVju0H226FtIJvc6JbJqd8Akp0iCzLfcOPORQXpV3ZLIdhV2CvbYEY
         4bO3nL2ZZlnL7UJ2oMX179ENPvXpe8unK0ylh10hPvSbrnJz2lnjU+oqwd+iCsuOQCKD
         vmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5f7ETO4WZpHkXTXZ2X486jzYCxbZkNhpNVXO75O3FyNmUPnyezYGsxhqqgfC11gv2tPraBOR4iZxnIfcTBaydDcqKFHUnSPt1jwXWE0=
X-Gm-Message-State: AOJu0YzjyfRFyHtPqR5P90xSj4DCqnmF4dy/QBYgv1gsG34z37YohASH
	Z/7wyOTUMBZAc3326sTQ6LfUzfBj6qfhE0EFEyar37NMMYBfP17eubrxShgX
X-Google-Smtp-Source: AGHT+IGd5zp75pmP/s8byQEByzNa+xmufe3IPf07Nq0Dko1VXTHjlGNSdDrYDp2Fh3sVgjfsRGrSPw==
X-Received: by 2002:a05:600c:1d0f:b0:412:f82b:9cb8 with SMTP id l15-20020a05600c1d0f00b00412f82b9cb8mr1165825wms.4.1709808599655;
        Thu, 07 Mar 2024 02:49:59 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b004130c1dc29csm2246778wmb.22.2024.03.07.02.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:49:59 -0800 (PST)
Message-ID: <f43dc8c9-3377-40c2-a384-906fe893c80c@grimberg.me>
Date: Thu, 7 Mar 2024 12:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] nvme-keyring: restrict match length for version '1'
 identifiers
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-7-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_025001_231055_B4B696BB 
X-CRM114-Status: GOOD (  15.69  )
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



On 27/01/2024 11:30, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> TP8018 changed the TLS PSK identifiers to append a PSK hash value,
> so to lookup any version '1' identifiers we need to restrict the
> match length to exclude the PSK hash value (which we don't have
> when looking up keys).
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/keyring.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index c16f9496643f..51b99b34e100 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -44,6 +44,27 @@ static bool nvme_tls_psk_match(const struct key *key,
>   		return false;
>   	}
>   	match_id = match_data->raw_data;
> +	if (memcmp(match_id, "NVMe1", 5)) {
> +		char *e = (char *)match_id;
> +		size_t offset = 0;
> +		int n = 0;
> +
> +		while (*e != ' ' && offset < match_len) {
> +			if (*e == ' ') {
> +				n++;
> +				if (n == 3)
> +					break;
> +			}
> +			e++;
> +			offset++;
> +		}
> +		if (n != 3) {
> +			pr_debug("%s: error parsing '%s'\n",
> +				 __func__, match_id);
> +			return false;
> +		}
> +		match_len = offset;
> +	}

My eyes hurt... I am failing to understand what this even does...

You have a concrete example?

