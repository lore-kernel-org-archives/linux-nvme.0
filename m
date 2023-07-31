Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05272C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 11:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=; b=HSqkwhhrGTpQBJlSGGf/qgtowI
	AUEC7gZUOCsm8dvqrEYXQpAN71EWuoQb59Jg6CrwcBvInRtFVF8587jPZDlVaopR4CJm7iSiH7Nr8
	9XqHAUy2JgejUsdFexROFb7nihekkyEp50X3YRTDEf9cLzWFtabtdcpDv2YEBU2QSQEc8WckVQ+8X
	oOZFRA0luaeWb63wVr7qLiYmEVJysPARLGAiejYLwMXEZg0EW3qxZLc81roVh8puJUAfICEJnp1Sj
	pHY2Ap8aRKYRlbC8VK8nm+5CCCVSBysyV0iPIyw+nQDRj7hGs1b/Yjv5yLJjXvU4Z2+tOku7PRT+K
	DHRq/dcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQl4-00FIaz-1I;
	Mon, 31 Jul 2023 11:08:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQU3-00F9sB-1u;
	Mon, 31 Jul 2023 10:50:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED50E22197;
	Mon, 31 Jul 2023 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1690800635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=;
	b=LfsIvVgX25rf01P6sVcmZRL3nPMT3sPJRPMrpOspwMqpMg9mmQx6AkDi/eF6WU32a2Vp6x
	/7YLD1OJK0u+bqfGa4P87gaOpA6/QZlHA1eZkenSQs1V9CjuRPICqxTQ9KdHYFZ84hOqsV
	4L46K3Rf4+bEtg2brIa/aboXrQrqviE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1690800635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJDu3H9G0xjlLFp1Wxvq9yQHkB2Q9jBIbPsGkP5jLhY=;
	b=X5g/KyOpcE2CiMGegP9N6Ypxz5sWUyAuayNnMILk5q3XabEg0BuGZ7c8jHqKycooaqKD7s
	Ajq9KEorZZBfWcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6932133F7;
	Mon, 31 Jul 2023 10:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ovhUNPqRx2R2ZgAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 10:50:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 457F5A0767; Mon, 31 Jul 2023 12:50:34 +0200 (CEST)
Date: Mon, 31 Jul 2023 12:50:34 +0200
From: Jan Kara <jack@suse.cz>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
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
	linux-xfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com,
	reiserfs-devel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Song Liu <song@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
	target-devel@vger.kernel.org, Ted Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Message-ID: <20230731105034.43skhi5ubze563c3@quack3>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
 <ZKbgAG5OoHVyUKOG@infradead.org>
 <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyiUcw+mH0sZa8f8UJsaSZ7NSE65s2gZDEia+pASyP_gJQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_035039_774002_1593871A 
X-CRM114-Status: GOOD (  21.49  )
X-Mailman-Approved-At: Mon, 31 Jul 2023 04:08:13 -0700
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

On Wed 12-07-23 18:06:35, Haris Iqbal wrote:
> On Thu, Jul 6, 2023 at 5:38 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jul 04, 2023 at 02:21:28PM +0200, Jan Kara wrote:
> > > Create struct bdev_handle that contains all parameters that need to be
> > > passed to blkdev_put() and provide blkdev_get_handle_* functions that
> > > return this structure instead of plain bdev pointer. This will
> > > eventually allow us to pass one more argument to blkdev_put() without
> > > too much hassle.
> >
> > Can we use the opportunity to come up with better names?  blkdev_get_*
> > was always a rather horrible naming convention for something that
> > ends up calling into ->open.
> >
> > What about:
> >
> > struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> >                 const struct blk_holder_ops *hops);
> > struct bdev_handle *bdev_open_by_path(dev_t dev, blk_mode_t mode,
> >                 void *holder, const struct blk_holder_ops *hops);
> > void bdev_release(struct bdev_handle *handle);
> 
> +1 to this.
> Also, if we are removing "handle" from the function, should the name
> of the structure it returns also change? Would something like bdev_ctx
> be better?

I think the bdev_handle name is fine for the struct. After all it is
equivalent of an open handle for the block device so IMHO bdev_handle
captures that better than bdev_ctx.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

