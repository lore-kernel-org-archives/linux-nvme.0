Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EECC27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 04:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cDsNGcAEhhxMhyCpisZW+qgd/qaenbjHbVGmZZAPTn8=; b=E7bss9z2eBKA+hkY2VoTchJEUl
	Miu88Wy5l6FBPZTRdZTHLtJ0n3DMt4f8pie/iODouwfDiEcZ4+1eW3cry68s5Hk/V/bj8FslEtN6g
	hz7tlhQhCKArtuBem+YHiLx/wdIJSTZLtviJInWL55aWD9qPmtl7DD6OOnN4e4W7cXSAw6LsDJM57
	Xjup4MSZGvQXgmudt8THlajcN0QLadPqXEceoUVRMePevKV6QaTCvzb0vfAc1a/7IJZgy656oh8pF
	Q6f+W5mrvoVyDLWgVzhvFWkgKykQdoB9nVmRpIDkCsHhDQfXYIuDk8/zxxzw9WAXAY0JshLTqHYtH
	DyxiROOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKsHV-0000000BLdj-18kG;
	Sat, 22 Jun 2024 04:23:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKlj8-0000000AblS-1N65
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 21:23:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A838A62F68;
	Fri, 21 Jun 2024 21:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D506C2BBFC;
	Fri, 21 Jun 2024 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719005001;
	bh=N4ivVfcXJIy+QZ0gUdEeSMav33R3fT7xLRRwMgFHS5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIjoAo9dVPq/wWSw7vIa+LUCdLv/cy0F+UpK0V0o6GG4XtJGpPyWD7XS6VYSOCLbE
	 96RxruHq6fyaGWj3Fcup4m2H2zjHCiaQsk2cwLejwCGTDk1h+CDL9GsEpDBeR+358D
	 eVikhWol4HvrtRbxIVuPnG8/eXP7DgKHQJuJc+DHT3QbmE/Ug77DxemimyxG+bwVLd
	 ayCRr4u6b+0c/fvSbv7PmeG3MeTeJovAWkBSk4O562mzy8+vpo9vIy6eLQV2Tb8vex
	 6s75hABhrSF177DZx/ED7ySzT1gVAEo80N7qgJFHW46uWn0nuJwTC9rbYIeMvVkLYN
	 /Y3Eol8tZh44w==
Date: Fri, 21 Jun 2024 14:23:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ojaswin@linux.ibm.com, linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
	nilay@linux.ibm.com, ritesh.list@gmail.com, willy@infradead.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Subject: Re: [Patch v9 07/10] block: Add fops atomic write support
Message-ID: <20240621212320.GE103020@frogsfrogsfrogs>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-8-john.g.garry@oracle.com>
 <680ce641-729b-4150-b875-531a98657682@suse.de>
 <d3332752-52b1-4d24-88cf-3b5e7aa4b74a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3332752-52b1-4d24-88cf-3b5e7aa4b74a@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_142322_748225_C344B406 
X-CRM114-Status: GOOD (  26.70  )
X-Mailman-Approved-At: Fri, 21 Jun 2024 21:23:15 -0700
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

On Fri, Jun 21, 2024 at 01:02:34PM +0100, John Garry wrote:
> On 21/06/2024 07:13, Hannes Reinecke wrote:
> > On 6/20/24 14:53, John Garry wrote:
> > > Support atomic writes by submitting a single BIO with the REQ_ATOMIC set.
> > > 
> > > It must be ensured that the atomic write adheres to its rules, like
> > > naturally aligned offset, so call blkdev_dio_invalid() ->
> > > blkdev_atomic_write_valid() [with renaming blkdev_dio_unaligned() to
> > > blkdev_dio_invalid()] for this purpose. The BIO submission path currently
> > > checks for atomic writes which are too large, so no need to check here.
> > > 
> > > In blkdev_direct_IO(), if the nr_pages exceeds BIO_MAX_VECS, then we
> > > cannot
> > > produce a single BIO, so error in this case.
> > > 
> > > Finally set FMODE_CAN_ATOMIC_WRITE when the bdev can support atomic
> > > writes
> > > and the associated file flag is for O_DIRECT.
> > > 
> > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   block/fops.c | 20 +++++++++++++++++---
> > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/block/fops.c b/block/fops.c
> > > index 376265935714..be36c9fbd500 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > > @@ -34,9 +34,12 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
> > >       return opf;
> > >   }
> > > -static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> > > -                  struct iov_iter *iter)
> > > +static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
> > > +                struct iov_iter *iter, bool is_atomic)
> > >   {
> > > +    if (is_atomic && !generic_atomic_write_valid(iter, pos))
> > > +        return true;
> > > +
> > >       return pos & (bdev_logical_block_size(bdev) - 1) ||
> > >           !bdev_iter_is_aligned(bdev, iter);
> > >   }
> > > @@ -72,6 +75,8 @@ static ssize_t __blkdev_direct_IO_simple(struct
> > > kiocb *iocb,
> > >       bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
> > >       bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
> > >       bio.bi_ioprio = iocb->ki_ioprio;
> > > +    if (iocb->ki_flags & IOCB_ATOMIC)
> > > +        bio.bi_opf |= REQ_ATOMIC;
> > >       ret = bio_iov_iter_get_pages(&bio, iter);
> > >       if (unlikely(ret))
> > > @@ -343,6 +348,9 @@ static ssize_t __blkdev_direct_IO_async(struct
> > > kiocb *iocb,
> > >           task_io_account_write(bio->bi_iter.bi_size);
> > >       }
> > > +    if (iocb->ki_flags & IOCB_ATOMIC)
> > > +        bio->bi_opf |= REQ_ATOMIC;
> > > +
> > >       if (iocb->ki_flags & IOCB_NOWAIT)
> > >           bio->bi_opf |= REQ_NOWAIT;
> > > @@ -359,12 +367,13 @@ static ssize_t __blkdev_direct_IO_async(struct
> > > kiocb *iocb,
> > >   static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct
> > > iov_iter *iter)
> > >   {
> > >       struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
> > > +    bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
> > >       unsigned int nr_pages;
> > >       if (!iov_iter_count(iter))
> > >           return 0;
> > > -    if (blkdev_dio_unaligned(bdev, iocb->ki_pos, iter))
> > > +    if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
> > 
> > Why not passing in iocb->ki_flags here?
> > Or, indeed, the entire iocb?
> 
> We could (pass the iocb), but we only need to look up one thing - ki_pos. We
> already have is_atomic local. I am just trying to make things as efficient
> as possible. If you really think it's better (to pass iocb), then it can be
> changed.

I certainly do. ;)

https://lore.kernel.org/linux-xfs/20240620212401.GA3058325@frogsfrogsfrogs/

--D

> Thanks,
> John
> 
> 

