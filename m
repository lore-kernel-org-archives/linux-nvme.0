Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A779C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnxhluBU+Ereeu9Ponp94hPIb8erFcKStbUETvq8ITk=; b=QYSzdNaxKcuCsalfng/+aq5Vd4
	h5a7eZF/yjpPnLheng5BzJS0jlvEULocUENXMibkaNpGwi6F/fw4fcc9zFFA+OxTgraXfZeH+GdDq
	HoYcmJCFN7HEnI7ATN+OGhFhz8PYGxk2KfKCC5ulNbBRaOXb9DH9nP3HLAaw9Hm1fhgEd5jqgLk50
	oiX1XK246z5usrPTeWka3WQX6NKe1DTfgXkfcgMzAxt8gGwq2Ubbun8xxytnkm6hALIkso9Rnra4D
	vF/OZZRcUDnaEMEqIFdXwXdLgtq9Ry9jjt2iJZfrd2Uz3U7vKoFXc3jQGSNmfh+xXXJEqaAFnZ9xT
	zJINyYhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNfDn-006Ygj-BS; Fri, 25 Feb 2022 18:21:39 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNes0-006Pek-G6
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 17:59:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0C6BDB832FE;
 Fri, 25 Feb 2022 17:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0965C340E7;
 Fri, 25 Feb 2022 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645811946;
 bh=tqc87Jy4ydsthmHNaKwH8I98BKpZjOMSiFRz9wHyYgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kFKp/oDX2779xseQ5UvOePNjeNUSgFLuUU5hKUewA+RYdKtMOqBNiDyBWzdthk6UN
 YzXFA6KqQ/ufXCaSrEkdfVgAGviykqebdaMckEyqVxpmCkxAmD9NDlwmk0Sv8DXF7c
 Bpxjd3w8yH8zXTCI4u4n5H94XuU5Ijjy8OxSWN2etguwPI93ao+pT6bL1occl1L5Je
 JMQGvk9mB0+HBDKNgyPK9yIXbqBglj5r1BnmjxSidOcT2Nc/LDiyUbY1wl2Va+KKZA
 uxl3Vyc6rRoO9dv6ZGZDzCbsz+BSQdtHA9f3/NMtqtle2V9Kj1VIAm+8Yo0wJCmUTd
 iHKOP5pnfyOOg==
Date: Fri, 25 Feb 2022 09:59:03 -0800
From: Keith Busch <kbusch@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 martin.petersen@oracle.com, colyli@suse.de,
 Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
Message-ID: <20220225175903.GC4111669@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-4-kbusch@kernel.org>
 <20220225160300.GC13610@lst.de>
 <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_095908_768214_83F58DC4 
X-CRM114-Status: GOOD (  16.33  )
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

On Fri, Feb 25, 2022 at 09:53:11AM -0800, Joe Perches wrote:
> On Fri, 2022-02-25 at 17:03 +0100, Christoph Hellwig wrote:
> > On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> > > The NVMe protocol extended the data integrity fields with unaligned
> > > 48-bit reference tags. Provide some helper accessors in
> > > preparation for these.
> > > 
> > > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Perhaps for completeness this should also add the le48 variants
> like the 24 bit accessors above this.

I don't know of a user for le48 at this time, and kernel API's without
users often get culled. If you think it's useful, though, I can
certainly include it.

