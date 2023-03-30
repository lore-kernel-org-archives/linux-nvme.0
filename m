Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274AC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEB5Mel7Vd54w/4ERCDqxMCUSy7mqUDyjKGbo6pcA/4=; b=YCYfF86M1644lDYEzW1McAZmF/
	Y62vMwjS225Ta8isueZ6G1IMvUOeoq8nq/niMAkYU+XafrCuJjqcGUy0+rCJQvdVzX1meqX9+vif2
	CcdQDpLahbDhDBvVdpH55/K2XB8LK84EjVCcP+Dbg6FNRaO7pNo5+hz2YFhkYcMNH1jVcfZT1CpLO
	sXfnVCnFy2xJNYATAcMXFORwu9MGuRsbgCFktjHWIn3C90zX8eizIrg8KJ7WlAn7jG3UV71auIHH+
	nO5QCpTWNoSgq0wwX5LLY1QzW68rm5t4HawZwQb7nJ+19VqpQ1s5OgHsbn6H+sLQxF6r3m0QrXtc9
	WDZVAHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuo7-004Pid-1f;
	Thu, 30 Mar 2023 16:07:23 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuo4-004Pf3-1W
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 16:07:21 +0000
Received: by mail-wm1-f49.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so8416853wmq.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEB5Mel7Vd54w/4ERCDqxMCUSy7mqUDyjKGbo6pcA/4=;
        b=v19rtt1ILm4sju/ZH0oN4UUg5yvUrA7Z0fP2XcOSolt05hd3PulgdGgzQJjtB4XVu3
         F4FKmKWpz83M90s8qDykPpjs3EJDeAZAzSX4si04/yhkOpoTFAxtdRnjhnR7hlj2qA5L
         OAkNR4VTR6b0fGzbwngW9gjylLdjP5qvxAItkS/QXg71r/CxrXPh6fbqVHy5UTznKOwz
         ySCdBzuvSr7YrwdP0vOta5px0fY/R/FUtIdUsymklTrVDDKMVTI1KTZ0PaIt7QXp+t2c
         eWGKra9p9Aqtn4jKwsBgfwpcp8NOtxFca+rbvAJ6Ys5RmMh/q4JPS60+93nNiBHaCqWy
         rz3Q==
X-Gm-Message-State: AAQBX9eSf0GyqSAMMUZR/xQf5Pt+5AGRo+z2H6GE6GIIWBCFvIrUvlRy
	nYMzwJkwP86Z7/Df45Q6ZIw=
X-Google-Smtp-Source: AKy350bKBX4MA3yXro5wM9AbxV3V7cg5tYMLc2MvvS3H2UrzxMT13MoEydjOCfY0/9y6zq8asJJmuQ==
X-Received: by 2002:a05:600c:3d8b:b0:3f0:34c4:e76d with SMTP id bi11-20020a05600c3d8b00b003f034c4e76dmr2392501wmb.0.1680192425606;
        Thu, 30 Mar 2023 09:07:05 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm6683818wmb.28.2023.03.30.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:07:05 -0700 (PDT)
Message-ID: <6fe0b3db-d60d-822f-b03a-acf697e50ff2@grimberg.me>
Date: Thu, 30 Mar 2023 19:07:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/18] nvmet: make TCP sectype settable via configfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-14-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-14-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_090720_513695_7A498CD7 
X-CRM114-Status: GOOD (  20.23  )
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


> Add a new configfs attribute 'addr_tsas' to make the TCP sectype
> settable via configfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c | 67 ++++++++++++++++++++++++++++++++++
>   1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 907143870da5..ca66ee6dc153 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -303,6 +303,11 @@ static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
>   	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
>   }
>   
> +static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int sectype)
> +{
> +	port->disc_addr.tsas.tcp.sectype = sectype;
> +}
> +
>   static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
> @@ -325,11 +330,72 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   	port->disc_addr.trtype = nvmet_transport[i].type;
>   	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
>   		nvmet_port_init_tsas_rdma(port);
> +	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
> +		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
>   	return count;
>   }
>   
>   CONFIGFS_ATTR(nvmet_, addr_trtype);
>   
> +static const struct nvmet_type_name_map nvmet_addr_tsas_tcp[] = {
> +	{ NVMF_TCP_SECTYPE_NONE,	"none" },
> +	{ NVMF_TCP_SECTYPE_TLS13,	"tls1.3" },
> +};
> +
> +static const struct nvmet_type_name_map nvmet_addr_tsas_rdma[] = {
> +	{ NVMF_RDMA_QPTYPE_CONNECTED,	"connected" },
> +	{ NVMF_RDMA_QPTYPE_DATAGRAM,	"datagram"  },
> +};
> +
> +static ssize_t nvmet_addr_tsas_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	int i;
> +
> +	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
> +		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
> +			if (port->disc_addr.tsas.tcp.sectype == nvmet_addr_tsas_tcp[i].type)
> +				return sprintf(page, "%s\n", nvmet_addr_tsas_tcp[i].name);
> +		}
> +		return sprintf(page, "reserved\n");

What is reserved?

> +	} else if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
> +		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
> +			if (port->disc_addr.tsas.rdma.qptype == nvmet_addr_tsas_rdma[i].type)
> +				return sprintf(page, "%s\n", nvmet_addr_tsas_rdma[i].name);
> +		}
> +		return sprintf(page, "reserved\n");
> +	}
> +	return sprintf(page, "not required\n");
> +}
> +
> +static ssize_t nvmet_addr_tsas_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	int i;
> +
> +	if (nvmet_is_port_enabled(port, __func__))
> +		return -EACCES;
> +
> +	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
> +		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
> +			goto found;
> +	}
> +
> +	pr_err("Invalid value '%s' for tsas\n", page);
> +	return -EINVAL;
> +
> +found:
> +	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(nvmet_, addr_tsas);
> +
>   /*
>    * Namespace structures & file operation functions below
>    */
> @@ -1741,6 +1807,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>   	&nvmet_attr_addr_traddr,
>   	&nvmet_attr_addr_trsvcid,
>   	&nvmet_attr_addr_trtype,
> +	&nvmet_attr_addr_tsas,
>   	&nvmet_attr_param_inline_data_size,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_attr_param_pi_enable,

