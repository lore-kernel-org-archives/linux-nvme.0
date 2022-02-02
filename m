Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjU/ea+exDuNeTBt2TIYh51vgHgp7FulRQyhkjkBnWE=; b=aX4QZN6HANqHfeDuCj1hLYvpTG
	eF4nZe72A1uN0LKRVhQPgTXuWYZaWbhZBavuuMhZWO6V6CUYrlWV8BkBrVjdqOtfaEpQM6jiIyvg6
	HJMW2nkihz52PtO1nddAX7A7H9d1DVT/UpDTDM95HmT+RxPMTmvGGALUvAJqXiWF1oOk3Q1IbU+Ok
	s7kQn3K0LvETNfsT+/bwykqU+xgsezjEdNE5rEZ4tYgR83/TEGMeF4RjuFND78tPmwWnN9lWIjemY
	hnVIDFBYsGkb7pt34+uS6hDNGmmhpDbg3iHUAr6+unGIcc2DYp7WM4BLNv2xbpk83Lm3ZXZLOUQNI
	ziS0GX/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFIOQ-00GFl6-7p; Wed, 02 Feb 2022 16:22:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFIOM-00GFha-KR
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 16:22:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AD39EB83061;
 Wed,  2 Feb 2022 16:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA674C340EB;
 Wed,  2 Feb 2022 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643818912;
 bh=aprhBNqV/yFavedqX4mLmND+1zJ0/xnjL0T01FTR7FQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HT12BqX8WuaY6JoH1taO7b/LCdLfxiSE+hPWLRvgT/CX2DLVBW/uckAJw1dLj6jRf
 U3wsftOUOQU8wUoWQuUURO7I+tUF+Wl9eQgipUfNZD3e9/O8UlAN8waqMJWbZvCKDi
 XUqaD852mzgPMfvB9JL0NoBjz9OL2l+7+6nYrmsjMZemEiqFfQuFLJ7etadp38euIP
 ZFURUM805EuRpRYW/9L24emVSXNycbI7wgV6NMzNJ/8E1nk0dNQpX1fArUV9ym5LiY
 ajri4+R/B6gU7JPFg9AaC0z6e0Gg2Vgv17QrxiKRJXJJ19pEWvj+WumReSroCP9kr/
 HMIXOam+C3+sg==
Date: Wed, 2 Feb 2022 08:21:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Message-ID: <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_082158_963913_26367CB8 
X-CRM114-Status: GOOD (  14.74  )
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

On Tue, Feb 01, 2022 at 01:32:29PM -0500, Mikulas Patocka wrote:
> +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +		      struct block_device *bdev2, sector_t sector2,
> +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
> +{
> +	struct page *token;
> +	sector_t m;
> +	int r = 0;
> +	struct completion comp;
> +
> +	*copied = 0;
> +
> +	m = min(bdev_max_copy_sectors(bdev1), bdev_max_copy_sectors(bdev2));
> +	if (!m)
> +		return -EOPNOTSUPP;
> +	m = min(m, (sector_t)round_down(UINT_MAX, PAGE_SIZE) >> 9);
> +
> +	if (unlikely(bdev_read_only(bdev2)))
> +		return -EPERM;
> +
> +	token = alloc_page(gfp_mask);
> +	if (unlikely(!token))
> +		return -ENOMEM;
> +
> +	while (nr_sects) {
> +		struct bio *read_bio, *write_bio;
> +		sector_t this_step = min(nr_sects, m);
> +
> +		read_bio = bio_alloc(gfp_mask, 1);
> +		if (unlikely(!read_bio)) {
> +			r = -ENOMEM;
> +			break;
> +		}
> +		bio_set_op_attrs(read_bio, REQ_OP_COPY_READ_TOKEN, REQ_NOMERGE);
> +		bio_set_dev(read_bio, bdev1);
> +		__bio_add_page(read_bio, token, PAGE_SIZE, 0);

You have this "token" payload as driver specific data, but there's no
check that bdev1 and bdev2 subscribe to the same driver specific format.

I thought we discussed defining something like a "copy domain" that
establishes which block devices can offload copy operations to/from each
other, and that should be checked before proceeding with the copy
operation.

