Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7995BD6EBE6
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Pdo2XgHgoWwYYQtfS1D7RkL2MKSB/1N1127K03n7ws=; b=LC8s/Z9nYvPK5UH6R3ye8YlQDx
	fAGGsV9T5F2SxONspg8Qb0a+oKK5vG7TPl/hZIUPLKczrG51SweXkQPL4nHzr+Nl/GBV4UwQpg9mP
	VQGla4S9LguTYBYlH/mA5aCErSNLK1Psgg2v7YlNaNACcDObuIPDz8p3+Ctm+tgpy1r3teXO3FXuT
	3YXRnwuVyNMjDNXzDrTQ9tRoErq61RZX57G4ClK0enyuoFYFesi2jdeo0VFO2oWF8OZQyfScyocmd
	kfoJrcmPtKazuTBwXc+tvjd4no4z0hvDLpFJ37LYtTLj+SXxRdk1VNWe9Tgp31kyCdALDhdTWajpx
	NjnqsNLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw7N-0000000H9ek-2Bs9;
	Fri, 29 Nov 2024 08:12:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGw7K-0000000H9d9-268H
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:12:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EACAF68D31; Fri, 29 Nov 2024 09:12:43 +0100 (CET)
Date: Fri, 29 Nov 2024 09:12:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <20241129081243.GE6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393a06d3fa651f9e68863b3cb9d952254f65e5a.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_001246_692216_03F49F73 
X-CRM114-Status: GOOD (  13.67  )
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

On Wed, Nov 27, 2024 at 05:27:51PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now when destroying the IO queue we call nvme_tcp_stop_io_queues() twice,
> nvme_tcp_destroy_io_queues() has an unnecessary call. Here we try to remove
> nvme_tcp_destroy_io_queues() and merge it into nvme_tcp_teardown_io_queues(),
> simplify the code and align with nvme-rdma, make it easy to maintaince.

Please split the reorganization from the fix.

Also can you add Fixes tag to the various bug fix patches?


