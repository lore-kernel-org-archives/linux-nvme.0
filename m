Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA43C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AjzmMHg4oT6++XJnBBiU7HBNZ/rYqods2nSCn29KEuU=; b=HTwMZuGuENiJf9Ig89B0Ud7SFc
	uaDT+6vNOgoqdjOFjxOvV3sVRX/pHP2rik0dp0SsaJ5IjqIbDuTR3AVwnIW+jMg8Elfs0JFhmKUR5
	FPboMNwisIMfJWJZtPCTkIZvRv7NiZhrZ3/yavmdci1KOMLBgAAEsvAPDuGi6hfI6aE5NJp2CDJow
	RIxnPvLuJ16FRt3T0ElxHYi09nb7DXFzFkRiBADk0+mW4VIO7LFlqpYo0BR/ufLMsdj2l/8Sdoz7y
	zdQ/WCvTu1MJtw7cjvsz50ryj0q5JWeirbzS0gdYdGS2NH/x4kX6dH5IDgorYlgC7anTth6qtfNCo
	Ku9ya00Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP0lQ-00000007GmA-21P8;
	Tue, 10 Jun 2025 15:19:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOySd-00000006qNl-1Lo7
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 12:52:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 136F15C51AA;
	Tue, 10 Jun 2025 12:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA52C4CEED;
	Tue, 10 Jun 2025 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559934;
	bh=JwfMRaXFDDcYug2KIgrnVERgvWlE8wove/kTuolnULA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYWPXDVmLs7QdDfubenWppMxdAmlxmoTZDbldEtP3Bg2abqUShOY7wFM3XjANm6CW
	 pL3XOgp6l5Guu1faLUlG3hxdXmx2l9Nx7lBgnXGWizzm31R7Pw58o9KQ9hmUQ952Fh
	 voG4DcUnqBbIw7h1mgdE5NIBmCEzy8e41dw7GLBfWgJEl5mJcm0ZJlzD/jONrXlYW1
	 IOVMOtNahLhfKttyz8qakCt0l0YdrEbbRcsme2/pDOEX4f7kj9GLbdP1vAkG0/ZPgA
	 UJSw5ycRSdwPtyq4D/FdYw/AIAfxiihwKiY+u+jKSXbwtvXSDMdCGP+lDvT38SxvFK
	 u5tOS+5aoe1LA==
Date: Tue, 10 Jun 2025 15:52:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <20250610125210.GE10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_055215_400188_826C6628 
X-CRM114-Status: GOOD (  11.74  )
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
> Move the nvme_ctrl_meta_sgl_supported into the callers.  2 out of
> three already have it, and the third will be simplified in follow on
> patches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

