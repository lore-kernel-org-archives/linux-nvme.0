Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C63C54731
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 19:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WDLr3YTdkM3TpIIDMpfuISPV/GPFciyhWAaDjRrEhuI=; b=ZesyYbhkWT+t/SfhGOcpLT20eK
	Gjaf/e6j4mOB1MaYRt+rDW8LXR1ZFiiAYtSmGAUgqX36Hmi6xZa6wUTN16EzSr0JoHoUZ+Q38kdbA
	XUp0GJxJcwPpiWI1DxAIJcJaVnk6W3Jg1Bru/T7GbQnZQv13bPtZZHkKs3WtZj0Q1z1oQ7FHq2XFe
	0lHpC7Xw04WSdMT6RR9HTIKbdJmOQDtWLVyE0iT4aGBUsZtSQjTwoFFbdsRv8e/Wlrvnlo8BLmQta
	lLQQ48nbcY9vJ4J3wNvGhmpAx5MTzQbDUKp/1Ey2PCrUKk5LgyN6QoI4K3kc2P6Ug6GXGzsfL/WNW
	xLDy7aEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj1aO-0000000CbD3-210h;
	Tue, 27 Aug 2024 19:10:36 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj1aM-0000000CbCJ-0IW3
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 19:10:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5A0B2A41B77;
	Tue, 27 Aug 2024 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BFEC4AF54;
	Tue, 27 Aug 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785832;
	bh=RPIQ9vG8OGc95glQixUGVxTdHhONO00TTltSs09zxzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R40N/fmIuyJl6elg+cwGiv2hpg/hDLlVtiVslzx5ZOj+mX7a+C08zli+rPePHnTn0
	 StbJXDhBOG2/kx44RvGGzJyT2YbkcQuxZOClyehpwN7jfWRFOaXopU1GMQOkZ0+0Bb
	 fFZHrB6peHIsOGV5Axe8ANNpVasLeFaUgjcEmlUovA1WAdAKJxpuzQD9lXJC4kDym8
	 +9SjLuGqk4zKPgn456PIDFTAp4Iomsk57PPtD+f3uWTNsGernJxi/CAS7iZN9xnOrw
	 2yjaJ2W80hftEMlDAM62qFdUNzqYBk04GvvVnpCCAgaxsMHZQS1oiqVBK+nKSy/L4U
	 uaqQK+73XnYOw==
Date: Tue, 27 Aug 2024 13:10:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
Message-ID: <Zs4kpqXWAb87VHcv@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com>
 <20240826103943.143962-1-anuj20.g@samsung.com>
 <Zsy4xXsmBr57p6Jn@kbusch-mbp.dhcp.thefacebook.com>
 <20240827032243.GA9442@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827032243.GA9442@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_121034_199340_556B745A 
X-CRM114-Status: GOOD (  15.41  )
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

On Tue, Aug 27, 2024 at 05:22:43AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 26, 2024 at 11:17:57AM -0600, Keith Busch wrote:
> > On Mon, Aug 26, 2024 at 04:09:43PM +0530, Anuj Gupta wrote:
> > > Rename apptag and appmask to lbat and lbatm so that it matches the field
> > > names used in NVMe spec.
> > 
> > Thanks, applied to nvme-6.12.
> > 
> > FWIW, the previous names were set before NVMe spec defined those fields
> > that way.
> 
> Btw, IFF we want to get the metadata through io_uring in, it might be
> better to move this patch out of the nvme tree and into that series.

Oh good point. I'll pop the commit off the if it's going with that
series for 6.12. If Anuj wants to resubmit with this one, you can
include:

Reviewed-by: Keith Busch <kbusch@kernel.org>

