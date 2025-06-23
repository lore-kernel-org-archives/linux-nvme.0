Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF12FC7115B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKhGplLt2+34II2qJo5VucGifMMp1ZzSzUpcSBaznck=; b=Ha7lNY+RnQ45ltInQYIthYmYhP
	Ltf9HPeHC2xAljiEgebDG3BpStue/WM0mhfdipry6TBcAsh8J7QcysU3zBrMsT+mKRK6LlcPMolqu
	B10BbOIn35S4aqeJGq4Pd424eMpy7FC08bz/b0o6/UjwlibANUhmNSlDVRgAwq7kASicPl/CcljkB
	v5qxLNdaQWbGwBkWMicjUbNlx61+ZE0uw3NLD/Ga/eaiM7xdpd+NZBdH79OusQrItVtGkjGrhYgQy
	PqEEm5ATDe/GfYZEBkiaBmgnC+7XT5PlOCx0N4A0iMThI7OIVuEueo810XwH03xQVIiblDzSJujt1
	DsItqsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTmVH-00000003m7K-09Mr;
	Mon, 23 Jun 2025 19:06:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTj54-00000003EJ4-0SoG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:27:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC8F35C5CD7;
	Mon, 23 Jun 2025 15:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A131C4CEEA;
	Mon, 23 Jun 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692452;
	bh=joX8RW2I71piMAp33vBoXEKsMPja6dSHkMWvCKOCIkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1BtWkZOw1oszg7cK+LkvSPJBc4VzqzqZPe87GeEwmc/ha8yUgrsgOo8+XcCqXmmc
	 JQ9gUWYdqmOjOiYUem1CtvIr2YquiFPjg9ZvGwt0Jv96fhrCAFZKhga5Dw57D91C0K
	 wbLeanlVIl4qIHThXOPmJWg+JpN6tvHJscEphqwwzgH9Rga6O41qCLdAo4V2UsnKxb
	 R1R/4QSj0+cedkdCSU0xUEIEyCWbkR8iT607NTogbX2zMPnIrhLztOoeQaophfnrK0
	 ZBmSn4bUnoOyQqWeA3uhJdOhajPIAR2pWfQ/6Xq1PSY4u99dEXfMYawkSqZv3lug7e
	 EsfVR22zxMZhw==
Date: Mon, 23 Jun 2025 09:27:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aFlyYjALviyhQ-IE@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_082734_192297_93366549 
X-CRM114-Status: GOOD (  12.51  )
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

On Mon, Jun 23, 2025 at 04:12:25PM +0200, Christoph Hellwig wrote:
> @@ -888,7 +899,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&
> +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
>  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);

We historically interpreted sgl_threshold set to 0 to mean disable SGL
usage, maybe because the controller is broken or something. It might be
okay to have 0 mean to not consider segment sizes, but I just wanted to
point out this is a different interpretation of the user parameter.

