Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB675C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmeUn7VDiq63Gkbx4wOoF1mT1K+eGEhEhLD1Ky6JPpY=; b=cNJ5FlE+poI4xLUgtk/5TUQX3K
	/dgIS/gOwHIcd4fT2FLplCRxsqx05zZqQh8sDc5KLkfRz3FowLvS4GZKxLXgUuw5Ax8eEu6EiHj1v
	Jn+zsKjAy4OUb1wR7vuDE7hgpttllKvIaQL0evIWYc/Hb91Od1un8HHBT+cm4JXdPSnU1EOlMyVsu
	lAC0vgxLoMKoMGLWX3Qz+XEINJjsKOOo6WdzUofZIY6dW9WSOytKNp4wH8cssfRz1658SLtQVFZt8
	cac3FhCW6l2rzR86ulaRbkwsx7pLEgF4PEBj2k0laKy2GlpE/S99f6m2O1aRu3kf3ZeRVpDZNl+Zw
	0B/BQ2Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEda-00000004uDm-3lPb;
	Wed, 31 Jan 2024 17:44:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVEdY-00000004uC1-0Q8R
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:44:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DB852CE1DC0;
	Wed, 31 Jan 2024 17:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138DC433C7;
	Wed, 31 Jan 2024 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706723072;
	bh=IhbssACKJ6bbGjEfKqH6OrV56/EZX7aHwtSnjlNeiN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hm5vMz/MJTAoRVewFJIuWPPK3SEIUgWpLRsLeS6t1dP3MMaFWr/EtlBAG7sYR5kQc
	 w8AARUimTrqij9x3BnxbCdBnZZ3RTirow1QvoLy3z/RLOtcHsQ+Hukh9NsJQWRUKy9
	 WWxEO0P1sorKfe4jTzuMYiPJ72FM1xjBeMAiybDQtQ+tCBuzWg1Rg5ZtB+7UQAx+LO
	 Fhy01PmxhxRVjNe4tMrAZR0suHXdfFqr/3OTJcqkis1hkbmr0MbtUEk3yxQE6y+YSi
	 TB9SPReM4ALamtWTfaZiVPw5+68Nxt+9dqcNrbLcbx0YpFnaiYqu2JjbLjB+RNUlpC
	 /cwodAMIROWkg==
Date: Wed, 31 Jan 2024 10:44:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 0/3] Block integrity with flexibile-offset PI
Message-ID: <ZbqG_YswNw1OL6ke@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240130171918epcas5p3cd0e3e9c7fb9a74c8464b06779c378ea@epcas5p3.samsung.com>
 <20240130171206.4845-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_094436_329918_214B67CD 
X-CRM114-Status: GOOD (  11.40  )
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

On Tue, Jan 30, 2024 at 10:42:03PM +0530, Kanchan Joshi wrote:
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
> 
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.
> 
> This helps to
> (i) enable the more common case for NVMe (PI in last bytes is the norm)
> (ii) reduce nop profile users (tried by Jens recently [1]).
> 
> /* For NS 4K+16b, 8b PI, last bytes */
> Before:
> # cat /sys/block/nvme0n1/integrity/format
> nop
> 
> After:
> # cat /sys/block/nvme0n1/integrity/format
> T10-DIF-TYPE1-CRC

Your series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

While reviewing, I realized O_DIRECT with DMA aligned offsets smaller
than block sized offsets can create segments that break PI iterations.
Not your problem, just mentioning it because I noticed ... and since I
introduced DMA aligned offsets, I should probably take a shot at fixing
that.

