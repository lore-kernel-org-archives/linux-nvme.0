Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF4AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 May 2022 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Go0K4uVPMcIRB9KqASU+Q8VWMrGbhmHToe/6r5Q5Jg=; b=3XLlj43jPz7P3lbhKE0mXZjh79
	eq/6mAwKWhMdY//boNS+/SXthj1D4JPAzQGgCYjhxqNwBd7Pnrtnj/05gwJK5+LRQeq4n5BgenERm
	k9r5+4LXAMgoqKf9QyPpYFGaUyO2kdZFYTTv2/yJk3tLdcv3MaEiJILjLFymIxpmZhBANyA6y7/5y
	reDv4sASAVHucGwhADg3IXTI5dmzAjDHO4x50G/jAr8rzvWgpK9ho9uPGrV62+gcGEZ4iCxcRBgHP
	HYkTsq0NWKHPT/0pZKtrXCMmgCU0Dht/lpmcEnXfPnDjw/gqZ59CIOwMPM5iVyY4h5dThv6ea77Aq
	IKsOD76A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlNNs-00HUIS-Uw; Mon, 02 May 2022 04:10:05 +0000
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlNNo-00HUHa-To
 for linux-nvme@lists.infradead.org; Mon, 02 May 2022 04:10:03 +0000
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au
 [49.181.2.147])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 71FEB10E608C;
 Mon,  2 May 2022 14:09:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1nlNNf-006zFQ-FJ; Mon, 02 May 2022 14:09:51 +1000
Date: Mon, 2 May 2022 14:09:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220502040951.GC1360180@dread.disaster.area>
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427124951.GA9558@test-zns>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=626f5993
 a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
 a=ldjz8t_eVu9c6UoTg2wA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220501_211001_165572_69D6D571 
X-CRM114-Status: GOOD (  13.92  )
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

On Wed, Apr 27, 2022 at 06:19:51PM +0530, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
> > On 4/26/22 19:12, Nitesh Shetty wrote:
> > > The patch series covers the points discussed in November 2021 virtual call
> > > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > > We have covered the Initial agreed requirements in this patchset.
> > > Patchset borrows Mikulas's token based approach for 2 bdev
> > > implementation.
> > > 
> > > Overall series supports –
> > > 
> > > 1. Driver
> > > - NVMe Copy command (single NS), including support in nvme-target (for
> > >     block and file backend)
> > 
> > It would also be nice to have copy offload emulation in null_blk for testing.
> >
> 
> We can plan this in next phase of copy support, once this series settles down.

Why not just hook the loopback driver up to copy_file_range() so
that the backend filesystem can just reflink copy the ranges being
passed? That would enable testing on btrfs, XFS and NFSv4.2 hosted
image files without needing any special block device setup at all...

i.e. I think you're doing this compeltely backwards by trying to
target non-existent hardware first....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

