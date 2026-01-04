Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DFC2A06C
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bK/Y56uIHrAI3Fz4bjkMvnsQQssT/RWDYiRTVYHq4ZI=; b=jIVR+Yr883Il9D9aiBV3kKEBz+
	hA6Lotq2ee6txPBrEWs3MM6nACqG/qUW2WaP0ojic0GHAORfOmoVLxg/Oq326hFQd6SLKUi8EjAy2
	uTpfbP+Gxe7lSY2uoHaeB/sXhoRO8poOsr1rx0HiIG0ilY++RLqkX71O8mFqypsYKpboF9z9HBhq5
	WvINitSGLm9memOI6NRVxpkCrexyey61pupyC2NyMS3V+NEBQGwC5hrsMDpN68c57ZEKmoG1ZDlzD
	TnBbE5uoAiv34GRz2mNB/Ono98Jzb1UW9Awc1y1Huao40X4EmoZaG35/kaf4ByRz4FGA+mdxUpN+F
	kFrZl/kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcPpF-0000000AJBJ-3VO3;
	Sun, 04 Jan 2026 15:15:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcPpE-0000000AJBA-06EX
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 15:15:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D981660126;
	Sun,  4 Jan 2026 15:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2718CC4CEF7;
	Sun,  4 Jan 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767539722;
	bh=KwyBr6ZNhjpDSvllOYbZp4V3CNJuKep94TyiPfnFVJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOyBtXP5QALAHoberi2uTNUqvdvL5sqflEYt5769XwMwb/I0hnqAwnVXOB+xdtYYz
	 CbTbmWPQjo81mFDzERgMya+LJbHbhr7bnA5HUTfprjfve799dyQBBS0ruKoV7bbfFT
	 9ZUe/1M4YwSUQ5NtDr1xNM3a0lR+F0RlDpq9t+z0BYEm2RG4DRsj6uYHVRt4zXxFul
	 xW6AVbP+CxIwhs3yJsTZK7euEbJP83INr6qRKgE/POi8rZgaZHLRJov3Z0TmHxR4Y/
	 221b8Miml4ElJePHhhvT08rUsE239UBIwtKyFDDWRt5dlgyJh+1D0ctZqeokPDrgUx
	 lSeiHP2vkBLxQ==
Date: Sun, 4 Jan 2026 17:15:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260104151517.GA563680@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
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

On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
> Jens,
> 
> I would like to ask you to put these patches on some shared branch based
> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> and DMABUF code.

Jens,

Can we please progress with this simple series?

Thanks

