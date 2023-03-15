Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898C0C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 19:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7EPmOABbyB067XYBDPlDGMo6rrZAkPxJwoWlIZoKEc=; b=Vnphn77lq6nabTeFd/S20G2PGs
	O8vCZYzSlhZUV0Zx0TX3q2CmMdudt3FMsSEEnTauCztDYO5ZpYNkKwVaO1usEGG2qW0Uz5NwIwoxG
	S88eZcHTFsvQTCCVXHbLInSj+ju2ENA1OH7RV60nnTZX0PT2sgDSEemFh7/bMRTunUJzsn4f8KmOG
	+Vc4JHRiyzze1k85ETYx6fcHy/l+gcIHQev7n69Y2yRRQ+codzZqotCr/NzlJZuzr4WhR2s7ZFkSq
	LajjlLkPFFN/1BhCryHNPLE2GtkGUl330FagzwKvcVZEkby0oQ4Iue7zEpu4Ib0QPNj1Hpf2NJCqv
	ttqPOv+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcWxq-00EKFa-0v;
	Wed, 15 Mar 2023 19:39:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcWxo-00EKEt-0t
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 19:39:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 606F261E61;
	Wed, 15 Mar 2023 19:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D860C433D2;
	Wed, 15 Mar 2023 19:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678909146;
	bh=Cj/IXs8KrJ8hNpPfYxwskPmUQFHCFys1dYQU9T1x3v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWNLyDz7/z/1Nwr7ixyrB4HVmg1SXB24tuH+IdKuPnN0W3Thx3ENGc74i15JptmfD
	 0b66qvSpCz1IiPN3JFu85PDXiDxNFj9kjj0SZGnHcbtTScrPHNk5rqqQb4chxbcpKB
	 ld357Xy2PXKZVqOuLEycCVmZbs8jtNs69rZG4ODHAyZmoG9b6lK+LkAp+9u0yG18Ko
	 KXGIIdv4PGkpghkdO2La//qRztzy+TxOP/Cod/efslcDaT7JZyRE1lI6TzTF4vEsvd
	 1I/5t6ztIc9chE+1JiMvzW35+2lDWz7dCM2IdVFAFlphpNWpmiYbImg8mFpytXkckX
	 Vbs+w7uLngrlQ==
Date: Wed, 15 Mar 2023 13:39:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBIe2H9J7XDs/zoD@kbusch-mbp.dhcp.thefacebook.com>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
 <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_123908_353631_C907AADA 
X-CRM114-Status: GOOD (  25.41  )
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

On Wed, Mar 15, 2023 at 06:23:32PM +0000, Belanger, Martin wrote:
> > 
> > On Wed, Mar 15, 2023 at 05:48:14PM +0000, Belanger, Martin wrote:
> > > I'm running tests where I connect/disconnect to/from a few I/O controllers
> > using the nvme_tcp driver. I use nvmet_tcp with a null_blk device to simulate the
> > target. The kernel module crashes (trace below) while trying to connect over
> > TCP. This happens on Fedora 37 and Ubuntu 22.04. I also recompiled the kernel
> > using the latest nvme-6.4 branch and I'm still seeing the crash.
> > >
> > > I'm not sure how to debug this further. Any suggestions?
> > 
> > Never seen anyone try to use poll queues with nvme tcp before. It doesn't look
> > like that would work for a connect command since there's no bdev at this point,
> > and polling needs a bdev.
> 
> Thanks for pointing me in the right direction.
> I wrote a test program that exercises all the different options available.
> The crash went away once I removed "nr-poll-queues=4". 
> But this begs the question: should a user-space program be given the ability
> to crash the kernel by simply providing the wrong (or weird) arguments?

Right, we certainly don't want to let an easy kernel crash like this exist now
that we know it's there. I'm just consdering a couple different ways to fix it.
We could just reject user polling options for nvme fabrics, or we could make
polling work with just a request_queue instead of needing a bdev.

