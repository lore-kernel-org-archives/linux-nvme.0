Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8D8D462C5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdEAB8vo3mIRwywu9A+ErtsaYwfm3xKv1GLk4Ir7d9k=; b=FWXtnYPVP/wErThBONuUMbHPcr
	bzZWooN9LhIswuYSneRVyQKF0u09o4r4a4191+d8/LxWPkPXtoAXXM7K+i+6aqR/vMPPeODHDUAdF
	jaLnQIwSTAiwBbbUuEDOZXyBejXk2z+uv9XgEmxT09yntilKuXKh3xaI5QUbCKxNoNyfgRyEEnBxX
	1Q856PH5II3Qog2YvDPEkRUNVh51SUDMPkGvPv9B6B1H3qY4wosnCxDei8EN5EF1FGS33Z6vqmE1B
	A0iM3uLvUeAh6uMbw4Ihp3UnhqQRTbMolRcwK6VbSpxuzc9n9hrjj4MOgvlArGL/877y5qlTl0TWF
	l+9oacJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFbm-00000007M9r-0YCQ;
	Wed, 13 Nov 2024 15:48:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFbj-00000007M99-16F7
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 15:48:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B5085C5815;
	Wed, 13 Nov 2024 15:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BC0C4CEC3;
	Wed, 13 Nov 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731512918;
	bh=ivZwD0CBNuC8+rVFN6+R0NWpg/HGcntTXQEiyOO6OgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loaA+tAe1HPrDAg6qQec9I5fCLwGshUsPZwf6s5I67Ji5SGj8c2vSZETKVznnJiGU
	 tpjmWFhveHHW+VxY3ZBeHhzR/PLPPpHdC0NngmSV9bhrCAPGsOyxgt+IxRRTisZPuM
	 qDL4be7Gp9WsuSzT0kcW5YuvLor3TCzoPzuKpW9PC5qTs0CA/QcdjikkLjW1kgvyEP
	 iX8BhKXcunRIMTeNWSe7BmNjGLHtoK24IjkdoST7AGOLVCJamrbOG7RE7JnQIIzNuV
	 8LSf5gTUsuXhjDtyeqtUpsiUKFrcwy4OzrMO1WvKXjlYLQgsYGFSylFIW8Nh65yanU
	 +of0IOYBdhkqw==
Date: Wed, 13 Nov 2024 08:48:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nvme-pci: add support for sgl metadata
Message-ID: <ZzTKVN_1BdNtIuJx@kbusch-mbp>
References: <20241112210620.2650523-1-kbusch@meta.com>
 <20241112210620.2650523-2-kbusch@meta.com>
 <20241113045812.GB20379@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113045812.GB20379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_074839_364057_60C77425 
X-CRM114-Status: GOOD (  19.34  )
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

On Wed, Nov 13, 2024 at 05:58:12AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 01:06:19PM -0800, Keith Busch wrote:
> > Supporting this mode allows merging requests with metadata that wouldn't
> > be possible otherwise, and creating user space requests that straddle
> > physically discontiguous pages.
> 
> Not just merging, but also creating :)  I.e. it allows to transfer
> multiple non-contiguous metadata segements.
> 
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index e119ba0f8ab8b..12e5064b9cba0 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1985,6 +1985,9 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
> >  	lim->max_segments = min_t(u32, USHRT_MAX,
> >  		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
> >  	lim->max_integrity_segments = ctrl->max_integrity_segments;
> > +	if (lim->max_integrity_segments > 1 &&
> > +	    !nvme_ctrl_meta_sgl_supported(ctrl))
> > +		lim->max_integrity_segments = 1;
> 
> Despite the general mess about the SGLS field in the nvme spec, the meta
> sgls bit really is a PCIe-only feasture, and this will break metadata
> support on RDMA.  The nvme_ctrl_meta_sgl_supported needs to be in pci.c
> to set ctrl->max_integrity_segments based on it.
> 
> > +static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
> > +{
> > +	return ctrl->sgls & NVME_CTRL_SGLS_MPTR;
> > +}
> 
> .. and thus I'd move this to pci.c (or just drop the helper).
> 
> > +	NVME_CTRL_SGLS_MPTR                     = 1 << 19,
> 
> Maybe give the other fields in SGLS a name as well?

Ack on all suggestions.

