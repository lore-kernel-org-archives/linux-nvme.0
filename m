Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE7C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:16:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06D4600EF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 14:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06D4600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t5MZ7He7kFtQtDuIAKoLB/ARy39qb5s0/ONUF5RPA9I=; b=Vw8t08O5aMS1rk
	tReKdyQbYW0vlKesqUXa0JehOGhWWUAr80i5AivaZWwAXe7gRaMMvxMT6ejeo6CoYqzLmAPb1LCNq
	fIJpd/k7vtRNzwKW64CtRMtVTi857o9t0dfbrEMAr+tPbuhytR1ZIUGNSam8BCFwfR90bWtsmUChn
	pwSbFBlzLXysfm+TXLnOWCsdSosiFr6NgkvtF206y40CQ/sVhz4P/YIUFgXTZjZGCBIaLJ1TlQnDm
	8HBrPuXJCYtcs4g5Ht/Ok4tsXCWQou8R760REfW1OCTtaWbbJCpz2Gf4mFRZx34SB3e3PxMjSL7Ok
	NwC3NF3LX4OWLsPEnMMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llXrK-005b3z-Rf; Tue, 25 May 2021 14:16:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llXrH-005b2B-Ji
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 14:16:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CC4B26736F; Tue, 25 May 2021 16:16:31 +0200 (CEST)
Date: Tue, 25 May 2021 16:16:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christoph Hellwig <hch@lst.de>, "Liang, Prike" <Prike.Liang@amd.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
 to D3 for s2idle
Message-ID: <20210525141631.GA12576@lst.de>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_071635_834206_8A6811BE 
X-CRM114-Status: GOOD (  23.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, May 25, 2021 at 02:06:09PM +0000, Limonciello, Mario wrote:
> Quoting an earlier version commit message:
> 
> "Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
> and then will lost the NVMe power context during s2idle resume. Finally,
> the NVMe command queue request will be processed abnormally and result
> in access timeout"

Where shutdown means power is cut off, right?  NVMe also has the concept
of shutting down the controller using a sequence of register writes and
reads, but if the SMU firmware messes with that we'd have deeper problems
than this.

> Which I think begs the question - how about if we keep the quirks list and logic
> outside of NVME and also outside of PCI but instead in an AMD owned platform
> driver?  Something like this:

I think what we're all missing here is that the concept of requring devices
to go to D3 for suspend to idle is a higher level concept.  AFAIK this
comes from this microsoft document:

https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro

and spread from there.  Note that this document explicitly mentions AHCI
in addition to NVMe.  It also has some issues that I can spot:

 - PCIe slots are not specific to storage device, so this really needs to
   apply to all devices
 - it generall is a rather bad idea to start with as each shutdown not
   only causes media progam/erase cycles, but also is not very power
   efficient.

So what we need is a way for a driver to figure out if for a given
device it should shut down the device fully or just do something that
is efficient for saving as much as possible power.  That can be either
in form of a flag or by splitting the suspend method in different ones
for different use cases.  Platform-specific code (right now for Intel
and AMD) can then make sure drivers do get the right requests instead of
hardcoding platform information in every driver that wants to be able
to implement intelligent suspend behavior.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
