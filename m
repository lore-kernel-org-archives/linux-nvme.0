Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D792CCD1A5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Oct 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNbiGE3PQoyGg5QY5TNEnFlc4NMxXXCwubWo2ZUcg3Q=; b=g8KQkDzuagahLserVTRpC5fzWU
	HoIne/6/8KSid+hnyl8WvyHzU7yvTKISz284C4mK2bxlm8MrLBrOlpwr8CmiG8gxG5zqU/ACXDmPf
	ZhdnHBUVR7P7/u2N7I0IZEP4tuZiH3DycdH7CjkxVq4VJ3Jv8WPqGm0enAYAs8IFCkJTtAOy7j+Du
	+z80Wguxshz5waOZ7DmwNRfxrViXbyBp644FNGbb6yPZbdGWyYG56Ix7R4CisE3BfNiLoWqw2CJWs
	sxt9u6Gs6cInqMXJ2J8OhJhqNIEdHgXiG3IseaBVgEWe7lzDAdlfp6wrkKNtilomDX+omlu31N/CT
	m0YcDmiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD00k-0000000CKM2-0RVu;
	Sun, 26 Oct 2025 12:38:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD00i-0000000CKLo-1LrZ
	for linux-nvme@lists.infradead.org;
	Sun, 26 Oct 2025 12:38:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 17CB5602CE;
	Sun, 26 Oct 2025 12:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6923C4CEE7;
	Sun, 26 Oct 2025 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761482289;
	bh=qw8/PAvD2816zMcT/W8BWmFh+apV2YWDBWzHohHc9Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQkNk0Sta/L0r0qWJfiwMmnRcxJLqPTWe/65cQ3Pfpc0tJUxZYvyNDt5rE8LNhrwH
	 ggkYucPLXnNtjYQjAlu8w6qWbMQl7YVrXhkxMuFysWP3k3fxIhhYQZmDRktF2ySR9a
	 kc7oNCgEHxB/0wOT1YfEsl+0oH2Pl5pleG/MPqcicK2J94n794MkgfH8zsmvTvzVgM
	 c0ufi4zVyPp/rVKwUwJMljkndLo/iwp3RR3LY4yWDAVU3X151+3YKUTHwJ9YN8H4bN
	 tSbWQ6s5DqB0b0mgg0++GGAVkizOJJL6b+MXVvbr/Gb9OGqPe1cr4pXQIbDoy8ayvy
	 X9sOiqXbIGEdg==
Date: Sun, 26 Oct 2025 14:38:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251026123804.GD12554@unreal>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
 <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
 <20251022061418.GC4317@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022061418.GC4317@lst.de>
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

On Wed, Oct 22, 2025 at 08:14:18AM +0200, Christoph Hellwig wrote:
> This actually has block and nvme bits, so the subject line should
> say that.
> 
> > +	unsigned int attrs = 0;
> 
> attrs is always zero here, no need to start passing it for the
> map_phys conversion alone.
> 
> > +	unsigned int attrs = 0;
> 
> Same here.

It gave me more clean second patch where I only added new attribute, but
if it doesn't look right to you, let's change.

> 
> > +	unsigned int			attrs;
> 
> And this is also entirely unused as far as I can tell.

Right, it is used in second patch, will fix.

Thanks

