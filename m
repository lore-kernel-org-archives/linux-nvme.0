Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3ADC531FF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FaGtWlbr9YeeSgYmwqonNqbXzBnlArSQFqbwbu5P558=; b=Ec4EN9kTHY1wxIk6oH3hpQGe9J
	Xb0Tw7D862ITByeDmCEreh0DXoYOKWUq5LTzIPNz8kCgrRJLxw3OlO4K7wSYeH9h2bijjp8mysn/T
	bMnJ8s2Hae/L4AzacW6/PGfpnJgKcYgE+EvB+vV153P1y5aqg6mdP9n4glm+wHgxUAjQfojx0/i2I
	owsLGDnt7moCip+ubo3Wad0fr3ECZBGPp9Muwa8Hx6wZOCjb1dKJqvLc1q9eqMQFK7cZE7B7EAZry
	jsP5MY87SpEDOhnbfU6V8IhaNYeXqkWCvXi1jqlzuUEJpwWhVptdSX2T17lg95yZvcj0N6KP89Sql
	tXQvvjgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn82x-0000000FU9S-2R6A;
	Fri, 24 Jul 2026 05:02:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn82u-0000000FU8w-0HNy
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 05:02:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20DF068BEB; Fri, 24 Jul 2026 07:01:53 +0200 (CEST)
Date: Fri, 24 Jul 2026 07:01:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Message-ID: <20260724050152.GA3680@lst.de>
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721114553.1657841-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_220204_281594_6A3791CC 
X-CRM114-Status: GOOD (  12.30  )
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

On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
> Setting as an RFC as adding this extra bio field is not acceptable, but I
> can't see how to lookup the original partition.

In general it is not, but you should mark this a block patch so that
Jens can better cream at you :)

I'm also not sure that supporting per-partition diskstats on a multipath
device makes too much sense, but then again there's a lot of setups
that are crazy and actually used..


