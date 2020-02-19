Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71106C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:06:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214524656
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XyT4Z2YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214524656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VQ4Ie52V0EovlZoUxXe0Ukx1m7FG1fjdDUK0Z8zN0b4=; b=XyT4Z2YZz52KG7
	ydYC+GDqEmCoyX70NQXFeGa2XojzMf6b4jldZmTb/bZlJFwvOlrMw53gECfEzXYnSLf9oOUS1qkfc
	aUiYd+zeY60hTuLyG8F9kdxMElj2160PXohJUwNO+aeC1pthQOgN0kvXxJNWoCQ3MZ3hRXbVlcryZ
	qZOIJlhAP2ovk0kOV++En+TCosLrU4Pg9K2vHVgP1CwJDiV+wHikl4Psg7ySRTP8SlISvovbO1voD
	O6X3eHkA3Z5dwXhk2xpT2FgyBHLjquV24a7CpjLJOPEqbAXIEKAa5ZGMBk6Hy7IrlTEehtMtv9aCR
	+KA9ZDWRSKuywkO4dVcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Qvo-0006FH-AJ; Wed, 19 Feb 2020 15:06:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Qvl-0006ER-RX
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 15:06:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C45B68B20; Wed, 19 Feb 2020 16:06:26 +0100 (CET)
Date: Wed, 19 Feb 2020 16:06:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Convert to PCI_VDEVICE() macro for
 Apple devices
Message-ID: <20200219150625.GE17748@lst.de>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
 <20200212173901.GB5708@lst.de> <20200212203418.GW10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212203418.GW10400@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_070630_038318_F5490439 
X-CRM114-Status: GOOD (  19.18  )
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
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 10:34:18PM +0200, Andy Shevchenko wrote:
> > This actually makes the code longer
> 
> I didn't get this. How? The code is for sure shorter.

Looks at the diffstat.

> 
> > and adds the antipattern of macros
> > that use string pasting on their argument,
> 
> Anti-pattern to what? Can you elaborate a bit more? Sounds like I missed some
> very basic thing.

> > 	and this breaking grep-ability > badly, so NAK.
> 
> This like a mantra people are telling, but looks like simple they didn't try.
> What grep issue do you see in this case (I would agree if we talk about device
> ID, though)?

If I want to grep for PCI_VENDOR_ID_APPLE I find the ids in the old code.
I won't find them in your new code.

> Are you going to remove PCI_VDEVICE() completely? Are you going to be
> consistent with the rest in this driver?

If you care strongly about using the same macro please send a patch to
remove it in nvme.  I certainly don't want the sane version switched
over to it.

> > It isn't by luck.  If the Apple devices were using the proper NVMe
> > class ID we'd never hit the apple specific entries, but the actually
> > use a different class code (the nvme one in big endian IIRC).  That
> > being said I'm all for having the class match last.
> 
> Nobody prevents Apple to fix this and re-use old ID. So, under luck we may
> consider Apple's negligence to the standards.

I'm just saying the current atch is not by luck.  As said in the previous
mail I'm fine with moving the class match to the end as it generally
is a good idea.  I just disagree with the "works by luck" statement for
the current entries.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
