Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0D0C677C4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 19:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IM26X5C1uM13qWNLt63Dfrka82WaMnsZGAnoBWJpxNw=; b=UZ9szFZ2tgoPrK4EghBQV4i+VZ
	vZ8mJ/5hMRb3osbvqBCKpMsp62mc6T3+7BhBmKHnMkR3Q2hPqnMxoiUpud6rQ9+FMKq0A5x3CyB78
	8KS9PW+o5pTVV1DB0e9kh1ODMA4YnxVgUrzwuNOJ86eb6QY+EO6h+iP24xZfoiAv4MOCfNj7wUmqd
	xtmUkop7BNPL7x5DB4yYwm+TxXGtUJFGd2i3emLE/0tHCYor4AYquGaYkFkpeSJ1nWea8ARc7hp++
	iTgiv9kMw10xSb0/u87JIUDmlIEcuE9Oe1cxxNYI/k9h1p69QlCAJC96kaR1D5t4igdM+qqZ0cFKN
	h6LNs3LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP4VM-00000007uHb-25nW;
	Tue, 10 Jun 2025 19:19:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP12b-00000007L51-0pL3
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 15:37:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C564629F6;
	Tue, 10 Jun 2025 15:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD2C4CEED;
	Tue, 10 Jun 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749569852;
	bh=TAlAnZ3QKtHhtNUZqaBtjheUqmF+Moexcf4ler6YxJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcV7pfLQVxJRnYH1e38OyW3r2QLZb0E7vokAVrfhjWBKUCe6drDnNbfNN+BGI1wjU
	 rFzDDzbvmN3d+9ECNbAD9rFl9BKL1eDLOFTbWKB1C2TWr9qAiDXoKXy0RdRPrlq+cl
	 KeultfRrXqLhMrQcYLhTjoKOvZFt2e7b4CDIuWvrFoCsazJUp/Uh+++JEltSHU3tNU
	 vK4yeSH2tvoI/0av4cjLnQicklMqZHEcjKcglRhZUvriN990qjbmexQ9XGkI8STxSV
	 +Ja/Kziv9GkRMVGp0UPD0EEI0yg76lM3vFa+7OK6BnT3KrhguOIi7MzVkp3drqJlb3
	 R+znKIHrCxf8g==
Date: Tue, 10 Jun 2025 09:37:30 -0600
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
Message-ID: <aEhROl2D89kFX8C7@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>
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

I may be out of the loop here. Is this an optimization to make something
easier for the DMA layer? I don't think there's any fundamental reason
why devices like nvme couldn't handle a command that uses memory mixed
among multiple devices and/or host memory, at least.
 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.

