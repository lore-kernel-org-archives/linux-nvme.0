Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82220C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RkPWSrbUhue/IGuXAsyfEqPciSlbxQ314sYBlz/Oexs=; b=GfCwJymDixG0iVF3J1Ubj4MkL3
	E7j4rE3qBiM75T/XnCdk8cuAfwEpXU+MxblWQLjE4aWtSAVdtgOjeNrfM4ulrKIYjDgeSt+NHAV+C
	iyNVl4nuVCuRn9PvtQjd4BsFyVs9osCR0Z3Xjrilt9qc3kOR8fv0xaDyDf/4RgKcVlYkq3RG1ifvX
	XvFqiDfyCLObNdThO9DIOpsVGyIGoKzCQ4MZxXP+Wi9Dpv7z0yQ/swUiyOkLDUDBunDYEbBjJxkQW
	cICNXqH5oZe7VqoYM+9RXcCtcnfNnjdunRIHAR7xQq036Vlf2v4NoPMcJI2XGDeYgvIelo4ucfJz5
	AbPUwcuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFIgX-00GJ5P-Uw; Wed, 02 Feb 2022 16:40:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFIgU-00GJ4e-O6
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 16:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643820041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkPWSrbUhue/IGuXAsyfEqPciSlbxQ314sYBlz/Oexs=;
 b=ShcBOlXtDC9c5WWO3PTJdgJ21DnoU/xtL0oFglF6gy3hzWyHqb6pVlgB+JYSBodvjDtdj1
 2hTn86iz2onBGChqbtqCGfuYvKUu/nQQRlNhuaA79gzSggD2uwltDgOJ24ycy/t17+/6qH
 LAYr4apV5apmmmDS4JuFMSq7sSIKUcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-35Gc2b91Oea_SG3sjsQYzA-1; Wed, 02 Feb 2022 11:40:38 -0500
X-MC-Unique: 35Gc2b91Oea_SG3sjsQYzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1F21853022;
 Wed,  2 Feb 2022 16:40:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 914772B4C9;
 Wed,  2 Feb 2022 16:40:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 212GeW3G000735; Wed, 2 Feb 2022 11:40:32 -0500
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 212GeUkY000731; Wed, 2 Feb 2022 11:40:30 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Wed, 2 Feb 2022 11:40:30 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Keith Busch <kbusch@kernel.org>
cc: =?ISO-8859-15?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
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
In-Reply-To: <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
Message-ID: <alpine.LRH.2.02.2202021134400.31294@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202162147.GC3077632@dhcp-10-100-145-180.wdc.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_084042_889546_C7F61840 
X-CRM114-Status: GOOD (  23.53  )
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



On Wed, 2 Feb 2022, Keith Busch wrote:

> On Tue, Feb 01, 2022 at 01:32:29PM -0500, Mikulas Patocka wrote:
> > +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> > +		      struct block_device *bdev2, sector_t sector2,
> > +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
> > +{
> > +	struct page *token;
> > +	sector_t m;
> > +	int r = 0;
> > +	struct completion comp;
> > +
> > +	*copied = 0;
> > +
> > +	m = min(bdev_max_copy_sectors(bdev1), bdev_max_copy_sectors(bdev2));
> > +	if (!m)
> > +		return -EOPNOTSUPP;
> > +	m = min(m, (sector_t)round_down(UINT_MAX, PAGE_SIZE) >> 9);
> > +
> > +	if (unlikely(bdev_read_only(bdev2)))
> > +		return -EPERM;
> > +
> > +	token = alloc_page(gfp_mask);
> > +	if (unlikely(!token))
> > +		return -ENOMEM;
> > +
> > +	while (nr_sects) {
> > +		struct bio *read_bio, *write_bio;
> > +		sector_t this_step = min(nr_sects, m);
> > +
> > +		read_bio = bio_alloc(gfp_mask, 1);
> > +		if (unlikely(!read_bio)) {
> > +			r = -ENOMEM;
> > +			break;
> > +		}
> > +		bio_set_op_attrs(read_bio, REQ_OP_COPY_READ_TOKEN, REQ_NOMERGE);
> > +		bio_set_dev(read_bio, bdev1);
> > +		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> 
> You have this "token" payload as driver specific data, but there's no
> check that bdev1 and bdev2 subscribe to the same driver specific format.
> 
> I thought we discussed defining something like a "copy domain" that
> establishes which block devices can offload copy operations to/from each
> other, and that should be checked before proceeding with the copy
> operation.

There is nvme_setup_read_token that fills in the token:
	memcpy(token->subsys, "nvme", 4);
	token->ns = ns;
	token->src_sector = bio->bi_iter.bi_sector;
	token->sectors = bio->bi_iter.bi_size >> 9;

There is nvme_setup_write_token that checks these values:
	if (unlikely(memcmp(token->subsys, "nvme", 4)))
		return BLK_STS_NOTSUPP;
	if (unlikely(token->ns != ns))
		return BLK_STS_NOTSUPP;

So, if we attempt to copy data between the nvme subsystem and the scsi 
subsystem, the "subsys" check will fail. If we attempt to copy data 
between different nvme namespaces, the "ns" check will fail.

If the nvme standard gets extended with cross-namespace copies, we can 
check in nvme_setup_write_token if we can copy between the source and 
destination namespace.

Mikulas


