Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF31C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XRbvGMlh84tAHyKxDKvcb7k9aGadHCqpihqECVm2hWU=; b=szxp9wVw8IpwDyKD8vQV/XzFU+
	2C0yEdg3ETmkVKluzCvr9l9C7IG47ZjDRSRH0ec5iQ46rIRRwgjg9ADv5CItUugi/5tzbEnx90et6
	f7xmLdybD30yNYG1DjdnpTOzMTNMZHAPc5S1VCjCIDMUdwNKRu9BkUgWHfvT6mnK/NjAlpGQdzEO7
	XbyUpM8oN0I+HBSHaXP/QTID4s7WQ6DAqho6Wcat++1GGzadlfZ9uR2JuAjCt9eeBOToDBD9N3QgP
	PuLdoanyIcgCDmll0VRzP6eyWU0WZIMifWViJs7mshMrR3GG996R1zZP/kxz934Jd2MTFsYdlz82a
	5WSGdIaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o998K-00BoJe-8f; Wed, 06 Jul 2022 17:48:16 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mnx-001zkg-3C
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 17:57:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 86F6FB8188D;
	Tue,  5 Jul 2022 17:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DDEC341C7;
	Tue,  5 Jul 2022 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657043862;
	bh=2n0MdI/phNcEmcix0C+izbdt51lZOoB1FibJBB1glbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPWuUIYH2m+thvDdaR7J1//HnOGKOFxxB4NJp6pNe6vMzogtjLZRoFBtxO5LlMNeI
	 yWudYsaRp5DLrK6fJ3hIMQYHCgLjjZ5MxX3p6AyAqdxBjjw/h26TTzcR/Pc8ewwHf7
	 QMwbCfdPkWn2iRfmb6GBERZ1Soz212xPz3jM9A45G2MEhQieqAKfyzJ4nbOrHPEOTO
	 N/cG0O5LyrMmRlQhtqIXscvzDi/zOUEEQMIE8bYNhu2xUZunJpe+x4Vs289Np/BdU0
	 uO/tchQgfmJcBt4F7r3FfIciHf3T2qrWT6ajp55T795YNQmliXF17uGnd3wfJMeH/3
	 7Zg6dyGWPk/BA==
Date: Tue, 5 Jul 2022 10:57:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"agk@redhat.com" <agk@redhat.com>,
	"song@kernel.org" <song@kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"javier@javigon.com" <javier@javigon.com>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 1/6] block: add support for REQ_OP_VERIFY
Message-ID: <YsR7lbTfBH0dUMMg@magnolia>
References: <20220630091406.19624-1-kch@nvidia.com>
 <20220630091406.19624-2-kch@nvidia.com>
 <Yr3M0W5T/CwMtvte@magnolia>
 <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476112fe-c01e-dbaa-793d-19d3ec94c6ef@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_105745_450328_538AB4BA 
X-CRM114-Status: GOOD (  22.03  )
X-Mailman-Approved-At: Wed, 06 Jul 2022 10:48:14 -0700
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

On Tue, Jul 05, 2022 at 04:50:33PM +0000, Chaitanya Kulkarni wrote:
> Darrik,
> 
> Thanks for the reply.
> 
> >> +
> >> +/**
> >> + * __blkdev_issue_verify - generate number of verify operations
> >> + * @bdev:	blockdev to issue
> >> + * @sector:	start sector
> >> + * @nr_sects:	number of sectors to verify
> >> + * @gfp_mask:	memory allocation flags (for bio_alloc())
> >> + * @biop:	pointer to anchor bio
> >> + *
> >> + * Description:
> >> + *  Verify a block range using hardware offload.
> >> + *
> >> + * The function will emulate verify operation if no explicit hardware
> >> + * offloading for verifying is provided.
> >> + */
> >> +int __blkdev_issue_verify(struct block_device *bdev, sector_t sector,
> >> +		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
> >> +{
> >> +	unsigned int max_verify_sectors = bdev_verify_sectors(bdev);
> >> +	sector_t min_io_sect = (BIO_MAX_VECS << PAGE_SHIFT) >> 9;
> >> +	struct bio *bio = *biop;
> >> +	sector_t curr_sects;
> >> +	char *buf;
> >> +
> >> +	if (!max_verify_sectors) {
> >> +		int ret = 0;
> >> +
> >> +		buf = kzalloc(min_io_sect << 9, GFP_KERNEL);
> > 
> > k*z*alloc?  I don't think you need to zero a buffer that we're reading
> > into, right?
> > 
> > --D
> 
> we don't need to but I guess it is just a habit to make sure alloced
> buffer is zeored, should I remove it for any particular reason ?

What's the point in wasting CPU time zeroing a buffer if you're just
going to DMA into it?

--D

> -ck
> 
> 

