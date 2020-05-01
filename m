Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CCC47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:54:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C7C24953
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uICnEiij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C7C24953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:To:From:Subject:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZHQzekCDx7hh7GJn+Z2Vmm/+9KO99T9RUTYJb9d7uqU=; b=uICnEiijP6hUN+
	iftoJScPzPiEr6b+jpEYZlepRzxdexFDKlNhAZe8r8lf/ibc4NqBbOHkm6jwFLYXAl+IF7n4h7CyJ
	Rbqea3XcvKviSasxagc22ED4DD1kT9Awi4RHlDneLOhE1rLWyZQNVWhz0RkJRMMB5RkTNy/lsi7VF
	mn921hYfO1/a1pS5l0XuJP8jHchcvU7Rc+5ip0ut1V/xX96DJ2ehKQDfqaHCxSWrwrivx5q9rkB2/
	pWhvXjt8FEFeb3vVKJzrKRBpLYQ9WFemg7X9VNWQMuDSReFOe1ldfkR3o0+BMwlm8uvEYpRCZ2mMj
	bMNXG0rMjoY8A+WZK0zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUXzr-00023W-9U; Fri, 01 May 2020 15:54:39 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUXzp-00022N-4K
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 15:54:38 +0000
IronPort-SDR: ZjhM3aS1/VdSBFbKCPUtP6M78cHcDtBun+SiS7v6/KBZZtNqGoRzF2BZOrW7nyIYoU9AxwbUGL
 TBPdg4AzjuDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2020 08:54:35 -0700
IronPort-SDR: ey3oKxUh7DvV+cxKGq9JyUiYKFbCwpaYL95UuuRXFcJoBwhE9hBZEEDPGjeC0qBXP9iw/hIUVT
 8/cIZhRGK3TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; d="scan'208";a="248577903"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga007.fm.intel.com with ESMTP; 01 May 2020 08:54:34 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.7.201.137])
 by linux.intel.com (Postfix) with ESMTP id 7BC2958062D;
 Fri,  1 May 2020 08:54:34 -0700 (PDT)
Message-ID: <4ef802c221ba879d87bc202487f0ac5f6b01e9f1.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
From: "David E. Box" <david.e.box@linux.intel.com>
To: "hch@lst.de" <hch@lst.de>
Date: Fri, 01 May 2020 08:54:34 -0700
In-Reply-To: <20200501131259.GB6600@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
 <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
 <20200501131259.GB6600@lst.de>
Organization: David E. Box
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_085437_220341_4925C466 
X-CRM114-Status: GOOD (  16.72  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2020-05-01 at 15:12 +0200, hch@lst.de wrote:
> On Wed, Apr 29, 2020 at 09:11:13AM -0700, David E. Box wrote:
> > Not drop completely. This patch copied the code used to read _DSD
> > properties under PCI root ports. But I agree that such properties
> > should apply to all devices on those ports and unfortuntely that's
> > not
> > the case here. BIOS got it wrong. My thought in dropping this patch
> > is
> > to rewrite it to read the property directly from the nvme driver.
> > Not
> > the way it's typically done either but it would avoid a global
> > change
> > in the pci core while allowing us to deal with the firmware we
> > have.
> 
> I'd be happy to heave less of this crap in nvme actually.  But I'm
> really
> pissed this shit got out in the wild.  It wasn't clear from the mail
> that this is something already out there because the idiots coming up
> with it just went ahead with it.  Please just update the commit logs
> and implementation to clearly mark it as a workaround for buggys
> systems, which just happen to at least be nice enough to tell us that
> they are buggy as f^$k.

Sure.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
