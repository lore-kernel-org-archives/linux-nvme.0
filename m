Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF6FC83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 14:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6896206D7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8Ar6d1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6896206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gu4Pg6i7UQdJYRYDFVJXX7RAuIWFex8phU/bTS/iAgY=; b=d8Ar6d1bSsM8Qz
	gMu4czfaK1TluRYTSRs6++sVvaWBKzsPYUu27Mzo1qoktljbGZ2LXtpdLT+zoD8lYmioyyJ5VrvAj
	4taHV+aXwnoXqMpbA4abD9A6n3HSC/macsZ0NOWLbX6ug2XJTp9FfTWb2BDTCitkZi+2wXqReemLN
	WJF8fEACN9lAmNGhxwUB28LliONRoRA9LvXjBdfv14t8dkfZvZtJFx6g81q4QTncsdB5FJlAN1MJA
	hLGF9N6XC/LgC4CqxAq6SPfHJiXrprA4BsX0FSMPSj3rI8ovHs5EbFedhyoSTGmxExi+qIN8NYIRI
	iHqFKracQGJN0SxQc3qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTR8O-0005M6-UA; Tue, 28 Apr 2020 14:22:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTR8M-0005LK-P8
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 14:22:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D68AF68CFE; Tue, 28 Apr 2020 16:22:47 +0200 (CEST)
Date: Tue, 28 Apr 2020 16:22:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
Message-ID: <20200428142247.GB5439@lst.de>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de>
 <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_072250_971815_2FAF7A67 
X-CRM114-Status: GOOD (  14.16  )
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
Cc: sagi@grimberg.me, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 bhelgaas@google.com, Christoph Hellwig <hch@lst.de>, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 28, 2020 at 07:09:59AM -0700, David E. Box wrote:
> > I'm not sure who came up with the idea to put this into ACPI, but it
> > belongs into NVMe.  Please talk to the NVMe technical working group
> > instead of trying to overrules them in an unrelated group that
> > doesn't
> > apply to all of PCIe.
> 
> Agreed that this is not ideal since it does not apply to all of PCIe.
> But as the property already exists on shipping systems, we need to be
> able to read it in the NVMe driver and the patch is consitent with the
> way properties under PCI ports are read.

The point is that it is not the BIOSes job do decide how Linux does
power management.  For example D3 has really horrible entry and exit
latencies in many cases, and will lead to higher power usage.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
