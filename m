Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E8EE57C0
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZu8AW0BeVf37W1CKuToQnEcN6erfZui2kj8yTIDt0U=; b=AaDjyoPIyFUV5csLIuXVRcvpxL
	yfXCEzpa7ojQUVSHq/JDRt9kUGSYNjKeMR7ayWvAe7g7YLwRnALFi2vF3ddV0gVm8kF64QAMhs+ZV
	1Blna3UpCrgIIVDNxE8D+tSQQX4VU84sWmnX4Pu6Q/+SP/H2FLeZulH3afrkcZjDFO0gh/kAC9dbS
	WdM66djXeHRpgqKqR8EVHjPtrS+1yye4gp4dWVrD/RsUy64VcL8sMOBBAEzERKTqObuWJ0MUkKVJf
	sbvNWegiY2htFNdJVIKZmLjlCIvMX+og5fe1gPulI8UwCDd5lL2lTo2/BeyJdLFtSdKA7IiqQu5Rf
	mMnqh2jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPAy-0000000A84M-3QSr;
	Wed, 11 Sep 2024 15:22:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soP7L-0000000A6i5-33Md
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 15:18:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A84605C0295;
	Wed, 11 Sep 2024 15:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584A3C4CEC5;
	Wed, 11 Sep 2024 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067930;
	bh=ccPusGui9l+4uHYSFKd64E0OMOr0AoqgldLtmLoEqYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqDcy7TJbQkf745PlXaAf/KeypPhhV5acD0o717aenLvheqSeXY3kLogzRjx6H5+9
	 TKZdRjlLyo/SF4rG5N4gr/KJGpVqIxTZRa7nkUrLXjIsolhy+vn9cNSOf7FW0vSTe5
	 mfgafYzdtGx6WjkZCJ1GWJ4DWZ7O9/HTPy6QRiwfVC2qYPDHnnWfa4SubT0DbFXLRi
	 ocuF8+/TLMd+jfSrxvgQiJhk1jyBLdymctdkPFpyAjeeDDiN9GWS5KS89VValAwfaG
	 ohskAH93ZjMc2eqdJ0lNbQI9EV5J4j1e6fU9DuJ4gUTJmN8vab9wRcgVuOpTdOUJdG
	 IdveCmvioaA9A==
Date: Wed, 11 Sep 2024 09:18:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 08/10] blk-integrity: remove inappropriate limit checks
Message-ID: <ZuG02LcaQwo9cK2a@kbusch-mbp.dhcp.thefacebook.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-9-kbusch@meta.com>
 <20240910154526.GH23805@lst.de>
 <ZuBx9blCTUvsS6yq@kbusch-mbp>
 <20240911081846.GB7372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911081846.GB7372@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_081851_830649_A8C028AC 
X-CRM114-Status: GOOD (  20.22  )
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

On Wed, Sep 11, 2024 at 10:18:46AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 10:21:09AM -0600, Keith Busch wrote:
> > I was hoping to not introduce another queue limit for the metadata
> > virt_boundary_mask. We could remove the virt_boundary from the NVMe PCI
> > driver if it supports SGL's and then we're fine. But we're commiting to
> > that data format for all IO even if PRP might have been more efficient.
> > That might be alright, though.
> 
> The real question is if we actually want that.  If we want to take
> fully advantage of the new dma mapping API that Leon is proposing we'd
> need to impose a similar limit.  And a lot of these super tiny SGL
> segments probably aren't very efficient to start with.  Something that
> bounce buffers a page worth of PI tuples might end up beeing more
> efficient in the end.

Yes, a bounce buffer is more efficient for the device side of the
transaction. We have the infrastructure for it when the integrity data
comes from user space addresses, so I suppose we could introduce a "kern"
equivalent.

But currently, instead of many small SGL's stiched together in a single
command, we have the same small SGLs in their own commands. I think this
patch set is a step in the right direction, and doesn't preclude bounce
optimizations.

