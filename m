Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA50DC83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gY+yGRa61TK2BR8Nw1XPStAseZID7tr6EzNodmZtwGI=; b=BJTg0FKkyufy+VCFbTLIVHOgyf
	++MlBUfIReRrqyLZQdnFpZTvofIRDBq6jLeEdBKQxFlYMHoGdRWL8tUB9qKy16Rq/TrRg1G5MkVvR
	wVVOH8VlkSa90/PEyQ1VcyndzhRvFkHxBRSS3E0yS3tigIFCtmVTlgg21iaXn6KpF7kjssyjFfMXD
	JPWTAMiyN5vHF8jTCMwiRNcCbqalHFo0aM9tmbS0mnadGHZvvEojIq6GmKxNMrwU7X1m8ArU5CCTT
	8wzU3dSQa8ELXmDjnjGzWbuasNhofu1tIIs8o/BQQh4+nAXVzzu8RgG461wqVZ51qoqq/M9yB49QL
	yN2t0tNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb0HQ-00Bkeg-12;
	Tue, 29 Aug 2023 15:05:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qafiM-009xvk-37;
	Mon, 28 Aug 2023 17:07:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 873FB1F37E;
	Mon, 28 Aug 2023 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1693242465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY+yGRa61TK2BR8Nw1XPStAseZID7tr6EzNodmZtwGI=;
	b=qVtknFwaytxobpauxbbKFuuIVi6tPH4Iq6U6De70imbcWuGOxhftHNb/4FbPSlc5GK5oK7
	GshsV6S1hXqpxSKPutaEa7H9BjX/0wslT8a/D4qnl6I13zhL54OxmZm3biLLUgjj3B0284
	RPao+ZPH1kv8DfDq9EfFHRPOBMpXacI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1693242465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY+yGRa61TK2BR8Nw1XPStAseZID7tr6EzNodmZtwGI=;
	b=R3UkEJ5CJtN+ADS2q+nxkKoBRTSfFifpdVN9hgBj3Kx2evg21jSoeC6uq7LeWXoMGsRfiN
	pZDyCc1pRe5jtEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A42A139CC;
	Mon, 28 Aug 2023 17:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id scxcGWHU7GQMNQAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 17:07:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE101A0774; Mon, 28 Aug 2023 19:07:44 +0200 (CEST)
Date: Mon, 28 Aug 2023 19:07:44 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH v3 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20230828170744.iifdmaw732cfiauf@quack3>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230825-hubraum-gedreht-8c5c4db9330a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-hubraum-gedreht-8c5c4db9330a@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_100747_148266_1FD34488 
X-CRM114-Status: GOOD (  28.23  )
X-Mailman-Approved-At: Tue, 29 Aug 2023 08:05:16 -0700
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

On Fri 25-08-23 15:32:47, Christian Brauner wrote:
> On Wed, Aug 23, 2023 at 12:48:11PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > this is a v3 of the patch series which implements the idea of blkdev_get_by_*()
> > calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> > makes the get and put calls for bdevs more obviously matching and allows us to
> > propagate context from get to put without having to modify all the users
> > (again!). In particular I need to propagate used open flags to blkdev_put() to
> > be able count writeable opens and add support for blocking writes to mounted
> > block devices. I'll send that series separately.
> > 
> > The series is based on Christian's vfs tree as of today as there is quite
> > some overlap. Patches have passed some reasonable testing - I've tested block
> > changes, md, dm, bcache, xfs, btrfs, ext4, swap. More testing or review is
> > always welcome. Thanks! I've pushed out the full branch to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
> > 
> > to ease review / testing. Since there were not many comments for v2 and
> > Christoph has acked the series I think we should start discussing how to merge
> > the series. Most collisions with this series seem to happen in the filesystems
> > area so VFS tree would seem as the least painful way to merge this. Jens,
> 
> I really do like this series especially struct bdev_handle and moving
> the mode bits in there. I'll happily take this. So far there have only
> been minor things that can easily be fixed.

Thanks. Since Al is fine with just doing a potential conversion to 'struct
file' as a handle on top of this series (it will be dumb Coccinelle
replacement) I think we can go ahead with the series as is. As you said
there will be some conflicts in btrfs and I've learned about f2fs conflicts
as well so I can rebase & repost the series on top of rc1 to make life
easier for you.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

