Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C8FC6FA86
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UzJLAyJxUX5RTFzbCin7lqKfwX21buu7VEm5Jm6Q5k=; b=inWN0VOwBwHUKan2GAsZAPhAs1
	Defk4DEB6JUudgKsB5dI7sfS+1/OvCnOvAVJAe56j619FoFQks9sBEjhZ/DyeskJOm97E0IOp0miX
	gb3gA5uvASAfGR+2C2AzRRidA+RyO2SH/xh/cArPQml0jFywMKtDmxOxFN9VAekn0jh0ecCcMzpkL
	aVNZ5JLxwU7gLI/L9OTWf4VHVlt6rH2x9FugcpE3/h6fo0Pns1Rq7tkMXrGAOne49sXnlEg/PmcPa
	itHODGv83gYimKi/sxHZszqGnP47W+bWV7t9N98L0NFBz4yJStxn5mCKCYkDU4xIGCSoFkAGc6Mzu
	TSG2sQ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHsX-00C7gF-RZ; Mon, 19 Sep 2022 14:36:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHsU-00C7cr-PW
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 14:36:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44D1568BEB; Mon, 19 Sep 2022 16:35:56 +0200 (CEST)
Date: Mon, 19 Sep 2022 16:35:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for
 nvme devices
Message-ID: <20220919143556.GA28122@lst.de>
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com> <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk> <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com> <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_073607_062288_66A56F34 
X-CRM114-Status: GOOD (  15.13  )
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

On Mon, Sep 19, 2022 at 08:10:31AM -0600, Jens Axboe wrote:
> I'm not disagreeing with any of that, my point is just that you're
> hacking around this in the nvme driver. This is problematic whenever
> core changes happen, because now we have to touch individual drivers.
> While the expectation is that there are no remote IPI completions for
> NVMe, queue starved devices do exist and those do see remote
> completions.
> 
> This optimization belongs in the blk-mq core, not in nvme. I do think it
> makes sense, you just need to solve it in blk-mq rather than in the nvme
> driver.

I'd also really see solid numbers to justify it.

And btw, having more than one core per queue is quite common in
nvme.  Even many enterprise SSDs only have 64 queues, and some of
the low-end consumers ones have very low number of queues that are
not enough for the number of cores in even mid-end desktop CPUs.

