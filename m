Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46808C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=duDSAblk4nehltajAuxbrbNdGwArjwPq4OFE7xgAqYI=; b=v87jk4p1/0XUtOfLUL1REuGbCp
	/y+SyHlib3LCr6hNqQ0i5bzH4xkEV4AF7DFZY3p9GEJln8Rjk2O5x8BZ/O0Wax6tFjMLog4gyXcjy
	sPc2lv1bsUm7BmTJ6LP43QOSWpDfxG1satkEiPVacEM354hNl6MrjbWwEAOa0aU8l5MJAKxQ/nepA
	+1VWYXRRwhf0igQ7sdNIbFY0+/6g4KMJ8Cr5dLGerD4K++jeB0b7KZw8xi+qX92Qmo8rtAR95+55e
	qQ3GZYB7atu/4BlaratzbNAVB7i/zSIqvuCmc9comZcR01i54WYFCo0UGXjb3UY4d7ib5w6lP4NYD
	x8mSExbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubfIm-0000000596B-0ej5;
	Tue, 15 Jul 2025 13:02:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubeeI-000000053TL-2jFn
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 12:20:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 97A4BA57001;
	Tue, 15 Jul 2025 12:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CDEC4CEE3;
	Tue, 15 Jul 2025 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752582041;
	bh=tMl1JvlwlYhUCWAJRzNllyLX2xjK9CnGH96Qoit7K4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzZNBylOhtaXDKpYwRumyL4AAGY6tVlnbwOdsYIS8EypLyTy3KxtuC/R4rZiHxD9t
	 dBOCAsI+w41ty6KcfglTwCv2GwgEm4cVvSamDN2wJ3Pgmh+b4XC2VaFIE7GoEVQJha
	 GFQhcxa490toVKN3yXsydwKx/Rh7IEkT5fLieqa2KcSzq1BQkfWXi/U4d3rCP3UaPp
	 MRRtlnKyYWWMNdGhfwRaesKaWvq3glrI1vZ4K5r3eYeFFhu6u+Gl7rd6aNQVkFIOqO
	 IKoQjOpJuifXqHNUh1+O7oGPETsDEdt4V9l7IX/w0Ro2FgBOQM05ijKCPwhuUxsRrd
	 dnmKYyY/xUkuA==
Date: Tue, 15 Jul 2025 14:20:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715-gekapert-einsam-4645671c7555@brauner>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <20250715-rundreise-resignieren-34550a8d92e3@brauner>
 <20250715112952.GA23935@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715112952.GA23935@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_052042_826402_550D40F1 
X-CRM114-Status: GOOD (  33.41  )
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

On Tue, Jul 15, 2025 at 01:29:52PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 12:02:06PM +0200, Christian Brauner wrote:
> > > I'm not sure a XFLAG is all that useful.  It's not really a per-file
> > > persistent thing.  It's more of a mount option, or better persistent
> > > mount-option attr like we did for autofsck.
> > 
> > If we were to make this a mount option it would be really really ugly.
> > Either it is a filesystem specific mount option and then we have the
> > problem that we're ending up with different mount option names
> > per-filesystem.
> 
> Not that I'm arguing for a mount option (this should be sticky), but
> we've had plenty of fs parsed mount options with common semantics.
> 
> > It feels like this is something that needs to be done on the block
> > layer. IOW, maybe add generic block layer ioctls or a per-device sysfs
> > entry that allows to turn atomic writes on or off. That information
> > would then also potentially available to the filesystem to e.g.,
> > generate an info message during mount that hardware atomics are used or
> > aren't used. Because ultimately the block layer is where the decision
> > needs to be made.
> 
> The block layer just passes things through.

We already have bdev_can_atomic_write() which checks whether the
underlying device is capable of hardware assisted atomic writes. If
that's the case the filesystem currently just uses them, fine.

So it is possible to implement an ioctl() that allows an administrator
to mark a device as untrusted for hardware assisted atomic writes.

This is also nice is because this can be integrated with udev easily. If
a device is know to have broken hardware assisted atomic writes then add
the device into systemd-udev's hardware database (hwdb).

When systemd-udev sees that device show up during boot it will
automatically mark that device as having broken atomic write support and
any mount of that device will have the filesystem immediately see the
broken hardware assisted atomic write support in bdev_can_atomic_write()
and not use it.

Fwiw, this pattern is already used for other stuff. For example for the
iocost stuff that udev will auto-apply if known. The broken atomic write
stuff would fit very well in there. Either it's an allowlist or a
denylist.

commit 6b8e90545e918a4653281b3672a873e948f12b65
Author:     Gustavo Noronha Silva <gustavo.noronha@collabora.com>
AuthorDate: Mon May 2 14:02:23 2022 -0300
Commit:     Lennart Poettering <lennart@poettering.net>
CommitDate: Thu Apr 20 16:45:57 2023 +0200

    Apply known iocost solutions to block devices

    Meta's resource control demo project[0] includes a benchmark tool that can
    be used to calculate the best iocost solutions for a given SSD.

      [0]: https://github.com/facebookexperimental/resctl-demo

    A project[1] has now been started to create a publicly available database
    of results that can be used to apply them automatically.

      [1]: https://github.com/iocost-benchmark/iocost-benchmarks

    This change adds a new tool that gets triggered by a udev rule for any
    block device and queries the hwdb for known solutions. The format for
    the hwdb file that is currently generated by the github action looks like
    this:

      # This file was auto-generated on Tue, 23 Aug 2022 13:03:57 +0000.
      # From the following commit:
      # https://github.com/iocost-benchmark/iocost-benchmarks/commit/ca82acfe93c40f21d3b513c055779f43f1126f88
      #
      # Match key format:
      # block:<devpath>:name:<model name>:

      # 12 points, MOF=[1.346,1.346], aMOF=[1.249,1.249]
      block:*:name:HFS256GD9TNG-62A0A:fwver:*:
        IOCOST_SOLUTIONS=isolation isolated-bandwidth bandwidth naive
        IOCOST_MODEL_ISOLATION=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_ISOLATION=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_ISOLATED_BANDWIDTH=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_ISOLATED_BANDWIDTH=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_BANDWIDTH=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_BANDWIDTH=rpct=0.00 rlat=8807 wpct=0.00 wlat=59023 min=100.00 max=100.00
        IOCOST_MODEL_NAIVE=rbps=1091439492 rseqiops=52286 rrandiops=63784 wbps=192329466 wseqiops=12309 wrandiops=16119
        IOCOST_QOS_NAIVE=rpct=99.00 rlat=8807 wpct=99.00 wlat=59023 min=75.00 max=100.00

    The IOCOST_SOLUTIONS key lists the solutions available for that device
    in the preferred order for higher isolation, which is a reasonable
    default for most client systems. This can be overriden to choose better
    defaults for custom use cases, like the various data center workloads.

    The tool can also be used to query the known solutions for a specific
    device or to apply a non-default solution (say, isolation or bandwidth).

    Co-authored-by: Santosh Mahto <santosh.mahto@collabora.com>

