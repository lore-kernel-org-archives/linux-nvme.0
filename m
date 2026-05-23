Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4258CD5BB1
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQ3xYNiFPi/ClO+/W6owXrAqBG2q4JnIlxaYYY94LsI=; b=sLzUTyuEq7x71aejHDV3uZyz3o
	8oraHo4gd9F9WEO3tyeBgMHiR3IIiJC4Ys2ogcIiKkVTxy5kXlo6OeqomHwbMJxHA3PUbaNXVTqTB
	U9ETsqL9CqNVTIbi+N2jgwvx9hC11fCVcT1i+LqUe/yOKx3dQAYzqBUgTdKSWsDy85JTT+Y0MUgB7
	Y+IxtT8BQPMkqp2owkgd5o2K6bbLkf9KKRw6ILmdPUu8tBrWETMiX9SZBVQi+WtsUFG8wl7f2A/fT
	nYfNJTfTRsIFIzzLkt5nyTfOHvy5cRWsAJCXWlC09jXeYVI7mQ/7SDe+Ejykx1LfE29+zMETch0Md
	L2YsfsPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQhYO-0000000CvcS-2yqI;
	Sat, 23 May 2026 08:17:52 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQhYG-0000000Cvbm-3xJv
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 08:17:47 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6F7A4240101
	for <linux-nvme@lists.infradead.org>; Sat, 23 May 2026 10:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1779524259; bh=BQ3xYNiFPi/ClO+/W6owXrAqBG2q4JnIlxaYYY94LsI=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=X7g+vTADRoNT7vL0XQt8x2t/6Uq/3N9R9LvXpQmUBg1F58+mMq+NpYIrZRaSV6CDN
	 TttzDxq4LKnvtgOqhqOImTIwVNcYU8botaU2RKvHWL/Qo7i2uT2X/3JFfPC+gIvLyN
	 iZzlhtD/LKW2gQfOOyNAkUvxf+BD7SKuR86lBzrzthXCOxjZtgoUMwgkK9JQX7mRIU
	 Lj7Gmvn09cVdgw0pSNgg8iEPnZQyaSI6b7A9acDneC6hRmOdefjmGmVd8bJzAlmtkI
	 tYDsdephrnx76g0ceen+FsrpkAd/ZO4pYJX/LwlvUyLBtnXAXueVM0sTamZ1SRDwib
	 lRwQGy40jF76Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gMw4L2DV3z6tvx;
	Sat, 23 May 2026 10:17:38 +0200 (CEST)
MIME-Version: 1.0
Date: Sat, 23 May 2026 08:17:38 +0000
From: mateusz.nowicki@posteo.net
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix out-of-bounds access in
 =?UTF-8?Q?nvme=5Fsetup=5Fdescriptor=5Fpools?=
In-Reply-To: <CADUfDZoHibw8RA_OiWfptQwa2HjPho9OotNX56kf5MvnQi8GuQ@mail.gmail.com>
References: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
 <CADUfDZoHibw8RA_OiWfptQwa2HjPho9OotNX56kf5MvnQi8GuQ@mail.gmail.com>
Message-ID: <8a73dd99b8280c5d1bde9c6caed8323b@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_011745_132503_00968032 
X-CRM114-Status: GOOD (  14.58  )
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

On 22.05.2026 17:27, Caleb Sander Mateos wrote:

> FYI there was a previous report and patch for this issue:
> https://lore.kernel.org/linux-nvme/20260309062840.2937858-2-iam@sung-woo.kim/T/#u
> . Looks like a v2 was promised but never arrived. Some attribution
> (Reported-by, Link?) for the original patch might be good.
> 
Thanks, missed that thread. Added in v2:
    Reported-by: Sung-woo Kim <iam@sung-woo.kim>
    Link: 
https://lore.kernel.org/r/20260309062840.2937858-2-iam@sung-woo.kim

Also added a Fixes: tag for d977506f8863

> I did like that the other patch switched the type of struct
> blk_mq_hw_ctx's numa_node field and the argument to struct
> blk_mq_ops's init_request function pointer from unsigned int to int to
> clarify that it was optional. But probably makes sense to do that as a
> follow-on commit separate from the bug fix.
> 
I can take care of it, will send it as separate follow-up.

> Is numa_node >= nr_node_ids possible? I think just numa_node < 0
> should be fine, and would avoid a compiler warning about comparing int
> to unsigned int.
> 

Right, dropped the nr_node_ids check. Went with == NUMA_NO_NODE
rather than < 0 to match the style in block/blk-mq.c

v2 incoming.

Thanks,
Mateusz

