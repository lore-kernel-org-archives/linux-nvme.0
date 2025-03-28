Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40960C28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmpoZqrBCBlsFuduC2Ckn7oRsahY/NmTf8MnqOwkhjI=; b=bjyR/6YajknH7vGkVhuN4r0iG9
	Sc7VXSLsrX2REFHjxhj6Oa5sZRxwkCb7IvDnDEiC6lTifW4YQjah0hB9a0okVj4L3Nu/ZdEkv8rRo
	VhfBEt43Dosoqc8NFdEIVI+6Cj1OPqoFEOG51avj/V0jPx/gSffGGs430sApEwWrrxBpjVFYZs9b2
	8+InnjskQW1cix0X+6e3cmj04jQlgA1ghFnw7rCSJyNJ0T+wOGjYVZhFCVUktbaFekpnDYrLTV/8m
	bSfJldBj1PIsRdwxsVPLTvyxnJti+4yZGs+OHJM1vaCgMkLIszqiHsKBT+cqEK4zbKUjrI2SeoXr8
	LDQiNRLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyHt6-0000000ENpa-37bu;
	Fri, 28 Mar 2025 22:09:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyHt5-0000000ENo6-1b4h
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 22:09:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D4B46115E;
	Fri, 28 Mar 2025 22:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15700C4CEE4;
	Fri, 28 Mar 2025 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743199754;
	bh=mahYWJ6R0qCvefG1hqhEtP/t/af8s4f/zTpIh0cvmdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NpCpF8Z6mt7TcuyUYAqBOOOtsY0trtsyBvhLLk7ZKpv7iwVzec2qqi+jiXkeeemzl
	 MOY3qVWyIROMeQmMiy2X7Ke/K6YAUdhnblebVUmzuH7LXBYw5lL4cH1UFS83cBt9fq
	 enIpn/tfuNP78XtdG9naa1zYwu9XbcwtyRYipMZzIlXhc1Dt7fk8JQ3z/dUU4fbS9R
	 rel2vorMceYHfUtfInYZiYqyw8x+ZMoBNVU14gXIo9edT0m/m+gsi27ljpF9gDF4p7
	 6lDgWs4nqpcYsYpTB4N/zQ+N3emzxrG14NkxVW9G9q7hfPDb/t87GFjfwh290eHFVB
	 7zVnzw1M5xl/Q==
Message-ID: <ca53c3a8-8af2-4e34-b0e6-3571cbec4bee@kernel.org>
Date: Fri, 28 Mar 2025 15:09:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
To: Kamaljit Singh <kamaljit.singh1@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250328213640.798910-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2025/03/28 14:36, Kamaljit Singh wrote:
> Added capability to connect to an administrative controller by

s/Added/Add

> preventing ioq creation for admin-controllers. Also prevent ioq creation
> for discovery-controllers as the spec prohibits them.

This second part should be a different (preparatory) patch.

> 
> * Added nvme_admin_ctrl() to check for an administrative controller

s/Added/Add
And this should be a different preparatory patch.

> 
> * Renamed nvme_discovery_ctrl() to nvmf_discovery_ctrl() as discovery is
>   more relevant to fabrics

I do not think that is necessary since this is testing the controller type,
which may be limited to fabrics or not.

> * Similar to a discovery ctrl, prevent an admin-ctrl from getting a
>   smart log (LID=2). LID 2 is optional for admin controllers but in the
>   future when we add support for the newly added LID=0 (supported log
>   pages), we can make GLP accesses smarter by basing such calls on
>   response from LID=0 reads.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>

[...]

> @@ -2863,13 +2858,19 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	else
>  		subsys->subtype = NVME_NQN_NVME;
>  
> -	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
> +	if (nvmf_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
>  		dev_err(ctrl->device,
>  			"Subsystem %s is not a discovery controller",
>  			subsys->subnqn);
>  		kfree(subsys);
>  		return -EINVAL;
>  	}
> +	if (nvme_admin_ctrl(ctrl)) {
> +		dev_info(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			subsys->subnqn);
> +	}

Is this really necessary ? In any case, please remove the curly brackets.

[...]

> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 299e3c19df9d..0f3150411bd5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1030,6 +1030,17 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>  		goto destroy_admin;
>  	}
>  
> +	/* An admin or discovery controller has one admin queue, but no I/O queues */
> +	if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctrl)) {
> +		ctrl->ctrl.queue_count = 1;
> +	} else if (ctrl->ctrl.queue_count < 2) {
> +		/* I/O controller with no I/O queues is not allowed */
> +		ret = -EOPNOTSUPP;
> +		dev_err(ctrl->ctrl.device,
> +			"I/O controller doesn't allow zero I/O queues!\n");
> +		goto destroy_admin;
> +	}

This is identical to the change for tcp, so maybe make this a helper function ?

> +
>  	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
>  		dev_warn(ctrl->ctrl.device,
>  			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 644f84284b6f..3fe2f617bfd5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2199,6 +2199,17 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>  		goto destroy_admin;
>  	}
>  
> +	/* An admin or discovery controller has one admin queue, but no I/O queues */
> +	if (nvme_admin_ctrl(ctrl) || nvmf_discovery_ctrl(ctrl)) {
> +		ctrl->queue_count = 1;
> +	} else if (ctrl->queue_count < 2) {
> +		/* I/O controller with no I/O queues is not allowed */
> +		ret = -EOPNOTSUPP;
> +		dev_err(ctrl->device,
> +			"I/O controller doesn't allow zero I/O queues!\n");
> +		goto destroy_admin;
> +	}
> +
>  	if (opts->queue_size > ctrl->sqsize + 1)
>  		dev_warn(ctrl->device,
>  			"queue_size %zu > ctrl sqsize %u, clamping down\n",

-- 
Damien Le Moal
Western Digital Research


