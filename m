Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6955D6A220
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uYVgu4peGSc8IFCuBVgkgP1p/z0bW4D+Q/21V7pWkRY=; b=VL0KuNRRRWZS3WWd8eBlvynozW
	0PIuWXDYEXOMY/JDawmE03jrjmSXby0y5iLy7T8QvKC4cbjywcq7SOWUljo81ZvrmHk7N7ed5grpY
	3wymbF+7yX4xWTmN+QgzrfMVdRnrmejCZt0fC7rocGnw2rczKOhXLqB7NS2wDOM3j70h4EIX1NCHj
	i8UAwdzCoTgiC0AbvwNuMvjL7juK2N2lV7Vyt+17Skt0MggoGF92VtgIyjd6YQkwNUBtwFLjH308d
	Rd2LCXpSZ+XM/aqmBoE33XpBvHZgmXG6SFbVUXVYujCdPD0cFyLghwiSsWebeg/R5rtDEAhCBjMEH
	SKSe48Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBdfG-00000000KYx-0scN;
	Thu, 14 Nov 2024 17:29:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBdfE-00000000KXh-1Hs5
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 17:29:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 938275C60EB;
	Thu, 14 Nov 2024 17:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A21C4CECD;
	Thu, 14 Nov 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605391;
	bh=m+PEfu1/MUUh+B0Vu+eVglgUE5EGK7uE5ju0F4v7m5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pN0wijvxeJyuwRp447tnZ4hkSf27SWMU+rqjQ0GlKR2EJEPCQP6tDt6plBFNqtBme
	 xt8tSGcb5hViUyxIpCTuVd1mk2GRSnCsZf8nBCoXkTtOqSJ6cKx6rVcA0vwjQ3Gtc2
	 55dcrR9VHxgGHPWYSLExJDdjf5TSNXhCDs/zIWSCjkvbUPYILn3bWY7TwywBo+zFzt
	 XKdJhy2/pzXpyONRmd8jpWdvRbf8g5eJvFJv56Wx5TD/SMC8POG6GrkMWk5y6UpNdy
	 ccVia9IPaaPNBxXD0SveZn36HJwHVrzMU+xC11xF4L9L9PluAwDHKZ5DfKCjFCub64
	 dF2asrddQMP3Q==
Date: Thu, 14 Nov 2024 10:29:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <ZzYzjFBr2WH5rvjN@kbusch-mbp>
References: <20241112210620.2650523-1-kbusch@meta.com>
 <20241112210620.2650523-3-kbusch@meta.com>
 <20241113045859.GC20379@lst.de>
 <ZzTKORM566PReqHI@kbusch-mbp>
 <20241114055642.GB10948@lst.de>
 <ZzYdDSNpH99YHJvb@kbusch-mbp>
 <20241114164245.GA4132@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114164245.GA4132@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_092952_383763_B683FFDC 
X-CRM114-Status: GOOD (  17.23  )
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

On Thu, Nov 14, 2024 at 05:42:45PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 08:53:49AM -0700, Keith Busch wrote:
> > Only admin users can access this path by default. You have to opt-in for
> > it, so it's not exploitable unless you ask for it.
> 
> We do allow non-privileged users to send I/O commands and a small
> whitelist of admin commands by default, limited by the CSE effects.

Not if you can't open the device. The default access permissions don't
allow non-priviledged users.
 
> > I can't see disabling
> > the interface entirely. In a previous version of this patch, I had the
> > kernel tainted if you tried to do passthrough without SGL support. Would
> > that be a fair compromise if I reintroduce that behavior?
> 
> Taint might be a bit too strong, but a one-time message in the log might
> be useful.

Sounds good to me.

