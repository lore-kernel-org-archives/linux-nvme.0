Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EDC352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:40:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FD724677
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 20:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OumoQU/v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5HcV7iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FD724677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w8bygieitBMimS2AjxBf1KxjSru3TV2DzBmrlr1iYkI=; b=OumoQU/vhu3sYp
	7Wj1RZs0k34tEcUnQMdzDXzrCaINBXnbCn9GZpwRaJA10YbjE0B5gbg4ElP9sJEciNAyrMUtOTIa/
	/oiUGC7DHoZ4ejABzJ/4buazfpAvD72fXevlUMzFje8fxAOPe1F2IMpbRhuUz2TCpQjU1TADUzsYh
	nb0iL/OnIE2unoQeHf2bPlZFAEHBZR/D1hKqtzvjcyaAJb68xw0ruPLIatxr4MenjrRRmjNxyg/t9
	UUG5nkk6uUYzdyVPSYYE01XjbGhutvuQsX7BmFnFXcC2/xxs7z5jH5xPQdPEC1QDDXlM43OGTuxhI
	EmTAmVZxafzo+njud8TA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1ynr-0005TN-MC; Wed, 12 Feb 2020 20:40:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1ynp-0005NS-PN
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 20:40:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C571924671;
 Wed, 12 Feb 2020 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581540008;
 bh=NmYJviQ/WXMkkhUnKUJnzVLNIVL+9DiNijpsMP6hlFI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g5HcV7iLJP21/wClFNMorjbf1FFzGb8CIftyaDdH7RTIuRpWypSux7QZyGpjW1OFy
 iwdlV8OFrMgfxfTkvmlYtCjDYBAA+4gG+3Nepbaz8Y5d1DmLmS3ZfxAycVmhNrM3HY
 ybwtuoS8CpYkg13Ay5dKkZV+o4HeNnIMAs8ieEdU=
Date: Thu, 13 Feb 2020 05:40:00 +0900
From: Keith Busch <kbusch@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Convert to PCI_VDEVICE() macro for
 Apple devices
Message-ID: <20200212204000.GA6343@redsun51.ssa.fujisawa.hgst.com>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
 <20200212173901.GB5708@lst.de>
 <20200212203418.GW10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212203418.GW10400@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_124009_846635_7C28876E 
X-CRM114-Status: GOOD (  11.77  )
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
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 10:34:18PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 12, 2020 at 06:39:01PM +0100, Christoph Hellwig wrote:
> > On Wed, Feb 12, 2020 at 12:32:19PM +0200, Andy Shevchenko wrote:
> > > Like for Intel devices use PCI_VDEVICE() macro to describe
> > > Apple devices.
> > 
> > This actually makes the code longer
> 
> I didn't get this. How? The code is for sure shorter.

What metric are we using? The diff stat says longer.

  drivers/nvme/host/pci.c | 15 +++++++++------
  1 file changed, 9 insertions(+), 6 deletions(-)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
