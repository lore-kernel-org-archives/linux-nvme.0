Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7AFC2BA1B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7fWLE8ySprvXWYFQg/VKg06g9FUPvXwxDCxkWFOycw=; b=lwOzcx+AJ9JipjRYXgwiUgTQqg
	fXysosmazKjZ1yDM/e8pIcuMl6ElbQ1tyJR8mQ9QvB4qXvmU8zH79ky86QRrC/jfLM0Iv412jlJZR
	RvFvnIySJR2C6FsGFD9kBfQPyQwiYP/jigww7PHXAK+8n11tfWAUGvPYM8shU6N0BLGN9sDT+UMfg
	IktHkp5byla0advFrj2T6IMAMbdroTkQS/8wqTNF9vn3ANKYcHtZBCZjDwVpP2e4faL/MJ3YnlnP4
	jvI4vgilmXpbZ8XwGBf4ddOk8IkONKDyAkChjU3jg9iXp8iO8+WRpTUV6urTD77bGWXSUiG9dWG6k
	i/7IOUvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trual-00000004w6t-1CRH;
	Tue, 11 Mar 2025 08:03:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1truQH-00000004uqA-3UwD
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 07:53:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2873F67373; Tue, 11 Mar 2025 08:53:03 +0100 (CET)
Date: Tue, 11 Mar 2025 08:53:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: simplify request ready check for pci
Message-ID: <20250311075302.GA14844@lst.de>
References: <20250307232655.2143570-1-kbusch@meta.com> <20250310132448.GB8835@lst.de> <Z87-43riMPw3jWqU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87-43riMPw3jWqU@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_005310_014909_DF2B803A 
X-CRM114-Status: GOOD (  20.37  )
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

On Mon, Mar 10, 2025 at 09:01:55AM -0600, Keith Busch wrote:
> On Mon, Mar 10, 2025 at 02:24:48PM +0100, Christoph Hellwig wrote:
> > On Fri, Mar 07, 2025 at 03:26:55PM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The criteria for pci transports' request ready check is simpler than
> > > fabrics. Move the pci check to a different function. This also makes the
> > > existing ready check simpler since it doesn't need to repeatedly test if
> > > the controller is a fabrics type.
> > 
> > The change looks good, but now that this is split, the PCI version
> > should move to pci.c, and the fabrics version should move to fabrics.c
> > and into the nvmf_* namespace.
> 
> I don't think we can move it to pci.c. The apple device isn't fabrics
> either, but is built without the pci.c module, so needs to be in a
> header or common core.

Indeed, Apple messes this up a bit.  But that also means the _pci namespace
is wrong.  It's about all memory transport including the (unspecified)
apple one.  So either rename it to something reflecting that, or just
duplicate it in apple.c as we'd done with a few similar things.

