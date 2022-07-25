Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F1BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGeqYXMwhCrQYlfyOUIp3sKlUUcQe00i5OqId0wRjO8=; b=HoC2rdgYGwLv8zZ81KcLywencP
	1BzvFgP2CYEeyguizPLuliBqM4FwZwdkEAUOqRYH434fEYwWjpMSgOTOWifNUM03AKVCd2VQk3Nyf
	8pi7UH8laKcjdCIrsjzVcPBU2Gl2N2nfVMzqeMF60GzRZl0JYhOqb1ErSKGCv6tlCnnjfpHVMxOha
	NIVL2G3htepoDoQrqDoWcR6VrOUZfeWwyXiADGUQlu0r+bA9flhNjNFX0KvlMIzAkQpHjhTmznivw
	9RYtSaMo2uR48jw9IqighPdWjLAhk9zBnnHI2WWuR5ZtzvhPRYSvK70F9eLJucXo0iW92ZmzDR281
	mH+ZZxoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFzMP-00CrXY-95; Mon, 25 Jul 2022 14:47:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFzML-00Cqhy-T6
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 14:47:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBCD61215;
	Mon, 25 Jul 2022 14:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A5DC341C6;
	Mon, 25 Jul 2022 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658760418;
	bh=PZKVLgIIqdh9g4wPfJ5NHR7BP7/xQGyMshytByH1RJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmS4DNDrLhJ9CA/GNgiKyZDaLdV2ZqESyyBrwX5Anr3zbwmlC1Amcvm+cxJKZtQFf
	 A5qRBVTOO0svm8DcPHWQREspfRrbKbEnZaPgemr6LNsWMT+YMiL6DO/VXbgLE7Siq1
	 jB1WtmFqomimhIRA2JXinRRzjMeQg4LHCNjMDGFty2LHhtLN+XrYTQULac6rfd1HnR
	 wqs8aa3KpPYNMU/iS8RU7gujJmvwcZei2+8mgr4biHSxlEDfK/fEJMBQrg4Ov6WQMn
	 Xd6uKDKNKxDjF4h0wpfyPRjUbewJEUxWHeQ+ESR7RovV5uy1MEdFVZMXmtuwup6PpK
	 gelQyAxIBu9xQ==
Date: Mon, 25 Jul 2022 08:46:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv6 07/11] block/bounce: count bytes instead of sectors
Message-ID: <Yt6s3uh5UijlYACV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-8-kbusch@fb.com>
 <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1cceb79-c72c-5a76-ed7a-156c09505692@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_074702_014766_59EBD684 
X-CRM114-Status: GOOD (  22.43  )
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

On Fri, Jul 22, 2022 at 03:01:06PM -0700, Bart Van Assche wrote:
> On 6/10/22 12:58, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Individual bv_len's may not be a sector size.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >   block/bounce.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/bounce.c b/block/bounce.c
> > index 8f7b6fe3b4db..fbadf179601f 100644
> > --- a/block/bounce.c
> > +++ b/block/bounce.c
> > @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
> >   	int rw = bio_data_dir(*bio_orig);
> >   	struct bio_vec *to, from;
> >   	struct bvec_iter iter;
> > -	unsigned i = 0;
> > +	unsigned i = 0, bytes = 0;
> >   	bool bounce = false;
> > -	int sectors = 0;
> > +	int sectors;
> >   	bio_for_each_segment(from, *bio_orig, iter) {
> >   		if (i++ < BIO_MAX_VECS)
> > -			sectors += from.bv_len >> 9;
> > +			bytes += from.bv_len;
> >   		if (PageHighMem(from.bv_page))
> >   			bounce = true;
> >   	}
> >   	if (!bounce)
> >   		return;
> > +	/*
> > +	 * Individual bvecs might not be logical block aligned. Round down
> > +	 * the split size so that each bio is properly block size aligned,
> > +	 * even if we do not use the full hardware limits.
> > +	 */
> > +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
> > +			SECTOR_SHIFT;
> >   	if (sectors < bio_sectors(*bio_orig)) {
> >   		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
> >   		bio_chain(bio, *bio_orig);
> 
> Do I see correctly that there are two changes in this patch: counting bytes
> instead of sectors and also splitting at logical block boundaries instead of
> a 512-byte boundary? Should this patch perhaps be split?

The code previously would only split on a bvec boundary. All bvecs were logical
block sized, so that part is not changing. We just needed to be able to split
mid-bvec since the series enables unaligned offsets to match hardware
capabilities.

