Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B09C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:13:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7916F2071E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 13:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="St3Gu9Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7916F2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YBt0zzKFt5C1uk7AdTiH91xRSoxz1aglIr64lkEH3/k=; b=St3Gu9LzzSo3Pk
	tlqV3HwqNZwCx4ti53SQKdTPia1cYlCc41AcIYUGefkqv/Hs72m7ug/K8U1Eb2Mz48VcpdpUzN+04
	+A8xDrjIm2plWRgRmH//aVe3kH+jDgR6yl1IKsMSUX6PDS4VTwsiOsLXXUC6VPr1uHqTgDDj5OZqN
	13aTP/T5Ac2hb8tKYYkWAGWM6DvKL87X7cGVIjcM80NPFNjuwZUjLIXVWQ4I2OqQG4H2j+bFu+G7K
	kqsqnGCHx4RqEOMiVoN68T7YqPnBoex6Bo/MWwHXZy/KSpCEzvyLF5Kbtz4luaN+4E/x9huCptJri
	ZB/VflVJVgWPKLDLYF0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUVTV-0001xB-Sl; Fri, 01 May 2020 13:13:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUVTS-0001wO-U3
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 13:13:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E2AC168BFE; Fri,  1 May 2020 15:12:59 +0200 (CEST)
Date: Fri, 1 May 2020 15:12:59 +0200
From: "hch@lst.de" <hch@lst.de>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Message-ID: <20200501131259.GB6600@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
 <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <537edbfaa088a655eb22e7eba05075aa61d941be.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_061303_116929_916F8F55 
X-CRM114-Status: GOOD (  10.67  )
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 29, 2020 at 09:11:13AM -0700, David E. Box wrote:
> Not drop completely. This patch copied the code used to read _DSD
> properties under PCI root ports. But I agree that such properties
> should apply to all devices on those ports and unfortuntely that's not
> the case here. BIOS got it wrong. My thought in dropping this patch is
> to rewrite it to read the property directly from the nvme driver. Not
> the way it's typically done either but it would avoid a global change
> in the pci core while allowing us to deal with the firmware we have.

I'd be happy to heave less of this crap in nvme actually.  But I'm really
pissed this shit got out in the wild.  It wasn't clear from the mail
that this is something already out there because the idiots coming up
with it just went ahead with it.  Please just update the commit logs
and implementation to clearly mark it as a workaround for buggys
systems, which just happen to at least be nice enough to tell us that
they are buggy as f^$k.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
