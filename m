Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA383D374BF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IccEZabjyRNlI5FiEtCSpyW4+sFREmpL88nE5lWit1I=; b=q6MFbkw7UOTkkOMd71Wd9ULHY5
	q4yDzvrAylo/Frp9S5XZs2Ubc4G9GD30y6qe+XChsTHI0P5ZXScMh9RKjkTz893t/7GS++MUdBEWb
	28QIQmaeQ7GuyzrYYsS4YUl6QaWojYiYl52zH9br+qiUVVHK45DV0s1aY1ShSDtHJU1aDW+MweiA7
	rQSt0KRJbC+j/iGVJDaq8yN7pwe2ddvkoIjEcooyoErvo4ndWTyEAJ8tGuBACg3h01VqrmEslQ4KZ
	n29y8dbFgWVJZ7CI+T461O4xjy4YGth2/zPl+qB05szQxzfogSI4+/Xb5FrQUf1BkpMe7elxROYcr
	ye3QGlAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TIC-0000000FTc6-3xuG;
	Thu, 17 Oct 2024 16:24:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1TIA-0000000FTbb-0PCP
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:24:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 35DE0A441A3;
	Thu, 17 Oct 2024 16:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FFDC4CEC3;
	Thu, 17 Oct 2024 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182240;
	bh=RjDlQZTkGZvAnkqNZFuzz/RFQ82YGlXnuCXfg/gs4cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftAo7CuQ4OQIWh1hU+NgHZhkzh+0FAswQMwWcVSNJE5zXBFdNGB/VIxsIA5pKB6AN
	 3Lr5M3uyOFeSB94cgkq6M9LT1C5UHhWW6q9Ql2JFCTzbFh10bxOZ4QLOH+ksP8X+sP
	 IIACWncBrUJWvzd441ZuKK5p1lQnopNeOSQJY8qIi6fx93iX5krdO4l8zFlkCZtnyW
	 0caoodB3qWS8twWihXtERAgMcc7lf1RLnQiojXa/hTdItF+nl4bueHKCZNbToGO21w
	 KX/BZYgnQKi/ZZOsCab8EBgQvs9sY2UrJLdRweybpbeYff/5bCLRzyx2w0fN48nvQk
	 eX+gqJQfy14zA==
Date: Thu, 17 Oct 2024 10:23:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZxE6HWwKPXJPtShT@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com>
 <20241015055006.GA18759@lst.de>
 <8be869a7-c858-459a-a34b-063bc81ce358@samsung.com>
 <20241017152336.GA25327@lst.de>
 <ZxEw5-l6DtlXCQRO@kbusch-mbp.dhcp.thefacebook.com>
 <37af5088-6f09-4e75-b5d0-559e92d625bb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37af5088-6f09-4e75-b5d0-559e92d625bb@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_092402_223305_7673223F 
X-CRM114-Status: GOOD (  24.14  )
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

On Thu, Oct 17, 2024 at 09:15:21AM -0700, Bart Van Assche wrote:
> On 10/17/24 8:44 AM, Keith Busch wrote:
> > On Thu, Oct 17, 2024 at 05:23:37PM +0200, Christoph Hellwig wrote:
> > > If you want to do useful stream separation you need to write data
> > > sequentially into the stream.  Now with streams or FDP that does not
> > > actually imply sequentially in LBA space, but if you want the file
> > > system to not actually deal with fragmentation from hell, and be
> > > easily track what is grouped together you really want it sequentially
> > > in the LBA space as well.  In other words, any kind of write placement
> > > needs to be intimately tied to the file system block allocator.
> > 
> > I'm replying just to make sure I understand what you're saying:
> > 
> > If we send per IO hints on a file, we could have interleaved hot and
> > cold pages at various offsets of that file, so the filesystem needs an
> > efficient way to allocate extents and track these so that it doesn't
> > interleave these in LBA space. I think that makes sense.
> > 
> > We can add a fop_flags and block/fops.c can be the first one to turn it
> > on since that LBA access is entirely user driven.
> 
> Does anyone care about buffered I/O to block devices? When using
> buffered I/O, the write_hint information from the inode is used and the per
> I/O write_hint information is ignored.

I'm pretty sure there are applications that use buffered IO on raw block
(ex: postgresql), but it's a moot point: the block file_operations that
provide the fops_flags also provide the callbacks for O_DIRECT, which is
where this matters.

We can't really use per-io write_hints on buffered-io. At least not yet,
and maybe never. I'm not sure if it makes sense for raw block because
the page writes won't necessarily match writes to storage.

