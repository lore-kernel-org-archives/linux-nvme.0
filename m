Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAF606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kDWacs87
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KPcGxWktlaGg63UoR245IUkJTtv/C1wkP9UzgLCl4Ro=; b=kDWacs87X2iIYd5baEZzgq1MCj
	QvccjxrMNVAmrG+/DSpbSDkhyqEW8pWcEy4VAIJEFUHZA+OFQ26i5CE2OiHu3XxZzlBY4CapegHCN
	E3ffmb7821qguSxYv4oPd1n2wRb4Xuatt2l/fzJIOl2/LjJC66dOak94/eKf7bOk4sRVTmhrBvuoy
	JvTsyME0/nqEYFk0uGLTNrg1cQlZBgRoHflfyuErb8BboO/wXIdUpbqymYdM83WffMWEF2tffryeA
	2rUJ5wcIsZHII3A8GOIXEvI4PD/f4wDv4rK/wzV9wGy32RGJ4wMzpbhzBH3VvJ720va1EQNdR0Epd
	AWbBPR8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc15-0000000B3ER-1Oiz;
	Thu, 12 Nov 2026 21:07:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc12-0000000B3DN-15DI
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:07:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12F196732A; Thu, 12 Nov 2026 22:07:19 +0100 (CET)
Date: Thu, 12 Nov 2026 22:07:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, dlemoal@kernel.org,
	cassel@kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Alexey.Bogoslavsky@sandisk.com
Subject: Re: [PATCH RFC] PCI: Start the reset of WD PC SN730 NVMe
 controllers early
Message-ID: <20261112210718.GA11040@lst.de>
References: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_130728_452932_4A7F698B 
X-CRM114-Status: GOOD (  15.33  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 05:31:43PM +0100, Paul Menzel wrote:
> devmem, works: the driver finds CSTS.RDY clear and continues, the reset
> completed within the first poll in 29 of 30 boots (35 polls once), and
> none of the 30 boots showed a slow reset, enable or read, against 8 of
> 90 without it. The difference is not yet significant (p = 0.1).
> 
> So start the reset in a final fixup during enumeration, at 0.19 s on
> this machine, about 100 ms before nvme probes, which overlaps a slow
> reset with the remaining kernel initialization and the module loading,
> and costs nothing for fast ones.

Umm, no.  PCI quirks are not a way to speed up slow device
initialization, which while annoying is not a bug per se.


