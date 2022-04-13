Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7107EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76vU9HIV7lvvIjYCfwSi8u2uyXaIqL//EQODJdszVWw=; b=T0CgXdBM/UzOPmL/2YmLQfVhj6
	cOiqonGLOBAEjORNWT0Cmvc5qnJuYURv1l24ygUPoiW9sO1j7EkdDSPGqhyKgCeRMZcIQN6+rf+1y
	BXypFI9+G/gdtmBW6q/wUtdcvPWiybh7xO4rNir11xb0wr2OwhKdbOIPyhPr5SS3qgvblRNB4LTuW
	Y5NWyv+8fn1mMhpT6AVhpdT5uugsHlb+VR8IdQX4unnKCZIQmx0z9sWcLht4k7NI5QRX7zTL8yUSr
	Er2Mx7BPpVzTNElf3eHKdRhu0GXL+Oe6/ayFxuiLpr09FCJMo/1wmUxj6HuA1jKk/XCzOK5iQ2fJi
	XoAZ+c2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nef14-001c89-0a; Wed, 13 Apr 2022 15:34:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nef10-001c5j-RW
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 15:34:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CAF3D68BEB; Wed, 13 Apr 2022 17:34:32 +0200 (CEST)
Date: Wed, 13 Apr 2022 17:34:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <20220413153432.GA27146@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlaMjz7SoctkLzYo@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_083443_056459_09555258 
X-CRM114-Status: GOOD (  17.68  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 13, 2022 at 10:40:47AM +0200, Klaus Jensen wrote:
> On Apr 13 07:34, Niklas Cassel wrote:
> > On Wed, Apr 13, 2022 at 06:49:05AM +0200, Christoph Hellwig wrote:
> > > Qemu unconditionally reports a UUID, which depending on the qemu version
> > 
> > Since it appears that both older and current QEMU versions are not
> > implementing this properly, perhaps you should also consider adding
> > the pci vendor and device id used by older QEMU versions?
> > 
> > QEMU nvme pci vendor and device id was changed in commit:
> > https://github.com/qemu/qemu/commit/6eb7a071292a2f11065127ac152fa24248806021
> > 
> > Which was first included in QEMU v5.2.0.
> > 
> 
> That is a good point Niklas. +1 for that. The driver already knows about
> that ID.

5.2.0 is also the first qemu that supports the namespace descriptor
list, that's why I didn't include it.

