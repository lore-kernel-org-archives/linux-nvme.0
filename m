Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720CAC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4xX18i9cZ41ZaKga0dRrI4tcTj8BTHIF2WZ/8NB4AUE=; b=k0c9VKRVfEAF5rkF+76jpUbNCr
	wCg1jZ2bqTk67tT9/sNoNIMXYWL9Zets3jnOzDGvhOJq1YFYacWPBfhBY1wmoCBEZL0tL4lpGV9FI
	GA007g56RU7skVwBoTKBXNQvX6Y1rrXYWtfsi64NSEhdHbJJHH2u6yeA/nZ30ll+2G1ac2VntGK1T
	oFaGitgIpjpQTC/l5W0cINRO1V/Bu7iR8sgqtXcltc6oqpS+jRWFCEgphNH7DUMYlUCzCSxvVteg+
	q9egtav/e+VebCDDQfCANV84JI+DeG9vD7qPyHhQ6Qdy+z4XTufUrsEo39VtHPz5IZ5FJzygrJxvK
	WZYYK/3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi5s-000000018T0-32d2;
	Thu, 09 Jul 2026 06:18:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi5p-000000018SQ-25E2
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:18:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A266168BFE; Thu,  9 Jul 2026 08:18:37 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:18:37 +0200
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
Subject: Re: [RFC PATCH v1 15/17] blk-cgroup: remove blkg radix tree
 preloading
Message-ID: <20260709061837.GF16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-16-yukuai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-16-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_231841_683259_42EBB164 
X-CRM114-Status: GOOD (  12.92  )
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

On Sun, Jul 05, 2026 at 03:51:22AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> blkg creation is now serialized by q->blkcg_mutex and no longer runs
> under q->queue_lock.  The radix tree is initialized with GFP_NOWAIT, so
> radix_tree_insert() cannot sleep while blkcg->lock is held and the old
> preload dance is no longer needed.
> 
> Remove the preload calls and the associated unwind path.

Isn't the GFP_NOWAIT a bit of a problem because it can fail way too
easy?

What about converting both the radix tree and list to an xarray
using the internal xarray to deal with sleeping allocations?


