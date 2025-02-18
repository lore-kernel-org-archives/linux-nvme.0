Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0D1C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLp9JRNVUhT0m1v0T73vab4YaM/Pfh0Xi9X9EVQSmqg=; b=CSCx4qgxvGV/R5+00eMUhwQZPB
	X3ojQ5+VYpi0NRmq1fIDyx8eOuZK0hMFBldj0LqtieJmlFwOoMCuh/olZh6sUINqu7YYRLiH4Hn5s
	fu+LMnSb1nizDgaFFKUKrlnTkyWtz5U6r1mAIXl+j4FJMc+BBxh/e07mPuDVRP/iysH3CWgKsE3CJ
	znF+nKfUSd7qgW8Ud1MmfG5qehGzCzYavwIkmooctb4cvol2wjjK0CWuSK8G9Z98PPFygWCJ/2g5w
	ZR6p8TqUeiNAk7KkYgSe25q8OAKmZUPeUhPzY6kb0H7VzayLAMWDc43jdTaw1ndIIgxgQCUhwTen9
	q0dpN/Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkP1X-00000008eI5-26zH;
	Tue, 18 Feb 2025 14:56:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkOpA-00000008bKa-2ds7
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 14:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739889827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLp9JRNVUhT0m1v0T73vab4YaM/Pfh0Xi9X9EVQSmqg=;
	b=AfIU3O0n4h2Cd6+EQqBLqzPKdEMckV6jHV/y6r0BEXTjWT1sVJJJIfVwd8Kr80VkMB6fTR
	f6E9TSkmZXVaX3ppu0Q9LDRWXDKsZgeLpGopuXm7mztNFM7cSz6TjyQlATSw2OepypH9Tp
	ITid6uGjUZ5LtHmOdrwZb6jSsSdcgX0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-rPY--Uj5NOyhtVFz1p5B2w-1; Tue,
 18 Feb 2025 09:43:43 -0500
X-MC-Unique: rPY--Uj5NOyhtVFz1p5B2w-1
X-Mimecast-MFC-AGG-ID: rPY--Uj5NOyhtVFz1p5B2w_1739889822
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5A681800874;
	Tue, 18 Feb 2025 14:43:41 +0000 (UTC)
Received: from [10.22.65.116] (unknown [10.22.65.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B8E21956094;
	Tue, 18 Feb 2025 14:43:40 +0000 (UTC)
Message-ID: <21abd9e4-de2f-4d9e-a6d2-700b3d326524@redhat.com>
Date: Tue, 18 Feb 2025 09:43:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk
Cc: bmarzins@redhat.com
References: <20250204211158.43126-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250204211158.43126-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_064348_743878_C38DF22A 
X-CRM114-Status: GOOD (  16.74  )
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

Bryan,  See my comments below.

On 2/4/25 4:11 PM, Bryan Gurney wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a85d190942bd..28ab868182b2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -9,11 +9,6 @@
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> -bool multipath = true;
> -module_param(multipath, bool, 0444);
> -MODULE_PARM_DESC(multipath,
> -	"turn on native support for multiple controllers per subsystem");
> -
>   static const char *nvme_iopolicy_names[] = {
>   	[NVME_IOPOLICY_NUMA]	= "numa",
>   	[NVME_IOPOLICY_RR]	= "round-robin",
> @@ -632,9 +627,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	 * We also do this for private namespaces as the namespace sharing flag
>   	 * could change after a rescan.
>   	 */
> +#ifdef CONFIG_NVME_MULTIPATH
>   	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
> -	    !nvme_is_unique_nsid(ctrl, head) || !multipath)
> +	    !nvme_is_unique_nsid(ctrl, head))
>   		return 0;
> +#endif

You don't need to add these #ifdef CONFIG_NVME_MULTIPATH conditional compile statements
to multipath.c because the multipath.c is not compiled when CONFIG_NVME_MULTIPATH=N.

These won't hurt anything, but they are redundant and we can make the patch smaller by removing them.

>   	blk_set_stacking_limits(&lim);
>   	lim.dma_alignment = 3;
> @@ -1038,10 +1035,11 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	size_t ana_log_size;
>   	int error = 0;
>   
> +#ifdef CONFIG_NVME_MULTIPATH
>   	/* check if multipath is enabled and we have the capability */
> -	if (!multipath || !ctrl->subsys ||
> -	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
> +	if (!ctrl->subsys || !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>   		return 0;
> +#endif

Same here.

>   	/* initialize this in the identify path to cover controller resets */
>   	atomic_set(&ctrl->nr_active, 0);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2c76afd00390..6dea04f05b59 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -972,7 +972,6 @@ static inline void nvme_trace_bio_complete(struct request *req)
>   		trace_block_bio_complete(ns->head->disk->queue, req->bio);
>   }
>   

/John


