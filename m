Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B7864F4F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 11:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B7864F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HbOz2KQivDLcc2OWnE5ymI/sjw2Hveg4JutyzJIQUFY=; b=KIcwjkt73im3kRhiGFUKLtOHX
	ta7dzdbxgq9U1rgUDH9H8/Y4ZPBbo9mRW1zNfqjk5nkb5s1KPXrSXBBM4hFi03wmX/uoy6hQASOhp
	1LiN5V7tzTNcrNOrAFjIDv32vhRqoxpkghYwv8cdYHFYUrMbTo3SJJP++W4g2non5h2LivYM98j6J
	pWDTyIWLWblovk+3gwzCvV3x2QoopEAQpnt+pnWSsEM7SeP06Bb5/QX8dQ+bDFm5YjAP8gFKIQ/Ps
	pmcti4RfvwATPWINsk4huGmhJV6CJYnn7X+YbAW87ZuYX6kCnUWvAnykWH3UDKs2Ttlh4DOSNid2t
	A1R8txN1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6uF4-0007NU-QU; Tue, 02 Feb 2021 11:53:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6uF2-0007N7-Co
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 11:53:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949E264EDA;
 Tue,  2 Feb 2021 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1612266787;
 bh=BRH68+6vOxOQ4LInf/FRWhZDyh3A94ESv/43pW43Yt8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OJ8N1X8f4o+yVH+a6dN3B/AyPw/cXpDy9CSfhpaCFB9Pa2HmmOTPmoaihArZTNnal
 TmR/WYbIOe25gnkHYcuWdIdweGqctOyJgUioqJreKa2g9TO4uxZrNsAJa2EbDxh24A
 xiEodTo2bHyB5/pstyzXoaX6qrNTA/sMppxDmtLo=
Date: Tue, 2 Feb 2021 12:53:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
Message-ID: <YBk9HsrdvcUb50Kz@kroah.com>
References: <20210201183017.3339130-1-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_065308_549328_50D89424 
X-CRM114-Status: GOOD (  15.77  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, erdemaktas@google.com,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 10:30:14AM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
> patch adds an option to make sure the mapped data preserves its
> offset of the orginal addrss.
> 
> Without the patch when creating xfs formatted disk on NVMe backends,
> with swiotlb=force in kernel boot option, creates the following error:
> meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
>          =               sectsz=512   attr=2, projid32bit=1
>          =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
> ink=0
> data     =               bsize=4096   blocks=524288, imaxpct=25
>          =               sunit=0      swidth=0 blks
> naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
> log      =internal log   bsize=4096   blocks=2560, version=2
>          =               sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none           extsz=4096   blocks=0, rtextents=0
> mkfs.xfs: pwrite failed: Input/output error
> 
> Jianxiong Gao (3):
>   Adding page_offset_mask to device_dma_parameters
>   Add swiotlb offset preserving mapping when
>     dma_dma_parameters->page_offset_mask is non zero.
>   Adding device_dma_parameters->offset_preserve_mask to NVMe driver.
> 
>  drivers/nvme/host/pci.c     |  4 ++++
>  include/linux/device.h      |  1 +
>  include/linux/dma-mapping.h | 17 +++++++++++++++++
>  kernel/dma/swiotlb.c        | 16 +++++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> -- 
> 2.27.0
> 

You forgot to mention somewhere, what changed from v1 to v2 :(

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
