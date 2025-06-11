Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E4FC71135
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkONy01OQvrLiRKZwGs3fucFTWVQC6us/hBQPuIZBQc=; b=RB92xV8jUt+zahdtJUUH3t1vmh
	WsYgVPMx5WJIcNueVoQwELP9IyoerJTN8Ea7dskFi5A3Wbs1ZNVbHJwhy2msqgovFrDMH1TYwNR9m
	noK7eOmP3O8O/wJCkrBhpo+xXizlDDziG6iXdnmgISx0HWXfxT+a8MxfKyjnYIZrHhh1xYcXZ3zLb
	/exITaFOgbNN+STwlzy16ablVHoulGePj5vxHA9MO4iGGnHexa/rJHWJLZeAjM2uETfGvFSD7Q2uJ
	fjz7/6QVYPeBoEdBGLQH/ouaun5uolgYZVsatFpbDUH1YdhH4Km6p2r8Lr2fgGhsyRN+l2doy3JaB
	BjcwQ6ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPUMW-0000000Ba6O-39lz;
	Wed, 11 Jun 2025 22:56:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPT9N-0000000BMI7-3S1y
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 21:38:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A35D25C63F7;
	Wed, 11 Jun 2025 21:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43973C4CEE3;
	Wed, 11 Jun 2025 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677905;
	bh=2vmuhdS+sywedYC4HhfK5n2ZCNJ9jH2NFwV5aFEEh24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imnw2yljyKAMX/ToZAK+hpHYEfPElTmY8uzaT3irIF4v/QgcOcs/Hw1RtVKDa/vZ1
	 J4XshinlWGuR+mBdyNcrhs3P7QoqC6ZKubsBawBABAghc5gDlkHgshH7tZky9Xtbwx
	 c6cjm5K6Ig6Ix0O+XQs2/uxZJKQrdgSXMYBO9Fbpc5wsq3R6GgaHsPMh5kbMHWvYRF
	 sGqYT08X7N3gCL2dfeChf0s1jk64wTdNxiH4k4GoO2aQ1RGNLujoyLZenKZfmfdc2v
	 iVjrIr4RCdjUt4R3J7PGIWktZI2JwMGZjcf0FcxiX8Hk7GaWVuB7Y9+Rfd0vBzuUBL
	 N7i+bYLAS+yBA==
Date: Wed, 11 Jun 2025 15:38:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <aEn3TZO1nGnh3wvK@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_143825_901943_76B3C909 
X-CRM114-Status: GOOD (  11.96  )
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

On Tue, Jun 10, 2025 at 07:06:41AM +0200, Christoph Hellwig wrote:
> +static inline bool nvme_pci_metadata_use_sgls(struct request *req)
>  {
> -	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
> -		return false;
>  	return req->nr_integrity_segments > 1 ||
>  		nvme_req(req)->flags & NVME_REQ_USERCMD;
>  }

...


> @@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
>  	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> -	    nvme_pci_metadata_use_sgls(dev, req))
> +	    nvme_pci_metadata_use_sgls(req))
>  		return nvme_pci_setup_meta_sgls(dev, req);
>  	return nvme_pci_setup_meta_mptr(dev, req);
>  }

Am I missing something here? This looks like it forces user commands to
use metadata SGLs even if the controller doesn't support it.

