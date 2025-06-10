Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2037DC5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Si8JnOYGyAJiEjf8Q97XT9GOPuVq8DxqsXuV6VBfxa8=; b=N1A9eDtVl4Fkxf1vvoyDaAMjvD
	kpN3W8ruiqecr5kYAN72SYH9Sh+YWL533sZBJe7+3FImFnCNeQrxK/w5s5P9fRAV3DYsxDIjvWcAO
	8JZ/ansjnti3bB/aC2H/HDOKOlUTQB95wdByGplUrO53AFl+yLqYdOe4yElhaYkij16BuwGWLbWwM
	pE7tx/hw7zgl3Uf1wg+4S9dlNkHGUfUFzLn9CKH+ZBGuXiPlplTPdxK6EHh8VGnLphO43czoULOMZ
	7SDEv8Q20qv+0z8iqGbpqetLeRjl6lRyuT4GyjLGYxe+M9/IJ8R5W5rlucoBIykxIaDfaPUs28oh4
	F9e2l06A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP12Y-00000007L3c-24TZ;
	Tue, 10 Jun 2025 15:37:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOykR-00000006uPw-3x9C
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:10:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A09BA5C5469;
	Tue, 10 Jun 2025 13:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34819C4CEED;
	Tue, 10 Jun 2025 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561039;
	bh=BcWdaNn+gD0RBwpLii90n/aNcuaDlEyZunddGwrP+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3A4jbCjAasEfmRLRMXd0iSqFUKYe8nEHUrtaKb5PX/LJOso/6yFX9hJ+Fs0WEeqM
	 m5X8f3UdOWx3qDyKJGSnY3ch67i9sLaYjBBJ2lXY1roxNK2ljjP8BCEKr4WQYSASb4
	 ffvVBA+R6kA6WAuLtVm6uiyUwXXICTjfMwUxyZjMar4/MzgCCX/ACfOH7kZWoKwG50
	 xPBQDKTw/N648uWwfmygUCQvcGjf6jQeE3lHXDoYURocmGtek6V7hYrnKqJUZXcG11
	 z9Ij2XUMOucMTZ13Kn9eoHbsrRl0ieIVWu9jUp3UtqgFr7tgFgcu6FknnBUHoathV7
	 8R/PfdWe069BA==
Date: Tue, 10 Jun 2025 16:10:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250610131034.GF10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_061040_027841_CA62921F 
X-CRM114-Status: GOOD (  12.90  )
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
> Move the average segment size into a separate helper, and return a
> tristate to distinguish the case where can use SGL vs where we have to
> use SGLs.  This will allow the simplify the code and make more efficient
> decisions in follow on changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

