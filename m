Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F188C3DA61
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 00:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pb2LA4nVhlCQiJEH5q6YsgUGsTqjn1SmpO6iO9wweQc=; b=ASKlvC9aLPNB1ogsV+F7bnnc4m
	IXdJqKhvHFYI8CfMoTuxWf19LqHtgPk9iGVayuTLDwRHgHenlc43rs8NKbisnEQMpXvHEbqOk678/
	7z1Yx+dq0mNrSDgy8U9pkPn/G2enC591il76v0JzwnRtXprRiaFC59m+4ydb4CZ+jL63Y9aYU+k9e
	mTyuBvbid/z9MZU6yclK8bcoyl8ui1S1JfgGn4kbuPETg/7GHJ0QOTu5cD+lui1GWFMzh/n9w68aJ
	cwuTSlQicY4e4M5+VOHfhRuxRfRk/glPv/kJLOHfRUZOlCWGKn7cxsRyXffBMvGFpaMIQGFYWoSvq
	zYkqbUGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWmaE-0000000GvNl-25Iu;
	Thu, 25 Jul 2024 00:43:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWmaC-0000000GvNB-1sNH
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 00:43:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 498FE6129A;
	Thu, 25 Jul 2024 00:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8129C32781;
	Thu, 25 Jul 2024 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721868227;
	bh=IvetRWMPtrvPQHZA4kgOHiZeVmh4EunPRv3Kba2KOok=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EuPab1B7WpSBM/KHI9Px1hrd+AgTPL70iI0vDoai8v5pwo2N5IdAIB5cztkaDmwoB
	 rfePZOerKPDdA7gbJ1ROtarmAgVHxd6HNbMTXOB/cK8eytdtdaMF7GpXwaxJZOygxh
	 X/Gugt47VdR5pHegjySWLsWvrbCg8UAvgfpAIkhPO31sRkToKKyFkmg2mqLaiZ6Prp
	 bxcNdveaCUVYb5axhEsWRqohSLWqqhsZgO1Qa1fYtDFQpmtvCzJ/8SrslujK6w9Dzk
	 1pUsMDyi+8+7ejBTFLnjOdufQHhiPjX8YSGVlYIYkENnBGT2ukekh3LeOiL+726Ynk
	 UW2b0SoKcC+PA==
Message-ID: <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
Date: Thu, 25 Jul 2024 09:43:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
To: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
 <20240724123052.49185-1-wangyugui@e16-tech.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240724123052.49185-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_174348_659474_33D45EF5 
X-CRM114-Status: GOOD (  18.89  )
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

On 7/24/24 21:30, Wang Yugui wrote:
> Rotational media(RMEDIA) support is added to the NVMe 2.0 specification.
> We firstly add Rotational media(RMEDIA) support to nvme host, then we can add
> the support to nvme target later if the backstore is a Rotational media(RMEDIA)
> block device.

Why not do that now in another patch, at least for the loop target ? Given that
they are not that many NVMe-HDD out there, that would be nice to have to test this.

> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>  drivers/nvme/host/core.c      | 5 +++++
>  drivers/nvme/host/multipath.c | 3 +++
>  drivers/nvme/host/nvme.h      | 1 +
>  include/linux/nvme.h          | 1 +
>  4 files changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 19917253ba7b..f4c41bf70b19 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -40,6 +40,7 @@ struct nvme_ns_info {
>  	bool is_readonly;
>  	bool is_ready;
>  	bool is_removed;
> +	bool is_rmedia;
>  };
>  
>  unsigned int admin_timeout = 60;
> @@ -1622,6 +1623,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
>  		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
>  		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
>  		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
> +		info->is_rmedia = id->nsfeat & NVME_INDEP_NS_FEAT_RMEDIA;
>  	}
>  	kfree(id);
>  	return ret;
> @@ -3613,6 +3618,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	head->ns_id = info->nsid;
>  	head->ids = info->ids;
>  	head->shared = info->is_shared;
> +	head->rmedia = info->is_rmedia;
>  	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>  	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>  	kref_init(&head->ref);
> @@ -3816,6 +3816,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  
>  	if (ctrl->opts && ctrl->opts->data_digest)
>  		lim.features |= BLK_FEAT_STABLE_WRITES;
> +	if (info->is_rmedia)
> +		lim.features |= BLK_FEAT_ROTATIONAL;
>  	if (ctrl->ops->supports_pci_p2pdma &&
>  	    ctrl->ops->supports_pci_p2pdma(ctrl))
>  		lim.features |= BLK_FEAT_PCI_P2PDMA;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 91d9eb3c22ef..a3cd6525d24d 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -626,6 +626,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	head->disk->private_data = head;
>  	sprintf(head->disk->disk_name, "nvme%dn%d",
>  			ctrl->subsys->instance, head->instance);
> +
> +	if(head->rmedia)
> +		lim.features |= BLK_FEAT_ROTATIONAL;
>  	return 0;
>  }
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f900e44243ae..9f2789c44249 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -465,6 +465,7 @@ struct nvme_ns_head {
>  	struct list_head	entry;
>  	struct kref		ref;
>  	bool			shared;
> +	bool			rmedia;
>  	bool			passthru_err_log_enabled;
>  	int			instance;
>  	struct nvme_effects_log *effects;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index c12a329dd463..2c259d126f80 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -546,6 +546,7 @@ enum {
>  	NVME_NS_FEAT_THIN	= 1 << 0,
>  	NVME_NS_FEAT_ATOMICS	= 1 << 1,
>  	NVME_NS_FEAT_IO_OPT	= 1 << 4,
> +	NVME_INDEP_NS_FEAT_RMEDIA = 1 << 4,
>  	NVME_NS_ATTR_RO		= 1 << 0,
>  	NVME_NS_FLBAS_LBA_MASK	= 0xf,
>  	NVME_NS_FLBAS_LBA_UMASK	= 0x60,

-- 
Damien Le Moal
Western Digital Research


