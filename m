Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EB6FF885A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgWNFUfgbNm6LWUwYHsU95msasZEsZ6bCwGdVOeL5vg=; b=A6w+yPhjbN9XZ1IqPSP5shnabp
	uYgHA+wvomOeG68UTJGqPP30spl+PSt5GW1MnmvXBkE2ecqAf3hRWRGQmKxE49WJh5KXeM+jtNI7u
	7mnMhLXoBri0NhjD4rgFNxWYOlYUref0jPLEENyw//ZC7Z5MVfetSzuWDU7+wBSZX0rCg38c1B+B0
	jPb/8dP5WuAcQwZRtIFCjTzuQI7ynhLd6cPBu68pk7w8nJWKIU9An695qwH0s/adRnMArvAFETdgA
	b9NbKAEa2viDAF4dq+YYAL3/mXb6Bga+ak1Xvr2DRE64CErMWf2UwOUvwKWRu+sz0BxlEwSnZI9Og
	Taye2UDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcIL-00000000eTq-01qA;
	Tue, 28 Apr 2026 06:51:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcIJ-00000000eTQ-0abl
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 06:51:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C530C4051C;
	Tue, 28 Apr 2026 06:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BCC2BCAF;
	Tue, 28 Apr 2026 06:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777359102;
	bh=XrGo2Yu6qE+gq8waaK4MHiUOfIoDRMYxz/uWM/EtO8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsohnjH1/g3lzpp3EOoivsv618TBmM/sqfWrHIn+etC4EWOt+qM+Ti0boAcm7b6cT
	 VQvSnNL8ef4PnFfmmX8cr1Z0dvorhhZe4RXJMBhhLRmMpJ/rBIQMCg9cAM6OSINxlD
	 5fMwOUzXG3qiIzm3OGpy9tckykgz0js06G1bGTlw3ol7pn9BSV4iyQxhWCDfKzLUd5
	 LEuXZKAvQGFKAmUo+dBkoXz0z/2+pENxGzWN8gdO1ygdr0F3PRsq7a/99w6VeyCFhz
	 /DhZWDDVezeL/xtR47mAf92FGJK7SRHgBi66c0RfsIxiy4yorBdIeIOXBSb27npdV9
	 d9m9PdPglOrsQ==
Date: Tue, 28 Apr 2026 07:51:39 +0100
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
Message-ID: <afBY-0abdJwOfwxs@kbusch-mbp.client.m3-hotspots.de>
References: <20260425130426.10061-1-ikegami.t@gmail.com>
 <20260425130426.10061-3-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425130426.10061-3-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_235143_226893_472E85A8 
X-CRM114-Status: GOOD (  13.73  )
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

On Sat, Apr 25, 2026 at 10:04:13PM +0900, Tokunori Ikegami wrote:
> This is to make sure scan_work done for the commands.
> Since nvme_passthru_end called when effects set.
> Also scan_work is flushed when NIC or NCC effects set.
> 
> The change is to improvement the scan_work to make sure.
> Always do scan for the ns_mgmt and ns_attach commands.
> All drives supporting ns_mgmt and ns_attach should have the entries.
> But no need to be depended on it as always do scan.

I suppose that's why the "known_effects" exists, but it'd be
dissappointing if we really need this. The other opcodes in there
existed before the Command Effects Log was created, so understandable
that controllers may not implement it. But NS management/attach were
introduced after the log, and there is also the AEN that the driver
could rescan on receipt, so it's doubly bad if a controller
implementation really needs this.

