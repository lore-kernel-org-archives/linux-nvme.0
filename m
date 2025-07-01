Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBEC7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rmzUj4ZD9gm0HoCKYYLt0+PcJutRfusCkPSoIPsvInY=; b=DE+CEZzAlNeEv48bqobd0n+55U
	/X7bS1aamr5o1EkM9qPITypZPr1El/MZRkK0opGLN7wrwCvOzLCMpWfU13sXPfL4SOruI6L7e8zBp
	4gK6RDir7kn9v7hIF3aXZ+ufeEkA+OZsXLes9PX5Nb14CuD5sL0Vb8/fCPJ0iRfdqyganxQ3dApam
	aXy9zsnOwh+O+mbZ4WchEIaETH3KqWEpxWm/oVkGjJObqQJl4yrNpWNHtfEnKDfzSoTm7k9iwKbRV
	8eDALyg/WFmhHEobk5drvyzG+YVvsUTXLRNQPcBRAJi+AtK/O4Bz0zHZdLpTmm9oHmzBEkqLgKvcG
	wUWTuzAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWdRl-00000005xz0-0YMx;
	Tue, 01 Jul 2025 16:03:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbqo-00000005gDs-2X1C
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 14:20:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CC3A3A52FEA;
	Tue,  1 Jul 2025 14:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204C0C4CEEB;
	Tue,  1 Jul 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379645;
	bh=rmzUj4ZD9gm0HoCKYYLt0+PcJutRfusCkPSoIPsvInY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrQmbsROkn81Qa45c1fXnnZNNwmO4+YXtGItxTGRGBkTFbZZa5KYuNhhED+a2z1C8
	 /jDDOdJEHdsA6yKmKxHPEKvd1wAf0YJlgIDu7C2HDh3tSeeVk8zTBYPKv/YtRr9LEx
	 b/RDk95xlMMehf6Mmdn7gursNVIzApQqij+z0W2woKboY6lOQkFER0yZXIh86VSM3U
	 Xaus1CtbQ1Httfkl7TuaCqqwIlbYxVot3BV5RHXyMco/pZzZrMI5abvI5dWKIuYzvk
	 lC15LIJZPJ9L+TOwVn80cWzHv4IBjaVB35QJn2yCGW9XkSaSJq5vIzWBw2KLW4dmP0
	 5dD1M7fg3HabA==
Date: Tue, 1 Jul 2025 10:20:41 -0400
From: Keith Busch <kbusch@kernel.org>
To: Ben Copeland <ben.copeland@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGPuue3_-BSPffR0@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <CAL0q8a7acv-9N1XUmJ9LAojdhm947eiira6Kx0tew-VVVCY6kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL0q8a7acv-9N1XUmJ9LAojdhm947eiira6Kx0tew-VVVCY6kg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_072046_708170_8E83FB70 
X-CRM114-Status: GOOD (  12.33  )
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

On Tue, Jul 01, 2025 at 02:05:04PM +0100, Ben Copeland wrote:
> Even though SGLs are not supported, I gave you the patch a spin and
> saw the same stack traces.

Right, that patch applies only if SGL is not supported, but it's only
fixing part of the problem, so I expected it would still fail.

The dma teardown needs to be symetric to the dma mapping, but we've
removed the sg-table now, so we don't have the original mapping context
in the completion path here. Christoph replied with a patch that tries
to infer it based on the dma_addr continuity, which I think should work
for you, but I'll have to look a bit closer to be confident it's always
the correct assumption.

