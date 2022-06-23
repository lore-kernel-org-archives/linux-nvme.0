Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BDCC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/KFkIhiecrBLwbPNmjF96yk1Vr8cHUaak1OIrOT6j0=; b=VqKVfFEF0qXJGLN5eJOPXuqI5K
	Z11l/36JB+/1LLeE2wZijKjM9zhgnN6vyKeuqt5n4DsKM9O4GCCZHnW4okoSxLo5vybB6N4aSelKw
	zThKDoxtSdPL3BaarxO3NreHEz6yQu3wsAfnvUJweICfpkONQ3RMKEeqZ1LOM5+NKWonHY9/LArkg
	4SDHP9VTxRjpHx35iDGa3N+6BphTZFFx715555I9PYfa2hWFm+suw0OtymDXOBuynO+uZU9CVHeUz
	9rIsAWwUB0UvmDHBuFDkbQ43RBYWV82fhJ/7N0Vl1C09UKpqLHFPZ3J570DiH+1xxKDb7SJzgb7Vg
	jxQ6pw9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4SFJ-00GRmT-Bx; Thu, 23 Jun 2022 19:12:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4SFG-00GRlW-AI
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 19:12:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE7960F06;
	Thu, 23 Jun 2022 19:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB333C341C0;
	Thu, 23 Jun 2022 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656011520;
	bh=2vFS5ecHYj7lFUc7JnMpmVqJneVrPDUFMqR3YyGroMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dglapzEvUizu4TJLaOScyRQb674dhVNYAwjiELs76w3pGcYX8SsrULa3MSpyJZWjK
	 oG5vwu/O8N4r5pTVvFrdw4knikfA3RoLKzIDn1FHYLSz9F22Me7u9O2Y7m5fzr/gta
	 4rYtJZDLSInC7tRUjsJKjTbGZJzNLZWdVg37zh0RJ7k2lbJb9vtYdlGPid0w2d3meJ
	 UATjOKK5xij1Oii0yIF8aNW8gBkiP6H7rI+xVIyfTjTxrFXGiH94XcXAXmGVUzrMwO
	 ruCxSPhOTaKCFakDxlc9AN8MexKuBY+8GzRYiA5qBYzRhy6/e4vNdzaAYmeXW4JwwL
	 vXFky3n51iGVg==
Date: Thu, 23 Jun 2022 13:11:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrS6/chZXbHsrAS8@kbusch-mbp>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrS2HLsYOe7vnbPG@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_121202_432861_50196A0E 
X-CRM114-Status: GOOD (  27.61  )
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

On Thu, Jun 23, 2022 at 12:51:08PM -0600, Keith Busch wrote:
> On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> > On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the address alignment requirements from the block_device for
> > > direct
> > > io instead of requiring addresses be aligned to the block size.
> > 
> > Hi Keith,
> > 
> > Our s390 PV guests recently started failing to boot from a -next host,
> > and git blame brought me here.
> > 
> > As near as I have been able to tell, we start tripping up on this code
> > from patch 9 [1] that gets invoked with this patch:
> > 
> > >	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> > >		size_t len = i->iov[k].iov_len - skip;
> > >
> > >		if (len > size)
> > >			len = size;
> > >		if (len & len_mask)
> > >			return false;
> > 
> > The iovec we're failing on has two segments, one with a len of x200
> > (and base of x...000) and another with a len of xe00 (and a base of
> > x...200), while len_mask is of course xfff.
> > 
> > So before I go any further on what we might have broken, do you happen
> > to have any suggestions what might be going on here, or something I
> > should try?
> 
> Thanks for the notice, sorry for the trouble. This check wasn't intended to
> have any difference from the previous code with respect to the vector lengths.
> 
> Could you tell me if you're accessing this through the block device direct-io,
> or through iomap filesystem?

If using iomap, the previous check was this:

	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
	unsigned int align = iov_iter_alignment(dio->submit.iter);
	...
	if ((pos | length | align) & ((1 << blkbits) - 1))
		return -EINVAL;

And if raw block device, it was this:

	if ((pos | iov_iter_alignment(iter)) &
	    (bdev_logical_block_size(bdev) - 1))
		return -EINVAL;

The result of "iov_iter_alignment()" would include "0xe00 | 0x200" in your
example, and checked against 0xfff should have been failing prior to this
patch. Unless I'm missing something...

