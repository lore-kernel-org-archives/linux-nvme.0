Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4kQ1AcrE2E0uLZC1B2QzKk7ztwYpkS8vXNyKhHiL4g=; b=o42vZv0JpsNuKMC0rymtf4+mtz
	ltuxlXA2b+u1pFqi/vdHInbfWn3HODcosnqcEsHP0TxMm1QcSKSNKS8G8PRo/50UNpxka5aKqhi3S
	HTCqmVXJW6NM6DHKWqJRFYTWlh0rDcNa2D2By4tCL/HTdfHAyROPPkYQNljeBHMct9R0WzIr3Za/u
	nGvqHoHpdm9EBlwBxH+8iA/56RRGSGNxy8lzLI6zfjLGr+vhVMewDSoTS8sZRtdRzLDLGx6+oZGJW
	w7LlrDEt465najPZCseUVoaiE+TTrWKNw2BILwr2O/72EFEkLRcI8LVfOSehkygpo/LFbGsYRQXhi
	60JAv4+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwPQx-00Giqd-C8; Wed, 01 Jun 2022 14:34:51 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwPKw-00Gfvw-3v
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 14:28:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9A3B8B8190F;
	Wed,  1 Jun 2022 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726A0C385B8;
	Wed,  1 Jun 2022 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654093715;
	bh=Ec+zMVVKrO00wokaNCpHD7B2w9xPUMaWVPh3i5kRk/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQMzxI85XfijhGCJjmQB3WIT5rNx6fMwGub/IZd5uRVMkJ4POuA5V2GYRreQfi5V3
	 Gv9KgKeR7hO/S9+i7QOcekhbAEY0SEmks6JMIqFOQb+jk0PxtqefWvXxoy1tsoebUO
	 rQKOlA4Gvu1nWUQQrbPyrN4iVpR9WXuZRxYlAEJxFJWtOUM1DHBknDgbcu1gFi65PL
	 /JuLOlIV7t94R1CF5VdBr0aGP5PUHSjMIc6YK0COHtQWaftZdaZ0hR/eaXb0A4h3NV
	 ty7YXBL8VtTFJxURMBmem7iU0O/UbwSHZq0neEpjGH2EbfnTaQxk5dtaCiB85YYLQa
	 xXzNmNSIzxk8Q==
Date: Wed, 1 Jun 2022 08:28:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
	pankydev8@gmail.com
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <YpcRLKwZpN+NQRxn@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcRLKwZpN+NQRxn@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_072838_477611_A9CDF0A2 
X-CRM114-Status: GOOD (  24.35  )
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

On Wed, Jun 01, 2022 at 12:11:40AM -0700, Eric Biggers wrote:
> On Tue, May 31, 2022 at 12:11:26PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The most significant change from v4 is the alignment is now checked
> > prior to building the bio. This gets the expected EINVAL error for
> > misaligned userspace iovecs in all cases now (Eric Biggers).
> > 
> > I've removed the legacy fs change, so only iomap filesystems get to use
> > this alignement capability (Christoph Hellwig).
> > 
> > The block fops check for alignment returns a bool now (Damien).
> > 
> > Adjusted some comments, docs, and other minor style issues.
> > 
> > Reviews added for unchanged or trivially changed patches, removed
> > reviews for ones that changed more significantly.
> > 
> > As before, I tested using 'fio' with forced misaligned user buffers on
> > raw block, xfs, and ext4 (example raw block profile below).
> > 
> 
> I still don't think you've taken care of all the assumptions that bv_len is a
> multiple of logical block size, or at least SECTOR_SIZE.  Try this:
> 
> 	git grep -E 'bv_len (>>|/)'

There are only 8 drivers that set the request_queue's dma alignment, which are
the only ones that could be affected from this patch series. The drivers
returned from the above don't set dma alignment, so they're fine to assume
those lengths.

I don't think the above query captures enough since it misses things like
nfhd_submit_bio() that shifts 9 on the following line. Not that that example
matters either for the same reason.
 
> Also:
> 
> 	git grep '<.*bv_len;'
>
> Also take a look at bio_for_each_segment(), specifically how iter->bi_sector is
> updated.

I'm not finding any driver user of this macro that's set the dma alignment
where this would break. They either never set it, or they're stacking drivers
that always get the safe default.

Outside drivers, blk-integrity doesn't operate on sector lengths, so that's
fine, and blk-crypto would prevent such unalignment much earlier. And btrfs
bounces this type of direct IO, so that's also fine.

Even if we assume all the existing users are safe, I suppose we could say this
type of assumption is potentially fragile. For example, I think drivers like
pmem or null_blk could readily reduce their queue's dma alignment limit, but
that may break their current usage.

