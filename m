Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCEDC04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 23:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u30s/X7RmhRmxcRFmrm1T3EjNuuh+CudoZ1sJYEmT/8=; b=rVLWp2rLXd9leHnC/DhwvQkoef
	VX0xsazDx2p+vljz2mQBgEF5eDIyehbYEdyk+6gDX4ONK95EmD2Zmm0Ez0SLmRKLgqL7HJ1Ovdi6M
	HYa+QTpH4w9I1Gk9FmV+lkFvOgxF1AMXPYrcv2QPoBDks68jB3Eo4VdcG8PAjwuQkLvgDzuP4wem/
	rDp/fdLJQbFdzXQCWGaALmsTCVEUS2TmUJZrpLSYB2vJYUyjRurNw7SUn1r7tUXZEcxrWEy9hNJVI
	/iPFcMw4MVezf6xDZ/wrUkrv0UwXpGbHDP6oBAzAMQWwmjDhkdVj1zsjQKhxzINYXo5KRtxmL9dtH
	eRo9PEZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wV5-00000008wzJ-1mnz;
	Sat, 11 May 2024 23:51:35 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5wV2-00000008wz4-1n8l;
	Sat, 11 May 2024 23:51:32 +0000
Date: Sat, 11 May 2024 16:51:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj__oIGiY8xzrwnb@casper.infradead.org>
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

On Sun, May 12, 2024 at 12:30:40AM +0100, Matthew Wilcox wrote:
> On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
> > We can't just do this, we need to consider the actual nvme cap (test it,
> > and if it crashes and below what the page cache supports, then we have
> > to go below) and so to make the enablment easier. So we could just move
> > this to helper [0]. Then when the bdev cache patch goes through the
> > check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
> > 
> > We crash if we go above 1 MiB today, we should be able to go up to 2
> > MiB but that requires some review to see what stupid thing is getting
> > in the way.
> > 
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53
> 
> This is overengineered garbage.  What's the crash?

I had only tested it with iomap, I had not tested it with buffer-heads,
and so it would require re-testing. It's Saturday 5pm, I should be doing
something else other than being on my computer.

  Luis

