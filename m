Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01779D2ED0A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zoCT4icyOLd/u3Rsciek9H/HEbnyl6qOerfuTKFkY6w=; b=pNjb9YK0F1OR7saUm/DNtxXYRB
	MbbbtmNpzRrRtq30Z2w+V0MW+3sGcBX86yguEtnUnVUGrbaMMsUrty6rAwWgNvtFLXRbUifVDI8NQ
	54NAolxqNMhAqPTxSk+Z0c5kpWFmF/cVTZpzGcmp7Ftpo2v+6CVm0YdDCn+N7R5E8oMqx5RECukc5
	wyGzKRRCtaKdllUeWmUKiXWDgtj3TyHIvr0gLRwJVC5s5EumSCb+FVNk56wuEM/SUq8o4VYkF+G3h
	z+8ApgOr+9nu+363C4RxqDMF1/NI50pZmElv8X7Yuf//BsxuCkh3x0DQIr8By/YhYwtjm15slU04w
	a8MfANsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wNm-0000000FT3A-1mcY;
	Wed, 01 Apr 2026 14:17:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wNi-0000000FT2y-3Kqy
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 14:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zoCT4icyOLd/u3Rsciek9H/HEbnyl6qOerfuTKFkY6w=; b=EeoZhB5mPFE4bScdm+ZnVGLYki
	I8+mHNdDdoFcgobSbG6qzUxKMdz7a0Zc846Fn01fLE0+0ftJh3D5KkHEbfw9mgfUsmAzvSfaMgKTo
	3OYVvG2eRxB2xQAFpfHRaCK2M8SZ7GRtTiURg7Hqdp5HNox4oiCaNreuHRDRltvWs6BeTCWkOInYN
	idBaZVFZ1fTQ7JUMkgrHBQI9XoGGJTyrfU7Dc5BAxCnpXW+rbsO6BHeL8xzq0uTA2jRv3I8ZrqOru
	vYJ12T467hmZlswDtiDTxb87kJU++ZZdDZnS3XvK2RA5TbqS3C+7h8omGxa+KdAfxPqwOKNMbHTaK
	sOEmxNNQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wNf-00000000aIy-1D18
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 14:17:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8494568D05; Wed,  1 Apr 2026 16:17:07 +0200 (CEST)
Date: Wed, 1 Apr 2026 16:17:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivaji Kant <shivajikant@google.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <20260401141706.GA22165@lst.de>
References: <20260401103441.1229964-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401103441.1229964-1-shivajikant@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_151715_514033_DD7BA1DC 
X-CRM114-Status: GOOD (  19.18  )
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

On Wed, Apr 01, 2026 at 10:34:41AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.
> 
> blk_stack_limits() currently filters out this feature bit because it is
> absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
> in nvme_update_ns_info() after the stacking operation.

This is really two different features/fixes and should be two patches.
Note that Chaitanya also has an outstanding patch about p2p on multipath,
so please work with him.

> Hardware reachability remains enforced by late-stage distance checks
> during DMA mapping.

I don't know what this is supposed to mean.  Callers need to check the
reachability first before submitting P2P I/O.

> +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
> +	bool supported = false;
> +
> +	if (r_ctrl && r_ctrl->device)

to_rdma_ctrl is a wrapper around container_of, so r_ctrl can't be
NULL for a non-NULL ctrl.  ->device also should not NULL because it
is set up before namespaces are probed.

> +		supported = ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> +
> +	dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
> +			supported ? "PASSED" : "FAILED (HW/Driver restriction)");

Overly long line, and screaming isn't really something we do in our
messages.  We also don't do that debug message in PCI, so please just
drop it.  IF you think this is important enough add a tracepoint in the
core code in a separate patch.


