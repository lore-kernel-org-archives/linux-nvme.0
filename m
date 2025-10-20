Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F78DCCD1A7
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93p26XQfizbnLpJhMCQsb4aFzVF6+NE/4SQI5yxPHiY=; b=agbpB28TT6NnQh9zSxFSASwNVE
	kKgmeukMlMLVjmS8plLK8PZKPzsa/5nfteTkDRlyytsxjOtuXKzZfHFWvlCHMZwNaqPMJ/fMCWDVK
	RKPTLmOb00/1gh2IVybYNqsj+9Ha5RXWXmKuHo+He/I2pZ6FPGvO9tsTVQ4r9S7bF+VqabRNpBhH5
	2bNL3pe0F1XRrAwwSNg1jhUPDk2PagVtHX0Nij56IjQZ712jx1mNV2Ze4oT0YiKmaIK12JIkGU00S
	tgbtDJ0uDeaiXfRSzHulvdPRbWHRYat6+Tt7dN0FlxEibeC8IVHjs4UPtc5TgAzGEuwiPY4wYmlGI
	0PBbuNFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAuEd-0000000EZvl-2P2M;
	Mon, 20 Oct 2025 18:03:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAuEc-0000000EZvf-1z7q
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 18:03:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C105C602CB;
	Mon, 20 Oct 2025 18:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C04BC4CEFE;
	Mon, 20 Oct 2025 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983433;
	bh=gPfTcbem+uwos1X4z5XeKlfdTnX/Sws5Dxx0a/AYoRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBXkXfgwF9DVSl++Yb/oXyIvJCIGUvs/Yu9ocXxgq3PD4eUai0Y4b3PKrXLKKVJbK
	 ro6fyR6J2OEoDQt62PMB0+Q1vV0pBt2uEUWJDQH54dbLqsx+gplmh8p1vtWTcDCoUT
	 OV/AY8gIErd4Cphlq/LlXh372aI6nf6ovLN6MShg+tAg4Wl6KHw2Es7iw5Exat1DPG
	 R2bj5f4PXF8aJMg5+9mIKKW3Noxxul4QbxtYY7ToG48wKGB/PS2Xh+DpCZKzVbUKmU
	 YGpa0WSMZAZu96RP8BAXwpXCsZUSvAtjKBZyeO97EtHBxPIB3dMMuyWFM6vZxI8anY
	 WUVsa2pJ1YDSg==
Date: Mon, 20 Oct 2025 12:03:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: Metadata integrity, single segment and peer-to-peer
Message-ID: <aPZ5h3q4BRr0-C4x@kbusch-mbp>
References: <73609a88-b98f-474a-8872-673cf5ca0581@app.fastmail.com>
 <aPZrka9vQKugd-o8@kbusch-mbp>
 <e9d4d0c3-21ec-40bb-a577-8a54ef5830d1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d4d0c3-21ec-40bb-a577-8a54ef5830d1@app.fastmail.com>
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

On Mon, Oct 20, 2025 at 08:51:25PM +0300, Leon Romanovsky wrote:
> On Mon, Oct 20, 2025, at 20:04, Keith Busch wrote:
> > On Mon, Oct 20, 2025 at 02:50:04PM +0300, Leon Romanovsky wrote:
> >> Hi Keith,
> >> 
> >> I'm looking on the nvme_pci_setup_meta_mptr() implementation [1] and
> >> don't see is_pci_p2pdma_page() which exists in
> >> nvme_pci_setup_data_simple() [2]. Is it intentionally? Can single
> >> segment be p2p transfer?
> >
> > We may be calling unnecessarily dma_unmap_page in that case for mptr,
> > but I think that still works anyway.
> 
> How? dma_map_bvec() is actually dma_map_page_attrs() and that function doesn't handle PCI_P2PDMA_MAP_BUS_ADDR and PCI_P2PDMA_MAP_THRU_HOST_BRIDGE states.

Oh, I guess I'm mistaken. In that case, it wouldn't work. I'll get a
patch out to just always use blk_dma_iter instead.

