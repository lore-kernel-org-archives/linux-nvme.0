Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A08C4450B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfAmbHkxOGOZSvyjNYXHGCsXwJ+f1gQZquKSLvKYyI4=; b=2lJ0ZGpOLa3qS1WQHQlk+aGm3h
	ywgQs5dL+NZjCEChkfO4Roy7Jt6bPkgkGiE7ox7KLFRAZ9hHdV0j02igR5rNdvxcEQ9GsPCuVjVDR
	d5kaE9/2ZNoWGR32VSKipcC7PdhXL++qn8woTh12Ky05XvLJ0ffbKEvmczD1a94cv3W5St4QaTykD
	E6SduxTdQna1sChWEloaZ2si3iPzO+bmaP+J7g3KQ+9a4aoEfuQG8dHBW7V0/upy+NkiunYw/XTR7
	2L3ywKTgwqe8qI4VFc0M0ADspNbCuQG0bFOS4jet8dtqZofOiPnkFUVB1JkxVAiPsBf4o6xxtAst0
	SSlAmC5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjkUS-0000000DK0E-0LOw;
	Tue, 14 Jul 2026 21:16:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjkUQ-0000000DJzc-2DuC
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 21:16:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC0AA43AD7;
	Tue, 14 Jul 2026 21:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C5D1F000E9;
	Tue, 14 Jul 2026 21:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784063789;
	bh=kfAmbHkxOGOZSvyjNYXHGCsXwJ+f1gQZquKSLvKYyI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbI3KRfQvZuVGdAlOnieGxAh6cB8kcdycwYbR/dhgR0VyVdv16RE9PGp6Iqyr9GH2
	 d1RY2f3OVqMKf/k+JSDDo2EB/iujBidjvAwWPaZqkRw6l1es+caLe3OXlOYVa7JYA3
	 PgMY2jWWtLZC4+A0K7UwHJqLv5dbHMfO3jpwuWuTF2pgLvCA31Vflk9Qg7UnqwJkzT
	 Zk5XXACUVob4H0asP3qDA6ikV1kjp9fQOIbJrWVWk3IyAewA2IK3CZQVgbBqfAuZLP
	 JmFp7WIHj8eev1KUPIElQpi9q3DsxQWRTltFfoo72RA9uIm4vNPKxM6towWbPlzq9r
	 uk8gEwyuj6VNw==
Date: Tue, 14 Jul 2026 15:16:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
	sagi@grimberg.me, roger.pau@citrix.com, phil@raspberrypi.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in
 nvme_free_sgls
Message-ID: <alanLCR3Gew9Fuac@kbusch-mbp>
References: <20260714201342.1347823-1-nb@tipi-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714201342.1347823-1-nb@tipi-net.de>
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

On Tue, Jul 14, 2026 at 10:13:42PM +0200, Nicolai Buchwitz wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> commit a54afbc8a2138f8c2490510cf26cde188d480c43 upstream.
> 
> The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
> parameters swapped.  This wasn't noticed by the compiler because both share
> the same type.  On a Xen PV hardware domain, and possibly any other
> architectures that takes that path, this leads to corruption of the NVMe
> contents.
> 
> Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [nb: drop the attrs parameter added in 6.19 by commit 61d43b1731e0
>  ("nvme-pci: migrate to dma_map_phys instead of map_page"), which is
>  not in 6.18.y]
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Yes, definitely want this for LTS.

Acked-by: Keith Busch <kbusch@kernel.org>

