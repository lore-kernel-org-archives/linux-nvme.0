Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA5C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4YW1ombdiVyrplKI9EK1rbitDg0mS7Yq0zwi0YNheok=; b=UzyFtXV1NEWEqGGKz0LKLr3bXL
	MUZ4gm4jDTur0QIXCM0ORUNKnJpdF5yT4snn9Iq2JAwE0d2WPIk2uQsTNY0HUKAUgr4aNF2oNohCX
	wcC+0H00iaeGvDx1/uwILk/rF+k4XD9jfy2cbKewXMGcSvIM3nk55xm3EnIIE5ibH7ejyTIiC9Ljl
	N32RVsTyPc3uuqS9q1uiqfd1+zvV524T/ixX6WIywbhHkU0eoNM5J9U/wCmAe3ieNNu7KJuiW3Q0v
	Z8wgt8oBXyi59iuIMqz6GtHiQ445Ihnbn1EJceh/k++geGJkCv7l99NaIqiMz8YzQi7y6S2AcNqzW
	kvAulRYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92BB-00000005nmC-2mTl;
	Tue, 22 Sep 2026 15:13:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92BA-00000005nlz-04Z4
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:13:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8511842D9F;
	Tue, 22 Sep 2026 15:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120231F00893;
	Tue, 22 Sep 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089987;
	bh=4YW1ombdiVyrplKI9EK1rbitDg0mS7Yq0zwi0YNheok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AI2MO8lyUTI1FrylfosPrScDAuXL4iTdnB7ysWXURrMrqmLalgOxDgylEOPuLOhYW
	 WgRtYeF/6+XfXO3QDXu/E+hqd9nKQUZLVKNYs0Z/sD993egm0Slrx7u8VQC6srd9xt
	 7RIGwis+VmLp+yjVrmjoKME6bOz/24AKNpSqPDL/E0bV3f1IZw6m1IZozApa7Gu18D
	 WL4LQVeJ27K95PNWWJdjmUQYd0nBhW5lVrhXcGYxlVHBKG78h1/Iry/LQxcSz57h2r
	 xo8N0C24nK9uGU7SGsZ0OC/9Llp4VIWSMqCjGtAJ2uhfHBdU9cpmrWee5UogYj78jx
	 SEBXdaezXOqpw==
Date: Tue, 22 Sep 2026 09:13:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone
 info is known
Message-ID: <arKbARv2BjhJgbRW@kbusch-mbp>
References: <20260914105713.155704-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914105713.155704-1-kanie@linux.alibaba.com>
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

On Mon, Sep 14, 2026 at 06:57:13PM +0800, Guixin Liu wrote:
> The namespace head is marked zoned at allocation time based only on
> the command set identifier, before any zone information has been
> queried.  If the zone info query fails on the first scan, the path
> namespace is registered without zoned limits while the head still
> advertises the zoned capability with a zone size of zero.  Reporting
> zones or writing to the head then shifts by ilog2(0), triggering the
> UBSAN shift-out-of-bounds report in the report-zones and write paths.
> 
> Drop the zoned feature from the head allocation and inherit it from
> the path namespace: the head limits refresh already stacks the zoned
> feature, the zone size and the zone resource limits from the path
> queue, so the head matches the path namespace and becomes zoned once a
> revalidation succeeds.  This also stops marking the head zoned when
> CONFIG_BLK_DEV_ZONED is off, which used to fail the head allocation
> with a WARN.

Looks correct to me. Applied to nvme-7.3.

