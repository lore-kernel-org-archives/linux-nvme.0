Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B43C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aj/qhWcY1zCs/mWXTLl7fyN6H8YdDRDbGU15e8D2Mjo=; b=wwK+Haq3O9wZhQe5XGZYo89VYf
	yK8RNNF2LCXhwzcl1VHWX0781vAatI51IpJbhvr3E7kG2PP6u4aJkpmG5lcnbPpLOTShCsQ4gxTAi
	nvg+IIdgAylMkRgtgZkxtPVPadvj/Un9RKzuDFZ4CTITFQJb+skBpN/NlUz0TlEh6badcwqy6U9EN
	LkjCfnvXA9nWCOYguLkhxaCxSpoTK81sRi4jhw7kEEHdiQayIrV3IacoubR7PxFWI/U/LICOqo4la
	OcSRlbQjBa3j9xGaiPNtCDBWBUkmAEWfaNKWhAxOQvJQRk+mHL6Ls5Dr321g2rUyr6vB+32ItxFa8
	l1bfV5vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU8fk-00000006Y1f-31bD;
	Tue, 24 Jun 2025 18:47:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU5O4-000000064A8-3Vli
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 15:16:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A84D95C67FD;
	Tue, 24 Jun 2025 15:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E89C4CEF1;
	Tue, 24 Jun 2025 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750778199;
	bh=hEvQpUCZMPL5fkKPXgFFqBCtfW+XlcYFWjP41KxclSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+ZoTY6Gb1VnxyAmP2FL1584knaODE8340QhlvqYQrtXRZIE3XtW9XAkH0GUFIkO9
	 CT5dwdLbMxRycIimvLqEvIccUWqvW90wPAbIaPE6Sqhezzbatkhvno9YObaOJBMGZN
	 FfgoiuAiCIgS1tTcfG2hLlQeW1OW1ZCJfXvDWyBBQyL/q7r3I+j6QMzyz6c3oMsXKf
	 G6Y1sEKi7qC8sjitxtjaoO9IVZ19QNOFQv/QRxS6adbvmCzNF0rQ2inHYOB2S5Ac/v
	 SvdgjUDePk5yQaQhcAWBtQvZztCWK96llQZM0jY5Iso9Ka7EEYY8O06tctL86+m9jS
	 vNrXk7Rk5X12g==
Date: Tue, 24 Jun 2025 09:16:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
Message-ID: <aFrBVeEcapNtOvPx@kbusch-mbp>
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
 <aCId7XmLnrLWZPdk@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCId7XmLnrLWZPdk@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_081640_915876_11129C8A 
X-CRM114-Status: GOOD (  16.51  )
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

On Mon, May 12, 2025 at 10:12:29AM -0600, Keith Busch wrote:
> On Mon, May 12, 2025 at 11:18:58AM -0400, John Meneghini wrote:
> > On 5/9/25 11:33 AM, Keith Busch wrote:
> > 
> > > If those are not unique, they need to be blanked out to make sure we don't
> > > expose these on the namespace's sysfs attributes.
> > 
> > OK, we can add another patch that blanks out the lower precedent/invalid IDs.
> > 
> > Will that work?
> 
> I think you'd have to blank out the non-unique ones, otherwise the
> driver would export them.
> 
> And while I think that might work, this proposal didn't go over so well
> last time it came up:
> 
> https://lore.kernel.org/linux-nvme/20250414111916.GB13225@lst.de/

I've recently encountered some devices with this behavior, from machines
hosted by various cloud providers. I had to pull in something
out-of-tree like the patch here just to get things going. I think we
should have the kernel discard lower priority fields.

