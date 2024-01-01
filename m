Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF83C47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSWJwGPk/XhJLbWLlWQsuKGQR88wVx/mRU4CBlEufiM=; b=BqCz4c8CSnjDivGE4yavK41DLz
	TmVo3gclcgi29LVholPdrQ0tADsJoxtsRpcHvr7+4Jm7hWYzOJ4X0NYNiv39v4YehpcDsAmPaCQqK
	dnZ7gqu3P1drWNcR0UV7JpqP4VJeWNDW5hb+xoPb81uHzCbV9qEvGEj4vPpQzoZYbhogzf7hwP40K
	34txda4mCdOT1MpGw0tcNgUsbMn8dLiILwBgCO7WNtG0c2oOtlrsuRui5NcT6tJ6yv+R8Blr4XGb6
	s6cNO7T/7J14o+IpjrFbVf8u52zeTOp3CISuNZeaTWFWmxh0MDIBqtAAepCg4gvcB0YSrPxtjiuU0
	rjonbyvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEgk-005pr2-1m;
	Mon, 01 Jan 2024 09:34:26 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEgh-005pqG-0r
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:34:24 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d377bd169so25345055e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101661; x=1704706461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSWJwGPk/XhJLbWLlWQsuKGQR88wVx/mRU4CBlEufiM=;
        b=wGyRzO+CAxAz4JRMpc+qVKiS1r505qxi7Fch9aE80TQ/vt51XT9SOAE4ixD1G6ZCd5
         27O7H3LsQDMOMd6qoAAsvoBYJlCYxEE4AozJ4F8lz0otHgHKMm5ufrcM8kUUCfoIfOT+
         /xiio0Bi0wJN9AwUMWLFvmRmKdPoYQz1WrDAhUJYseta9Fe8Pwu9fYmGwUTfJSquoaaQ
         Q8Jk2U8+tINsnxCUwKvNtUAo3VaCKxkEGgXCRfc9nwMZpXxQuvVq2AOwNRLllH9DAbPF
         vTczQVryPTcQHBKbVeElJMqo2v5O/hEtXUq2mbrNwGyRwfzI1B+rfhgJvF+JGoCxERLy
         dDHg==
X-Gm-Message-State: AOJu0Yx+/HIzZ6jnI6E2KHMGv+CCEitemnF/VB/Jb1XVWlR2cnGxcGQz
	Ha8YWD52Aj0pSF4pfPOs6nPS0f0j67A=
X-Google-Smtp-Source: AGHT+IF/gtI/wYhf4HuTDe9+nHzFlIANLB66Sys9C0pI2HwKDP9TinVDTSAlaTX+w29gjQUukHYuqw==
X-Received: by 2002:a5d:5744:0:b0:336:7f36:5225 with SMTP id q4-20020a5d5744000000b003367f365225mr18899900wrw.4.1704101661095;
        Mon, 01 Jan 2024 01:34:21 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b00336e69fbc32sm14048382wrs.102.2024.01.01.01.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:34:20 -0800 (PST)
Message-ID: <d55384fd-42aa-4aeb-8a7c-f36c6a9dc6a4@grimberg.me>
Date: Mon, 1 Jan 2024 11:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-rdma: introduce
 NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-8-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-8-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013423_302027_9C15FA35 
X-CRM114-Status: GOOD (  18.00  )
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

Another completely arbitrary limit...
Can this come somehow from the rdma core?

If not, its not making things any worse. So its fine by me.
Please comment that this limit is based on testing the devices
that support PI.

On 12/31/23 02:52, Max Gurtovoy wrote:
> This definition will be used by controllers that are configured with
> metadata support. For now, both regular and metadata controllers have
> the same maximal queue size but later commit will increase the maximal
> queue size for regular RDMA controllers to 256.
> We'll keep the maximal queue size for metadata controller to be 128
> since there are more resources that are needed for metadata operations.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/target/rdma.c | 2 ++
>   include/linux/nvme-rdma.h  | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 4597bca43a6d..f298295c0b0f 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -2002,6 +2002,8 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
>   
>   static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
>   {
> +	if (ctrl->pi_support)
> +		return NVME_RDMA_MAX_METADATA_QUEUE_SIZE;
>   	return NVME_RDMA_MAX_QUEUE_SIZE;
>   }
>   
> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
> index 146dd2223a5f..d0b9941911a1 100644
> --- a/include/linux/nvme-rdma.h
> +++ b/include/linux/nvme-rdma.h
> @@ -8,7 +8,8 @@
>   
>   #define NVME_RDMA_IP_PORT		4420
>   
> -#define NVME_RDMA_MAX_QUEUE_SIZE	128
> +#define NVME_RDMA_MAX_QUEUE_SIZE 128
> +#define NVME_RDMA_MAX_METADATA_QUEUE_SIZE 128
>   
>   enum nvme_rdma_cm_fmt {
>   	NVME_RDMA_CM_FMT_1_0 = 0x0,

