Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419B3CCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lyWquYm+wo2eIzpWrDlO5QVCWljB/qtM8dbsSn/dbzA=; b=if+osQjTx0zUMWORpyvfG6h2lv
	1A/4/SnD7wAAPaqav0HpVSGsH/sJyaeYDudjokQnMyYpoZxzxtVnDVkurjccruXPRVX5ef2aeD6WW
	J2BfDpjxpB1p8YVz9E5CAejJ9P9lD23WiLWqquWe9w+hbJDFyuXplI66ggd1jhiOSJ5EsEee1x5cn
	4R2GlgBVVhgV0HEgRDwvqVIb6CT1TJF0uq1hRryuGMZXRbOM88YiugtcZYg8rQQIH7OBtJz0lBksf
	H1tAGiAWEpgux8WbOqJNCRjMJBagzX1I5UYMZTGqhdjbc0AtedhuJ5H5RCFeUV7dWTS8Z0U2Ub8U+
	Rjd6RquA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6O1-00000001P1O-3hms;
	Wed, 29 Oct 2025 13:38:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6Nz-00000001Ozz-1VsI
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 13:38:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64D4B227A8E; Wed, 29 Oct 2025 14:38:35 +0100 (CET)
Date: Wed, 29 Oct 2025 14:38:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029133834.GB14596@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org> <20251029074403.GA30412@lst.de> <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local> <20251029095907.GA1652@lst.de> <831d8af6-5bb0-4869-b9a5-6a4442ec8d67@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831d8af6-5bb0-4869-b9a5-6a4442ec8d67@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_063847_539872_D3BF01DD 
X-CRM114-Status: GOOD (  20.56  )
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

On Wed, Oct 29, 2025 at 11:14:27AM +0100, Daniel Wagner wrote:
> On Wed, Oct 29, 2025 at 10:59:07AM +0100, Christoph Hellwig wrote:
> > The problem is that there is no such thing as a sanity check.  Otherwise
> > life would be easy.  But I really can't believe that Dell is incompetent
> > enough to not leave a mark of their OEM Firmware version anywhere.
> 
> Got it. Sure, there are version strings though not really 'stable' as
> Hannes told me. Maybe there is a way to filter these out. But isn't this
> what the command line idea overwrite feature is?

Version isn't optimal, but model numbers often encode model numbers,
and some devices have identifiers in the vendor specific regions of
identify commands.

> John, did you have some progress with this?
> 
> The sad thing is that the Intel device needs the quirk. If the Dell
> device just would use it's own IDs...

I'm pretty sure they are one and the same device, just with slightly
different firmware versions.  It might be that Dell actually reported
the bogus IDs to Intel as part of compliance testing and Intel only
fixed it for them and not the generic firmware build :(

