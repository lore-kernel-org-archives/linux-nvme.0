Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA04BECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrHxI6t4Dj2JAtg+uu0daAVbi/0TARHiEDVmd3GE4Tk=; b=AH4OGIWPTOyYyfzyEctILqOna3
	YRLsVej8xMmM6nnRe+SOAKzKXketLZKe0uLnIvizRuKiILsQIkAjACCNUbWW729UX9/NKJegp2XkG
	v1X3Wi4hdSLESnIiWl86R5DppRrjzss5Otg8tCk1J3MKNUYkjGM22pHHqo8IPGdxVCe4UUljYfEd7
	6xl6ozkOA1yUrxxjmx20oYu8MqDOlgGptsntWHI7WGKrRSOmaP9eXrfFezL6dYUqE+Ctte0WwFwAE
	9rlfD/5A0MF3MOyTbRYt7XqL97k0tIcTAOSx7RD4vWWnl5UL4KPGHuj3r3jQl6hILn3FhAsNQXePh
	znIz/5QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oThz1-00BE1M-VD; Thu, 01 Sep 2022 11:03:39 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oThyy-00BDvC-Sr
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 11:03:38 +0000
Received: by mail-wr1-f43.google.com with SMTP id k9so21883856wri.0
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 04:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XrHxI6t4Dj2JAtg+uu0daAVbi/0TARHiEDVmd3GE4Tk=;
        b=skQB4nexlJGpa/afV8M3QFt8xQGg6uqZuRTIt/EsR4MpaSZEow7mNEwMhXz+qGojqq
         HYz6i3B9wCgciAu+S7DsyToly0tf4PGe3R2Fn9JMqpOHuUmYf+RJBsexsT0sudxXdXIF
         OyvqEzwfFGpffRfcbyNoFufaFvQGCLVjLHOTSGWyMmJV3bEimTSqmeuG8EhO2JAM1Tlu
         Uhq/gI/eryosg06xQ6FLrCFXAto9dZ+mTAkPxOlMiemfetMnsAN4sHRvIvK1ofrz5tBo
         R4D3fVPEVMv02UNAJcsGVgQPELKUgn/i2hJCEs97bbkaQeJDeTuBSRfZeOpAxSpLlF8Q
         l3xw==
X-Gm-Message-State: ACgBeo2rRtG3XqFFJhP8rk3cyD9rrPXqUTHyxcGlYA3antQLX8w8u72N
	ZsAwQxPTukAYgLlfvNLZg1Q=
X-Google-Smtp-Source: AA6agR4JQCc56wSZYRVKVvQAKhLhwrcpzRL1h7RIwlwxScc1YSQwW79B3HdO6yev2X/TSMpH6hRShw==
X-Received: by 2002:a5d:63ca:0:b0:225:899f:4e5c with SMTP id c10-20020a5d63ca000000b00225899f4e5cmr14657142wrw.697.1662030204476;
        Thu, 01 Sep 2022 04:03:24 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bcbda000000b003a331c6bffdsm4606273wmi.47.2022.09.01.04.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 04:03:23 -0700 (PDT)
Message-ID: <f9a17bb8-a101-6478-db5f-6573c8a472ef@grimberg.me>
Date: Thu, 1 Sep 2022 14:03:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvme-tcp: Print actual source IP address in address
 attribute
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB429186CED76BA96A2AD3D7AE9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB429186CED76BA96A2AD3D7AE9C789@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_040336_968226_68F01211 
X-CRM114-Status: GOOD (  32.65  )
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



On 8/31/22 22:38, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TCP transport relies on the routing table to determine which
> source address and interface to use when making a connection.
> Currently, there is no way to tell from userspace where a
> connection was made. This patch allows exposing the actual source
> address using the host_traddr field of the address attribute.
> 
> This is needed to diagnose and identify connectivity issues since it will
> allow us to tell which interface and source address is associated with each
> connection.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 044da18c06f5..adbb76483a74 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -165,6 +165,7 @@ struct nvme_tcp_ctrl {
>   	struct blk_mq_tag_set	admin_tag_set;
>   	struct sockaddr_storage addr;
>   	struct sockaddr_storage src_addr;
> +	struct sockaddr_storage sock_addr;
>   	struct nvme_ctrl	ctrl;
>   
>   	struct work_struct	err_work;
> @@ -1597,6 +1598,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>   		goto err_rcv_pdu;
>   	}
>   
> +	/* Retrieve the actual source address from the socket */
> +	ret = kernel_getsockname(queue->sock,
> +		(struct sockaddr *)&ctrl->sock_addr);
> +	if (ret < 0)
> +		memset(&ctrl->sock_addr, 0, sizeof(ctrl->sock_addr));
> +

For every queue?

>   	ret = nvme_tcp_init_connection(queue);
>   	if (ret)
>   		goto err_init_connect;
> @@ -2532,6 +2539,31 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	return queue->nr_cqe;
>   }
>   
> +static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
> +{
> +	int len = 0;
> +	struct sockaddr_storage *sa = &to_tcp_ctrl(ctrl)->sock_addr;

You can just retrieve the sock_addr from the admin queue here locally. I
don't think we need a struct member for it.

> +
> +	if (ctrl->opts->mask & NVMF_OPT_TRADDR)
> +		len += scnprintf(buf, size, "traddr=%s", ctrl->opts->traddr);
> +	if (ctrl->opts->mask & NVMF_OPT_TRSVCID)
> +		len += scnprintf(buf + len, size - len, "%strsvcid=%s",
> +				(len) ? "," : "", ctrl->opts->trsvcid);
> +	if ((sa->ss_family == AF_INET) || (sa->ss_family == AF_INET6)) {
> +		len += scnprintf(buf + len, size - len, "%shost_traddr=%pISc",
> +				(len) ? "," : "", sa);

It is confusing to expose that if it was not specified, that is creating
a different behavior from the existing behavior and from other
transports.

> +	} else if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
> +		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
> +				(len) ? "," : "", ctrl->opts->host_traddr);
> +	}
> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
> +		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
> +				(len) ? "," : "", ctrl->opts->host_iface);
> +	len += scnprintf(buf + len, size - len, "\n");
> +
> +	return len;
> +}
> +
>   static const struct blk_mq_ops nvme_tcp_mq_ops = {
>   	.queue_rq	= nvme_tcp_queue_rq,
>   	.commit_rqs	= nvme_tcp_commit_rqs,
> @@ -2563,7 +2595,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
>   	.free_ctrl		= nvme_tcp_free_ctrl,
>   	.submit_async_event	= nvme_tcp_submit_async_event,
>   	.delete_ctrl		= nvme_tcp_delete_ctrl,
> -	.get_address		= nvmf_get_address,
> +	.get_address		= nvme_tcp_get_address,
>   	.stop_ctrl		= nvme_tcp_stop_ctrl,
>   };
>   

