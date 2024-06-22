Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32117C27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 05:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ntMMOHUl/0Cypj2ZWm7Kq3Lpcob5hboGJ2uwzvu0IA=; b=z+m2d2cjC/vHgGu83K8pa3zhaI
	GclpiEQLG7BQ31pE23rnL3pNxZ5SpgaQgfzb4b3KmDab/HHVWiJIEtdTnXMy/lN4pgxkOEIWqDeZd
	DVSfcnwTHt0KGEaVXFHTliIT7t2wjRs8nEzRz6635geAfWsjpwAXRkz5npShR9xbsgkINPHqmGFcJ
	mTIEkCrawbEhlRILhvlHUlDObebZ35yJ1KxjtJHiGbCOnZ1KWHF+iOGrREqzDIgn0ENuqvpnDsC7O
	aMPAMGg0mzHyYFreNvFXs1MTA+RhrJ3rEYPChcKP0bo4AuwSZDh210TZ9sekdWBXslfZOVCLZ8PyH
	5FNut59g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt2o-0000000BQ52-3Wys;
	Sat, 22 Jun 2024 05:12:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt2l-0000000BQ3z-0Mrc
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 05:12:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E39668C7B; Sat, 22 Jun 2024 07:11:57 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:11:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
Message-ID: <20240622051156.GA11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_221207_292080_542D581A 
X-CRM114-Status: GOOD (  12.93  )
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

> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fa..fe751d704e99 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -16,6 +16,7 @@ enum hk_type {
>  	HK_TYPE_WQ,
>  	HK_TYPE_MANAGED_IRQ,
>  	HK_TYPE_KTHREAD,
> +	HK_TYPE_IO_QUEUE,
>  	HK_TYPE_MAX
>  };

It might be a good time to write comments explaining these types?


