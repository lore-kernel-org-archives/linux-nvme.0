Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43426C44501
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMYq9cG/rxD4S9M4Bz3xT+UHw1tldDaTR6qW8eCUA00=; b=n67jCr0JH6iDME/akwwp6p38oA
	7TXuhGftxhJgIqmlF2OwEG1jPP0qvUp1V1yLypb+oy5SP69y/5X/bBWZX7SWICNCtMpqH18Qsp/tf
	IxLv4YrKRipNFOBAUx5KTJcb7LFD1EEg/YHxfh6y2v0B0SUSq73AqyE7g4pkUnD7BhUfdAdzAbXA5
	FOIPsK0KyETXt7uf/KWcbtvWGKep00ESz2KTv9WXZWCed4n3ZC6O8UCJWu9udP4BYsRZ0eR8ELT8d
	d5G0tU5J/2conRJpwMFM7s1DROsODzip160TL5JWd72k1G4lSOR1nk9f5+JuUtRlNxuGO8QSx7edh
	6CQSQSxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi1F-000000017po-481G;
	Thu, 09 Jul 2026 06:13:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi19-000000017oi-40M9
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:13:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B41F68CFE; Thu,  9 Jul 2026 08:13:49 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:13:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 06/17] blk-cgroup: support non-blocking bio
 association
Message-ID: <20260709061349.GD16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-7-yukuai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-7-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_231352_139848_218A9AEA 
X-CRM114-Status: GOOD (  12.98  )
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

On Sun, Jul 05, 2026 at 03:51:13AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> Allow bio association helpers to be called from non-blocking paths by
> returning whether the association succeeded and by taking a nowait argument.
> The normal callers pass nowait=false and keep the existing behavior of
> creating missing blkgs.
> 
> For nowait=true, the helper only succeeds when the needed blkg already
> exists.  This lets callers set or clone a bio's bdev without entering the
> sleepable missing-blkg creation path.

I think this is not needed once we kill nonblocking bio allocations,
but if not please have a clearly visible separate API for the
non-blocking version.


