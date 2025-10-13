Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A3CCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6z2RRcYhZF1c6OOPt8TZ0/LKARfbBB8JHLy95oALGLg=; b=RqjQ1iTVt9Ql+0YPmqizq5jXmY
	TSjga0waHWz9PumO/KnXECWW+w+oUCo6gqAlC/3pRH/LtKtVqfh2qFqjFHGDEUYwOUeHc+QjPi0h6
	Cp7Sfw92RGHsfImz7TyV/4H8CZ6elG1L2mtmF9t6JJ32MJ4l2gR32SJ8l4jVx6TxMN+2iTKsFiEBN
	UHlxxbU0UQRcu3mCdhdqfT81Og1Ylp8tmTqY/i/nLMLbZp+RiO8w7rgvoMmhmDYT8Xw5/Updy5EwP
	2cXTsFHvHgbQKm+0EHYwpP5xWbMET3EpZqyAOH1aBCm6tb4uS3aVARHtcjYC79z/K6FwIvSw3LBk0
	r16gxEHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8NnO-0000000EEEY-3t2N;
	Mon, 13 Oct 2025 19:01:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8NnN-0000000EEE4-2NN3
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 19:01:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 03C90601E9;
	Mon, 13 Oct 2025 19:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C89C4CEE7;
	Mon, 13 Oct 2025 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382080;
	bh=XQDkE/8tBk6nehhOH0iQzIUwEp3GEInWpkiI99TIOQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qhaz/TnwVyoz6uNWfuBZZDGSDBBQT6YiFDSTiw6kj9qLlFOT5yPCC3xtvMC1oXAK+
	 CntVwTbpTyhaLvipsZtw0+6KlWL0FHX5K1/R3VcP38joXFPoXKLLlag80ONETCfTjY
	 09I8r/dX4oNga1FjMvtD6c64E9nTjuF2naqiXX/IXQb0Xp68Q2n8M+nNr4mysTueJU
	 vLgiUWhc/QVS9cuquDY4/nQ/Erv9bPgkja5lOUhvO37poGzsK0+J793cIGg85RqJ/X
	 keI5PZM5HeXEtGD2dk9F1bOioWxlrxIQstXRzaGt9t1SfdcZntRWMXzcbnlMzvLtDE
	 tCLNIpfS2yW0A==
Date: Mon, 13 Oct 2025 13:01:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <aO1MfsuWeteOsBve@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
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

On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> +	unsigned int attrs = 0;
> +
> +	if (req->cmd_flags & REQ_MMIO)
> +		attrs |= DMA_ATTR_MMIO;

Since data and integrity paylods use these same functions and may point
to different kinds of memory, I think you'd have to pass the 'attrs'
from the caller since it knows which flags to check for MMIO dma.

