Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68097C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Feb 2022 06:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeErea1KNVsvGG1/DzyBT0YHCag1yVRHroDCfmgmaVc=; b=Ojmp8Ym03DNLHKFqnc5oxyMb0G
	WFZaBdQpi8JYENFfhFqxbdg2cJxMdEuR5Q+2XkQhLpu0vBBYpTjM6ZmHWW/32+Q5Odwz9N8YOa47B
	P3Hg2YJVDaOFcrVahbptDSwAMrdgpN3HFxq8qhZIUzBfv8498unqs869W6x/nuq1SMD2fN2YMqjho
	Si3Y5666BooaI7w8+bXbR/SaaRE30N/QXHh1bvC5yiemqSSqZFczs9SghUqImDXOE9p7594aX/K+d
	JOl0IDm0OaFHC515LMCB2XP64Lo7vXxiCNtunJa52LxQ+zTBhpheSXxq2+Qi8tJJTu9R6w/LMyvzT
	/RXboA/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMkzw-00Cwfp-9M; Wed, 23 Feb 2022 06:19:36 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMggy-00C9dB-LS
 for linux-nvme@lists.infradead.org; Wed, 23 Feb 2022 01:43:48 +0000
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au
 [49.186.17.0])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C1E5D52F66C;
 Wed, 23 Feb 2022 12:43:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nMggp-00FHrN-4M; Wed, 23 Feb 2022 12:43:35 +1100
Date: Wed, 23 Feb 2022 12:43:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
 jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
 nitheshshetty@gmail.com, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Add Copy offload support
Message-ID: <20220223014335.GH3061737@dread.disaster.area>
References: <CGME20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0@epcas5p2.samsung.com>
 <20220214080002.18381-1-nj.shetty@samsung.com>
 <20220214220741.GB2872883@dread.disaster.area>
 <20220217130215.GB3781@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217130215.GB3781@test-zns>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6215914d
 a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
 a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
 a=ejYDZuiVgDdOHNFj5oEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_174345_102800_266C4640 
X-CRM114-Status: GOOD (  28.76  )
X-Mailman-Approved-At: Tue, 22 Feb 2022 22:19:07 -0800
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

On Thu, Feb 17, 2022 at 06:32:15PM +0530, Nitesh Shetty wrote:
>  Tue, Feb 15, 2022 at 09:08:12AM +1100, Dave Chinner wrote:
> > On Mon, Feb 14, 2022 at 01:29:50PM +0530, Nitesh Shetty wrote:
> > > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > The biggest missing piece - and arguably the single most useful
> > piece of this functionality for users - is hooking this up to the
> > copy_file_range() syscall so that user file copies can be offloaded
> > to the hardware efficiently.
> > 
> > This seems like it would relatively easy to do with an fs/iomap iter
> > loop that maps src + dst file ranges and issues block copy offload
> > commands on the extents. We already do similar "read from source,
> > write to destination" operations in iomap, so it's not a huge
> > stretch to extent the iomap interfaces to provide an copy offload
> > mechanism using this infrastructure.
> > 
> > Also, hooking this up to copy-file-range() will also get you
> > immediate data integrity testing right down to the hardware via fsx
> > in fstests - it uses copy_file_range() as one of it's operations and
> > it will find all the off-by-one failures in both the linux IO stack
> > implementation and the hardware itself.
> > 
> > And, in reality, I wouldn't trust a block copy offload mechanism
> > until it is integrated with filesystems, the page cache and has
> > solid end-to-end data integrity testing available to shake out all
> > the bugs that will inevitably exist in this stack....
> 
> We had planned copy_file_range (CFR) in next phase of copy offload patch series.
> Thinking that we will get to CFR when everything else is robust.
> But if that is needed to make things robust, will start looking into that.

How do you make it robust when there is no locking/serialisation to
prevent overlapping concurrent IO while the copy-offload is in
progress? Or that you don't have overlapping concurrent
copy-offloads running at the same time?

You've basically created a block dev ioctl interface that looks
impossible to use safely. It doesn't appear to be coherent with the
blockdev page cache nor does it appear to have any documented data
integrity semantics, either. e.g. how does this interact with the
guarantees that fsync_bdev() and/or sync_blockdev() are supposed to
provide?

IOWs, if you don't have either CFR or some other strictly bound
kernel user with well defined access, synchronisation and integrity
semantics, how can anyone actually robustly test these ioctls to be
working correctly in all situations they might be called?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

