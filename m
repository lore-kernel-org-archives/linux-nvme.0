Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F2ED6B6B3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+h1H2MVFNXjZ0WzzkMCG6fsnsj+xUdBlacuWOVrJwjQ=; b=hJkcSCLhmDNSINPMl8Sfw9tCPi
	SJ1/9yzgSabesGTimRJRYetEfOJfxTj+EfZmPGHdiFfH6wjwvh6xeKXtn3diG9eJUVhjw0wlidA03
	C/oj5l9aharIz2W1PvNALzMLEzPuPQnDA5hWgQv2Q5W9pRgApV69V2rzFqzE0lRw54i/95GpSBPSI
	BqHEXx7JasI23klSj2hnkQIp1eNOnk4/0DGT56BoJdXiwIOMz4yj3o7RonsiM6tKMFefWfhXzC76L
	f2T9hQAqSKvYioss1x66rOMLe14IWKZXhCtvHwKK+EKHCrAyXFUW3F7usTnY7a/fj+3UCsa9L77hl
	dsgx6XCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CPp-00000001GkD-1M6z;
	Wed, 30 Oct 2024 17:23:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CPm-00000001Gik-2RBh
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 17:23:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 06B19A42F94;
	Wed, 30 Oct 2024 17:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A931AC4CECE;
	Wed, 30 Oct 2024 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730309005;
	bh=6IqeD9OR8grEFIquAlG+eKQrDyJFCloHUWc1o9RKuUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8U1HDtUMehii0vbt7n5UMBQ7tiCAXpqPof9Ag1fL4SSGBjdfJSTa8XVyZgOGPSfY
	 iEGhqZYO6CvAMk5G0h+p+fujQ67rChs5InFn5Q66g1yUcAdwc7oaHqHMCtx0OwtmS2
	 hpIXJxfb1wDtJ2mGPcZ6RdsogLsJr2UvP4KG8vvzbkYS5i18RW1VysWRywVnMJ2ipW
	 Xgj4zFUbb/K6aJOQeY5xkotMciWJO+Tzr1xjE1cC6J4COwk73lWqDekE5YWbT3K8hr
	 EiUWD43kgEeTJrE6ihcrgPgKApivC0DytrXs5AHhe0gFKbe2drRlDQTo5t4Q+0ZBfh
	 WHiU4fXH82brw==
Date: Wed, 30 Oct 2024 11:23:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyJriq2jZ4ZG-UAC@kbusch-mbp.dhcp.thefacebook.com>
References: <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
 <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
 <20241030154556.GA4449@lst.de>
 <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com>
 <20241030155052.GA4984@lst.de>
 <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com>
 <20241030165708.GA11009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030165708.GA11009@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_102326_707657_48E7B2BB 
X-CRM114-Status: GOOD (  16.65  )
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

On Wed, Oct 30, 2024 at 05:57:08PM +0100, Christoph Hellwig wrote:
> > On Wed, Oct 30, 2024 at 04:50:52PM +0100, Christoph Hellwig wrote:
> 
> > It sets temperature hints for different SST levels, which already
> > happens today. The last data point made some minor changes with
> > level-to-hint mapping.
> 
> Do you have a pointer to the changes?

The change moves levels 2 and 3 to "MEDIUM" (along with 0 and 1 already
there), 4 to "LONG", and >= 5 remain "EXTREME".

WAL continues to be "SHORT", as before.
 
> > Without FDP:
> > 
> > WAF:        2.72
> > IOPS:       1465
> > READ LAT:   2681us
> > UPDATE LAT: 3115us
> > 
> > With FDP (rocksdb unmodified):
> > 
> > WAF:        2.26
> > IOPS:       1473
> > READ LAT:   2415us
> > UPDATE LAT: 2807us
> > 
> > With FDP (with some minor rocksdb changes):
> > 
> > WAF:        1.67
> > IOPS:       1547
> > READ LAT:   1978us
> > UPDATE LAT: 2267us
> 
> Compared to the Numbers Hans presented at Plumbers for the Zoned XFS code,
> which should work just fine with FDP IFF we exposed real write streams,
> which roughly double read nad wirte IOPS and reduce the WAF to almost
> 1 this doesn't look too spectacular to be honest, but it sure it something.
> 
> I just wish we could get the real infraѕtructure instead of some band
> aid, which makes it really hard to expose the real thing because now
> it's been taken up and directly wired to a UAPI.
> one

This doesn't have to be the end placement streams development. I
fundamentally disagree that this locks anyone in to anything.

