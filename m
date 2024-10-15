Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E228CFC267
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=un+aSqQVKpOMlaOrENWlNAFqtb1lRw0+iFSN1RNwMng=; b=mnW+pPJSOGTZbHbmzMNbA0tLIX
	E1ORPuwNZLlKdHltMnRJVuZd4A4YxTPu+9vzmFqpHkvokClw+R2xqUI7P2mJLXqMmyCUP0JfZG/M1
	iqE3JdRnQ2avywWfAXHRObb7m1coSHeJgnkDL282wHIjQRS0Q7Bs7z6yrjR7/tPkGc3jEP1G8niV1
	zpKUo121gBF/rB1L5Fi+pxInbpJPopNBczgDU7IgG+RWYDj6ugmDbRpVklr/7THyY62N7N1CclsdC
	vzHi4fm/oLBo1K+IspdfNwCpYyUGRe/gONA8VsxBahSGQ+VdPvvvN7wkM4r6Jfb2WaCkFcpDFFtPQ
	byrA6DVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0aRh-000000078UK-3bzi;
	Tue, 15 Oct 2024 05:50:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0aRe-000000078Tm-3jtO
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 05:50:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00F65227AA8; Tue, 15 Oct 2024 07:50:06 +0200 (CEST)
Date: Tue, 15 Oct 2024 07:50:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, hare@suse.de,
	sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241015055006.GA18759@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930181305.17286-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_225011_099778_8EE9EFF4 
X-CRM114-Status: GOOD (  18.75  )
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

As the current discussion is probably too tiring for anyone who is not a
professional mud fighter I'll summarize my objections and comments here
once again in a way that even aspiring middle managers should be able
understand.

1) While the current per-file temperature hints interface is not perfect
it is okay and make sense to reuse until we need something more fancy.
We make good use of it in f2fs and the upcoming zoned xfs code to help
with data placement and have numbers to show that it helps.

2) A per-I/O interface to set these temperature hint conflicts badly
with how placement works in file systems.  If we have an urgent need
for it on the block device it needs to be opt-in by the file operations
so it can be enabled on block device, but not on file systems by
default.  This way you can implement it for block device, but not
provide it on file systems by default.  If a given file system finds
a way to implement it it can still opt into implementing it of course.

3) Mapping from temperature hints to separate write streams needs to
happen above the block layer, because file systems need to be in
control of it to do intelligent placement.  That means if you want to
map from temperature hints to stream separation it needs to be
implemented at the file operation layer, not in the device driver.
The mapping implemented in this series is probably only useful for
block devices.  Maybe if dumb file systems want to adopt it, it could
be split into library code for reuse, but as usual that's probably
best done only when actually needed.

4) To support this the block layer, that is bios and requests need
to support a notion of stream separation.   Kanchan's previous series
had most of the bits for that, it just needs to be iterated on.

All of this could have probably be easily done in the time spent on
this discussion.

