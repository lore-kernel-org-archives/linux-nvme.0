Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC9EC021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvj3vozWqkmBCXN9KKTDXH97BLEJH6YvNtbFBYno/3c=; b=EeHghRh+MY6EqtcOGWcXBXJDoo
	YobkKcINo3ZWAxXVWrr4HXEM5XmEfFOvYO3fQfE0nvAGlrqi7SXNhyUDNSgJfsrnppckun2SkpI+j
	2nuY0fUUwHQKdvMYu71H9qEAgzreGup4C3u+QM24zsIS3O4J6sZB6RPLFE7avGwsPAEyFenDrKGGT
	DMkcCbtE/H69dsk8DBb+Ig6dsCs/wy2d9e5xq31236QtE+N99vxA8m74SvSgRrDf64xPLNAJXKSg1
	ESyuDl3k0yvj8VI5GK06PQrt3aOaMPOtJgne+uYz/muYCG+r4bXJdjhOOGYiR58aF/MliqxpOCo74
	9fOLrOtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYtf-00000006Bl7-0Lpg;
	Tue, 04 Mar 2025 20:29:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWKT-00000005h4B-0Rb4
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 17:45:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5CB3E5C5E0C;
	Tue,  4 Mar 2025 17:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697E0C4CEE5;
	Tue,  4 Mar 2025 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110315;
	bh=/XYaCM7ffLPvBmOKEewqpIBZvsk+7sQeQ/ouoLNmb3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGsrPmrUNKRPdh6/tPUlX0DZdO3u6G1v8Z7IsvxUh0PTFWtmzC1luyNhUg54gtQsz
	 hLBHBzARalamTAD5aPs4A0PHkO4gqajIhWvYUj4l+gRx0LG4mrT5S6rasBKofCfv20
	 uobPfLhnY0b1eoLdz1/CkS62UAKNVzGsLyyJg89Cshk/aiw3YiYO4RdDCAVBu6ofUI
	 YCUrz+qKrzzMkJtTwHG9EUWsd6S+6vqfSPeVPuZ2Y/CEoEwUyQIAip//uRrEFeV6fI
	 Ly70iWwN1Bzdk7YWcT9NzZOC/jJOf8+cbIK5Way9ARjAsmre6xLdELbapWyJC1H/Ch
	 PbxEKKV3bEQ4Q==
Date: Tue, 4 Mar 2025 17:45:10 +0000
From: Simon Horman <horms@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
Message-ID: <20250304174510.GI3666230@kernel.org>
References: <20250303095304.1534-1-aaptel@nvidia.com>
 <20250303095304.1534-16-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303095304.1534-16-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_094517_260418_C0B8608B 
X-CRM114-Status: GOOD (  25.65  )
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

On Mon, Mar 03, 2025 at 09:52:59AM +0000, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> NVMEoTCP offload uses buffer registration for ddp operation.
> Every request comprises from SG list that might consist from elements
> with multiple combination sizes, thus the appropriate way to perform
> buffer registration is with KLM UMRs.
> 
> UMR stands for user-mode memory registration, it is a mechanism to alter
> address translation properties of MKEY by posting WorkQueueElement
> aka WQE on send queue.
> 
> MKEY stands for memory key, MKEY are used to describe a region in memory
> that can be later used by HW.
> 
> KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
> enables to map multiple memory spaces with different sizes in unified MKEY.
> KLM UMR is a UMR that use to update a KLM_MKEY.
> 
> Nothing needs to be done on memory registration completion and this
> notification is expensive so we add a wrapper to be able to ring the
> doorbell without generating any.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c

...

> @@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
>  	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
>  };
>  
> +static void
> +fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
> +		      u32 klm_entries, u16 klm_offset)
> +{
> +	struct scatterlist *sgl_mkey;
> +	u32 lkey, i;
> +
> +	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
> +	for (i = 0; i < klm_entries; i++) {
> +		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
> +		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
> +		wqe->inline_klms[i].key = cpu_to_be32(lkey);
> +		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
> +	}
> +
> +	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
> +		wqe->inline_klms[i].bcount = 0;
> +		wqe->inline_klms[i].key = 0;
> +		wqe->inline_klms[i].va = 0;
> +	}
> +}
> +
> +static void
> +build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
> +		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
> +		       enum wqe_type klm_type)
> +{
> +	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
> +		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
> +	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
> +		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
> +	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
> +	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
> +	struct mlx5_mkey_seg *mkc = &wqe->mkc;

Hi Aurelien, all,

I think that the lines above...

> +	u32 sqn = queue->sq.sqn;
> +	u16 pc = queue->sq.pc;
> +
> +	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
> +					     MLX5_OPCODE_UMR | (opc_mod) << 24);
> +	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
> +	cseg->general_id = cpu_to_be32(id);
> +
> +	if (klm_type == KLM_UMR && !klm_offset) {
> +		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
> +					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
> +		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
> +	}
> +
> +	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
> +	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	ucseg->xlt_offset = cpu_to_be16(klm_offset);
> +	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
> +}
> +
> +static void
> +mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
> +{
> +	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
> +
> +	memset(wi, 0, sizeof(*wi));
> +
> +	wi->num_wqebbs = wqebbs;
> +	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
> +}
> +
> +static u32
> +post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
> +	     enum wqe_type wqe_type,
> +	     u16 ccid,
> +	     u32 klm_length,
> +	     u32 klm_offset)
> +{
> +	struct mlx5e_icosq *sq = &queue->sq;
> +	u32 wqebbs, cur_klm_entries;
> +	struct mlx5e_umr_wqe *wqe;
> +	u16 pi, wqe_sz;
> +
> +	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
> +	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
> +	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
> +	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
> +	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
> +	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
> +	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
> +			       klm_length, wqe_type);
> +	sq->pc += wqebbs;
> +	sq->doorbell_cseg = &wqe->ctrl;

... and this one need (at least) to be updated for the following commit
which is now present in net-next:

bf08fd32cc55 ("net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings")

> +	return cur_klm_entries;
> +}
> +

...

