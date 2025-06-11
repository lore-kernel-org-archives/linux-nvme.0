Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E3C71149
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itjpmWn8rFXLHXEJr0maI7um2F1Lpkt93D4yK0a4E3k=; b=BxtJvrzgvrhYB02nmtv00S7V/X
	SQ5MaObnn2gxDr5+9Q7wAQiTCsrVrfWHEyZYQlr3z2tX2RLPXydw37+jd1ScZpZNc6XO6gVkkmP3C
	/XeODzJ8vycQQqnOBRC2GKCM3luhGlriC18IPftOzVeZlDUBjaNLy34vT1tr0jPnefYliGfOvhMuz
	u9Cg5AGVhvZcyaPuAE/eqXEUqnDhAwfsyQqgoT4vO5+h/A/OWyQgp1QlT++LWNiVfS4+Ke50uT9SV
	Z8Mfn4gimpi9BSq5k9RtvGu0FJM/INOqfmYper0WfpoeRUv1brSHrA5uScOblWt8g/HH4abr7jIwu
	+MYvO7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSoH-0000000BGVM-2WqD;
	Wed, 11 Jun 2025 21:16:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPOHA-0000000AbpI-2agI
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 16:26:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 842115C56EC;
	Wed, 11 Jun 2025 16:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F112C4CEE3;
	Wed, 11 Jun 2025 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659166;
	bh=fKCue/QRAGLJEvsZ48ApXivr3PElq2mFF2q18ziSqeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1tcDAkUdPJ8BLQiFMQqrOoJlInDmXRG40dxIRDrTuna8Wm1UOs9VNUZpdTo62mm7
	 4P3xKc01nGq35CE11qepOwBQ8aKO/lTo2C/7NqmB2Ww+y0u/m7Eefp39KlxyqNAff9
	 H/pE8vi6X5NliSRGC/GbaYZiB/CGFHnyIIW2L7VlAJVbwsnezI+hm3u/2eLeg2ekTq
	 niJrrHie2h1T3B2kl17ZTHlYSXZG0IC6ko99lFj8FiLBbeNf9d3butB94yhsLi6C7x
	 Qx9ihtcZbnXBFyCO+WRqUZytAZdw6AVAdWVEchGJz9rb4JkM9MfpWpj5AtifJ3XE//
	 YVuR0+ywOsypw==
Date: Wed, 11 Jun 2025 10:26:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEmuG1dUDGuci7VW@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611034316.GA2869@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_092608_694417_50F36FDC 
X-CRM114-Status: GOOD (  19.59  )
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

On Wed, Jun 11, 2025 at 05:43:16AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 09:37:30AM -0600, Keith Busch wrote:
> > I may be out of the loop here. Is this an optimization to make something
> > easier for the DMA layer?
> 
> Yes.  P2P that is based on a bus address (i.e. using a switch) uses
> a completely different way to DMA MAP than the normal IOMMU or
> direct mapping.  So the optimization of collapsing all host physical
> addresses into an iova can't work once it is present.
> 
> > I don't think there's any fundamental reason
> > why devices like nvme couldn't handle a command that uses memory mixed
> > among multiple devices and/or host memory, at least.
> 
> Sure, devices don't even see if an IOVA is P2P or not, this is all
> host side.

Sorry for my ignorant questions here, but I'm not sure how this setup
(P2P transactions with switches and IOMMU enabled) actually works and
would like to understand better.

If I recall correctly, the PCIe ACS features will default redirect
everything up to the root-complex when you have the IOMMU on. A device
can set its memory request TLP's Address Type field to have the switch
direct the transaction directly to a peer device instead, but how does
the nvme device know how to set the it memory request's AT field?
There's nothing that says a command's addresses are untranslated IOVAs
vs translated peer addresses, right?  Lacking some mechanism to specify
what kind of address the nvme controller is dealing with, wouldn't you
be forced to map peer addresses with the IOMMU, having P2P transactions
make a round trip through it only using mapped IOVAs?

