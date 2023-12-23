Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E940C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Dec 2023 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVWpCvqkw7p8e7hj81Ymc/IdDENzeAIKkppF4B6qO+s=; b=PqviCLJAl5i5VXwhYDtnvVQ3S+
	ITUj9JA6NKnxUrCKEUHkzcQ9Fj3zs2Psa6Xap9OxLv/5mYXh2mEXN1jK3bnFZQ4U930Cuak+mTpLD
	e7+NYzM2l5LXcn6YDW5W/lhb2Yg1SaFjFWQCiElCxxjNfQBdjsOzD8o4YTPiR/BAmKroP4TlBru8e
	exWJAyaY6nu0FS4qih+4VC0l3UOR9To1WZTk6GSeD58s3byuXDS/jiETU4/Gn0e+MOSVTyPMC0dMl
	U+syE9m+wKDqGPL22YVo4KtCXvasDCJj6TdZfRAQ4QGmBVC3DoalqnxAKiGDjTvrbooLJHf4zHibg
	0wBDp6Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH67N-008F6U-0X;
	Sat, 23 Dec 2023 17:48:57 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH67K-008F68-0i
	for linux-nvme@lists.infradead.org;
	Sat, 23 Dec 2023 17:48:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id F2ECAB80972;
	Sat, 23 Dec 2023 17:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA04C433C8;
	Sat, 23 Dec 2023 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703353731;
	bh=03Mw3pTrVcalUFwXHgizomiqyu9j2TDfmFEEnJjsgSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAeXLlZEsG7ROdqI2PXNz8MBASajy2ZNVJ88sgC51YVXI0A1RuK4prwwUGUBCcKNA
	 ZWvhbhh2RtVAO/X3fa7jKu197+ZctY+cgk0J5Y0Jxg5dFLQLGie1/NZOAq5Of0FwOY
	 yUNUC0g0xz5Q3vO2cnMtKqXuhakspKlilGAFsPJa/RrpPkTCFZ9inDvUn1rsRNpgVB
	 Dn9AC8x0JNbd7us27h5eIwDxpkXWX/+oSjqEOe2sWkxtwJfmOZJldEiqw9kbFwWXDB
	 0CQQavMbPWhcvnsbnq8AecfdCU9kQfpzD5CF/kHglUhUPQdgFSKP5iqzjbHTVSwboB
	 /1P4KefGIGucg==
Date: Sat, 23 Dec 2023 17:48:45 +0000
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 16/20] net/mlx5e: NVMEoTCP, queue init/teardown
Message-ID: <20231223174845.GJ201037@kernel.org>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-17-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221213358.105704-17-aaptel@nvidia.com>
mlx5e_open_cqFrom: Simon Horman <horms@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_094854_543575_B0045ACD 
X-CRM114-Status: GOOD (  19.41  )
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

On Thu, Dec 21, 2023 at 09:33:54PM +0000, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> Adds the ddp ops of sk_add, sk_del and offload limits.
> 
> When nvme-tcp establishes new queue/connection, the sk_add op is called.
> We allocate a hardware context to offload operations for this queue:
> - use a steering rule based on the connection 5-tuple to mark packets
>   of this queue/connection with a flow-tag in their completion (cqe)
> - use a dedicated TIR to identify the queue and maintain the HW context
> - use a dedicated ICOSQ to maintain the HW context by UMR postings
> - use a dedicated tag buffer for buffer registration
> - maintain static and progress HW contexts by posting the proper WQEs.
> 
> When nvme-tcp teardowns a queue/connection, the sk_del op is called.
> We teardown the queue and free the corresponding contexts.
> 
> The offload limits we advertise deal with the max SG supported.
> 
> [Re-enabled calling open/close icosq out of en_main.c]
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

...

> +static int
> +mlx5e_nvmeotcp_build_icosq(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_priv *priv, int io_cpu)
> +{
> +	u16 max_sgl, max_klm_per_wqe, max_umr_per_ccid, sgl_rest, wqebbs_rest;
> +	struct mlx5e_channel *c = priv->channels.c[queue->channel_ix];
> +	struct mlx5e_sq_param icosq_param = {};
> +	struct mlx5e_create_cq_param ccp = {};
> +	struct dim_cq_moder icocq_moder = {};
> +	struct mlx5e_icosq *icosq;
> +	int err = -ENOMEM;
> +	u16 log_icosq_sz;
> +	u32 max_wqebbs;
> +
> +	icosq = &queue->sq;
> +	max_sgl = mlx5e_get_max_sgl(priv->mdev);
> +	max_klm_per_wqe = queue->max_klms_per_wqe;
> +	max_umr_per_ccid = max_sgl / max_klm_per_wqe;
> +	sgl_rest = max_sgl % max_klm_per_wqe;
> +	wqebbs_rest = sgl_rest ? MLX5E_KLM_UMR_WQEBBS(sgl_rest) : 0;
> +	max_wqebbs = (MLX5E_KLM_UMR_WQEBBS(max_klm_per_wqe) *
> +		     max_umr_per_ccid + wqebbs_rest) * queue->size;
> +	log_icosq_sz = order_base_2(max_wqebbs);
> +
> +	mlx5e_build_icosq_param(priv->mdev, log_icosq_sz, &icosq_param);
> +	ccp.napi = &queue->qh.napi;
> +	ccp.ch_stats = &priv->channel_stats[queue->channel_ix]->ch;
> +	ccp.node = cpu_to_node(io_cpu);
> +	ccp.ix = queue->channel_ix;
> +
> +	err = mlx5e_open_cq(priv, icocq_moder, &icosq_param.cqp, &ccp, &icosq->cq);

Hi Aurelien and Ben,

This doesn't seem to compile with gcc-13 with allmodconfig on x86_64:

 .../nvmeotcp.c: In function 'mlx5e_nvmeotcp_build_icosq':
 .../nvmeotcp.c:472:29: error: passing argument 1 of 'mlx5e_open_cq' from incompatible pointer type [-Werror=incompatible-pointer-types]
   472 |         err = mlx5e_open_cq(priv, icocq_moder, &icosq_param.cqp, &ccp, &icosq->cq);
       |                             ^~~~
       |                             |
       |                             struct mlx5e_priv *
 In file included from .../nvmeotcp.h:9,
                  from .../nvmeotcp.c:7:
 ....h:1065:41: note: expected 'struct mlx5_core_dev *' but argument is of type 'struct mlx5e_priv *'
  1065 | int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
       |                   ~~~~~~~~~~~~~~~~~~~~~~^~~~
 cc1: all warnings being treated as errors

> +	if (err)
> +		goto err_nvmeotcp_sq;
> +	err = mlx5e_open_icosq(c, &priv->channels.params, &icosq_param, icosq,
> +			       mlx5e_nvmeotcp_icosq_err_cqe_work);
> +	if (err)
> +		goto close_cq;
> +
> +	spin_lock_init(&queue->sq_lock);
> +	return 0;
> +
> +close_cq:
> +	mlx5e_close_cq(&icosq->cq);
> +err_nvmeotcp_sq:
> +	return err;
> +}

...

