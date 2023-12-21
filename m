Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D043CC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=trh8uV/SVrkJ/a2kKu3iP/8vvuOG9CFg3E0iPkNw4Ic=; b=Ef00hQ+q7hDd6QJF3glbws8YDV
	IKlOHd+mk4ML1/q6aZhSXRVAPOAyS8vm/AaN3hCLWj5uON+ZOADk/EfOj8ElPuhWrzmvcX9TNW044
	nwAWDJ9MghaXFRxUJ1yTqgTVCnNUIg804J3Rkh+CUoiEaZmCsvyJiBH+Ie3f5jlGYIhliAGqvZHXb
	/ga0xHd7c8fguIvIlLFNNNcpThcAQbfUs3r8NB1prQdO0sZ9fPu0Rz52Gehi8uvUZ/wAjzjVV/Uoq
	TqfHN2JjXIxitrOMYkSFoo2R/uvaeLgyoMDZCtUjkBtHD7j7ncIUd0kp3HCp/a+M+DN9vRhvWXvyU
	FODS5ANw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMSb-003aHl-0Y;
	Thu, 21 Dec 2023 17:03:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMSX-003aHI-36
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:03:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 59A15CE1FF4;
	Thu, 21 Dec 2023 17:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EF2C433C8;
	Thu, 21 Dec 2023 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178223;
	bh=Cjmw151Q8qHltXLXAPXD7l7NdX11QIL0kl2lAT+81DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUs1NUUKJn0oKififiJCXU1rcZouv/jYsUVf7jQmqsjnMyHOIoHoOIeNOrCHndB7t
	 faW9/Sh65gCzmN7YvM3enGW7L6a6q+wD8Tvez+U9KzeNtcZe1K/Odb94DCMnARWbmc
	 MssdnmpCXqfRUcwS+FfGPy9PehPHC53tFRVbI+0CnoanggKiy6wfMNJoIzkSu53uYG
	 Iw1KfyAzWLjiGl/2q+ZhXMfxJ535zqukHiqCnRqxe2/s+OTwCmpL1/QIBsbIRdLM2+
	 a/lScnBRvYLkgFePM43gDt6y/+F0A1jjajmvKAzEDbvQD6Q4hyE9+hotIZf7HUMKHD
	 1ewSEPUR/pcZQ==
Date: Thu, 21 Dec 2023 10:03:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, marcan@marcan.st, sven@svenpeter.dev,
	axboe@kernel.dk, james.smart@broadcom.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org,
	kch@nvidia.com
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Message-ID: <ZYRv7Fo6oCHgETyk@kbusch-mbp>
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <20231221121746.GA17956@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221121746.GA17956@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_090346_192624_568F1301 
X-CRM114-Status: GOOD (  17.03  )
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

On Thu, Dec 21, 2023 at 01:17:46PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 11:30:38AM +0200, Sagi Grimberg wrote:
> >
> >> NVMe PRPs are a pain and force the expensive virt_boundary checking on
> >> block layer, prevent secure passthrough and require scatter/gather I/O
> >> to be split into multiple commands which is problematic for the upcoming
> >> atomic write support.
> >
> > But is the threshold still correct? meaning for I/Os small enough the
> > device will have lower performance? I'm not advocating that we keep it,
> > but we should at least mention the tradeoff in the change log.
> 
> Chaitanya benchmarked it on the first generation of devices that
> supported SGLs.  On the only SGL-enabled device I have there is no
> performance penality for using SGLs on small transfer, but I'd love
> to see numbers from other setups.

It's the larger transfers where it gets worse. To exaggerate the
difference, consider send a 2MB write with virtually aligned but
discontiguous user buffer: 512 folios.

PRP fits in 1 prp_page_pool block.

SGL needs 3 prp_page_pool blocks, tripling the command's memory usage.

