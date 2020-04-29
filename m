Return-Path: <SRS0=l4SY=6N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC1C83003
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 05:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B7F206D6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2020 05:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s5LrDz/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B7F206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3sA8jjS9HM1e081SO/CAKDkniNehV79YWjQYxc17o98=; b=s5LrDz/xl3nalj
	dEu0HcE26LjpF3qKafuGnOrIF+API3qywzW80aDIEmyx+LmaZI4zYjtsiU+uk1nIN53TmczXkNX6H
	cexsabiMRw/V+iaf4BSI7YGfRK+syLpdiVlZk25hpu3MgEuUc4l35Gsmc0e2Q7dtYO6x04Y8Z65Kr
	pZtuwcVj6SmOC0Pj1BCTEPJ6shAtzZT9eAg2UDE3hn+Y0I5ojwLs12eOUYMNhjujncb1NFkKIdksv
	vUJ9v4ihotOhoCV7Ry2zTEPfpEQ4AI5OCoGsjg5n3X36MbzwYM1ZCtLnuZUVEmZllqx5AH7RHE92x
	rvygkaLYdr0+nsMUZfVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTf8q-0000VE-MT; Wed, 29 Apr 2020 05:20:16 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTf8n-0000UX-TM
 for linux-nvme@lists.infradead.org; Wed, 29 Apr 2020 05:20:15 +0000
IronPort-SDR: mcXD09AIjJI5dJnL4D7N9ov9ahNpn1UBnbAEoS3jKAVPeke+yNzRbxX6NW3znC1KrjmZrdNZbA
 Syp5uGawl+Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 22:20:11 -0700
IronPort-SDR: qZAwIGjYFXEwc9gn7eJBUXXY7T9uXzfVFuBF4Ch77I1paTO/rTowIqW+PyVP28RtGTT6YD6skR
 mGvAhhGh3hAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; d="scan'208";a="432440250"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 22:20:11 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 22:20:10 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.205]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.195]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 22:20:10 -0700
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "hch@lst.de" <hch@lst.de>, "david.e.box@linux.intel.com"
 <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Thread-Topic: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Thread-Index: AQHWHeXa7+nQtLOpJUmuLMlaOXTLQw==
Date: Wed, 29 Apr 2020 05:20:09 +0000
Message-ID: <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de>
 <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
In-Reply-To: <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.30.10]
Content-ID: <70CC327022932945B5FF865EF7EEC18B@intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_222013_960314_3A2BA4E0 
X-CRM114-Status: GOOD (  15.09  )
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
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-04-28 at 08:27 -0700, David E. Box wrote:
> On Tue, 2020-04-28 at 16:22 +0200, Christoph Hellwig wrote:
> > On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > > > I'm not sure who came up with the idea to put this into ACPI,
> > > > but
> > > > it
> > > > belongs into NVMe.  Please talk to the NVMe technical working
> > > > group
> > > > instead of trying to overrules them in an unrelated group that
> > > > doesn't
> > > > apply to all of PCIe.
> > > 
> > > Agreed that this is not ideal since it does not apply to all of
> > > PCIe.
> > > But as the property already exists on shipping systems, we need
> > > to
> > > be
> > > able to read it in the NVMe driver and the patch is consitent
> > > with
> > > the
> > > way properties under PCI ports are read.
> > 
> > The point is that it is not the BIOSes job do decide how Linux does
> > power management.  For example D3 has really horrible entry and
> > exit
> > latencies in many cases, and will lead to higher power usage.
> 
> The platform can know which pm policies will save the most power. But
> since the solution doesn't apply to all PCIe devices (despite BIOS
> specifying it that way) I'll withdraw this patch. Thanks.

Wait, why withdraw? In this case the platform is unfortunately
preventing the standard driver from making a proper determination. So
while I agree that it's not the BIOSes job, when the platform actively
prevents proper operation due to some ill conceived non-standard
platform property what is Linux left to do on these systems?

The *patch* is not trying to overrule NVME, and the best I can say is
that the Intel Linux team was not in the loop when this was being
decided between the platform BIOS implemenation and  whomever  thought
they could just publish random ACPI properties that impacted NVME
operation [1].

So now David is trying to get these platform unbroken because they are
already shipping with this b0rkage.

[1]: 
https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
