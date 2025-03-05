Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CBC19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7TU3bjLM7Kk9wjHsOCNvuPzJqYTbP5q9iK8ewQzVcQ=; b=cPrUAdYyHo4iy/rgb/RDh72eqQ
	sELv/hfcTfcEAX35pa2wc9VpbGkkXmnCHm8dOTt94IfmXEpZp/39Rjby98XvQtDefrTZRdvVFdnhz
	1LnUUBw7ASEKuVP4JiYOCzFz4tbOWHOGgXMj/tLPiMCTdVFFib3u/CAeVeBnpHk0jSFwBZNmwCJRx
	0A+c8vc+PopMzmVb//+wIl7Q0HKOwJEsZG0uj4bz1kYGFf+nuJDF9db2gheHQsKcCCofLwpfV1YHr
	G26tNmUbVbFSWpLdUTXzz7QMSZmdmFrnfVctRqy+FNbf9FhWqky+oJCnfoWHmhBQqunZGqITzaZdK
	FEa6PJ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tptEd-00000008tNO-1Cdu;
	Wed, 05 Mar 2025 18:12:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tptDM-00000008tCX-08L2
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Mar 2025 18:11:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F7TU3bjLM7Kk9wjHsOCNvuPzJqYTbP5q9iK8ewQzVcQ=; b=IgSfPWUcfV/nOKNGVnqs2/fVCy
	s7dYvyuf7GrdM2LlrzACrgBe5KNPB0fXPHNxfHP0C+aKXPzRgZrSLvZGb7ueo/dfMa1fmPivOHie2
	BRv5fC4REUKx0FFNE8GSVKE4gp9p/YMJQ6eO0QvaDhWredhqa7ZdDFjWmq+8EY+XmFsLg1VOfHtmC
	sZMRS6Dt1ySdNKExAzX/DaNZupo6eUwej0n5v41ErZfsi5D9Y8BaBRT5H2P8rlqzf4jRnMnLgtush
	fws/3jWYDIvOSn10BXc5Gbrc5fsaw8TYiI51R1FV1Y5ulwZoho820CotEXb0nQ3ClR62JhBoWsDMr
	UUZLX4eg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tptDI-00000005zFf-1Ztk;
	Wed, 05 Mar 2025 18:11:24 +0000
Date: Wed, 5 Mar 2025 18:11:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Networking people smell funny and make poor life choices
Message-ID: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
References: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
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

On Wed, Mar 05, 2025 at 12:43:02PM +0100, Hannes Reinecke wrote:
> Oh, sure. But what annoys me: why do we have to care?
> 
> When doing I/O _all_ data is stuffed into bvecs via
> bio_add_page(), and after that information about the
> origin is lost; any iteration on the bio will be a bvec
> iteration.
> Previously we could just do a bvec iteration, get a reference
> for each page, and start processing.
> Now suddenly the caller has to check if it's a slab page and don't
> get a reference for that. Not only that, he also has to remember
> to _not_ drop the reference when he's done.
> And, of course, tracing get_page() and the corresponding put_page()
> calls through all the layers.

Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
PAGES.  That will speed up networking (eliminates two atomic operations per
page).  And of course, it will eliminate this hack in the MM.  I think
we do need to put this hack into the MM for now, but it needs to go away
again as quickly as possible.

What worries me is that nobody in networking has replied to this thread
yet.  Do they not care?  Let's see if a subject line change will help
with that.

