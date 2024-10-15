Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6651CFC277
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EOK9/UnCdU8avNRn1xq3SsbFfmJsuGMQM1ypFjGu1CI=; b=3x7/dV48P0bj8Deqmlygx9R0j1
	QSYr+uoWZXLx+NDnktOV8jlirlX2kY6FwDqjPZyCoyCt44Plygwu2KnglH1wRwd+vuhOXn4YqckK7
	V5cHNQ7nI5QAnXAoW1/JuUkLjBH/NbppokFRCDHH5bh2EoS5mwycPRs2honUumfx6zyRZv7x+zTIN
	YhIKBtIDIAGDtnXLHR+b/mvuqqLebTEgaI32oXKtCaKmKxPJoQ6gD8aQzk47k9zE6/4BoKOCyS0JZ
	F4NHjhhpoFBtcXUrYfI7byLXDRmc9OuktZ6OVl7UIGZW2m6bW9uo3XQxyEiGl8Cz6W+AVX3jOuGNu
	uvEXjOVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jO5-00000008gbi-1qMn;
	Tue, 15 Oct 2024 15:23:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jO2-00000008gaJ-0iof
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:23:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AA12227A8E; Tue, 15 Oct 2024 17:22:58 +0200 (CEST)
Date: Tue, 15 Oct 2024 17:22:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241015152257.GA12898@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241015055006.GA18759@lst.de> <Zw6FoPCEJ0-rARGT@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6FoPCEJ0-rARGT@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_082302_533523_14BD296D 
X-CRM114-Status: GOOD (  39.76  )
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

On Tue, Oct 15, 2024 at 09:09:20AM -0600, Keith Busch wrote:
> On Tue, Oct 15, 2024 at 07:50:06AM +0200, Christoph Hellwig wrote:
> > 1) While the current per-file temperature hints interface is not perfect
> > it is okay and make sense to reuse until we need something more fancy.
> > We make good use of it in f2fs and the upcoming zoned xfs code to help
> > with data placement and have numbers to show that it helps.
> 
> So we're okay to proceed with patch 1?

No, see point 3 and 4 below for why.  We'll need something like the
interface you suggested by me in point 4 and by you in reply to point 3
in the block layer, and then block/fops.c can implement the mapping on
top of that for drivers supporting it.

>  
> > 2) A per-I/O interface to set these temperature hint conflicts badly
> > with how placement works in file systems.  If we have an urgent need
> > for it on the block device it needs to be opt-in by the file operations
> > so it can be enabled on block device, but not on file systems by
> > default.  This way you can implement it for block device, but not
> > provide it on file systems by default.  If a given file system finds
> > a way to implement it it can still opt into implementing it of course.
> 
> If we add a new fop_flag that only block fops enables, then it's okay?

The flag is just one part of it.  Of course it need to be discoverable
from userspace in one way or another, and the marshalling of the flag
needs to be controller by the file system / fops instance.

> > 3) Mapping from temperature hints to separate write streams needs to
> > happen above the block layer, because file systems need to be in
> > control of it to do intelligent placement.  That means if you want to
> > map from temperature hints to stream separation it needs to be
> > implemented at the file operation layer, not in the device driver.
> > The mapping implemented in this series is probably only useful for
> > block devices.  Maybe if dumb file systems want to adopt it, it could
> > be split into library code for reuse, but as usual that's probably
> > best done only when actually needed.
> 
> IMO, I don't even think the io_uring per-io hint needs to be limited to
> the fcntl lifetime values. It could just be a u16 value opaque to the
> block layer that just gets forwarded to the device.

Well, that's what I've been arguing for all the time, and what Kanchan's
previous series was working towards.  It's not quite as trivial as
we need a bit more than just the stream, e.g. a way to discover how many
of them exist.

> > 4) To support this the block layer, that is bios and requests need
> > to support a notion of stream separation.   Kanchan's previous series
> > had most of the bits for that, it just needs to be iterated on.
> > 
> > All of this could have probably be easily done in the time spent on
> > this discussion.
---end quoted text---

