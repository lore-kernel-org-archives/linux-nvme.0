Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA4C88E75
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIsizXorVJHbFJH4dS14341/nrFnwwmQIGTYGo6r+oE=; b=BkC8AgxojAW06Ip/UtCOx+qY+x
	dTJQzWcf8lhzByPwgeCWkNz9YoKmO53rw1c08KVL75CUSypL43rrBRBs0JnUJCBN4vsq+0wo0PYk9
	9ej5oY9Dp+kDpNVWYcizCw12AoiOd1PsA6y2/i+M8vRmGx4psLNafj2EAS/ZjS9ywu/hwFsG32EVv
	H6NOcJ+AkG1d78eBnUvkiYMyHBe8OK/CXsCtKXfjoiYQ/4ONQGS4qPBn6exP88a67KD4B93g+y391
	roACQUNymqtPGWqmXkMc4DEfBKkGcyCappDvPMprQo5gzWmpSzRw0TUYewElGzoz4eRQEOmoGfXiz
	EErxNd1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Mmu-00000005MUA-2uHi;
	Tue, 15 Sep 2026 06:37:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Mms-00000005MSm-1yJE
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 06:37:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C78BD68C4E; Tue, 15 Sep 2026 08:36:51 +0200 (CEST)
Date: Tue, 15 Sep 2026 08:36:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone
 info is known
Message-ID: <20260915063651.GA13293@lst.de>
References: <20260914105713.155704-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914105713.155704-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_233702_665052_17C3CB56 
X-CRM114-Status: GOOD (  16.45  )
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

Where do we actually stack it right now?


