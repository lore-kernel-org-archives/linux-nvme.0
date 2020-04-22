Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF7C55189
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 08:37:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2918E206B9
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 08:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lUqU/7fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2918E206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u4pxJjhE/OvG+Tpta+eQ6MzChK8ymz6u6pQf9YyY3Dw=; b=lUqU/7fadvK6j5
	s6X16IYcvoNvl6/Fb/TCA21pChx61oGXnEeqQDoIf6+x/gFcZuo4e6b0vE5zf/Qowrluz2nhjkmoS
	KEs6yYQpXtMiyL6/dwx//hGHyBk5ZN3O1gQaSWPugUbvOoSfJZWRVkd0mKMAwrNGfr7QCFTtZRXjv
	9e74DfJWpK2/9cRirrTKkVs+L/W2y8Rr7DKxPNA5X8q3nPrBtb0FVUj6/BMcpeaAlantmUSidIV1w
	5TpX5JstNS+DhZo43qZvh3c5c/cFheHLgUZauGGq5eLDME1q46nlrevhpiv9ux+MPUpCNVAmeLqzX
	IR01Hh/vxXBR3aE86fcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRAtC-00023C-32; Wed, 22 Apr 2020 08:37:50 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jRAt9-00021t-O4; Wed, 22 Apr 2020 08:37:47 +0000
Date: Wed, 22 Apr 2020 01:37:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
Message-ID: <20200422083747.GA26915@infradead.org>
References: <20200410095719.GA4393@192.168.3.9>
 <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
 <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
 <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
 <CAA70yB7bkeSwQVjJ5rjGS3HxZtkraUY1FX9ZMHXH8FO6a-8omw@mail.gmail.com>
 <df0fa3a0-7764-bc1f-711d-d264fc4f444f@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df0fa3a0-7764-bc1f-711d-d264fc4f444f@mellanox.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, Weiping Zhang <zwp10758@gmail.com>,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 14, 2020 at 03:59:12PM +0300, Max Gurtovoy wrote:
> > > write_queues and poll queues shouldn't be writable IMO.
> > > 
> > I think we can keep it writeable, the user case is that setup as many io
> > queues as possible when load nvme module, then change queue count
> > for each tag set map dynamically.
> 
> We can keep it writable but I prefer not change the controller initial queue
> count after reset controller operation.
> 
> So we can keep dev->write_queues and dev->poll_queues count for that.
> 
> You can use the writable param in case you aim to hotplug a new device and
> you want it to probe with less/more queues.
> 
> IMO this feature should've somehow configured using nvme-cli as we do with
> fabrics controllers that we never change this values after initial
> connection.
> 
> Keith/Christoph,
> 
> what is the right approach in your opinion ?

The problem with PCIe is that we only have a per-controller interface
once the controller is probed.  So a global paramter that can be
changed, but only is sampled once at probe time seems the easiest to
me.  We could also allow a per-controller sysfs file that only takes
effect after a reset, which seems a little nicer, but adds a lot of
boilerplate for just being a little nicer, so I'm not entirely sure
if it is worth the effort.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
