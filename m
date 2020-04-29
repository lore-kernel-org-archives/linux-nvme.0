Return-Path: <SRS0=l4SY=6N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8115C83000
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 16:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876CC2072A
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 16:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o7BGNHYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876CC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ChgCgWxlrCZS9xuMwjjV6Uv0R3qIRnUHI2aUrfPTw0=; b=o7BGNHYPrUAxff
	9JCf7Bg0mEc+56SA8q3s/5msT0jfM56MXpdZLuGojmLonsF/pJBQBDuHjblcRpOFUacuqEJsY997U
	y6RmYMuzeKS3UghT9S8XhTWKojrcWnecVWGX1A7DuV7psIFifJalnwJeENk+IEmsSlxDPOSlL4LWx
	sIKS00J3d13WMtDcWscJQI66OII6ZsOUYRN1fGJ+OXP+P1a7mO9ZdTvsoR67ItRdLFV/Nd0U7B96C
	ySKDrb2OxNoqrYd0+7HdPLKZNii3l+wKldr3gMvCnWbl6+pC6hXBAcf41ejiuyh2++OEsA6pJEzzX
	7BUfpaEgYz8wsYn8wNgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTpKo-0002VX-79; Wed, 29 Apr 2020 16:13:18 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTpKl-0001wr-Si
 for linux-nvme@lists.infradead.org; Wed, 29 Apr 2020 16:13:17 +0000
IronPort-SDR: s0I/ef5qJ7e5Pq8nze1IA+kiGFUkEdIqWnrF5qxSN+qhLpawn6QhyxExaWDzHxSFPLklU/mN1h
 28s0DRcwRBLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 09:11:13 -0700
IronPort-SDR: lx2KkyTZPhRl1sD40I4Y7gLUcq7I5rdu5EFyb/8mWtnfuMy8EnenzMatqwkSikUnQqCqGtHMR3
 hmFSOvd9wCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; d="scan'208";a="249494877"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 09:11:13 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id 52DD8580613;
 Wed, 29 Apr 2020 09:11:13 -0700 (PDT)
Message-ID: <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From: "David E. Box" <david.e.box@linux.intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "hch@lst.de" <hch@lst.de>
Date: Wed, 29 Apr 2020 09:11:13 -0700
In-Reply-To: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
Organization: David E. Box
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200429_091315_941712_4D19350A 
X-CRM114-Status: GOOD (  28.05  )
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
Reply-To: david.e.box@linux.intel.com
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-04-29 at 05:20 +0000, Williams, Dan J wrote:
> On Tue, 2020-04-28 at 08:27 -0700, David E. Box wrote:
> > On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> > > On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > > > I'm not sure who came up with the idea to put this into ACPI,
> > > > > but
> > > > > it
> > > > > belongs into NVMe.  Please talk to the NVMe technical working
> > > > > group
> > > > > instead of trying to overrules them in an unrelated group
> > > > > that
> > > > > doesn't
> > > > > apply to all of PCIe.
> > > > 
> > > > Agreed that this is not ideal since it does not apply to all of
> > > > PCIe.
> > > > But as the property already exists on shipping systems, we need
> > > > to
> > > > be
> > > > able to read it in the NVMe driver and the patch is consitent
> > > > with
> > > > the
> > > > way properties under PCI ports are read.
> > > 
> > > The point is that it is not the BIOSes job do decide how Linux
> > > does
> > > power management.  For example D3 has really horrible entry and
> > > exit
> > > latencies in many cases, and will lead to higher power usage.
> > 
> > The platform can know which pm policies will save the most power.
> > But
> > since the solution doesn't apply to all PCIe devices (despite BIOS
> > specifying it that way) I'll withdraw this patch. Thanks.
> 
> Wait, why withdraw? In this case the platform is unfortunately
> preventing the standard driver from making a proper determination. So
> while I agree that it's not the BIOSes job, when the platform
> actively
> prevents proper operation due to some ill conceived non-standard
> platform property what is Linux left to do on these systems?
> 
> The *patch* is not trying to overrule NVME, and the best I can say is
> that the Intel Linux team was not in the loop when this was being
> decided between the platform BIOS implemenation
> and  whomever  thought
> they could just publish random ACPI properties that impacted NVME
> operation [1].
> 
> So now David is trying to get these platform unbroken because they
> are
> already shipping with this b0rkage.

Not drop completely. This patch copied the code used to read _DSD
properties under PCI root ports. But I agree that such properties
should apply to all devices on those ports and unfortuntely that's not
the case here. BIOS got it wrong. My thought in dropping this patch is
to rewrite it to read the property directly from the nvme driver. Not
the way it's typically done either but it would avoid a global change
in the pci core while allowing us to deal with the firmware we have.

David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
