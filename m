Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA312C678DA
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgOTldmHYzY41B040Q9/kN/OY96ZYH9M7UujHmsfe1Q=; b=ZP+87PiguGzk0YY7Ona2iCnImS
	EfRSi4HoI+hvfdzAX4up7/3nHrzJeqHO3zs9bN3/pi1kIWpC47VBg+gNyPwO/WJ3FYoB823LJmsK7
	4FULJhyp4wcSE2h8gOqL9gMdOzDlXEokszl//tAcDSbo1lFwnP1Nw6ER68o4pWZ5wPNLwb6WKkI0r
	NqeOZ0dYKwkk9w374nOrN2QCEaJUnBoSlusK2v+XmHABmfP0T/33tfk3pTIGCgiZasfw/uulNFY5x
	yfQ5WLkrU3eR6MWBmZcH27gv8rAxliTGOCuAGm1m66tEifVydqR0AqtnlK1huJFpcZ6ekpNQqaFP+
	eIoNdeRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP0SB-00000007CiT-1lep;
	Tue, 10 Jun 2025 14:59:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyLV-00000006ojL-3CBj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 12:44:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 89BFD5C54C6;
	Tue, 10 Jun 2025 12:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A414C4CEF2;
	Tue, 10 Jun 2025 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559492;
	bh=nENN5E4cU4vlaajFZf4FyS7H/8oCnYy0WKTBohDXero=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmlpSdTs5cjVi8dmgyDQWcAGloOwm4MYO70IWjrwc/CjghgQ9KI65CHsejYQkoj0M
	 E0hklrtJVjnHXkMaJIVE7aMkmRhZO6jrTvdClB/bkfOHAUPPPoDRDN+eEV0oCS57S5
	 +tWGDTyO2t/Q8KI+ohMY2z3JrpiSpYL6ZE7m6wJtC0pksASUKfxfWqMBn4ArAkNXT4
	 gIQ4OnBTPGT2Go3o3BZQGKc69hWan2AfPZxZxE7OyA9QtGx+wYUwyDqn3IhpIHSica
	 Q5Y73tbvK2IvJkDsnbANU2+YYChtWgDyiEmVdQf5Mzm4zJvNluy9Z00fExnr+lxTS5
	 d35LeRDfuXI8w==
Date: Tue, 10 Jun 2025 15:44:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <20250610124448.GC10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_054453_840482_EFC117AD 
X-CRM114-Status: GOOD (  15.98  )
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

On Tue, Jun 10, 2025 at 07:06:39AM +0200, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c     |  3 +++
>  block/bio.c               | 20 +++++++++++++-------
>  include/linux/blk_types.h |  2 ++
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

