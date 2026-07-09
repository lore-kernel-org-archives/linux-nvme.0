Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A8EC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKOjSLcYKvuXC2LmFkxOKwMP/GX1QBfvgxze7Lbp8F8=; b=APYZCorWRlPGh/PWJTvzzl1Jbz
	h1bXqaS1oabdS2izsXd3q/TIImveepjz0ExC/7/2PhWhD4ey4V09T0Y2UScPJLQMxk88fXL81rzbM
	sMNeBtBn3K6kO/EmbneslHSqGZOqzFEteYVNd6vm8kKKKo4H8equS/rEzC2s4/sqaAqDL1JHAK8v/
	wRVNO+b1gqCnKbB7QGahCj5iqc2I12FdOpqx8VYwM1ahEjZppBcXNI4r/ZGMA5Oni6RwE8S+pZFEb
	nOksPqSTPNZby+xbNCBSc/JyIJbcztlFzWzudSqYAbdAdCVpDBSyuppAJntqTFwS9lVjayov32D8b
	gbmRfENg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsIC-000000036Pj-1yBg;
	Thu, 09 Jul 2026 17:12:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsIB-000000036Pb-2M0U
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 17:12:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B57E61381;
	Thu,  9 Jul 2026 17:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF59E1F000E9;
	Thu,  9 Jul 2026 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617125;
	bh=WKOjSLcYKvuXC2LmFkxOKwMP/GX1QBfvgxze7Lbp8F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=By5Fn0J2Uqegx7giTEeEir65EWgeoFC2e8r/Tuj4hKt5Y2icx2Qpe/TZlG9lO3h7E
	 ESbGZEUJwnQa/yjnL3m9TW5JaXqHpuaMNeUHGtFdQiu0Z2JW+8E+2QcPiucsJLcrdY
	 5zfJvxgJH6lBUAWdOuW53DHqfk7AuUkGP9i0YenNLqAkiheC8ZnFFPy4CZuMaN7i3m
	 IBHXKR9N69U3oqy7wnBUB444elv4ADLt01nBmobKSyAEWptRTfCE9wUQqo31doCNVP
	 wUrzSLolpdoy72BInuVg3rWfZV1+DrBIlLDW5X8zrPUcWf9mkIAtI/8HYbYMc2HoH4
	 K/imR/cwoFDIg==
Date: Thu, 9 Jul 2026 11:12:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>, Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v4 0/3] nvme: add ABI documentation for sysfs and
 configfs interfaces
Message-ID: <ak_WY5NWWMHZ3BYC@kbusch-mbp>
References: <20260707121227.2274769-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121227.2274769-1-kanie@linux.alibaba.com>
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

On Tue, Jul 07, 2026 at 08:12:24PM +0800, Guixin Liu wrote:
> The NVMe host sysfs interfaces and target configfs interfaces lack
> ABI documentation under Documentation/ABI/. This series adds the
> missing documentation and updates MAINTAINERS accordingly.

Thanks, applied to nvme-7.3.

