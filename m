Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D2CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5KZNzT4r8hymYNyVXxSZkyth4lkx71AbAsXvrU7ChYg=; b=yWv90Ph3CAfglVZ7LUt9HeWffp
	t58P3SPtDCldFrubtYyYzTM2VIFwI/oLrmJ5IhjZ5YZs9w7joBvFSl4Q8Ber5VlwnOSLTT8mLHLmV
	SGqPsP6UU5fv0rnPmCZm+SHJNycxZSiktohs8sbLTy9JDgQ+HRhrO2dQF1Pv8OXdnikIwBuSZ/r+Z
	g2VexYW69NhSTQeI1eKubk97X8Xq/UTT3/H6ZK/ONRjvGj2GG0lC6PrbYsI9jAnpL2eNHSw8H/ZD9
	24wO6ZRkRYZaDxozCITm3/iQUnspxD7v2WVnhnnG+agidPuS+LAZDJvD7RrE2SPRefY9oghS1FQbP
	85NGKjFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeiv-0000000DPuu-0ngU;
	Tue, 13 Oct 2026 15:47:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeit-0000000DPuT-46cT
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:47:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B795E40B0D;
	Tue, 13 Oct 2026 15:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513F31F000FF;
	Tue, 13 Oct 2026 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906447;
	bh=5KZNzT4r8hymYNyVXxSZkyth4lkx71AbAsXvrU7ChYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miZh4p7uObohzX7WzJhA+5wxdaxV1bOipgn4upKPIBUdPNu1HQcq2AS35CRJvrcLT
	 4GXp0SJrwh4zKbFYyMnsdOWr1wsHDJd2LkBYXcW7mBk8TMhgDFWbQ7UheE4VBqlijA
	 9Cm62rHqBdIC5vZorRUB9MwsgPrSZCpW8J9oesKjGAvL9XAa65TJODSTDQyOyhKsx/
	 qsWn7RFAgHiSpC0WHJ6RR6gigbbggwBVH3HHyD3wflagEX+fAjTLTc5rdtxqrgbt2m
	 10iU63oZXKqUNmzLIc/IjUkehHTXb5Ip0Z8SvQrTZFr+vADQ4A3zo4V6T/XvHtL6t7
	 2VEMHe7TouRyQ==
Date: Tue, 13 Oct 2026 09:47:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone
 management receive
Message-ID: <as5SjbytODSvl-DQ@kbusch-mbp>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
 <20261012141239.156408-3-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012141239.156408-3-parri.andrea@gmail.com>
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

On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> A Zone Management Receive report returns the full buffer the host asked
> for, but nvmet_bdev_zone_zmgmt_recv_work() writes only the 8-byte
> Number of Zones field and one 64-byte descriptor for each matching zone
> that fits. The 56 reserved header bytes and every descriptor slot past
> the last match keep whatever the buffer held before. A 4096-byte report
> covering a single zone leaves 4024 bytes unwritten.
> 
> The tcp, rdma and fc transports allocate that buffer with sgl_alloc()
> and pci-epf with kmalloc(), none with __GFP_ZERO, and on success each
> sends the whole buffer to the host (nvmet_setup_c2h_data_pdu() for
> tcp), so the host receives old kernel memory from the target.

Thanks, applied to nvme-7.4.

This one looks good on its own independent of the patch series, so I've
applied this one now and will wait for the comments on the remaining
patches to settle before considering the rest.

