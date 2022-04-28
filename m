Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C46C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1Ucnor/Z1cqCDHOmHdHkdz7IYcVUk6mea6efCXAgOA=; b=iUP6xf8+pLNun0KLnmk5wC1Blx
	Cq8QYEAbye8lhcfnyx2GOdDb83l3/FslkU9/S8g4ZX6UL82llXezmlLryQjS7yoaVP2yg5iQB+1+r
	KDowq5WeVXowiYC/AxuIAmv+4up9s+SD0SX6m/Ey+VhXCUNbJ1YkjruLxBDfYf4lxeUNJSXutXt6m
	LwWZg2WfJbNkIlmcc37c9hzX/kbuUhETQVSuIXKxvJChLWNxSc5gyo5CFfN2K3XYyqcQrEj80Y5tE
	bDmHJDDQAJFjqg867BbypoBaMPDCEmqez6F+E5iIM1JJlmeNlOLKYrNky21L5a4hl1QyILzKBoV6E
	eVP7eAuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk6hl-007qOy-57; Thu, 28 Apr 2022 16:09:21 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk6hh-007qLV-Ow
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 16:09:19 +0000
Date: Thu, 28 Apr 2022 18:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1651162151;
 bh=EFIxJKLXRND1+RqQt43Rt2lySMTfl9maJOfaKECS52E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LSPywKfczIqIU5RFrDA+zcwxNzF9vfVLeaZAoggwkKgC/w8NPn92Igcqvupp4iLVl
 3zvapYjzdZ8PtOY/FeJDohJxFgYpaemZV+7c27hwuw4jXfx+bcdcqR1TQvyrdp3C2D
 uw2VnGKYlScHzfH2D1JmOs1tnB92ZTE6vHTr3Xpk=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix host memory buffer allocation size
Message-ID: <676c02ef-4bbc-43f3-b3e6-27a7d353f974@t-8ch.de>
References: <20220428101922.14216-1-linux@weissschuh.net>
 <20220428143603.GA20460@lst.de>
 <5060d75e-46c0-4d29-a334-62c7e9714fa7@t-8ch.de>
 <20220428150644.GA22685@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220428150644.GA22685@lst.de>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_090917_999416_3684BD27 
X-CRM114-Status: GOOD (  18.56  )
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

On 2022-04-28 17:06+0200, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 04:44:47PM +0200, Thomas Weißschuh wrote:
> > Is the current code supposed to reach HMPRE? It does not for me.
> > 
> > The code tries to allocate memory for HMPRE in chunks.
> > The best allocation would be to allocate one chunk for all of HMPRE.
> > If this fails we half the chunk size on each iteration and try again.
> > 
> > On my hardware we start with a chunk_size of 4MiB and just allocate
> > 8 (hmmaxd) * 4 = 32 MiB which is worse than 1 * 200MiB.
> 
> And that is because the hardware only has a limited set of descriptors.

Wouldn't it make more sense then to allocate as much memory as possible for
each descriptor that is available?

The comment in nvme_alloc_host_mem() tries to "start big".
But it actually starts with at most 4MiB.

And on devices that have hmminds > 4MiB the loop condition will never succeed
at all and HMB will not be used.
My fairly boring hardware already is at a hmminds of 3.3MiB.

> Is there any real problem you are fixing with this?  Do you actually
> see a performance difference on a relevant workload?

I don't have a concrete problem or performance issue.
During some debugging I stumbled in my kernel logs upon
"nvme nvme0: allocated 32 MiB host memory buffer"
and investigated why it was so low.

