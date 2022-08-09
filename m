Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82233C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+/v5a1z7CV9AA8q2DsCR7/OEKQfT9Z1/G3IBxTNM2A=; b=l26uIoDN2FmYIcUZ7a7nFdi8Oq
	PHI4x9AQZR5PZeBvYHi6IoAvfMwjoOo5kze0BTA3zr9sm4jN10O7Wn2zENYhXQknS/P5RXjf4TQ/Q
	aywaBZBN9BDFEI0MDm/2NLNujQcBIMzTUcZvmXAPVgOOD89g9Zx8SmqE4DaQbr4OQgdYmCgP+BezM
	x26MPBKpc5QdKpDqSQw4D5B+ugjyKCn2LOsjYuM60NVmQ3SejEZQpu5G8IYtwldxWC9zjFwtkwjO/
	7C6v9TyzxM0+mMfDeCkmB5nyZhx4UaOtfQOV4oOFZbrVJKkAC5p/KhJfNr8hdHY3+NZjZ5fk2JyCT
	vtM9qJeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLSMv-0053zZ-1V; Tue, 09 Aug 2022 16:46:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLSMs-0053xb-2w
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 16:46:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AF6B160B9C;
	Tue,  9 Aug 2022 16:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C6BC433C1;
	Tue,  9 Aug 2022 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660063568;
	bh=H7kbVRAtb9GZOzmFO3rQ0QGsMQNhMUqqE1xRN8YJRvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrG0LcgUBcrq8e7AF9I0le9zmYPq/7kwYXWyPmBP+stBShkPKxfIU6eX8ORcPBsJc
	 wtiON+GuQr9K3VkRFmyzifIYmSBm3LkMe/VYrj3/u0hbDhwOIwElZiIlCL/PeYLU6L
	 NKYdNQgRVDnFX9wcxld3oCU3uLtT2Noq/X01ZpZtJnofqvTE4qSLb58TI2wT44cm0V
	 o/xGytd4OpTgqPnV9dCYU453PPKCCV4ELr+3i5O8ndMK/mU0xv/vtv94dzFMuFS9Sk
	 tUMRmTr5cHBuu2cmaXv0LgSWcMZYwSm2vwrC5TzTWl+xg3iEu+n9lTt30E9WG4/saF
	 vn0Amndb3VTzQ==
Date: Tue, 9 Aug 2022 10:46:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <YvKPTGf56v/3iSxg@kbusch-mbp.dhcp.thefacebook.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220809064613.GA9040@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809064613.GA9040@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_094610_208249_2C3A2768 
X-CRM114-Status: GOOD (  16.51  )
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

On Tue, Aug 09, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
>  - the DMA streaming ops (dma_map_*) are only intended for short term
>    mappings, not for long living ones that can lead to starvation.
>    Especially with swiotlb, but also with some IOMMUs.  I think this
>    needs to be changed to an API that can allocate DMA mapped memory
>    using dma_alloc_noncoherent/dma_alloc_noncontigious for the device
>    and then give access to that to the user instead

I am a bit reluctant to require a new memory allocator to use the feature. I'm
also generally not concerned about the odd resource constrained IOMMU. User
space drivers pre-map all their memory resources up front, and this is
essentially the same concept.

For swiotlb, though, we can error out the mapping if the requested memory uses
swiotlb with the device: the driver's .dma_map() can return ENOTSUPP if
is_swiotlb_buffer() is true. Would that be more acceptable?

