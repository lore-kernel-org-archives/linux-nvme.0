Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0581C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVqtDK118W+AAchvsAztzUwu+BMugEURqxneJgQQq0g=; b=h5dbNYvu4S/1IdGGOtWSuzOHcD
	Kz8FRxTDslOrjePuwTno0wq3zsH7F4IuzVQG5f1SIkKqFI20vcAjCZbi4puGEOccOB+RKkibDYLVu
	eMhMdesQG0QmtXwuZHh30j1xMm9wGCPPytppnmUwG3SVT/Um0tmi18zbXkbSPdPxytAvCzz/mYb9O
	vwEDeX9tJAZBLbx3m6ZNJs5qIzkwpwPAXNTeuL2ETFXIbDHJ3nhsJCc/wZHYZpYXpvp14aUwfwG9Z
	oR8i3/cL5+ucFQk2tNjbKWhBuOPO8VmV694uZpnW0N+B2cwRVDHS97HifEW+MUuuu+DHwJAJPbP9M
	GAXwf7pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2zS-008NsN-VO; Tue, 15 Mar 2022 08:57:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2zQ-008NrJ-Bd
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:57:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 988FC68AA6; Tue, 15 Mar 2022 09:57:09 +0100 (CET)
Date: Tue, 15 Mar 2022 09:57:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 12/17] nvme: enable bio-cache for fixed-buffer passthru
Message-ID: <20220315085709.GD4132@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152718epcas5p3afd2c8a628f4e9733572cbb39270989d@epcas5p3.samsung.com>
 <20220308152105.309618-13-joshi.k@samsung.com>
 <20220311064847.GA17728@lst.de>
 <CA+1E3rJshMVkLwpAQwM1L6L_xcrK9drKP+rpcrfizYuFsQOGjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJshMVkLwpAQwM1L6L_xcrK9drKP+rpcrfizYuFsQOGjA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015712_571988_A5B32D66 
X-CRM114-Status: GOOD (  12.49  )
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

On Mon, Mar 14, 2022 at 11:48:43PM +0530, Kanchan Joshi wrote:
> Yes, the only reason to switch from kmalloc to bio-set was being able
> to use bio-cache.
> Towards the goal of matching peak perf of io_uring's block io path.
> Is it too bad to go down this route; Is there any different way to
> enable bio-cache for passthru.

How does this actually make a difference vs say a slab cache?  Slab/slub
seems to be very fine tuned for these kinds of patters using per-cpu
caches.

