Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12BFCCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mB1lyDJtxnoLmeurhPWzLVLDYob9XndoNmsaP9fWeJw=; b=4n+GUxItJoHaRSebsqtNWPk7jk
	l2wvzW8HXqppE/EzRHWIfjA0wlwYZSUw+IExuwQ7yBmBhZXig8fBy/r+yDYMmdqeLEptEIexCvVHo
	1WTKz2OeVBqpcMXyLdje9aWWwuKAKVpl53weKn/ViZDS9prU9qPEksckZswRd8KeKBkt/1eqB34aV
	gyCk9NKa8J5rj9h9ZBKiy8t38GcaVZEDxnZ60ptz1N4ymQIvGYdtkaxRRxYa2+EvEm3rC28X2FUWz
	gA3p+25ik5XkU0TClcZXo53qMDqgZRc1HNCMklZLRrTJSHwKWNZV2aVX3+zCJlzU6rtw3uFIPjQG3
	mdKVp6Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlEy-00000003VLp-453I;
	Fri, 16 Oct 2026 16:57:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlEw-00000003VKC-4BO9
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 16:57:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 26D4A60A82;
	Fri, 16 Oct 2026 16:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D251F000C7;
	Fri, 16 Oct 2026 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169825;
	bh=mB1lyDJtxnoLmeurhPWzLVLDYob9XndoNmsaP9fWeJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BZdt5w6p84jWf0riEkOHuE+a1YOcGugk9zO9Qs04Z0U5I3Gy9Tlqyafp0CiDc58mW
	 aJ34Xu6nFizWsQTooGld+Csg88R63a+GiODdERTP+MWl3vTh8fhFcF96JImhNAbKuE
	 Nhv41ulBpmHzkY6GoAgF2n/S2Sb0O6J1Pu8mE95mYExYmLTjaPDUFip60WJZh8D0H4
	 40EDBIE899wHulZOncMsz20d5rEv4/ia+q7VIJh3MsVNeT91YK+oOM3shKJ+1ty8Rg
	 GZ9ZvYzJ8hobHy4U0qOza4HqXWYL5a5WZlSsZTB2XD3PTRMSvVaEJ+73PD2IyGJCnd
	 VNqIePe69G4wA==
Date: Fri, 16 Oct 2026 10:57:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	Erwan Velu <e.velu@criteo.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
Message-ID: <atJXYHJa4jkUWJmP@kbusch-mbp>
References: <20261016141208.2641974-1-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016141208.2641974-1-e.velu@criteo.com>
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

On Fri, Oct 16, 2026 at 04:12:08PM +0200, Erwan Velu wrote:
>   job                   | cache   |   IOPS | fsync avg | flushes |  gain
>   ----------------------+---------+--------+-----------+---------+------
>   psync buffered, QD1   | back    |   3885 |   247.6us |  116552 |
>                         | through |  48325 |    15.7us |       0 | x12.4
>   ----------------------+---------+--------+-----------+---------+------
>   io_uring direct, QD1  | back    |   3886 |   238.2us |  116593 |
>                         | through |  41924 |     5.7us |       0 | x10.8
>   ----------------------+---------+--------+-----------+---------+------
>   io_uring direct, QD32 | back    |   5088 |  6173.5us |  117793 |
>                         | through | 140196 |   107.0us |       0 | x27.6
> 
> From NVMe 1.4c (sections 5.21.1.6 and 6.8) up to the NVMe Base
> Specification 2.4 (sections 5.2.30.1.4 and 7.2), a Flush command has no
> effect if the volatile write cache is not enabled.

Yeah, the NVMe Flush operation should be a no-op in the device, so the
dramatic performance difference is a bit alarming. Surely the block
stack's flush machinery is not the reason for the difference, right?

If the device's flush handling is this bad when VWC is disabled, what
happens when you have it enabled? Can you re-run the same test with that
setting?

I'm not necessarily against what you're proposing here, but your numbers
are unexpected.

