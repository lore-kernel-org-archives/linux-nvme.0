Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C538C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXkIY3wk7h71lKOG+iKPfCtgskVq40Hz3IMYfFS6bQE=; b=y88llkvrrkYzZZDZz5uzuIop2+
	5rPObfWFSXCLmPBZBgpFz+QxQm7u5D3yrrVG8ReQekuiiCgg7ZA89jZ7ah6kK7QM4LzOzzc3sHKyl
	CbycsW2lUrD311JPuRG+yzACmv4zCZXYfOWdgoK0/GrHtSSjJ8rhyzUjKNHmiWOHeA+p+iAwyxXnZ
	9hJP2Mc3CtcJWEutYhIRDGQC1pu/RDqaaWFvbb7NsudtbsrzLruUagvU4peBKHTx7xrbEZOr88as/
	GMEZ0ZCYdwJ21AAciz2QT8lkdptiWvHde4x2n+Nt89Ez3mVC4iRh/Jv/ef08sj28K8r4a7DFgeCix
	LXhuLUjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCKj-00Fbe3-2k;
	Tue, 23 Jan 2024 08:40:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCKh-00FbdC-0n
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:40:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 716F968BEB; Tue, 23 Jan 2024 09:40:29 +0100 (CET)
Date: Tue, 23 Jan 2024 09:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 02/15] block: refactor disk_update_readahead
Message-ID: <20240123084029.GA29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-3-hch@lst.de> <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_004035_427933_87BB742D 
X-CRM114-Status: GOOD (  14.53  )
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

On Tue, Jan 23, 2024 at 01:41:05PM +0900, Damien Le Moal wrote:
> > +{
> > +	/*
> > +	 * For read-ahead of large files to be effective, we need to read ahead
> > +	 * at least twice the optimal I/O size.
> > +	 */
> > +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> 
> Nit: while at it, you could replace that division by PAGE_SIZE with a right
> shift by PAGE_SHIFT.

I don't really see the point, this is everything but a fast path,
and for simple constant divisions compilers aren't actually bad at
doing optimizations.


