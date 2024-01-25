Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1306DC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzReysmAP/ALM/HdRrBuSLd0v1MY+TBbV5lrLIEUHVI=; b=MeGEftklT9r9CUyDCquvJ7OydK
	x4nDzTXS5ln4j8mMTftByHICasBSKe0bPv6qeYUUn0UVsWgzTAAS0Svp/gSDR4TflZ0iZRDRlljcc
	+g9rSrMqBDD7R3YJy1AmK9o+HKcbOqGhI0Iu1/Iu76L5gDKKC9wuoWm8Fa2EZWJbe3I3zkzI1a24B
	8aYn05UH66AuBOXgBo0HiDdTnFbkvjDuA0ATxsItZu4qhE8dvO6pGQw+hYRd89GqNhDiooK1l7s2q
	O0UcwFzKkiHpQCS+lhaFHymQL2UNRLOQ1DkfupSkeGN8DM7mLrXZBnItt4TunCZiYRC4QIoc3iIhI
	TgQZJv0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1xq-00000000gJj-0HLo;
	Thu, 25 Jan 2024 15:48:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1xm-00000000gIB-2aOq
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 15:48:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3CCBB67373; Thu, 25 Jan 2024 16:48:14 +0100 (CET)
Date: Thu, 25 Jan 2024 16:48:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: hare@kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Message-ID: <20240125154814.GA23800@lst.de>
References: <20240125130906.94874-1-hare@kernel.org> <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_074822_842462_FC826400 
X-CRM114-Status: GOOD (  18.70  )
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

On Thu, Jan 25, 2024 at 08:42:10AM -0700, Jens Axboe wrote:
> On 1/25/24 6:09 AM, hare@kernel.org wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Authentication commands are normal NVMe commands, and as such
> > can return a status where NVME_SC_DNR is not set, indicating
> > that the command should be retried.
> > Rather than checking NVME_SC_DNR manually for each command completion
> > this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
> > the REQ_FAILFAST_DRIVER option to be cleared and the command to
> > be retried via the normal mechanism.
> 
> Can we please do this without adding Yet Another parameter to that
> function?

Heh, I wrote about the same reply a few minutes ago.  I'll try to think
what we can do instead.

