Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C721C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDyv3NeEuJBmPLvrgoETkJvUUk++NsedIod9LKManGw=; b=oWc2p9YOWO+6XmzDjZlnNAWq89
	B2Tfgs6yB4Sfi14EnaQrwFbkz8lFVDrhpkirmOQzdAuiqpnBwiQkTQ5/EkjTIeLgLnybEQoI+cE7C
	4iAuud6VWujrHlEpca7l+FS0lW3zOpy8UnpG0BG0FrA5onLYidC0J6CyN6rpnTNkauDFZB+jJ2CM3
	U+yYrYnjv15V+fPyXpI7D7T/m3+8yVpFLcFDPGzLN5aVENyHbSpLqSewgxIGsZQxw2ueRs06zMvjG
	7I7lDb5uyQqGNB3fuBFQaiYr+Y8gPZ0dd323Ago8x1b3426SP5806iRhyBDA1ISLvGHKgr1sjLIeV
	h9yYK8Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk5O4-007WoR-80; Thu, 28 Apr 2022 14:44:56 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk5O0-007Wmf-V8
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 14:44:54 +0000
Date: Thu, 28 Apr 2022 16:44:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1651157087;
 bh=1g8VE7azqFzzy065FworAEOOCfsdqNZvcvV19NCfaYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hmP6z0TnAhqP4V6qWw0EaMSba/ZbdeMGOnIcJerhHOgpwd+2rlft+wbi0T2B+zQ3f
 n0zyrr3suOZpW+PvJICdGGK0apKO0bpWTmNiXQdtJ9KCO7lWqnkKqOruGx0iQ2ymbe
 ortsdVhugui2YrCf1EN1N0sDQ+HQ7dQ/SAUO4oi4=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428143603.GA20460@lst.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_074453_189455_1A99E0E8 
X-CRM114-Status: GOOD (  21.49  )
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

On 2022-04-28 16:36+0200, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 12:19:22PM +0200, Thomas Weißschuh wrote:
> > We want to allocate the smallest possible amount of buffers with the
> > largest possible size (1 buffer of size "hmpre").
> > 
> > Previously we were allocating as many buffers as possible of the smallest
> > possible size.
> > This also lead to "hmpre" to not be satisifed as not enough buffer slots
> > where available.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > 
> > Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/
> > 
> >  drivers/nvme/host/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 3aacf1c0d5a5..0546523cc20b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
> >  
> >  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
> >  {
> > -	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> > +	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> 
> preferred is based on the HMPRE field in the spec, which documents the
> preffered size.  So the max here would not make ny sense at all.

Is the current code supposed to reach HMPRE? It does not for me.

The code tries to allocate memory for HMPRE in chunks.
The best allocation would be to allocate one chunk for all of HMPRE.
If this fails we half the chunk size on each iteration and try again.

On my hardware we start with a chunk_size of 4MiB and just allocate
8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.

What am I missing?

