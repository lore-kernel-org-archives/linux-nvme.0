Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7FC001DE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V4Oi+U396seMukjWyCgcudTyklaukmgZXAY+HAvJwF4=; b=bvDRxc7LK70k2ykdU0xYmv47vR
	2eJiHjcEaNj8OKXx1Re4oDFj5VJihbgdLQNg3Kkoq//RkWaus8bffoFSPjRm94ZVyPh4NBFZ94PRz
	2BAXTBWfSqyKctXTpeVkjx+f704TaVPh+cua5dv+GJg+FfbCHiJMWv2FVA0elSBhanHFRvoKz4asu
	sOQy7kYzc8s6vDsX5XUHB8k/j3Zvz82kBq18w3yBvx4Qroh+pcIdusUZw/pUHsdIJ36mqReTyN1ja
	g3Sryfx45+w3gA3PSXRy0PJyj7GPZY6NBqm7hhzWU8cSTJWzstscNLQW6TAxOnzWIMPtZcvdr2ye6
	CBE7HHPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgfk-004eXE-1e;
	Wed, 09 Aug 2023 10:44:12 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTgfh-004eTJ-1A
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 10:44:10 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99c3ca08c09so202040666b.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 03:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577846; x=1692182646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4Oi+U396seMukjWyCgcudTyklaukmgZXAY+HAvJwF4=;
        b=B2DyGSidm59DiP6EF722llHnCR9TAkulY6v5sfL+YwwrWg7V40G32I35ZN6I0pHXWX
         d8CsKm+WWWfESYMLbCBukHOR19lWgEp+OP+rkAw3koXI4n7zUTYgmsNuFYxF+h/6tfw0
         yGgPdD8WO20XRttEXSVCNVcvBukGITI76tSX9/X/xCFY2UL35tuZKM3hxP8gQi81S+VR
         VDu5ar4pK5wRFgKfToSLv9yIc0jprzEgqXpCehecX9PJzomnKT0lMeXGpd0ppDV6S5GD
         EtVpSp0eMUt1HJwOjXa1FQRGOuKg4o95ZUtva/T22R4Vq9oXeVGAgFW4kRJJCp4QCXbc
         BxJA==
X-Gm-Message-State: AOJu0YzaQ1ATc6rfuBR+nHLuACUSkCDPfXmcxs+f7gC+US04va0JtJem
	WooXTfblde/Z587aYyd5khE=
X-Google-Smtp-Source: AGHT+IFAhAKxFK5OHSvlFCmWkD8kYoEfFbUpLr9a5GYZeoNFsESfq7iPOoLWK63Vs/JeDWs6rugNPA==
X-Received: by 2002:a17:906:220e:b0:993:eed1:8f7 with SMTP id s14-20020a170906220e00b00993eed108f7mr1665285ejs.3.1691577846550;
        Wed, 09 Aug 2023 03:44:06 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bo21-20020a170906d05500b0099b6becb107sm7924958ejb.95.2023.08.09.03.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 03:44:05 -0700 (PDT)
Message-ID: <28b7fa83-291f-00bc-913d-8a6a7688557a@grimberg.me>
Date: Wed, 9 Aug 2023 13:44:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/16] nvmet: Allow to change 'TSAS' and 'TREQ'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-15-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-15-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_034409_405228_F8F269C4 
X-CRM114-Status: GOOD (  26.95  )
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



On 8/8/23 19:53, Hannes Reinecke wrote:
> Allow to change 'TSAS' and 'TREQ' to values specified in the spec.

I think a little more description is needed here. About the
rules of how the two interact.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 7f826ac8b75c..3c2aeb763e22 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -159,10 +159,15 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
>   	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
>   };
>   
> +static inline u8 nvmet_port_treq(struct nvmet_port *port)
> +{
> +	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
> +}

The function name does not match what it does.

> +
>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   {
> -	u8 treq = to_nvmet_port(item)->disc_addr.treq &
> -		NVME_TREQ_SECURE_CHANNEL_MASK;
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_treq(port);
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> @@ -174,11 +179,16 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   	return snprintf(page, PAGE_SIZE, "\n");
>   }
>   
> +static inline u8 nvmet_port_treq_mask(struct nvmet_port *port)
> +{
> +	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
> +}

Same here, function name and what it returns seem diverged from each
other.

> +
>   static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> -	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
> +	u8 treq = nvmet_port_treq_mask(port);
>   	int i;
>   
>   	if (nvmet_is_port_enabled(port, __func__))
> @@ -193,6 +203,15 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> +	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
> +		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
> +			pr_warn("cannot change TREQ when TLS is not enabled\n");
> +			return -EINVAL;

So what are you supposed to set in treq without tls?

> +		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
> +			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
> +			return -EINVAL;
> +		}
> +	}
>   	treq |= nvmet_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
> @@ -371,6 +390,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_treq_mask(port);
>   	int i;
>   
>   	if (nvmet_is_port_enabled(port, __func__))
> @@ -389,6 +409,16 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   
>   found:
>   	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
> +	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
> +		if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
> +			treq |= NVMF_TREQ_REQUIRED;
> +		else
> +			treq |= nvmet_port_treq(port);
> +	} else {
> +		/* Set to 'not specified' if TLS is not enabled */
> +		treq |= NVMF_TREQ_NOT_SPECIFIED;
> +	}
> +	port->disc_addr.treq = treq;

Hmm, so setting tsas modifies treq under the hood.
Surprising...

It is not clear to me what is the user supposed to set in configfs.
Just set tsas to tls1.3 and that's it? any treq setting will not be
allowed after it? Its a bit confusing.

