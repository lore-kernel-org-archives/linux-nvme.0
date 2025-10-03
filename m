Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C307BCAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eWkinr1OgxcJX30p4Q36JfFG/eo3RXkubfePsx6WM50=; b=Wz4Udlro3hOSzNXjV/ytG3uuwv
	qRtpK+0298U8kc5bINRMrELnt5ae22Ba5kFraGj7zUokl9IYOXD0GkavcayrI/GpR+rXfVbh2dGaX
	S7AGWJWB5O9w8DLEWzZlMvUXPaACwoZVS+ttpTxnBsa2LLtzTYhviBJc0mI//Qpaz4U9imC6s+cTK
	SK71NEqJMCmHqYfvhGJI0gTcgfOEzEHqLTjulTyBkGYWbwM/ZBXUKCuIMCQUX+fmGoQuWg8/cDElq
	e4Oveo9VCxd1k5N3BM232xrNuqhqt65WR3F2ehHkRGe2pQymctvWX+mUxl9G73Ge3LSP0/HDbuPoE
	G7tnvC3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4faS-0000000CMNa-1aKJ;
	Fri, 03 Oct 2025 13:12:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4faP-0000000CMMl-2aGT
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 13:12:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4752F227AAC; Fri,  3 Oct 2025 15:12:30 +0200 (CEST)
Date: Fri, 3 Oct 2025 15:12:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] nvme-keyring: typo in nvme_dhchap_psk_lookup()
Message-ID: <20251003131229.GA18230@lst.de>
References: <20251001142200.61696-1-hare@kernel.org> <20251001142200.61696-3-hare@kernel.org> <20251003073506.GB12862@lst.de> <aN_Ek04e4ldw7Ppq@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_Ek04e4ldw7Ppq@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_061237_798929_6C5B9AD8 
X-CRM114-Status: GOOD (  16.60  )
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

On Fri, Oct 03, 2025 at 02:41:55PM +0200, Keith Busch wrote:
> On Fri, Oct 03, 2025 at 09:35:06AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 01, 2025 at 04:21:59PM +0200, Hannes Reinecke wrote:
> > > Spurious semicolon in the function stub nvme_dhchap_psk_lookup().
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/
> > > Signed-off-by: Hannes Reinecke <hare@kernel.org>
> > 
> > Looks good.  But maybe we should just drop the series and pick up a
> > resend with the fixes folded in?
> 
> Yes, I was totally planning to squash and force push, but I'm
> considering moving this to the -6.19 branch rather than the current
> window.

Yeah, the 6.18 merge window is over.

