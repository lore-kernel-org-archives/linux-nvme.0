Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74173D1715C
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wnkwLCM3TBlG97SLJcn9tNUhJLvVWqxGx4qZDf0GEw=; b=1/+I0EpaG03RLPutkqtfUSTVm+
	sJ2k3ACfMekzlFJ2d5V9RCbx+Gfqrl4kuwBH1NqDnjh53h/sUxpbnKYnIx60Nb2kK/Yco+dPs58HM
	YrC3Lf08aEjJKPeKyFAaXhzzJsm4RcX/PIB4Msuzo7XMq/kJYuYNBkme0ul//YOuVsKLYXYrK4m0s
	++l8DY9F9HqvQ0g8WKWNh39f6IiFc8mKVxXHEzkNsNsnmH70FGh0dLhMQK7lTwXRkmkU700TjMeBg
	IuetKUAGTYxG5Sd/EZPBL7KS683VB3HzXFZHkXBNcE7zjh+Ov0Jxo4pzwzIPaX2YBUW21ypCBp3DV
	TnM5JAJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t35My-00000009P2N-1O40;
	Tue, 22 Oct 2024 03:15:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t34Ic-00000009HqX-0vwG
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 02:07:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D2725C4963;
	Tue, 22 Oct 2024 02:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4DEC4CEC3;
	Tue, 22 Oct 2024 02:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729562825;
	bh=vK7BuUmQSfhY5BYyxBJktKZo2vYB27zhwicGS79m0G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+f2w2Gr6/bc5mZ3ZiKNtBXS3Q0acbSn9NV09to14aPYdBYEcuoY376iNVR+BX2B3
	 xalJmQK8X+W5BjfygL3F7GE58jsEf4+hYw8U63gcrupOkrhCiGYD6He+YFmJk9dPOv
	 60vNsXeIPqd8ipadD+cwAIieAj1UXppS1dyPJ7zkJ66zvQ/8FVudymFEP68BT1Yre8
	 UrQmQIKUo4NqhA2/mFr5eQoLako6VgGPTRIeCHYx4S0CutvZxdbnpyFTjxubfWmiyN
	 OpLPLX8jH5pIEKULl0f3GTjG9Uz0m4rVTBkkaXxAy5njCm6QY1HEQeY17WoSqc9J+S
	 oE1VRB77aE6hQ==
Date: Mon, 21 Oct 2024 20:07:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <ZxcIxhQMYt2fsPiY@kbusch-mbp>
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <ZxbWxuzH3u6hAezr@kbusch-mbp>
 <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_190706_330369_7EEFCEAA 
X-CRM114-Status: GOOD (  19.60  )
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

On Tue, Oct 22, 2024 at 09:43:01AM +0800, Guixin Liu wrote:
> 
> 在 2024/10/22 06:33, Keith Busch 写道:
> > On Mon, Oct 21, 2024 at 07:03:31PM +0800, Guixin Liu wrote:
> > > new file mode 100644
> > > index 000000000000..aa69656a0ac5
> > > --- /dev/null
> > > +++ b/drivers/nvme/target/pr.c
> > > @@ -0,0 +1,1186 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * NVMe over Fabrics Persist Reservation.
> > > + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
> > > + * All rights reserved.
> > > + */
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +#include <linux/unaligned.h>
> > I don't find any such file. Should this must have said <asm/unaligned.h>
> > instead? Curious to know if the target side was actually tested.
> 
> New 6.12-rc2 add a commit 5f60d5f6bbc12e782fac78110b0ee62698f3b576("move
> asm/unaligned.h to linux/unaligned.h"), I change my code to fit this.
> 
> You can find the discission in v14.

I see, thank you for the clarification. I hadn't been paying close
enough attention at that discussion.

So, minor problem here. This new feature is 6.13 material, but our
upstream block branch has forked before that commit. IMO, I feel
introducing that header movement after the merge window is poorly
timed...

Anyway, I don't think I can get away with something this large in 6.12,
so it's going to have to be in our second 6.13 nvme pull request after
the next rebase. I've set myself a reminder to merge this when that
happens.

Thanks!

