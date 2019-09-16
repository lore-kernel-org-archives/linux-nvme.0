Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97468C49ED7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:35:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524262067B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 07:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GJ7/C10E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524262067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1rdHHX+0qirq40D/hSwxScEBldn+tukdqK5vZvf6JY0=; b=GJ7/C10EGXZEYx
	dPmZYZw8/s1HkGYwaaPECkBQEfWJdQRzfy/2VoKVAnsZdVBzbr90ApkaJPIjUmdFWLaEspWuXDphv
	3i58ySb1w4bx9rgmdotq1f1zmrX5MsBm8c7/ipO20DidPOFRTgn61x4B8btatNu3Stcem/40GLBYl
	fVwddduwvrJKvb9Pjt5BV4StD5D4KjwTLYP8wC+ro7JdVPHh5gbHEtddn8Lu0mJA7qQaVW2Y4yekQ
	F/UJ/cxwR+tPXpONOicJocdATPdSu1oRoAV2Lh7BdTz4M0XerW3iPhiCNBxxV9j295GobXbB1Yn8D
	Cf8tllutoQUSm5DJ7MLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9lXK-00015X-Im; Mon, 16 Sep 2019 07:35:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lXH-00013j-T6
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 07:35:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BCB0C68B05; Mon, 16 Sep 2019 09:34:55 +0200 (CEST)
Date: Mon, 16 Sep 2019 09:34:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Baldyga, Robert" <robert.baldyga@intel.com>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190916073455.GA25515@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_003500_093230_6A7096E0 
X-CRM114-Status: GOOD (  19.16  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Rakowski,
 Michal" <michal.rakowski@intel.com>, "axboe@fb.com" <axboe@fb.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 16, 2019 at 07:16:52AM +0000, Baldyga, Robert wrote:
> On Fri, Sep 13, 2019 at 04:37:09PM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 13, 2019 at 01:16:08PM +0200, Robert Baldyga wrote:
> > > Hello,
> > > 
> > > This patchset adds two functions providing kernel to kernel API 
> > > for submiting NVMe admin commands. This is for use of NVMe-aware
> > > block device drivers stacking on top of NVMe drives. An example of
> > > such driver is Open CAS Linux [1] which uses NVMe extended LBA 
> > > formats and thus needs to issue commands like nvme_admin_identify.
> > 
> > We never add functionality for out of tree crap.  And this shit really
> > is a bunch of crap, so it is unlikely to ever be merged. 
> 
> So that modules which are by design out of tree have to hack around
> lack of API allowing to use functionality implemented by driver.
> Don't you think that this is what actually produces crap?

Because you added another badly designed caching layer instead of fixing
up one of the 2 to 3 (depending on how you count) in the kernel tree.
And yours is amazingly bad even compared to the not very nice one in the
tree.  It basically spends more efforts on abstracting away abstraction
that you wouldn't need without another layer of abstractions.  And it
does all that pointlessly tied to NVMe through a bunch of layering
violations.

> 
> > Why can't intel sometimes actually do something useful for a change
> > instead of piling junk over junk?
> 
> Proposed API is equally useful for both in tree and out of tree modules,
> so I find your comment unrelated.

It is not.  We will not let random kernel modules directly issue nvme
admin command as there is no reason for it.  And even if for some weird
reason we did we'd certainly not do it for out of tree modules.

> If you don't like the way it's done, we can look for alternatives.
> The point is to allow other drivers use NVMe admin commands, which is
> currently not possible as neither the block layer nor the nvme driver
> provides sufficient API.

And the answer is that we are not going to allow that.  And we'd not
allow other things even if they were not a bad design for out of tree
modules.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
