Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A1ECA0FE8
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qxpdd7vSHWAWUcYcWrm3MJxf6eR+loQRCQUNdueFNek=; b=fJ5sU3CgDjeyUJ48uwASD/0viN
	XsY/2WpskLe+N8/vUBhnXMN1/YXN0wl+MoE8rLvVtWyJ9xKTjzMQrKSUf6+E2ak1t6hEudgfy+GsO
	M8AIxbbv8AFhON872bjxhDGOlbEoiljzSwEXngKVFhbS+FDT7yXs82rPdgnxeyuTeac5FydTvZycQ
	EIqNKGcRpFxpfKgjCI7tXRxS8gMwv70uS9Wo9qdJi63YyqZ7HsZlQyrbbh7MpUM0Wp8ud5kpjTcp+
	uh1L0jSF3CPy3XFRlY1ajZD6Frc++xC0Z9aYVJAGkxUt29dZ1H5FPwRDCYAr8eUz8I+pSKvDwSXUW
	jpnM+FVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYir-00000008Qaa-0eoQ;
	Mon, 25 Aug 2025 15:03:01 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXZb-000000088zb-2BlD;
	Mon, 25 Aug 2025 13:49:23 +0000
Date: Mon, 25 Aug 2025 06:49:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <aKxp49SdTknkO1fb@infradead.org>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204420.2267923-3-kbusch@meta.com>
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

On Thu, Aug 21, 2025 at 01:44:20PM -0700, Keith Busch wrote:
> +	/*
> +	 * The virtual boundary mask is not necessary for PCI controllers that
> +	 * support SGL for DMA. It's only necessary when using PRP. Admin
> +	 * queues only support PRP, and fabrics drivers currently don't report
> +	 * what boundaries they require, so set the virtual boundary for
> +	 * either.
> +	 */
> +	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
> +	    ctrl->ops->flags & NVME_F_FABRICS)
> +		lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;

Fabrics itself never needs the virt boundary.  And for TCP which is a
software only transport I think we can just do away with it.  For
FC I suspect we can do away with it as well, as all the FC HBA support
proper SGLs.  For RDMA the standard MR methods do require the virtual
boundary, but somewhat recent Mellanox / Nvidia hardware does not.

No need for you to update all these, but I think having the transport
advertise the capability is probably better than a bunch of random
conditions in the core code.


