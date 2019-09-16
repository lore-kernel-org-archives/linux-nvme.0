Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA81EC49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 12:13:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA99214AF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 12:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pYV3zVzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA99214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eZUsuVzPOyIIM/GFfsIPJpFRYAQccUNj6cIwO1JEv9I=; b=pYV3zVzQy5P30N
	5n6hKzPTcnGXYiTvWELZWJbm2H4xtaF9+POZJbNEMe9RobPtISNHGLamz0zWBHR3xZdvRdsaC1p5b
	42SRWA4Y6YvajxX1AD+cDHbcHIMIEMNQoW02xQmSB4Yz7Q0xGrGrjOmCdmIfiwR09XHoiZN57fD7H
	tYOvu/R887ZNLghA7Nl5V3a9a3hsPNi83C5N4wPyxbV5OaaCu+Okz42wHL2vOgiPfnxmUenk0WPiV
	ImapunsT5S5eNRA6iMqbnG4ojCuC9wvBTbNnRz90EqhjIGF8gH91d+H/qFh2QKXHRx0Knrs5uApNH
	o1ncqv+45DMV6qYgd0gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9psq-0006W6-O5; Mon, 16 Sep 2019 12:13:32 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9psn-0006VF-0U
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 12:13:31 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Sep 2019 05:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; d="scan'208";a="337632577"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
 by orsmga004.jf.intel.com with ESMTP; 16 Sep 2019 05:13:25 -0700
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.103]) by
 IRSMSX151.ger.corp.intel.com ([169.254.4.234]) with mapi id 14.03.0439.000;
 Mon, 16 Sep 2019 13:13:24 +0100
From: "Baldyga, Robert" <robert.baldyga@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 0/2] nvme: Add kernel API for admin command
Thread-Topic: [PATCH 0/2] nvme: Add kernel API for admin command
Thread-Index: AQHVaiSqeBhk6f9KbEiN+m1w1CltIacpnGSAgARMMRD///TVgIAAXeIQ
Date: Mon, 16 Sep 2019 12:13:24 +0000
Message-ID: <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
In-Reply-To: <20190916073455.GA25515@lst.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzc3MjI3MDYtZjc5OS00MDQzLTkyOGYtMWY0MjlmYTI0YTExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRU81VUJsXC81SGpqbXdKTHB6UVpTUkRkXC9EVVBFcnY2ZkJ4c3hublJnVUFuVUwzcW1oMW51NlhIWjNyTXUwNXIrIn0=
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_051329_068372_EC84561D 
X-CRM114-Status: GOOD (  28.91  )
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "Rakowski, Michal" <michal.rakowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 16, 2019 at 09:34:55AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 07:16:52AM +0000, Baldyga, Robert wrote:
> > On Fri, Sep 13, 2019 at 04:37:09PM +0200, Christoph Hellwig wrote:
> > > On Fri, Sep 13, 2019 at 01:16:08PM +0200, Robert Baldyga wrote:
> > > > Hello,
> > > > 
> > > > This patchset adds two functions providing kernel to kernel API 
> > > > for submiting NVMe admin commands. This is for use of NVMe-aware
> > > > block device drivers stacking on top of NVMe drives. An example of
> > > > such driver is Open CAS Linux [1] which uses NVMe extended LBA 
> > > > formats and thus needs to issue commands like nvme_admin_identify.
> > > 
> > > We never add functionality for out of tree crap.  And this shit really
> > > is a bunch of crap, so it is unlikely to ever be merged. 
> > 
> > So that modules which are by design out of tree have to hack around
> > lack of API allowing to use functionality implemented by driver.
> > Don't you think that this is what actually produces crap?
> 
> Because you added another badly designed caching layer instead of fixing
> up one of the 2 to 3 (depending on how you count) in the kernel tree.
> And yours is amazingly bad even compared to the not very nice one in the 
> tree.  It basically spends more efforts on abstracting away abstraction
> that you wouldn't need without another layer of abstractions.  And it
> does all that pointlessly tied to NVMe through a bunch of layering
> violations.
> 
> > 
> > > Why can't intel sometimes actually do something useful for a change
> > > instead of piling junk over junk?
> > 
> > Proposed API is equally useful for both in tree and out of tree modules,
> > so I find your comment unrelated.
> 
> It is not.  We will not let random kernel modules directly issue nvme
> admin command as there is no reason for it.  And even if for some weird
> reason we did we'd certainly not do it for out of tree modules.

Ok, fair enough. We want to keep things hidden behind certain layers,
and that's definitely a good thing. But there is a problem with these
layers - they do not expose all the features. For example AFAIK there
is no clear way to use 512+8 format via block layer (nor even a way 
to get know that bdev is formatted to particular lbaf). It's impossible
to use it without layering violations, which nobody sees as a perfect
solution, but it is the only one that works.

> > If you don't like the way it's done, we can look for alternatives.
> > The point is to allow other drivers use NVMe admin commands, which is
> > currently not possible as neither the block layer nor the nvme driver
> > provides sufficient API.
> 
> And the answer is that we are not going to allow that.  And we'd not 
> allow other things even if they were not a bad design for out of tree
> modules.

I'm not going to insist on merging changes dedicated for out of tree
modules. I'd be happy to get involved in improving kernel support for 
NVMe so that there would be no need for that changes. What I proposed
is a quick fix for the problem that, for sure, can be solved another,
better way.

And this is not about being in tree or out of tree - a lot of out of
tree modules are doing well without any special care from the upstream.
This is about lack of support for certain features. If you have any
proposal how we should solve this problem in a better way than I
proposed in my humble patchset, I will gladly submit new patches.

Best regards,
Robert Baldyga

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
