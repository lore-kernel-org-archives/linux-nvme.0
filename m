Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDB1C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o16Cxqf85RjDabk5pLpl/2qD1rwsojxUbXa0fOhRaTU=; b=H22PXvmlRfkIxZ4dy///LIJKoX
	yaoC4xlKA5GyRG8uNt3Zyv02rXtRf5GGaFCjiSBlptoBD59YzT/yp3ltqIL3HDiOSBqZ2vIPmr+Ns
	AblcFr8pH5SzljMyH4imoQ9vW3xy5HSYSVBT0Mv7b9djI8fjFL1Cqm4bjxAtUofTdAkh4AWZqpn+v
	U4oKpHWMHZKhjtEcYqQGEcjpHkhucsrxxnV9sthJys+8uTVu+sTRHTjz81fetzVL7qOceBunNTM9I
	shQNvJI67CMsUdL7wi2PDHoqwKxdUK/ZOG0wLGJSbDMTo5HAIe2dc3OEHQEqS+FbhP5ooTrvpcny9
	n/FRITNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCFM-00ARbx-0V;
	Mon, 18 Dec 2023 11:57:20 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCFJ-00ARXm-1i
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:57:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336616892ccso252587f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 03:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900634; x=1703505434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o16Cxqf85RjDabk5pLpl/2qD1rwsojxUbXa0fOhRaTU=;
        b=mk/oY/x3rVjgTplppjgiRKgg4d070lZJ23jVfnNkk7mjYxzVy8l9HW6sGVCphpvgRA
         uOaaToEENyXjt3T6n3LyDOHdj13FN0C+ABiTIo37x0MyFrflzKmcfYOY5vqJ0Ln818zV
         hMUwe64L2QVsSpIA9g41K0L5gocAjn/tajy87DgNn315JFPuGWtWfOXTVDRM6EC+Mw0m
         5b5jpCI8StyqYjjKTJEXRtqdA+NY8DciaQFyBX7vfADN5+CytBoP6Vw1Sp7K+Uv/Bv5O
         36VYHVeVTwAYxkcsGQBU9WiVFQLH+7VZzSwS2kcy5WKkdVh7NUJrWsXbVIYW1d6jzLWN
         1deg==
X-Gm-Message-State: AOJu0Yxgmk41WvJoZoC45q9U5c/90DLuZ1tevblDsFu8XOGLOVnGLK1U
	rwuTDjHNjv5XWL+aF/lNooI=
X-Google-Smtp-Source: AGHT+IGh4MHfzz9jhxM76GHkO+0lFnw9FPtQ3OJPBa32vRSr2unfOO8Y1vd3OilpXH0Gt1KwwY1HVw==
X-Received: by 2002:a5d:5888:0:b0:333:4d89:f73f with SMTP id n8-20020a5d5888000000b003334d89f73fmr18924262wrf.5.1702900633828;
        Mon, 18 Dec 2023 03:57:13 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033668993237sm2396484wrx.49.2023.12.18.03.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:57:13 -0800 (PST)
Message-ID: <d301da61-1076-462b-a679-4b847dd334ff@grimberg.me>
Date: Mon, 18 Dec 2023 13:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
 <1702897533-49685-4-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702897533-49685-4-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_035717_580395_50E858A2 
X-CRM114-Status: GOOD (  17.42  )
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



On 12/18/23 13:05, Guixin Liu wrote:
> Currently, the host is limited to creating queues with a depth of
> 128. To enable larger queue sizes, constrain the sqsize based on
> the ib_device's max_qp_wr capability.
> 
> And also remove unused NVME_RDMA_MAX_QUEUE_SIZE macro.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/rdma.c  | 14 ++++++++------
>   include/linux/nvme-rdma.h |  2 --
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 81e2621..982f3e4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -489,8 +489,7 @@ static int nvme_rdma_create_cq(struct ib_device *ibdev,
>   static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   {
>   	struct ib_device *ibdev;
> -	const int send_wr_factor = 3;			/* MR, SEND, INV */
> -	const int cq_factor = send_wr_factor + 1;	/* + RECV */
> +	const int cq_factor = NVME_RDMA_SEND_WR_FACTOR + 1;	/* + RECV */
>   	int ret, pages_per_mr;
>   
>   	queue->device = nvme_rdma_find_get_device(queue->cm_id);
> @@ -508,7 +507,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   	if (ret)
>   		goto out_put_dev;
>   
> -	ret = nvme_rdma_create_qp(queue, send_wr_factor);
> +	ret = nvme_rdma_create_qp(queue, NVME_RDMA_SEND_WR_FACTOR);
>   	if (ret)
>   		goto out_destroy_ib_cq;
>   
> @@ -1006,6 +1005,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   {
>   	int ret;
>   	bool changed;
> +	int ib_max_qsize;
>   
>   	ret = nvme_rdma_configure_admin_queue(ctrl, new);
>   	if (ret)
> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>   	}
>   
> -	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
> +	ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
> +			(NVME_RDMA_SEND_WR_FACTOR + 1);
> +	if (ctrl->ctrl.sqsize + 1 > ib_max_qsize) {
>   		dev_warn(ctrl->ctrl.device,
>   			"ctrl sqsize %u > max queue size %u, clamping down\n",
> -			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
> -		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
> +			ctrl->ctrl.sqsize + 1, ib_max_qsize);
> +		ctrl->ctrl.sqsize = ib_max_qsize - 1;
>   	}

This can be very very big, not sure why we should allow a queue of depth
of a potentially giant size. We should also impose a hard limit, maybe
align to the pci driver limit.

