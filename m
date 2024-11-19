Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1019D6C285
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nljCT9m1qJgkEdK4ytLpaFgRXCC2mebKxiAsbaQH0D4=; b=ClIwjc1biLBdXkqAS5XwKGISFP
	2ELt4v5e9gjTVYVUWPph2B5/pckoJ1Er3ewIH0wj/PSnP7qyEuYWHl/iI8R5MOFM35vEt+vvBdkaN
	S7hwGIUftH3A9wHn/Q0CERMkuomeReLcm8JAYdhzQkJuRAPRww1s9vph+6AufIDY3IjyCpRvcmQ75
	SMx5mGf4s+cYkF3bQjPtgLmwFiAL8mJOAyGzEQ2poio3+NG2lwbSnJhXZHZamUejeJ178d4xRLhy9
	71udbgDdSeAmFc3PKQ4AAK9UC5vYOe1p5ynZksUQcHqz/lSf4sfVJ5nOJXaNd0YNuPAgyJPmVbkc/
	Uleveqhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDStx-0000000DNWA-1dWf;
	Tue, 19 Nov 2024 18:24:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDStu-0000000DNVT-2pmv
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 18:24:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E0F268D8D; Tue, 19 Nov 2024 19:24:27 +0100 (CET)
Date: Tue, 19 Nov 2024 19:24:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme: enable FDP support
Message-ID: <20241119182427.GA20997@lst.de>
References: <20241119121632.1225556-1-hch@lst.de> <20241119121632.1225556-15-hch@lst.de> <ZzzWQFyq0Sv7cuHb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzzWQFyq0Sv7cuHb@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_102434_859168_DA943FC3 
X-CRM114-Status: GOOD (  15.82  )
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

On Tue, Nov 19, 2024 at 11:17:36AM -0700, Keith Busch wrote:
> > +	if (le32_to_cpu(configs[result.fdpcidx].nrg) > 1) {
> > +		dev_warn(ns->ctrl->device, "FDP NRG > 1 not supported\n");
> 
> Why not support multiple reclaim groups?

Can you come up with a sane API for that?  And can you find devices in
the wild that actually support it?

> > +	ns->head->runs = le64_to_cpu(configs[result.fdpcidx].runs);
> 
> The config descriptors are variable length, so you can't just index into
> it. You have to read each index individually to get the next index's offset.
> Something like:

Indeed.  The current code only works when the first config is selected.


