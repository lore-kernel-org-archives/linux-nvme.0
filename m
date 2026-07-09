Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82286C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTpfQ49290vcsQPpkc1KAhPjJUa7iUBgEKlYPPzNJXU=; b=4GMUG+4+GCXuvZjPOOs1gj6pEU
	KTJg0TKQhhPa3FJI8/f1uurjfgnEqzUG0EdmMxErQAc5pziO61zLfGYhNG5Z00kglcB6IWpoOBRZS
	C9+IhZHUFFI7Ee9sDtoz6l2N+JriGRSKr+N3A0GVP3tRnI4sQKLqiJzZd0rsOHjEJHurXPyctCN0O
	7HUEN3pitHywEN27hR2E0uSe92zWOPMXWJIo958wa5Y0MYNAq8InJrY6er4oISIsDuY0uzfQDuQAu
	R7b7nf5+wGAfLlq8SKTBqTPiW2zDbbWATpfbQnRWI9+O8CWrZXMwQkOQNW2qBVpBrBap3jsguhVEZ
	PNqCn4Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhxY-0000000179n-3CQO;
	Thu, 09 Jul 2026 06:10:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhxU-00000001797-1tlB
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:10:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07E5D68BFE; Thu,  9 Jul 2026 08:10:00 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:09:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex
Message-ID: <20260709060959.GA16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_231004_640648_2EBFBEDB 
X-CRM114-Status: GOOD (  14.69  )
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

On Sun, Jul 05, 2026 at 03:51:07AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> This RFC moves queue-local blkg topology synchronization from
> q->queue_lock to q->blkcg_mutex.
> 
> q->queue_lock is a hot block-layer spinlock used by request queue runtime
> paths,

I don't think it is hot any more.  If it is in one of your workloads
we have a deep problem somewhere.  That being said, futher removing
uses of his old catch-all lock is always good, hopefully we can
eventually remove it entirely.

So this series looks great to me conceptually, but I'm unfortunately
not a very qualified reviewer for the blk-cgroup code.


