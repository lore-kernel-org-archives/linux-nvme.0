Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E37C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:34:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0759621739
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uYbgutNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0759621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v1PFvaTzUjc2HI4S3AdAiLE/CdkHV287g0nssfeES4Q=; b=uYbgutNoFySdy+
	cpFi3+Knhgz8z2fUvplUAihyFAD7RtoTFiL/Lbj0xXnjnr/mzb9v+ltuY3oeCB/HnWHNcNZfT0UIF
	qKE+8nROx9423ZiISH6T1wTSw5gbvFvMZzX53mAfAF7X4OQkm1fuf7w0HD1iIp2/ypFRuDz/Fydax
	O7GNekaqP1wBGE7roNWFlH2KbwDpYF1Fo1yiN+qwGo+sFkzcWCS7vcKL/t8vv0Mt9BPHukiBu3dmk
	s8eheWbgUQ99KSt0pq8MsLKwgM7d6DOdwizlGU1ktufcvLBaFF5eiGYGttPpKXO7N6m/1YN6OoX8a
	3D1Dz9SLeKUGXn3bEg5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1yiF-0002Y6-Qu; Wed, 12 Feb 2020 20:34:23 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1yiC-0002XI-H0
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 20:34:21 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 12:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; d="scan'208";a="237825665"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 12:34:17 -0800
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1j1yiA-00100X-DY; Wed, 12 Feb 2020 22:34:18 +0200
Date: Wed, 12 Feb 2020 22:34:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 2/2] nvme-pci: Convert to PCI_VDEVICE() macro for
 Apple devices
Message-ID: <20200212203418.GW10400@smile.fi.intel.com>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
 <20200212173901.GB5708@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212173901.GB5708@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_123420_637238_8D758840 
X-CRM114-Status: GOOD (  19.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Leif Liddy <leif.liddy@gmail.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 06:39:01PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 12:32:19PM +0200, Andy Shevchenko wrote:
> > Like for Intel devices use PCI_VDEVICE() macro to describe
> > Apple devices.
> 
> This actually makes the code longer

I didn't get this. How? The code is for sure shorter.

> and adds the antipattern of macros
> that use string pasting on their argument,

Anti-pattern to what? Can you elaborate a bit more? Sounds like I missed some
very basic thing.

> 	and this breaking grep-ability > badly, so NAK.

This like a mantra people are telling, but looks like simple they didn't try.
What grep issue do you see in this case (I would agree if we talk about device
ID, though)?

Are you going to remove PCI_VDEVICE() completely? Are you going to be
consistent with the rest in this driver?

This patch (first part of it) is to bring some consistency to this table. I
don't see how it may thing worse than they are already.

> > Besides that it's a luck that we got devices enumerated when
> > they are listed after class matching entry. So, move them above
> > and leave class matching entry the last in the ID table.
> 
> It isn't by luck.  If the Apple devices were using the proper NVMe
> class ID we'd never hit the apple specific entries, but the actually
> use a different class code (the nvme one in big endian IIRC).  That
> being said I'm all for having the class match last.

Nobody prevents Apple to fix this and re-use old ID. So, under luck we may
consider Apple's negligence to the standards.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
