Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD605FEFB50
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqF+psdpvtXP84hsHI1crkldJBM6VCg8/M1Py+9n7sI=; b=xH8SGWrgQ9/b9PC0mVZSdNXn4n
	YKgQRNtpTU7dP/qYLjcdjzUJUcjFUiEe8TiEz6HQGSYtsA69QNBCo9poJM44Cr+Q1KWYDCwCmEusN
	yddmp1zhuZvrUEGi+CGeFqzUGSAY4Q5VvzEyLpKjkfQgibTYdpjvHUjZcgt2LGfcVjVv+d5GJSus6
	b+7UAuvwNMzR5Fk8Ts3KIm7R7lH/IlgoG2PWAqbdoq6WKnl7hlcuqadJVAwW37gXLhHqO73Atk5+f
	J7LIvXTLZoVwW7mbZochi9Z+xsQ/qZg4NFj+QEO3Aj4yGz2csRdGnYyWOmSZNDcIaZYrHEIEsUyPK
	ipvEWZ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyHx-00000008PXU-1atH;
	Fri, 27 Feb 2026 13:53:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyHu-00000008PXA-1pJ0
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 13:53:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53BA468B05; Fri, 27 Feb 2026 14:53:48 +0100 (CET)
Date: Fri, 27 Feb 2026 14:53:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path
 deletion
Message-ID: <20260227135348.GA20751@lst.de>
References: <20260225202109.447144-1-kbusch@meta.com> <20260225202109.447144-2-kbusch@meta.com> <20260226153740.GB31615@lst.de> <aaB6BJV3FvAVBuPq@kbusch-mbp> <e79a3ed5-e2ae-49f3-919c-735a2ff33358@linux.ibm.com> <aaCSe6PZu-PiH72S@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaCSe6PZu-PiH72S@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_055350_640903_A894A7DF 
X-CRM114-Status: GOOD (  18.96  )
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

On Thu, Feb 26, 2026 at 11:35:39AM -0700, Keith Busch wrote:
> On Fri, Feb 27, 2026 at 12:01:48AM +0530, Nilay Shroff wrote:
> > On 2/26/26 10:21 PM, Keith Busch wrote:
> > > This is looking pretty tricky to resolve. The best solution I'm coming
> > > up with so far is to have the scan_work synthesize a
> > > NVME_AER_NOTICE_NS_CHANGED event for every controller in the subsystem,
> > > then re-kick their scan work if the scan_work removed anything.
> > 
> > So does your disk when reuse NSID, changes ns ids such as NGUID/UUID/EUI64?
> 
> Yes. The NSID is put back into the available pool when it's deleted, but
> the UID associated with it is newly generated upon creation.

Yeah, that is one of the two allowed nvme behaviors, and there's a bit
to detect if the persistent ids can be reused or not.

