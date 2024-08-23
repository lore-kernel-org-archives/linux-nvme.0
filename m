Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F5AC531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QcbuVrnSLvYWlw/4wWxnpJHFEiLVUSrBLQYJUm8AiQM=; b=2hF6keBTDgKdKuaeR5BpJ3BM9J
	4Giizpa5AZI5XHKx4czmG1wN+q7kOOFP0ptseiIX0JQMSjnx9tX+f+PrGNS0RmM6u9SCA1p8YWFbT
	rr8au19aDzYJgHd0izyn0cqLGX8amRzh0JQWXSg1HlpHfrp1w0v24+0QFDWAX5N/z/u28YrI0kdWq
	PnxljUex356LIk8rPPSEAuAXduk5z8DEpZXBIkWTYe+sTYv0rx8VHD/wrOeHEK4nc5Mi2FohPJf70
	u5+jV9eunC2ufnbcmO3w4Efk+qyaipG04+zC/BfjuRD9dqVMtFozt/J3Z2AuhkP43m9KV9XBwWKcL
	3hPM6VqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPqS-0000000Fv8h-1qeZ;
	Fri, 23 Aug 2024 08:40:32 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPZ3-0000000FqU4-44aN
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 08:22:35 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 174A91EDDE4;
	Fri, 23 Aug 2024 10:22:32 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724401352; bh=QcbuVrnSLvYWlw/4wWxnpJHFEiLVUSrBLQYJUm8AiQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OEui8JWOUqmhI7bjHT/b2HCKNOcFPQxCUr641ZDqRi7RKL2PxGsSn5lU56hqpmDW9
	 G7f4RasFO1/aHLQpYZaAZ/zj9O48xNWcsBKLCZxN6BXSY7Lv+Cg9dKb6pHoW4oJaBD
	 yyJi/oMd84J+zIWPJY7I1ruJi9W0azntPTfrMDLJSc9CDu3m04hEIeiiOvEgIjuNFw
	 8JHkkbSx2Ss3E1mTliS0ZsR7uaCcF/lixNun7AdWbA1A0EQsw/3WEQoU6tPknplOUL
	 R2FFbTnNcxBEwM6ABXaznsLXSwURBvJVaUzBzVKh8cor9oqa9TbZUWqN75yWsyhwM5
	 Xe+b0P5jM99yQ==
Date: Fri, 23 Aug 2024 10:22:31 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 6/7] nvme: Move BLK_MQ_F_BLOCKING indicator to struct
 nvme_ctrl
Message-ID: <20240823102231.5def53f4@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-7-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-7-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_012234_203159_393E5658 
X-CRM114-Status: GOOD (  21.39  )
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

On Thu, 22 Aug 2024 11:37:17 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> The NVMe setting that controls the BLK_MQ_F_BLOCKING flag on the
> request queue is currently a flag in struct nvme_ctrl_ops, where
> it is not writable. A new use case needs this flag to be writable
> based on a determination made during the NVMe device probe function.
> 
> Move this setting to struct nvme_ctrl, and update the only user to
> set it in the new location.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  drivers/nvme/host/core.c | 4 ++--
>  drivers/nvme/host/nvme.h | 2 +-
>  drivers/nvme/host/tcp.c  | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33fa01c599ad..f1ce325471f1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4495,7 +4495,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  		set->reserved_tags = 2;
>  	set->numa_node = ctrl->numa_node;
>  	set->flags = BLK_MQ_F_NO_SCHED;
> -	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +	if (ctrl->blocking)
>  		set->flags |= BLK_MQ_F_BLOCKING;
>  	set->cmd_size = cmd_size;
>  	set->driver_data = ctrl;
> @@ -4565,7 +4565,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  		set->reserved_tags = 1;
>  	set->numa_node = ctrl->numa_node;
>  	set->flags = BLK_MQ_F_SHOULD_MERGE;
> -	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +	if (ctrl->blocking)
>  		set->flags |= BLK_MQ_F_BLOCKING;
>  	set->cmd_size = cmd_size,
>  	set->driver_data = ctrl;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ae5314d32943..28709f166cab 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -338,6 +338,7 @@ struct nvme_ctrl {
>  	unsigned int shutdown_timeout;
>  	unsigned int kato;
>  	bool subsystem;
> +	bool blocking;
>  	unsigned long quirks;
>  	struct nvme_id_power_state psd[32];
>  	struct nvme_effects_log *effects;
> @@ -546,7 +547,6 @@ struct nvme_ctrl_ops {
>  	unsigned int flags;
>  #define NVME_F_FABRICS			(1 << 0)
>  #define NVME_F_METADATA_SUPPORTED	(1 << 1)
> -#define NVME_F_BLOCKING			(1 << 2)
>  
>  	const struct attribute_group **dev_attr_groups;
>  	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9ea6be0b0392..6b9fdf7dc1ac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2658,7 +2658,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
>  static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
>  	.name			= "tcp",
>  	.module			= THIS_MODULE,
> -	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
> +	.flags			= NVME_F_FABRICS,
>  	.reg_read32		= nvmf_reg_read32,
>  	.reg_read64		= nvmf_reg_read64,
>  	.reg_write32		= nvmf_reg_write32,
> @@ -2762,6 +2762,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>  	if (ret)
>  		goto out_kfree_queues;
>  
> +	ctrl->ctrl.blocking = true;
>  	return ctrl;
>  out_kfree_queues:
>  	kfree(ctrl->queues);


