Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A319BC5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wrMXArZNFCALMzEhrXwHCWwussw3Va1bj4J/QoBh5F0=; b=VYWrHSiBB8OTzSiga17gH31UdG
	5jngQliqPTk9gxWYOp9T2MkInz8tnNU5bFkufNQuBCnbbIvA+Nb205wgre1zMXRay9SrSqY/hzRng
	wiEyZIUa22KenTqpav5xqkCnJkr8dZffZw6RzslMF89hDSHM5lI09a3SBTv1fcfRtZtNQEWYuL1Xs
	lAMg9r8Nr1Cfkl20oiKLoCWQpiJNsocylYMMfdxJ42z8uLpR3/34MKymgwMQO//4A5WuivN4/hny0
	7C0CWuDHH+THx+KP+Vv/k9FDhSYowDCKUwnzYuCXSC8oCVGHUqn958cqfdc9Ojv9P1QwdhvpBB28I
	uaMAD3tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiHR-0000000A5zL-2xsj;
	Wed, 19 Aug 2026 15:32:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiHQ-0000000A5zF-2WPL
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:32:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5E18F40678;
	Wed, 19 Aug 2026 15:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF861F000E9;
	Wed, 19 Aug 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153560;
	bh=wrMXArZNFCALMzEhrXwHCWwussw3Va1bj4J/QoBh5F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=chxjo6m9o85EXi2m8nni5EnDclBBLo65qxKowm6388IMJZV+jYkqkiMlV+LxEBq1m
	 dMZyFLI+/XptattdLZRRnDCy0D8TxonGbsjdN5asJjPvTZHQnEu3Ctv770LgV3FcMR
	 oWkjpWJnImWaSFVdirW4XWGwg6IFT4ufUyPZ8fhxvI+kpdhZzjff9yLNAhqzTGLgaI
	 0ES9yVaQbz/zpjuuL+0wwRUhIh5uPxXYJ7YcRgKgK0bt3UCcSyP3nBdns0ryBPCm5F
	 2KW8iL7nJY32FrNgVkAu2ayNWlrch5wxr6jZWI12k7RNrJ37CIXwb/b6j1KIa3h4re
	 tmS4Y9cH1XC5Q==
Date: Wed, 19 Aug 2026 09:32:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme-rdma: fix -EIO cleanup order in queue_rq
Message-ID: <aoXMlj33ku943CHm@kbusch-mbp>
References: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn>
 <cover.v2.1787121041.git.liuxixin@kylinos.cn>
 <66b08bdf7d4d.v2.1787121041.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b08bdf7d4d.v2.1787121041.git.liuxixin@kylinos.cn>
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

On Wed, Aug 19, 2026 at 02:30:00PM +0800, Xixin Liu wrote:
> On -EIO, the RDMA queue_rq path reports a host path error and then
> still cleans up the command and unmaps the SQE DMA. The path error
> helper completes the request, so that is double cleanup and DMA unmap
> after the request is already complete.
> 
> Unmap the SQE first, then report the host path error. Skip the outer
> command cleanup on that path.

Thanks, applied to nvme-7.3.

