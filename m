Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D1C10DCE
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/tBBk9craj+FD/yNXPVyO3O0Eh8Y6pNkwwHNA3G6nU=; b=hphaRoW6ORRg+uSs+7VT76IC/J
	cmMjqtI471qI+KZrS2/mBNHsULT0wPRdZH9n7GcBbyM7KbHzIU3MKusOlZ5r2lx2fYNJoZwbv1EZ0
	rCL5nioqfVdfnKzdJvTD7WIesxhvIGAm7Vlvp1pL8n/4g9E+NUfNjFGirVFnOoHuZrFX6RX3d8wds
	+CaT3kSGEGXdDGC9n5yoMl2cDzAUTBsjjz9uVEobtI+iwYfGCIxGhAVIvBdHJ71wIFY3OoL503pA4
	1hy2oymdwDFcRZX9ycClAgTMhGdAanvP3EUtGsLrxMgCuBGgVNVy2wMo89hjb2+GdJufhR/Ircy1t
	kB1CYQxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAA3F-004nBj-0k;
	Mon, 04 Dec 2023 14:36:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAA3C-004nAj-0S
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 14:35:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD8BA227A8E; Mon,  4 Dec 2023 15:35:52 +0100 (CET)
Date: Mon, 4 Dec 2023 15:35:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Message-ID: <20231204143552.GA30918@lst.de>
References: <20231130201919.2486553-1-kbusch@meta.com> <20231204083034.GA32360@lst.de> <ZW3jHePnYN_m7OU7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW3jHePnYN_m7OU7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_063558_327225_572A51FA 
X-CRM114-Status: GOOD (  17.07  )
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

On Mon, Dec 04, 2023 at 07:33:01AM -0700, Keith Busch wrote:
> On Mon, Dec 04, 2023 at 09:30:34AM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 30, 2023 at 12:19:19PM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > This can be an expensive call on some distros.
> > 
> > Huh?  How would a distro matter for kernel code?
> 
> Security monitoring: audit, LSM, and bpf hooks all make this function
> undesirable for a fast path check.

So what matters is kernel configuration, not "distro".

