Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98318C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ou4nYw8ILf2zn1HP6ee9FnWXxzs81yaI99FjUJRJI98=; b=Y2qdJkHxYVEGH/QhmDAPMzak95
	T+Gajjpe09QbxNbD4TsvqEFeBrooOTZqbpjEuBsR0JN4HKcyEQlfJkkgX5YKn/frywcQPPIsYe5IA
	c+wayzZ1/bpjbEpmPoD0FWhlCl5zl4Z1UBLZlax9m611CKH6FeDV26qWacFulsw0p6NhIVTMlYl4e
	XD2SMzGKnuuLZ+PWvC5uMiJWVfczl9XBKofoZYUckGn5jyzFlddPLgsjM8MrxeO3NaYyvx3NO5iL7
	hozIZnrZIBSMiFmaOlnuY2eoJfmJ2AHTmyYWmxNAJlrhZfvEvL+qvYW+hTlpu6IKXESfmqc/Q5V31
	P0kEqi+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmtLf-0026iX-5I; Fri, 06 May 2022 08:30:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmtKa-0025qz-OQ
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 08:28:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 73B1A68AFE; Fri,  6 May 2022 10:28:44 +0200 (CEST)
Date: Fri, 6 May 2022 10:28:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220506082844.GA30405@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_012856_987116_CB0BE212 
X-CRM114-Status: GOOD (  13.73  )
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

On Thu, May 05, 2022 at 11:23:01AM -0600, Jens Axboe wrote:
> The top three patches here have a proposed solution for the 3 issues
> that I highlighted:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough
> 
> Totally untested... Kanchan, can you take a look and see what you think?
> They all need folding obviously, I just tried to do them separately.
> Should also get tested :-)

I've also pushed out a tree based on this, which contains my little
fixups that I'd suggest to be folded.  Totally untested and written
while jetlagged:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/io_uring-passthrough

Note that while I tried to keep all my changes in separate patches, the
main passthrough patch had conflicts during a rebase, which I had to
fix up, but I tried to touch as little as possible.

