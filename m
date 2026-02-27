Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4763FEFB50
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6Ikh5wVdqihWXJ/QyLsYGUiGXtH+hvAHcEADfcap8g=; b=WXZDuBd3qjtwpZzusCdA+pyhtl
	CuH/zptu070MxmbSglhW0tuGFywtoI9x4pfPRJHoWYVJss2Kew+SNavYxQsC5T2sOo7U5ffJFj4jh
	5vo3NarSdSNceJIqQ3r+xN6IL98XSPFZ1dTgWzYAVhf2tnXJp/Qt8k2zotnmFHyY4xqvOZh3oYD4q
	oNFaNeQ8Q6OfvWTU3HVvCSgsCDGIPc6txqC3OdVDT0t4TgMjXFAxo22Fk5frpWAM9PKKPFIDwQJKU
	/pXFys0iRr1FEEGPpMsuw7Rlf86SYg3b1PnlvtMJKSezu9vEtJVfXCj591vnaKn1Y1WKPtSn2SOXQ
	Nx96zGVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyIK-00000008Pb4-2weW;
	Fri, 27 Feb 2026 13:54:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyII-00000008PaY-2LL5
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 13:54:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E20D868B05; Fri, 27 Feb 2026 14:54:11 +0100 (CET)
Date: Fri, 27 Feb 2026 14:54:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/3] nvme-multipath: rescan siblings on last path
 removal
Message-ID: <20260227135411.GB20751@lst.de>
References: <20260226183216.2098584-1-kbusch@meta.com> <20260226183216.2098584-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226183216.2098584-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_055414_742347_64D099B9 
X-CRM114-Status: GOOD (  13.57  )
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

On Thu, Feb 26, 2026 at 10:32:15AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> When a controller's scan removes the last path to a multipath namespace
> head, sibling controllers in the same subsystem may need to rescan. A
> concurrent scan on another controller could have encountered the stale
> head with mismatched identifiers (e.g. from a recycled NSID) and failed
> to set up the namespace. Without notification, the sibling won't retry
> until the next AEN or explicit rescan.
> 
> After a scan that performed last-path removals, notify all controllers
> in the subsystem to rescan by requeueing their scan work. This ensures
> that recycled NSIDs are promptly discovered by sibling controllers.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

