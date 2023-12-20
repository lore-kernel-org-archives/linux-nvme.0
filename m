Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6012FC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auml9JU/eoYlonun+nYriQnsPRKFi3WEUNQtJ0WfJs4=; b=KxGTfQsxMx4WL8bPd/Bq4oTLgq
	yNr+CVfMlD6PumXb9wH2DHXqZrzP3piCkgovroMhxkvnPIyDK6WLWJ0JNDnt5Mv/vUFEIO0TU25E+
	iBwwBvGPni4sX3jV8UYfeaWaOdoaK+9dkOrI3qOKNhbsrhmyRkBzjQj1xR3l17s+Pj4nN7ZD39ShV
	ZESbIqSDzXoHeQJ2/h0vJvzc48MKXgX3fyuR6Wbf66ZEg3Q3EHoHdtd4Gf9k68tg0hS2I6itoTy1x
	oCQxqRLJ0tqvJO2iLSh+WpDFH5gyhG/cK/6Q8P2pfbGFptEFPAVtnyi2/I0Bb/pJZXnpcoTBUYkI2
	XmWCfcKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFshX-00Gi7P-0F;
	Wed, 20 Dec 2023 09:17:15 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFshU-00Gi6i-2B
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 09:17:13 +0000
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3efb6bfa3so946395ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Dec 2023 01:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703063828; x=1703668628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auml9JU/eoYlonun+nYriQnsPRKFi3WEUNQtJ0WfJs4=;
        b=PlswFs5bLbn2SNXzCfcUmnHF6hZ77RupBFgggWvr47THLszv6nlHqXrwcMAvcA7usa
         +dVWoBGjGpFTJXTdaTENINoMkuaxFZWobZp866CfhgUvZRrGa4+FYkkZlbTgr7uoHfV6
         GIvVViNdhodUs7HnUwpQZUHBI2Gwj1vHDC8GUtohB3mdfZbLgRJGj9q76Mfno5FQ3ZHB
         ojjJRmd7LAlOZpPBdhTZsQVAFlCCr2muOkAGW0ZUEFb/CL0Wlp2F0GIbqURfDmIiXX7R
         ieB+ykaNEAAEM5pLn18sQktDQLTR917gfnMB7KAv1+L8AVinUcZwcdsa81bkDRCD0Bso
         rLSw==
X-Gm-Message-State: AOJu0YzBFUIAFzRZp4Lca5lN3BSylp+0h5L8nzDgbBzVCpACFS3OLebS
	W9PIEKkvmaJ/jzUkIxClDgI=
X-Google-Smtp-Source: AGHT+IGxmIy1VcEH7flGRc80P79LiUEVhggLXHhKqi8lvzigbHazbHyQpuEYXCcGwPrL+XuPHXUH1A==
X-Received: by 2002:a05:6a20:7d8e:b0:187:df59:5c43 with SMTP id v14-20020a056a207d8e00b00187df595c43mr41868375pzj.2.1703063828051;
        Wed, 20 Dec 2023 01:17:08 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c16-20020a62e810000000b006d922015d25sm3377345pfi.186.2023.12.20.01.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 01:17:07 -0800 (PST)
Message-ID: <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
Date: Wed, 20 Dec 2023 11:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kbusch@kernel.org,
 kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_011712_717551_165A2CD0 
X-CRM114-Status: GOOD (  16.89  )
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



On 12/19/23 09:32, Guixin Liu wrote:
> Currently, the host is limited to creating queues with a depth of
> 128. To enable larger queue sizes, constrain the sqsize based on
> the ib_device's max_qp_wr capability.
> In addition, the queue size is restricted between 16 and 1024 in
> nvmf_parse_options(), so the final value of queue depth will not
> biger than 1024.
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

rdma_dev_max_qsize is a better name.

Also, you can drop the RFC for the next submission.

