Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9436C3567B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D8C20828
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 09:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P/6e6qJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8C20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwU+BG6r0FosvCt0rqkHOxR7XdW5yJ8/2pxSmMJOTWw=; b=P/6e6qJtQHJ0q1
	T3R06LoQq97R10hezCfFkDQGcXkKKcyXY6vhw+PyomxIshi3PrP+Rccehkv6xUtMnCcaP+w+Ox2n4
	mwK/xO+x8OFX1WsKq1LVSllCO1TlgWTYgoMlZcNHSUZ8zO8qCMBlP/E5ijueuRcAIZ/V2O72MSjc1
	D4Fs9Fa1Pv2clE8pAlvxfXryNYMAsItntF28MRVU3usUOjx4z0JUy5pRojd3HAYp98JwHBRz4OQoA
	ycu8nxxT5KVLLawqFUYVTfzMcXA/Pm0ovNrpc8Lgz2HHvhC4nIEAtCkR1LQMkqH6Lf6YDhb3QVM43
	++2dkEIOt58utGZvZVPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6ASN-0002i8-St; Mon, 24 Feb 2020 09:55:19 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6A8m-0003PC-6R
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 09:35:06 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 01:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="231079120"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 01:34:58 -0800
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1j6A8h-004LzG-SO; Mon, 24 Feb 2020 11:34:59 +0200
Date: Mon, 24 Feb 2020 11:34:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 2/2] nvme-pci: Convert to PCI_VDEVICE() macro for
 Apple devices
Message-ID: <20200224093459.GV10400@smile.fi.intel.com>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
 <20200212173901.GB5708@lst.de>
 <20200212203418.GW10400@smile.fi.intel.com>
 <20200219150625.GE17748@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219150625.GE17748@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_013504_494586_C3A24E3D 
X-CRM114-Status: GOOD (  25.05  )
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

On Wed, Feb 19, 2020 at 04:06:25PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 10:34:18PM +0200, Andy Shevchenko wrote:
> > > This actually makes the code longer
> > 
> > I didn't get this. How? The code is for sure shorter.
> 
> Looks at the diffstat.

Yes, but let's calculate a real code (not all lines).
In terms of characters it's shorter, in terms of LOCs it's the same.
On top few comment / blank lines were added.

> > > and adds the antipattern of macros
> > > that use string pasting on their argument,
> > 
> > Anti-pattern to what? Can you elaborate a bit more? Sounds like I missed some
> > very basic thing.
> 
> > > 	and this breaking grep-ability > badly, so NAK.
> > 
> > This like a mantra people are telling, but looks like simple they didn't try.
> > What grep issue do you see in this case (I would agree if we talk about device
> > ID, though)?
> 
> If I want to grep for PCI_VENDOR_ID_APPLE I find the ids in the old code.
> I won't find them in your new code.

But it's matter of writing good enough RE, right?
What about, as rough approximation, `git grep -n 'PCI_[^,]\+APPLE'`?

> > Are you going to remove PCI_VDEVICE() completely? Are you going to be
> > consistent with the rest in this driver?
> 
> If you care strongly about using the same macro please send a patch to
> remove it in nvme.  I certainly don't want the sane version switched
> over to it.

Perhaps in the future, but no guarantees I find a time for that soon.

> > > It isn't by luck.  If the Apple devices were using the proper NVMe
> > > class ID we'd never hit the apple specific entries, but the actually
> > > use a different class code (the nvme one in big endian IIRC).  That
> > > being said I'm all for having the class match last.
> > 
> > Nobody prevents Apple to fix this and re-use old ID. So, under luck we may
> > consider Apple's negligence to the standards.
> 
> I'm just saying the current atch is not by luck.  As said in the previous
> mail I'm fine with moving the class match to the end as it generally
> is a good idea.  I just disagree with the "works by luck" statement for
> the current entries.

Thanks, I will send a new patch just for that.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
