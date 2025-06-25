Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE80C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJzWtCkNFQRsgy1KeYTUwkX5GIoNdzrZw5SherovxNo=; b=ZfWV7k6Y9gUvh1+fPcR4L2q1Hr
	NuOf8svCl++F++qjDyxKdE8vaJ7sp/MSdBF/8RHxH3gD0uk7YxNX6rrlgvFp7FC6VafIZgyvpADUV
	H9aUpyxQaTix0o82CqkZswMKommJJfmsOvAX2mwB4a8AwfXY1Khszf/tAaBKUlF8aJuyu2YCArHhy
	M7woSgwT9UQ773F48RhNubq1LH69RF2WBlvPWaghGNlfvWypJ/e+hNcPr81hFgW7q2nCNXr+fXo4U
	p9632jnKQoGwoP6wy2lScdwhP5IL9/GUbUuoLv6LpAuTax23nwmyy1BIQDhN39c19yB+YEwkc64DD
	zsPU3HPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUUsZ-00000009am5-2ria;
	Wed, 25 Jun 2025 18:29:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUSaj-00000009DJi-10FZ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 16:03:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9006249D7E;
	Wed, 25 Jun 2025 16:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F0C4CEEB;
	Wed, 25 Jun 2025 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867395;
	bh=DB+eC0c3o2pnETrjNuTskHB3LeYZnQynixMCUoGGhxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQytwcdCVx19NT/KhwTZvD+/xzS0fsE/dOAekhrVpx5Lo0XX80oUDaB+mvAchxJnZ
	 8j/vgqi631Q0GVo4YsX18SE5I3Nol3M1bRD4ZLjZWLfeCUIoLnuSxeM3jN+qy4MFEM
	 bFGLocuPIfmysKMeZqpIjUeVYlM2J3YtilWFHY9omxPW4K+O6t929c9zlVycbVDJbo
	 /jk/S7p3u1F29/j88wRJK7hzFmXm9H5Gzxbaelbh6nBIrU6rrqwBsDyA5MGp68pvUT
	 MJGJ9fvCKgxF5w+JZPKS9Fp3rcUKqHlavMKct01rFOuHPLZ0ZFI8240EpG6BF8mM4B
	 3SxySj7OxPOTA==
Date: Wed, 25 Jun 2025 10:03:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <aFwdwa4-36u0w8Cx@kbusch-mbp>
References: <20250625113531.522027-1-hch@lst.de>
 <20250625113531.522027-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625113531.522027-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_090317_295356_3C8FFA43 
X-CRM114-Status: GOOD (  10.68  )
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

On Wed, Jun 25, 2025 at 01:35:00PM +0200, Christoph Hellwig wrote:
> Move the average segment size into a separate helper, and return a
> tristate to distinguish the case where can use SGL vs where we have to
> use SGLs.  This will allow the simplify the code and make more efficient
> decisions in follow on changes.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

