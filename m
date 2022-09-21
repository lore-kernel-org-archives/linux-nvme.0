Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCD9C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3127fbFYbYPTVzJCtPT6JDJz6aSRwQRgLTvUBXZAvT4=; b=UVsJkuOe7B8rhGPY4xShnElRYv
	Z7yRfSWvLzkQvDw/WbdAc/yPdLGb4idVe6cEsg9X4NteDjDKXVXOP+zKrUWOxanO3/1Q6zGYPJ/hy
	PSjvkhKo2GO3jcujw1F2RJO2RSJO6Vz4kos8aM6pfUUyXHu6hvaUdoUnaMsmXeNuXf9zmxMiGnlBG
	gUbDXHja7QPrFtI+kwO9T6UoSIt7k/rDFe2d7r/Yps0FXloKl77OtTMt25VN5KHyaUVIqwNCpuEPx
	3r9PfTRJwlHdQzy3PVWMtYqZaoqyPrw80uwFPcmd2Wz2tfXujV/2xVC10g58erkW10dzIVni+zvHQ
	C58OvobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oavFS-00A1Zf-2e; Wed, 21 Sep 2022 08:38:26 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oav2h-009vyT-4E
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:25:16 +0000
Received: by mail-wr1-f54.google.com with SMTP id x18so2559730wrm.7
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3127fbFYbYPTVzJCtPT6JDJz6aSRwQRgLTvUBXZAvT4=;
        b=Kluf9lrLWqBiBR/HyGj70Eduh4mUIOoHsk+tonL8ckghhcoq3QPgrRXK7fHXi4I6DF
         Ety2gnk11FVYDPdR5SusTq7GRrwTtbt4m4S/KNda+r+ZieNRy2bAjatsQ71C9ZbeDuTw
         yZmNcgP9d+63FFDRbTB8mPyNVAbMXatxERNKrGjO3bXlbB6YAlnre6573JHW1WDTPZ4R
         jQxKv2b3+m7Kapjz0XCuevWzo/6TPPErXr6g4rZHCe+oHhggZsm31ZZWFtRzrb0smB2p
         YjPQlBoiaxTdHhhYCyqS3OpqGjF4rIlcENrdvAV/vOq+OxuxhU8aFvw8vaCD/Je/2V5K
         1w/w==
X-Gm-Message-State: ACrzQf0mLZC0ZoWMbjeZigSXzIXOvLbUFEQDOMvfRVFd0ZKMn6FX1Z4n
	Udy59T9NfSJu7VLkEdQvwgg=
X-Google-Smtp-Source: AMsMyM5Z8EKjHwrJd2YeEoodh3o+GSlvhg7CPnSuGb/G4yL8IzYdrcSoUYQ56TlCeqnPXcdc3ORrrA==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id y9-20020a056000168900b0022aa66d1f37mr16630988wrd.197.1663748713130;
        Wed, 21 Sep 2022 01:25:13 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d4e43000000b00228dc1c7063sm1781074wrt.85.2022.09.21.01.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:25:12 -0700 (PDT)
Message-ID: <cc827eb3-96d2-ff65-7204-05213bc018e8@grimberg.me>
Date: Wed, 21 Sep 2022 11:25:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_012515_220562_AE88FD53 
X-CRM114-Status: GOOD (  21.20  )
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



On 9/20/22 20:15, Christoph Hellwig wrote:
> Add common helpers to allocate and tear down the admin and I/O tag sets,
> including the special queues allocated with them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 100 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |   8 ++++
>   2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8c9c1176624da..f8d9f32adc87c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4800,6 +4800,106 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
> +int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size)
> +{
> +	int ret;
> +
> +	memset(set, 0, sizeof(*set));
> +	set->ops = ops;
> +	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set->reserved_tags = NVMF_RESERVED_TAGS;
> +	set->numa_node = ctrl->numa_node;
> +	set->flags = flags;
> +	set->cmd_size = cmd_size;
> +	set->driver_data = ctrl;
> +	set->nr_hw_queues = 1;
> +	set->timeout = NVME_ADMIN_TIMEOUT;
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ret;
> +
> +	ctrl->admin_q = blk_mq_init_queue(set);
> +	if (IS_ERR(ctrl->admin_q)) {
> +		ret = PTR_ERR(ctrl->admin_q);
> +		goto out_free_tagset;
> +	}
> +
> +	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +		ctrl->fabrics_q = blk_mq_init_queue(set);
> +		if (IS_ERR(ctrl->fabrics_q)) {
> +			ret = PTR_ERR(ctrl->fabrics_q);
> +			goto out_cleanup_admin_q;
> +		}
> +	}
> +
> +	ctrl->admin_tagset = set;
> +	return 0;
> +
> +out_cleanup_admin_q:
> +	blk_mq_destroy_queue(ctrl->fabrics_q);
> +out_free_tagset:
> +	blk_mq_free_tag_set(ctrl->admin_tagset);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
> +
> +void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
> +{
> +	blk_mq_destroy_queue(ctrl->admin_q);
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		blk_mq_destroy_queue(ctrl->fabrics_q);
> +	blk_mq_free_tag_set(ctrl->admin_tagset);
> +}
> +EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
> +
> +int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size)
> +{
> +	int ret;
> +
> +	memset(set, 0, sizeof(*set));
> +	set->ops = ops;
> +	set->queue_depth = ctrl->sqsize + 1;
> +	set->reserved_tags = NVMF_RESERVED_TAGS;
> +	set->numa_node = ctrl->numa_node;
> +	set->flags = flags;
> +	set->cmd_size = cmd_size,
> +	set->driver_data = ctrl;
> +	set->nr_hw_queues = ctrl->queue_count - 1;
> +	set->timeout = NVME_IO_TIMEOUT;
> +	if (ops->map_queues)
> +		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ret;
> +

if (ctrl->ops->flags & NVME_F_FABRICS) {

> +	ctrl->connect_q = blk_mq_init_queue(set);
> +        if (IS_ERR(ctrl->connect_q)) {
> +		ret = PTR_ERR(ctrl->connect_q);
> +		goto out_free_tag_set;
> +	}

}

> +
> +	ctrl->tagset = set;
> +	return 0;
> +
> +out_free_tag_set:
> +	blk_mq_free_tag_set(set);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);

