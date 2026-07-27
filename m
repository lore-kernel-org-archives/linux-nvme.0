Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F921C531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BhY9/KraQUCSXM1kTBMLeBmHA+bbILbhXU+6O9/0rFw=; b=F9i3M9sKCyHrxmJJASrRFD26fs
	FCxkggCUipfOXHXFqAHwlbdwkGLGEKeDDELIl9IHHNaxcKOzr0NwJbLvqPCmhPsMZrcUi2Y5zy0/g
	f1xKojhduuTLlSICNAGt3iDgI8nivvEzRIGFJiRYPWx/+gvdEsaAq+tqkMYIjwQifpiLZ0tSmJGxO
	jFF8yjx6xkeEnBOk16luI9bia2VuirGRhN9tQPBBLpszd7MwoGG0mM8tGLMM1hCGug0h290wT1bx3
	9Ti2ENbH/yVKBJfXz3P1fZAF9j3xe04TAfb2rd4ZchSk8u1BnNv7RWlkA7gVcwxfT453+Y1k+DKUP
	aowo8ipg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMG4-00000002yvG-1pP8;
	Mon, 27 Jul 2026 14:24:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMG3-00000002yuZ-0fhh
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 14:24:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 29118600E1;
	Mon, 27 Jul 2026 14:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABBC1F000E9;
	Mon, 27 Jul 2026 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162281;
	bh=BhY9/KraQUCSXM1kTBMLeBmHA+bbILbhXU+6O9/0rFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UUUjzyw0sVoo3QEs4Qa+UOjw54f/gV3ku3GbccoJ1eGg4z3TmwScj+3FEBmuwx6/t
	 9Tqx00yNtPP9j4u2my3Oer3Jpx8aW3PAZxBMGrmarDLjj4OjRNFuQaQdLzdZMtKkNK
	 9n2BP4327l1NAmDSRJPim9ITKT3SN3rwrCzaRO5YEvOWIWa8iPLmR1gfmuNzJ7Bshb
	 8Ftu/ePcxnx5SWBz/BSJhGRoxkBPw92CrmlKEzrEIO43zIMKUrtwTpnX4kketcBtC8
	 hHUBDjZgPJrL65iQw/lv/LJWY19boKGFoajtqAfLZ+NbHPZMUSk5+oXSWrRXbfwyKC
	 WOi1fWaP8HQIQ==
Date: Mon, 27 Jul 2026 08:24:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <amdqKEI44SKwq-K2@kbusch-mbp>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725135111.14041-3-harimishal1@gmail.com>
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

On Sat, Jul 25, 2026 at 03:51:11PM +0200, Hari Mishal wrote:
> write_stream is validated against bdev_max_write_streams() in both
> generic block direct I/O (block/fops.c) and F2FS before a bio
> carrying it is ever built, so write_stream > nr_plids shouldn't be
> reachable through any current legitimate path. The remaining users
> of bio->bi_write_stream elsewhere in the block layer only copy an
> already-validated value between bios (bio.c, blk-crypto-fallback.c)
> or compare it for merge eligibility (blk-merge.c); none of them
> introduce a new, unvalidated value.
> 
> Using WARN_ON_ONCE as the backstop for that assumption isn't worth
> it given how many deployed systems run with panic-on-warn enabled;
> the existing graceful return BLK_STS_INVAL already handles it on
> its own.

That's not a very good reason to remove a WARN_ON. You've left the check
in for a condition that should never happen, so when it does happen,
it'll be impossible to debug without the WARN.

And the WARN also annotates the branch as unlikely, which is desirable
for this case.

