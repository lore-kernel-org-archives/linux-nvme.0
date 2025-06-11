Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D90AC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mp3tpEUI/np35pt2H813TEIBhYFlhsTXQ2G6rjrZ/Pc=; b=2iPFjvpUGMn3jZgNV1cOwKRJ8c
	6yIq39O4yCBKJw9nmN73SxQF/GRN/UI2VFnXom+wpWRi/Q4Hg9UXKFDEiAC0ZshC+7tWcSmhqagLB
	mH2mjQFl0Sa4PqcicP9F3BubazRmZ/QVuAbtHFQ3FXOqINzldthh3mW/2bgj5BwP37b3xGopcc7dV
	fdqObxaYiZ7eghQzD2zlvv3ltZWSKRurQavK1TE09+v6sGJHc0KR0C5N+gOKEdc6ZFQdVNM7v4GJn
	ZKzx3GoTbVeMi5HnVxxRr04ml3VK7/LhdxbXH2S/Sll/s/xdOkv+bXDzFZ6VwZ3Z8u0c4q1DyIOpA
	uL/7Q7TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPTma-0000000BS8Q-0Gzg;
	Wed, 11 Jun 2025 22:18:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRd3-0000000B7AS-1mDX
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 20:00:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mp3tpEUI/np35pt2H813TEIBhYFlhsTXQ2G6rjrZ/Pc=; b=XHwGJnexCrJuLZkl8kphL+eRjC
	+GJAF7lhEmduQmErej+X25C8gT2qYV4WT6CP0mjDLWoW0C9XvfkYULMD+TUvLSZ4YrGlBW4Jr4Igy
	GTf4POlgtrptw8A9V8vyc0XvoyWk7GB5qKev+Xdj22yObK2JFmAta5vIeKq1CyaveUK3dZ0fZtDfl
	YnIfxg7zbI4xSpllrg71FOteik7GXwYMgKYHIJNwOwQkK4y1ynNiLiDbTxVzssovAJg922qMkq1uq
	dpBZJNiMbNvW/SaeYn4nU7NOFZJQXctLK0lrTwA1+Qg/CPJm11KdsfVgtG7vnZTY4zZs+kUvoufyo
	PjHairBg==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRcL-00000002VBI-49o7
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 20:00:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 72159A51A42;
	Wed, 11 Jun 2025 20:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA0C4CEE3;
	Wed, 11 Jun 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672007;
	bh=ooKf35t5Mm4QWKAgMc0QQBD+koQKDB4/2gFAGm9zMdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck+I2qQ7CfveRuzjoUygtQAbhUev9wTDtalXJBJYaeFI1NWp1p3T8m9Lo+XSW51sx
	 nL6rQT3JKRp/VjpxsW4Xovk+m+1lCN9eF3RB5dcERSzYSKyruti4+i7HTNjMEE5DWv
	 EtkciBllqF5lL3Q/T69Iy0fa2e1V9BYWz4RbLaTa0nHDMDfAB4GqJiFvYJ3nSbb2/i
	 aj8ic5bG7WCNsUnVcFHoHSKqvQpXnClUPcVsLxFDnNNgUEgy9o9KlX6jnRQVzw5tAf
	 u3kuNNzbY2dCkq/R3+gpxQ3n7rWvnTWuMmwJl3WcvVXUuaRcj7UzchCXqdWuSg4fio
	 cUZ7k8GC32Y0g==
Date: Wed, 11 Jun 2025 14:00:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEngRKqXEYmikcn2@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
 <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
 <aEmxn0K6m34HsZeN@kbusch-mbp>
 <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_210016_813218_BC26CA17 
X-CRM114-Status: GOOD (  12.82  )
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

On Wed, Jun 11, 2025 at 01:41:54PM -0600, Logan Gunthorpe wrote:
> On 2025-06-11 10:41, Keith Busch wrote:
> > Is there some other mechansim that ensures a host memory mapped IOVA
> > doesn't collide with a PCI bus address then?
> 
> Yes, in the absence of a switch with ACS protection this can be a problem.
> 
> I haven't looked at this in a long time, but the iommu drivers reserve
> regions where the PCI addresses are valid so no iova will be allocated
> with a similar bus address. After a quick search, I believe today, this
> is handled by iova_reserve_pci_windows().

Excellent, I think that was the piece I was missing. Thanks!

