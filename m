Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A5C2BA83
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:39:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0D42073C
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tOn3G6v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0D42073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TyOlh05UmBF0IY6x/eiu7NEPFVKvpcjtI7w+d9GvbJw=; b=tOn3G6v5+xRnY/
	5GtefuvbgwS2JTY7g0spgMWbJhvResTTl4miU51qllBZCVxFpixhiANyED1TJ5UYTNmeSAuZCoFWA
	p+5fh8qkjIBiiRjNCqjUpqgPcLDcrJjnCLrhE1Tq6EykEy++z21/vWAuBpIBKJFJ2yMp3IGpIWLZe
	dbJ6bNdWl1bYgOWWAhJuXTXzTEMa+TNMF9eQ6DfiX/U9WDfesjkhup/YgGq/TFelG+87Ex6Ul59Zu
	IGWU4EtydU2+YSuvtzkndPUWm0VzKn+cmXg8pUn0e1z62XElyR5lUYTAQ0XVlqoXK1/jle5jjkWdn
	Vn/ElIWzjR54V30G2BLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1vyc-0006AR-Tt; Wed, 12 Feb 2020 17:39:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1vya-00069x-KE
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 17:39:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B75C568BFE; Wed, 12 Feb 2020 18:39:01 +0100 (CET)
Date: Wed, 12 Feb 2020 18:39:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] nvme-pci: Convert to PCI_VDEVICE() macro for
 Apple devices
Message-ID: <20200212173901.GB5708@lst.de>
References: <20200212103220.80680-1-andriy.shevchenko@linux.intel.com>
 <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212103220.80680-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_093904_814566_9F1C5BB1 
X-CRM114-Status: GOOD (  10.21  )
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

On Wed, Feb 12, 2020 at 12:32:19PM +0200, Andy Shevchenko wrote:
> Like for Intel devices use PCI_VDEVICE() macro to describe
> Apple devices.

This actually makes the code longer and adds the antipattern of macros
that use string pasting on their argument, and this breaking grep-ability
badly, so NAK.

> Besides that it's a luck that we got devices enumerated when
> they are listed after class matching entry. So, move them above
> and leave class matching entry the last in the ID table.

It isn't by luck.  If the Apple devices were using the proper NVMe
class ID we'd never hit the apple specific entries, but the actually
use a different class code (the nvme one in big endian IIRC).  That
being said I'm all for having the class match last.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
