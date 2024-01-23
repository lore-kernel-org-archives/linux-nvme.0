Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0707C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3R8LZ01E2dQbnjnl79El2In3ousSV+VraR6J7nXvXkM=; b=K5YIIzFfM3foNwCNu3vgc/SWe1
	MBxxolsKVYqIn52+ZO9F/JGyefuiU0/RtE7fVSTbjB8OtRfrWQSZeYcg/S+Fd2Lvq/grIf+DgFuQz
	ErWw21GPq7AqAyNAlHGRsShtW4NS6h18LkRfuP/viHbrRboiURuDWB22ycGxFzlR2rdKyL3/NMazj
	Q5CHKBI8znrYVCNXaApVfkLPAZLJ6ZoxzIqai/GqTacDxSrPRxpdnoL4/Cij9dH9EFJwYxUiQCOcx
	oOLrRzHgxEdmvHy2C9gcAQb0gsc1iicUvdc7rm6dY9/95kNPZd5VFbhyA/Lg5ecwzLLaQdOqRi7mC
	yDtWIwOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCYZ-00Fegi-0K;
	Tue, 23 Jan 2024 08:54:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCYU-00FeeG-14
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:54:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B258868BEB; Tue, 23 Jan 2024 09:54:47 +0100 (CET)
Date: Tue, 23 Jan 2024 09:54:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, israelr@nvidia.com, kch@nvidia.com,
	oren@nvidia.com
Subject: Re: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
Message-ID: <20240123085447.GF30155@lst.de>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com> <20240104092549.25721-7-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104092549.25721-7-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_005450_518785_98C6395B 
X-CRM114-Status: GOOD (  20.59  )
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

On Thu, Jan 04, 2024 at 11:25:47AM +0200, Max Gurtovoy wrote:
> If a controller is configured with metadata support, clamp the maximal
> queue size to be 128 since there are more resources that are needed
> for metadata operations. Otherwise, clamp it to 256.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/rdma.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index bc90ec3c51b0..d81a7148fbc5 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1029,11 +1029,20 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>  			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>  	}
>  
> +	if (ctrl->ctrl.max_integrity_segments) {
> +		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_METADATA_QUEUE_SIZE) {
> +			dev_warn(ctrl->ctrl.device,
> +				"ctrl sqsize %u > max queue size %u, clamping down\n",
> +				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_METADATA_QUEUE_SIZE);
> +			ctrl->ctrl.sqsize = NVME_RDMA_MAX_METADATA_QUEUE_SIZE - 1;
> +		}
> +	} else {
> +		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
> +			dev_warn(ctrl->ctrl.device,
> +				"ctrl sqsize %u > max queue size %u, clamping down\n",
> +				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
> +			ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
> +		}

Can you just add a local max_queue_size variable instead of
duplicating all this?


