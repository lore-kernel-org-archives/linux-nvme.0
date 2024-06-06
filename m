Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40228C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 04:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2JtbAgd30+0IvM+q/D4vhSA5mhyMjGpdLe9+kGDIkfQ=; b=yhOXRxmu0tcGfOQV2fEejKMTem
	R+ufXqTGwy10CfrkK1EDYn8tP84iw5ltUMq7w6HFl/dwMU+JPY22v0MMlhYMEP0JxoE3bz4YBxIVH
	MRI/LibxHyr7EyjNXTYi570ZLxbHwle8fUXNrvdMHTry+KXr3P0fseyVXfOPWKM6YWGHoZn9Taq8u
	PWUHavkbEem15Zs5HIUZ3VUfVTsytbxWOGhU7M6hXHJUHs6ZhDrI+5yqiAYg9oqZQron5wSVyJjWH
	bgDA9kit/S4RVkKRQYtdenm6dSh62z7/Ev9Ios9dGM1+tS9/beI02WXey2X4FzAigUWBn8zrJMH84
	Un7HC46w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF53r-00000008Lij-2DzT;
	Thu, 06 Jun 2024 04:49:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF53o-00000008LiG-2jmA
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 04:49:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCAAF68CFE; Thu,  6 Jun 2024 06:49:06 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:49:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
Message-ID: <20240606044906.GB8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-5-hch@lst.de> <CA+1E3rJn3uNfkoFtm_am9qwQmwWvhu3nPVMaM63AJ2GBdxZTmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJn3uNfkoFtm_am9qwQmwWvhu3nPVMaM63AJ2GBdxZTmQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_214912_932950_484EE2FD 
X-CRM114-Status: GOOD (  18.32  )
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

On Wed, Jun 05, 2024 at 08:05:20PM +0530, Kanchan Joshi wrote:
> On Wed, Jun 5, 2024 at 12:01???PM Christoph Hellwig <hch@lst.de> wrote:
> > @@ -446,13 +446,14 @@ bool bio_integrity_prep(struct bio *bio)
> >         if (bio_integrity(bio))
> >                 return true;
> >
> > +       if (!bi->csum_type)
> > +               return true;
> 
> Changes look mostly good, but trigger a behavior change for non-PI
> metadata format.
> 
> Earlier nop profile was registered for that case. And the block-layer
> continued to attach an appropriately sized meta buffer to incoming IO, even
> though it did not generate/verify. Hence, IOs don't fail.
> 
> Now also we show that the nop profile is set, but the above
> "csum_type" check ensures that
> meta buffer is not attached and REQ_INTEGRITY is not set in the bio.
> NVMe will start failing IOs with BLK_STS_NOTSUPP now [*].

Yes.  I didn't remember that odd case and failed to test it, but I can
trivially reproduce it now.

Which brings up another issue: bio_integrity_prep allocates the metadata
buffer using kmalloc, so we'll leak write random kernel memory to the
devices for this case which is ... not good.  I guess for stable fixes
and backports I'll add a real generate_fn that just zeroes all the
memory for now.


