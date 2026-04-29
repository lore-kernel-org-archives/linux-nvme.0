Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965BFFF8867
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 08:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8huIk9xNESBV/CcjbIBRoQKHf1H5YEcM9t01nXJOCQg=; b=D78vevkGmmohA3z8u87BbbZfgd
	N3UFPZXATu5Z90w/IoS3RpizoQ7NxpK1qP/uZ9O2cn+1TIXN8WzcgM+2T6C/95FqyYVZPn4PDktRG
	cewPmH9iCjDc873WdjT9EbkKnFFZI+7T7whi8t4fpfbs1+g/Tm2Hku8xpWnlm5xCyobEeeDh6QoaK
	Y5TAZO9veyr2HqB/R/vS181PgDx5FT54Lr8hexmm+ZGvz+X+aweimLYxzWANu5SF81mmJaV4211Pn
	f08uRK3nCJXCwxI4sGfbrMvpf2CLNKgRLOAhR3fbI4GAX2/wt/mi89OtOSEczBnvWrVkgCM68APck
	E5gIEDfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI0bD-00000003G4i-2JlU;
	Wed, 29 Apr 2026 08:48:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI0bB-00000003G4E-1OpD
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 08:48:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 33C1F41B03;
	Wed, 29 Apr 2026 08:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D707C19425;
	Wed, 29 Apr 2026 08:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452526;
	bh=3/m5e8jUbDhKgZ4gOnrx/zL6UuszxyVdDqcbQbTtPe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JW61SClBmmQTrLmKKtqlE0awxa6SH9TyZJ/1Q5qyZChRPq0yEmMf19Sx16Qeqd81B
	 bMRTh4AVvrEMa/CzlMBUiQG9zJXRkwUxhBp78/pQuqtnieoTkUifeed0teuHAUh7Wy
	 w54v3P0IITijigZPV7KE4X/I5yvcQEhcppE+8v277Xt2BwPDDN36yBcaRipzZ5MG63
	 mvyPZctSr/JRLc5YIJ6IF3aDMPdy6pL749/akNnrVrQf+56MOVFZuDzYjgjOZnsWE8
	 SmmubEbP6uFoKlec8znhtDoW8w3YQOlfmlglVk6iGRGREZBsYzxczNKOmB3fg58MUX
	 zoRWg5wQyfkDg==
Date: Wed, 29 Apr 2026 09:48:40 +0100
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
Message-ID: <afHF6FJAPbDXAniR@kbusch-mbp.client.m3-hotspots.de>
References: <20260425130426.10061-1-ikegami.t@gmail.com>
 <20260425130426.10061-3-ikegami.t@gmail.com>
 <afBY-0abdJwOfwxs@kbusch-mbp.client.m3-hotspots.de>
 <56500e42-51c6-4be9-aff1-f11b45c47b13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56500e42-51c6-4be9-aff1-f11b45c47b13@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_014849_420486_88C831C7 
X-CRM114-Status: GOOD (  20.44  )
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

On Wed, Apr 29, 2026 at 03:08:59PM +0900, Tokunori Ikegami wrote:
> On 2026/04/28 15:51, Keith Busch wrote:
> > I suppose that's why the "known_effects" exists, but it'd be
> > dissappointing if we really need this. The other opcodes in there
> > existed before the Command Effects Log was created, so understandable
> > that controllers may not implement it. But NS management/attach were
> > introduced after the log, and there is also the AEN that the driver
> > could rescan on receipt, so it's doubly bad if a controller
> > implementation really needs this.
> 
> Just rechecked the specification again then the log page identifier:
> commands supported and effects mentioned is optional for NVM express
> revision 1.4 and earlier then for the older controller the changes not bad I
> think.

Yes, but the namespace management commands are also optional, so it
sounds weird to me for an implementation to choose to support the
optional command that's more difficult to do and skip the easy log page
that advertises support for it.

> By the way about the scan_work executions for the command effects log and
> AEN I thought it is better to be handled only once but I do not have an
> actual idea for the exclusive control.

You can attach namespaces to controllers driven by a different host, so
the AEN is the only way to trigger a rescan in such a scenario without
admin intervention. An extra scan_work is otherwise harmless, I don't
see a particular need to introduce a mechanism to avoid it.

