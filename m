Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D6C71135
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFGxR9d1FpyuQXgUpQ5o88tVpQP8eP3GTkyFS+pk1Gk=; b=AC2xub8Vze37IuQQms/rN7VxpO
	aCf/k9nR0RQyM4dc86NGkSH+3z3CFdNOl2x0NAQMQBBhmjAaljAhIeMz09M5LR76fMfddZyWv39zC
	a+fJ9kKbrgfcZ0au5/5dM5IbRDLgPow1vwKJXvfcNjsfxPAWSe075U98CCZ6aQOTRDAvPT1iRfXNy
	9byOvibyyMmSwEeXu7fVIVkgXgRIWGD0Ns3lPzxHTKzEbobzCjErWrMekXiijfly1Om4oSetflOdA
	5AjYcSRbHiH5U8G1G9XkEe1C49iHF31wZRZ6okemMYH/4bQ9GhIqd3Id2tmEvHUjBDWh2jvwN9C6z
	3P//gGaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPTx7-0000000BTej-3VRs;
	Wed, 11 Jun 2025 22:29:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSPS-0000000BDWf-01MO
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 20:50:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 15AAC61135;
	Wed, 11 Jun 2025 20:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CDC4CEE3;
	Wed, 11 Jun 2025 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675056;
	bh=gf+hIWT9HhXqRqMoHWdMRBTuwbAJOSl9YndIJ3I3zes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7QrJChkFzVsAw+KF7PRDhHLQXFndOX0uKd0aorRVyzMoe+tPQKuqHDQa3IsdzLaw
	 c5s33sv5Z4MH+KAwkjhkh2xtJUav98RNFW5LJs69IqCTxAfMHsn94LgljVB61Q3Z35
	 YjxOcss1faPyrskjewVIXlpGBZqadCVyBYC6ircuDrPzXXpBD2Vlk9IJa/yWgOsgdQ
	 h6Ja5peuxUqkuSslDEm9RN7N9EgR6dGQfPUYLB5d8l0E1CTJzeOKcOCOI6++VgN13b
	 IB4VGBKZ+eLjmGlHnv0sd7g2X+tIA5bBX5z5BoPl6qsdSkSJ43OdaEKffhnsQE5Mtv
	 FwoH0ZWZbcqtQ==
Date: Wed, 11 Jun 2025 14:50:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aEnsLRDcZ-ykBsVX@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>
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

On Tue, Jun 10, 2025 at 07:06:42AM +0200, Christoph Hellwig wrote:
>  static inline bool nvme_pci_metadata_use_sgls(struct request *req)
>  {
>  	return req->nr_integrity_segments > 1 ||
>  		nvme_req(req)->flags & NVME_REQ_USERCMD;
>  }
>  
> -static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
> -				     int nseg)
> +static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
> +		struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> -	unsigned int avg_seg_size;
>  
> -	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
> +	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
> +		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
> +			return SGL_FORCED;
> +		if (nvme_pci_metadata_use_sgls(req))
> +			return SGL_FORCED;

nvme_pci_metadata_use_sgls() already handles checking for
NVME_REQ_USERCMD flagged commands, so I don't think you need both of
these conditions to return FORCED.

> @@ -886,7 +897,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&
> +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) < sgl_threshold)))

This looks backwards for deciding to use sgls in the non-forced case.
Shouldn't it be:

	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))

?

>  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
>  	else
>  		ret = nvme_pci_setup_prps(nvmeq, req, &cmnd->rw);

