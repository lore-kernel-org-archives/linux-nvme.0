Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E7C48BCF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:27:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3506108E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3506108E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vxcc57GFZ3L5/+VEgbn8WzwmYnFHSRYzZUkDSkCLN7g=; b=Pfg5ht0ZE+PeFt
	C8WqfDNUtn9pFhs3nwV4stpkhe5uutI+AYarhex0BlkFTsvzwzoux00hzj0uux35KELnAQ1M8Tsq8
	pZmHJksLxNQ1bWSwwQ9xbGAvx41KTFcibCYqR1ekrKilRnInO11Zreh8smggNY8BzZ/topFtqxblq
	h2FjGAYA0I7O2SanN3vkvTvgqkNpW5VCuaROh56B7BwNWq4CqAn7D4dG3Q6MTdjCAHyVolGWuA9mt
	zORx3mqQ/jQMSi/II9Jw1hsI2iVkb4uDFi7V1rUn25WPqPTWWa+Ae5w9UY3Q+qUqYsqDGX2ckVJXc
	jEDna0HaVBa0nZhAykmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqyFC-00Dzwu-EJ; Wed, 09 Jun 2021 13:27:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqxor-00DsPU-L8
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 13:00:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4FFBF68AFE; Wed,  9 Jun 2021 15:00:26 +0200 (CEST)
Date: Wed, 9 Jun 2021 15:00:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable
 property to acpi
Message-ID: <20210609130025.GC1837@lst.de>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
 <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608200101.GB339628@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_060029_881289_68D2143E 
X-CRM114-Status: GOOD (  23.94  )
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

On Tue, Jun 08, 2021 at 01:01:01PM -0700, Keith Busch wrote:
> On Tue, Jun 08, 2021 at 07:35:46AM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
> > > +/**
> > > + * acpi_storage_d3 - Check if a storage device should use D3.
> > > + * @dev: Device to check
> > > + *
> > > + * Returns %true if @dev should be put into D3 when the ->suspend method is
> > > + * called, else %false.  The name of this function is somewhat misleading
> > > + * as it has nothing to do with storage except for the name of the ACPI
> > > + * property.  On some platforms resume will not work if this hint is ignored.
> > > + *
> > > + */
> > 
> > I still do not like this comment.  There is nothing about only using this
> > for storage devices.  It is specific to a PCIe slot, and if I plug
> > something that is not a storage device into it the same restrictions
> > still apply.
> 
> Hm, I thought this comment was good. Despite the dupious connection to
> storage, the function name matches the ACPI property, so an explanation
> for this misnomer seems appropriate.

I suggested a comment earlier that explains the connection without being
completely misleading.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
