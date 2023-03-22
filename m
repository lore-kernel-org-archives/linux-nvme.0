Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7300EC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hcaWn3x8HzznlCP6STce0PW7pEnfcSv58C95Y57nBhw=; b=0XrD/lyLkU8YbW8qF4TnN/YsY6
	V8cEFAwcNnSvudCB9XkpYS6IBJc5v0G2+a+CGOsxifi4a6oM2vLGoIWuSXz8wSufVUccpuuU9mXBE
	1tEpttOi34KeSkvOL1oMb2evj+raq8v1BOXeEQcxHuIuUG3Ac7WbZclCdNpk1SsJ4Zjw4waEwQ/R2
	EbbwyFc2zl86j1xb+ifl0pQ37Y1OR23uCrPXHv9ABhJFSPzLcYsPcAk0XtX8uDYGACZo0TjqGRiuu
	3Nyq4TI6iIxRHzQvToeD9Gw5aW5/hP/0wCDS5OLwaT0LWbbnFxxQzode43gJzteRhs5sqIbj8zQhu
	n4zV8KsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewnq-00FnUG-2C;
	Wed, 22 Mar 2023 11:38:50 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewnn-00FnTK-0N
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:38:48 +0000
Received: by mail-wm1-f43.google.com with SMTP id m35so11300131wms.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 04:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcaWn3x8HzznlCP6STce0PW7pEnfcSv58C95Y57nBhw=;
        b=Wy9UjP9F+JhSBfsD14VO5bnEEG7yeFj3QFOQyVcnZ2OGEjAazC09UXKUJ8O38v2rbp
         m4055BqiLzOaf2evHTMz1PBk9UrgbKW7FpX5NHRuXJpIC7bDwExycj/URJctZ/niLt65
         pmYbrMY1o+ggvaaDEjikaH8LdOkngIKIo4Qe6xl3tHeh8cmjeyrFwqpHMFeO8efu64i+
         N5642kSfhjaKOgrNEK0YRSm0jDBfrxFF5IuX0WbwRPOOwS139rK5FMWUCE0LHHFYaAKC
         lSVVgx5I21qArdLT5SjxVaGDjZc81X2zxSL3u8Itns4lA5TROcJ3h0Ae6qDeHwOELeu6
         MX3w==
X-Gm-Message-State: AO0yUKWB3fnlGVPaqJke1mQsDSbI7D+9pcXm3SXree4EqQjYkNflMnhv
	++4BHMhugUAakKbvfSbhhkg=
X-Google-Smtp-Source: AK7set/cS9T1f2OhOp2yDxXdAePB9QWSYDGEQr05zRfavj481WUVhscxVRbCTjYXNrrxuMSAOvpWKQ==
X-Received: by 2002:a05:600c:45c3:b0:3eb:42f6:ac55 with SMTP id s3-20020a05600c45c300b003eb42f6ac55mr6175232wmo.1.1679485123074;
        Wed, 22 Mar 2023 04:38:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b003ee1acdb036sm6350921wma.17.2023.03.22.04.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:38:42 -0700 (PDT)
Message-ID: <5ca8be56-e28e-52c9-f632-e6e6d864245c@grimberg.me>
Date: Wed, 22 Mar 2023 13:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 12/18] nvmet: make TCP sectype settable via configfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-13-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_043847_156336_88069544 
X-CRM114-Status: GOOD (  21.87  )
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
>   drivers/nvme/target/configfs.c | 65 ++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 907143870da5..d3d105a1665c 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -303,6 +303,11 @@ static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
>   	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
>   }
>   
> +static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int tsas)
> +{
> +	port->disc_addr.tsas.tcp.sectype = tsas;

Better to call the argument sectype.

> +}
> +
>   static ssize_t nvmet_addr_trtype_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
> @@ -325,11 +330,70 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
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
> +	{ NVMF_TCP_SECTYPE_TLS12,	"tls1.2" },
> +	{ NVMF_TCP_SECTYPE_TLS13,	"tls1.3" },
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
> +	} else if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
> +		switch (port->disc_addr.tsas.rdma.qptype) {
> +		case NVMF_RDMA_QPTYPE_CONNECTED:
> +			return sprintf(page, "connected\n");
> +		case NVMF_RDMA_QPTYPE_DATAGRAM:
> +			return sprintf(page, "datagram\n");

There is no way that datagram is supported. Not even sure why it exists.


> +		default:
> +			return sprintf(page, "reserved\n");
> +		}
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
> @@ -1741,6 +1805,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>   	&nvmet_attr_addr_traddr,
>   	&nvmet_attr_addr_trsvcid,
>   	&nvmet_attr_addr_trtype,
> +	&nvmet_attr_addr_tsas,
>   	&nvmet_attr_param_inline_data_size,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_attr_param_pi_enable,

Overall though this looks good.

