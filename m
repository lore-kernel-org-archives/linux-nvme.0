Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32FAC432C3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 12:44:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7398720684
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 12:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u/Oox4z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7398720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XWVC23vJeh80BdVTcwPDY/QlOB78wFVdVvi9/9mP0gA=; b=u/Oox4z67pUoGn
	sYD6EG06CCTOGSaOHd29KPr2SIqFjFdPJGcioCX4IBWn5ItdDXPwXuK7okWtjXH9a/utI/RjYTkkN
	QStVdtxOk2wHkeLWTVzBEcdEZZME1iSvh8JAsRmwcg9fgRynMTcZjEZR1t+DlwX0eZHxVOn94MS++
	/x0qRLfHPSwjMB9ffsRUIGQVYXu7b6zOGWfl2PD+YamS5HB+8bzZ3lx8XKE+UvZLuHZpT2JQ/rKQO
	FFfsaS8D2FoHU7dtkEFGs1f8viMhBAlVHmdzMY8YpQMdQYaKamgJGqjIbqmfUoDyRXh0xvrHJOUpn
	QeSGlQaXtPF5LYg/HtUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic7X5-0007mT-WB; Tue, 03 Dec 2019 12:44:00 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic7X3-0007lz-7W
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 12:43:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B98BDAC9F;
 Tue,  3 Dec 2019 12:43:53 +0000 (UTC)
Date: Tue, 3 Dec 2019 13:43:51 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC][PATCH] nvme/core: Notify udev about capacity change
Message-ID: <20191203124351.GE21721@Johanness-MacBook-Pro.local>
References: <20191129002746.6622-1-sblbir@amazon.com>
 <20191129082449.GA9953@lst.de>
 <0a5fc287a4ac392b9b192402e6786e7129b9d5f2.camel@amazon.com>
 <20191203065421.GA23032@lst.de>
 <BYAPR04MB57497F5F024F3E5F2200835F86420@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20191203073447.GA23426@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203073447.GA23426@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_044357_418326_40A5DCBB 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 08:34:47AM +0100, hch@lst.de wrote:
> On Tue, Dec 03, 2019 at 07:26:03AM +0000, Chaitanya Kulkarni wrote:
> > On 12/02/2019 10:54 PM, hch@lst.de wrote:
> > > I pretty much hate the set_capacity name to start with, so what about
> > > a more descriptive name for new the helper?  blk_set_capacity?
> > 
> > Do we also need a blk_mq_ops or appropriate block layer callback
> > capacity change function, so that file systems can register
> > a callback function to take an appropriate action, e.g.
> > rebuilding the metadata with new size ?
> > 
> > If this make sense I'll be happy to take a look.
> 
> Well, and op isn't going to help with file system notifications as
> that goes the other way around.  We'd probably need some way how
> file systems can register a new callback into the existing block
> device events framework that is used for media changes.

I had this on my TODO List but one thing stopped my endeavors, having a
"notifier" for resize is easy when we only grow the block-device, but what
should the FS do when we shrink it?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
