Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2CACA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPs86aSbZgX8fWc8IXfIeDTwG8EaRAglf608cFsaxpE=; b=MQEPYSTsPPLvoVTNF7WK32kGJh
	myFQ59ofi+LC3BSUOlUCjbJKqCNr9/kg4lkzxfpgbkO2z2kBcbIRycbg9X4ov3F9vBW+SFJPD14d5
	evH479YhrhSaEFLX7Jj15RS6ao6kA3YjzORqIPjxYJfulMJwuVXO36KeBSxnDhggYP3vcfMtHLRwq
	tgbAXsPHIDmYLuNsKSZB3+AD2U6hidRqywTZrs1s8/waiMVWAvc2TYvZwOj1A4P2PeHVAbWwaw418
	zTKoI2pUhOrNy+bEig+IzDpCJXisscl/FC5pfoGaHf7pocsVeEDlN4ZvXxIzHLL0V8G68uyHHOKaa
	iKKDMgxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1d5-003DLd-0b;
	Tue, 12 Sep 2023 11:32:27 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1d2-003DKY-0F
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:32:25 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so1174963a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518340; x=1695123140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPs86aSbZgX8fWc8IXfIeDTwG8EaRAglf608cFsaxpE=;
        b=WBeYs5xcZasxJJfLollknePmgVaRwhw2U3WAEgbCHIia23PJ+ZU3+TJnOjQPeqyrQW
         XLnXRHLE1PLa6lJ5vICb9TOk634uXoYC0F0DqUGNJzT1Lkzvq7AkaHUrqcworRAweeJR
         B9hMGVv3Zk0fkE2zD7AiJfo+fepUd0K6bB5iZ3wkCxk6fDTzr0sOt8pLNhT0FNaE9OH9
         Pd/MprHuYx+nTxQQPSovLwBTnGy1OXLTIYP+PN0BujzSnTzDPsnge/FSWmwZY3ZH0mfI
         oe2HPBsaVjYwc23YK3egVIryIxw+D0kArMDaByWHcbk8huLtWAg51MCZotN6snCae48F
         wINQ==
X-Gm-Message-State: AOJu0Yxp98OwxjhMmrETddXtkpwIuRV8d2WV5V2tX0nDfs6IPIeaO/oP
	vqF3jPsSKcWkXjNNrIZJb6s=
X-Google-Smtp-Source: AGHT+IEMVIatcRC7BVXoxFi1FVTJoGCn9Y9MO7vSDOYO1QEJehV8fS+jddEtQsCcvGnTjnBh6W14dg==
X-Received: by 2002:a05:6402:4404:b0:521:d2fb:caa1 with SMTP id y4-20020a056402440400b00521d2fbcaa1mr11824515eda.0.1694518340274;
        Tue, 12 Sep 2023 04:32:20 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cfd2000000b00527e7087d5dsm5712709edy.15.2023.09.12.04.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:32:15 -0700 (PDT)
Message-ID: <b545b658-0771-6c53-fc9d-a69e452909c1@grimberg.me>
Date: Tue, 12 Sep 2023 14:32:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-19-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230824143925.9098-19-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_043224_110204_85581D99 
X-CRM114-Status: GOOD (  25.20  )
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



On 8/24/23 17:39, Hannes Reinecke wrote:
> Incoming connection might be either 'normal' NVMe-TCP connections
> starting with icreq or TLS handshakes. To ensure that 'normal'
> connections can still be handled we need to peek the first packet
> and only start TLS handshake if it's not an icreq.
> With that we can lift the restriction to always set TREQ to
> 'required' when TLS1.3 is enabled.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 25 +++++++++++---
>   drivers/nvme/target/nvmet.h    |  5 +++
>   drivers/nvme/target/tcp.c      | 61 +++++++++++++++++++++++++++++++---
>   3 files changed, 82 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b780ce049163..9eed6e6765ea 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -198,6 +198,20 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> +	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP &&
> +	    port->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13) {
> +		switch (nvmet_addr_treq[i].type) {
> +		case NVMF_TREQ_NOT_SPECIFIED:
> +			pr_debug("treq '%s' not allowed for TLS1.3\n",
> +				 nvmet_addr_treq[i].name);
> +			return -EINVAL;
> +		case NVMF_TREQ_NOT_REQUIRED:
> +			pr_warn("Allow non-TLS connections while TLS1.3 is enabled\n");
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>   	treq |= nvmet_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
> @@ -410,12 +424,15 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   
>   	nvmet_port_init_tsas_tcp(port, sectype);
>   	/*
> -	 * The TLS implementation currently does not support
> -	 * secure concatenation, so TREQ is always set to 'required'
> -	 * if TLS is enabled.
> +	 * If TLS is enabled TREQ should be set to 'required' per default
>   	 */
>   	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
> -		treq |= NVMF_TREQ_REQUIRED;
> +		u8 sc = nvmet_port_disc_addr_treq_secure_channel(port);
> +
> +		if (sc == NVMF_TREQ_NOT_SPECIFIED)
> +			treq |= NVMF_TREQ_REQUIRED;
> +		else
> +			treq |= sc;
>   	} else {
>   		treq |= NVMF_TREQ_NOT_SPECIFIED;
>   	}
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e35a03260f45..3e179019ca7c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -184,6 +184,11 @@ static inline u8 nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *por
>   	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
>   }
>   
> +static inline bool nvmet_port_secure_channel_required(struct nvmet_port *port)
> +{
> +    return nvmet_port_disc_addr_treq_secure_channel(port) == NVMF_TREQ_REQUIRED;
> +}
> +
>   struct nvmet_ctrl {
>   	struct nvmet_subsys	*subsys;
>   	struct nvmet_sq		**sqs;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 67fffa2e1e4a..5c1518a8bded 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1730,6 +1730,54 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   }
>   
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS

You need a stub for the other side of the ifdef?

