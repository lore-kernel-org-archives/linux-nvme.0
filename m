Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C4C19F2A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Aug 2022 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/V6MnTCLVoftkYF3g4ON5cGPPOU8522/Qgzg2Ih2yRc=; b=sTxTBls4jYRbon24tR3Qxf/fG5
	QMp7BT3jSO3eYMhQEkX638OO/aXO975zIeLOlJxCQKfwP+MPgq//+dgH1A4PJfSWi7qI001pj0ZUe
	cbtd4Cji6mkRhJELpZbzYZ+YUaP4WaU4MikOkpveahybHfLYXZU7Y82SKiYC0bhfFgBjb91QWg8xm
	VDxpIF4mv2GSBb5tr1WICrEH26rFMq9LFU3iPl48tkGsmMuUSTSz5VRauzaN8MbBz4dxHFFsU+sCD
	8PYdSj7lbaUcliN7JCdn9dP1/xICLif13Q5qmk1b0dPRfLcEJSU2IJWH3BclOLJKavMQruPriS5GG
	kKV2nUtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKrL3-006AFE-1C; Mon, 08 Aug 2022 01:13:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKrL1-006A9K-NR
	for linux-nvme@bombadil.infradead.org; Mon, 08 Aug 2022 01:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/V6MnTCLVoftkYF3g4ON5cGPPOU8522/Qgzg2Ih2yRc=; b=dUVXF7OA1PsGnfvhHBAojxamR7
	XKHfTtzI8McKgCPAbREShmxCdCKu+uLpO8NJFVsAEsPhrI+sZv0XgUJiCIxYMoPsLXr13VrOm4yRW
	MjOYo4f01cVIMqC5NfYrB97YJlAbQOt1rgtby+mlMoYfiHnDHg8QbxpYDn3DieMHijCbhYN2qiuBq
	IQuUrcNDPVXSozoLsRzexyhPDDTx7GfvgkKSMySLAOzQ/wWFGo9VgnZqgwZiu/2ua0yFWfu9jMEI/
	hlwxGy5m9ZuEIApzb9EI4A+BLRwgiHQYVfb3IUXRs0T0H6U23zlKvY1+p3FBwSXINw4HT+bdyfhG1
	6iAwAo2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKrKv-00DRm8-Uq; Mon, 08 Aug 2022 01:13:42 +0000
Date: Mon, 8 Aug 2022 02:13:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/7] file: add ops to dma map bvec
Message-ID: <YvBjRfy4XzzBajTX@casper.infradead.org>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220805162444.3985535-3-kbusch@fb.com>
 <20220808002124.GG3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808002124.GG3861211@dread.disaster.area>
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

On Mon, Aug 08, 2022 at 10:21:24AM +1000, Dave Chinner wrote:
> > +#ifdef CONFIG_HAS_DMA
> > +	void *(*dma_map)(struct file *, struct bio_vec *, int);
> > +	void (*dma_unmap)(struct file *, void *);
> > +#endif
> 
> This just smells wrong. Using a block layer specific construct as a
> primary file operation parameter shouts "layering violation" to me.

A bio_vec is also used for networking; it's in disguise as an skb_frag,
but it's there.

> What we really need is a callout that returns the bdevs that the
> struct file is mapped to (one, or many), so the caller can then map
> the memory addresses to the block devices itself. The caller then
> needs to do an {file, offset, len} -> {bdev, sector, count}
> translation so the io_uring code can then use the correct bdev and
> dma mappings for the file offset that the user is doing IO to/from.

I don't even know if what you're proposing is possible.  Consider a
network filesystem which might transparently be moved from one network
interface to another.  I don't even know if the filesystem would know
which network device is going to be used for the IO at the time of
IO submission.

I think a totally different model is needed where we can find out if
the bvec contains pages which are already mapped to the device, and map
them if they aren't.  That also handles a DM case where extra devices
are hot-added to a RAID, for example.

