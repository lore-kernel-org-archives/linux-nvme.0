Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C992BD31761
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVuFH9ReTo8s8VTKkGTxL0zVQnVPX28nyuPV6x+AAmE=; b=HKHTO55Tot8s0HNdQw/XrE0npX
	gHerF2piKZ7gqhmFtIElOLhIaw0bkjNLF2X89PaQXwqT+UupCqctDtACcOQr0FU8HCbSBlE+/GEWw
	cuwwKjSUuYPrGN+P0IWT3CplfMSwnbyAbh9fUQJb/m+iQ2Trw9VWkYfCzAFcBtd6f9Xj7QOYBP8l8
	v5POTtvftNykbKzOvsjzZm3gdxwADE9Js/f8L/UjvgkBWcpp2ECBtws7ox3xQRpGYRwpN4LcIzXfy
	PcZft2rfOsCqPWvN5g9i0Pk9VgZ0OlJNJEQYnc+pmxyhpZFNzDgQWQyzzXZ9Du6bUiZDQsr3KA88Q
	0C/9aIug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8MZ9-0000000049N-2nYM;
	Tue, 05 Nov 2024 16:38:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LyL-0000000HXQU-1cBU
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 16:00:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 028A05C5517;
	Tue,  5 Nov 2024 15:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30908C4CECF;
	Tue,  5 Nov 2024 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730822400;
	bh=23x5xm46gXEdI5ebgFbFxrk9ZudJPea8U0vq8WL3cFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1G+8C5W7Vx+lBEXGOb0V5Aogj1x6Mnn7nH+HvfyZpu3XWxYX6AltIhrxEhayumUg
	 VRrZfxUEmrkO2V6kC3d0HFxAa87uSLcGMh6lNIM4mJ4EL6Cu+503vnI56hKPda9z0t
	 E3gwVVVdD9Rp/AjbOEkcPN4DhB57Ir1b8dv/DwetgqtYepVR6kQuQqjCRYVH2I4u+p
	 EtfO3o28bvzKFRH5aX4V/h1Nxaf1NDfyCVqnBR3gfMrC9pRxoWRLtuq/tbtFXK02uj
	 kIMNPzhchZRU8kS1LhhcUWj3a2G+XtmXdZZv+jRj7oO8fcNjMxtOkN7SFiYwTyjZUF
	 tlym1S4LmQj3w==
Date: Tue, 5 Nov 2024 08:59:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: create single-segment HMBs when using IOMMU
Message-ID: <ZypA_oUFLNX_LrMM@kbusch-mbp.dhcp.thefacebook.com>
References: <20241101044016.405265-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101044016.405265-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_080001_500896_E8FA3887 
X-CRM114-Status: GOOD (  11.25  )
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

On Fri, Nov 01, 2024 at 05:40:03AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> NVMe controllers usually have a limit of how many HMB descriptors they
> support, and even if they support multiple they usually prefer less of
> them.  When running with an IOMMU, the DMA API can coalesce virtually
> discontiguous segments, and using the right API doesn't even eat up
> vmalloc space for that.

This all looks good to me. Thanks, applied to nvme-6.13.

