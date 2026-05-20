Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4407ECD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T45+ITuGycMs1FD2QyVsalQe29yM+1XXtMPeU+HAl9I=; b=z+AcHj+ve3m0WKMfC0UY3/JyDg
	bt0OuUedZjTe3WZD5AB4FsFCnlJbB1oR8RRlk+VK5FRa7RljKDp73H1hqwkWcteALxgxmNBymIQvh
	27shZJ0GGNWBeYPsKB1tMgbcWJoZYhDmuFhM/GMxgqvA43BbeW0Kx90beJj1/9wWyZw1IiahfL/np
	9KxxKEXCCw+Qzr3Sq734/V3tOA5MWvFIVt1lVYjw7KfHmSid/q5d/Zko/rC7BumGQ9Xn+BFl7z/5d
	hn8RCqPA8eKY2/Yv8ZY4B7Z4v7ZCo0TxxYtiOvxFNA55DxWDL0fpkJXTxzegdcRMSA1zOSrAHNlSr
	p3NHmfyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPiWY-00000004v59-3Ldc;
	Wed, 20 May 2026 15:07:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPiWW-00000004v4C-1JBF
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 15:07:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A38CD412EB;
	Wed, 20 May 2026 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D551F000E9;
	Wed, 20 May 2026 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289671;
	bh=T45+ITuGycMs1FD2QyVsalQe29yM+1XXtMPeU+HAl9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b9s7TLcWnSjFzaGVGi5BPYO/oGSLu4+c3z4MEh55zX9F7aKiJa9qeNU6F+W6NpDDq
	 5kICPbiaLOrnH7Y0462st1tCLeMmmwk1w32e3VeFeDK/xqwjgIsIhMq9Z76d+uH5Yl
	 nDpIpTOFfVpMUW6LKXTxm8fowbezf/A4cKaWa9vdLSsdClobZL6uwC/d+O36zEc2Ie
	 FW3zxtdF3YYor/kSuwRSLr/oYH50kD6Njd2nsLkAWPsl7hYBvxY1gxWlNf5vgHooqI
	 YQV00w+mh8SQJnmV/zechlNShA4HfHPFxGIfj2+1UttrduOTSfxlObS9T0NTgPT0X6
	 9z+YvhGCydU1Q==
Date: Wed, 20 May 2026 09:07:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <ag3ORafKCTyn7TBA@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-6-kbusch@meta.com>
 <20260520072746.GD14937@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520072746.GD14937@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_080752_371005_EEE0A280 
X-CRM114-Status: GOOD (  22.76  )
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

On Wed, May 20, 2026 at 09:27:46AM +0200, Christoph Hellwig wrote:
> On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The nvme driver has long utilized a zero capacity to indicate the path
> > isn't reachable, which creates a race condition with IO dispatch when
> > paths are being detached on a live system: when the block layer rejects
> > a bio early due to a capacity check failure, drivers with multipath
> > support using the original bio have no interception point to redirect
> > the bio to another path.
>
> Trying to reverse-engineer - the problem is that the block-layer
> code catches being beyond the capacity and directly completes the bio,
> right?

Yes, and in the case being addressed here, the "zero capacity" setting
is path specific, hence the driver wants to attempt a failover. I
imagine general capacity violations are not path specific though, so
this is kind of a weird case.

> IMHO the right fix is to get rid of the capacity hacks, and have a flag
> we can catch in the nvme driver and complete through the mechanisms.

Sure. I think we can at least remove the unconditional set_capacity(0)
from the nvme driver because the block layer generically does that if
we've done a surprise removal on the namespace's disk.

As to removing the hack from the block layer too, it's been a while, but
I recall it was the easiest way to get forward progress for some
degenerate case of continuously attempting to sync dirty pages. But
maybe we don't need it anymore: it looks like there are more checks on
the GD_DEAD that might make that whole capacity trick unnecessary. I'll
try to whip up a quick test to verify.

