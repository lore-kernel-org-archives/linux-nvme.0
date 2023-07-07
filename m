Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7372EB64DC
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Jul 2023 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUfYUy8/J6JDn9FoGNDP036sYhvQ7qr7NPrif4Grdk0=; b=Rk86fYNQtW3Su2KHtHLSc7TlZG
	hmpCrKLmrXVp7eB8UxSjMAAYbu8Q3+JfCc4CNJvUVwVC48WtshWdQ22zcy5lx/cEZ2ILF88o1vV0D
	9QeY54zlrLhH+gzOJnaVOXSlY/S2/j/wcJ1m7nR+IVXLVDF6RQJmUTtv9Ix/Q78G5LHXU5VJguekB
	em9DUqv7nWmEjrhk3b6l2r/2qaYJyxZe1DNV0e38piwth0V5/E93g2VtHcJEENC5i9giooqoZNJBr
	3jIUTR/0OgVI6z5hCjCAekyfuKG1O8Noy0Pzz4suDGxYU86mzRrpFjlO1IH0Eb0bTCFMxS5PFuarV
	6KbPU0sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIXfr-009S9z-02;
	Sun, 09 Jul 2023 16:54:15 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qHjdh-004Vpz-0w;
	Fri, 07 Jul 2023 11:28:41 +0000
Date: Fri, 7 Jul 2023 04:28:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna Schumaker <anna@kernel.org>, Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, David Sterba <dsterba@suse.com>,
	dm-devel@redhat.com, drbd-dev@lists.linbit.com,
	Gao Xiang <xiang@kernel.org>, Jack Wang <jinpu.wang@ionos.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Joern Engel <joern@lazybastard.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Mike Snitzer <snitzer@kernel.org>, Minchan Kim <minchan@kernel.org>,
	ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Song Liu <song@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
	target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Message-ID: <ZKf26fYMDHnTCb29@infradead.org>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
 <20230706161433.lj4apushiwguzvdd@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706161433.lj4apushiwguzvdd@quack3>
X-Mailman-Approved-At: Sun, 09 Jul 2023 09:54:10 -0700
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

On Thu, Jul 06, 2023 at 06:14:33PM +0200, Jan Kara wrote:
> > struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
> > 		void *holder, const struct blk_holder_ops *hops);
> > void bdev_release(struct bdev_handle *handle);
> 
> I'd maybe use bdev_close() instead of bdev_release() but otherwise I like
> the new naming.

We're using release everywhese else, but if Jens is fine with that I
can live with close.

