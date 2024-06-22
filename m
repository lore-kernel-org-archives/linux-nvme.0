Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E17CC27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 05:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGzkn8gnhBrPi8Knr9qbPoMYOPtTnJH3tbhdknCsMBQ=; b=L6xgAW7H/XLQzD7nX+6f/QdIAu
	8fEpc38QyGpKXFNlTMWeP17Dfb4Zryx0FuteCEaqiHhJBw0b/YY76AkQ+/HWuFs1qVO/2oPRX15fE
	np0yzWaMSBGLKX1QhVRODyAM9H+Ig42fEHaU/BzKWi+Z2OCizk/i+6CCkZ7ft67tcq2pTiuD8rgFW
	2T/eNtAd318v+DjY7Nl6jDw6HgPjLtF3/9KeHGKpTf+d6XwQmiv/rvvKuDz1kDm22uEhUFkBCOYYa
	NOD2qkh4z4OcZHzlRXKciHTYMQz8Y7rqLSauNQzhoyiJbW/F/BnScqcagqq6R1QzWtHltF+tIIrHy
	hp3Mt6iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt3z-0000000BQGA-2iKN;
	Sat, 22 Jun 2024 05:13:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt3w-0000000BQFX-20xf
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 05:13:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF51B68CFE; Sat, 22 Jun 2024 07:13:15 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:13:15 +0200
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
Subject: Re: [PATCH 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <20240622051315.GB11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-3-8b169bf41083@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-3-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_221320_711021_0D30F60E 
X-CRM114-Status: GOOD (  11.22  )
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

Shouldn't this go before the current patch 2?

> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +	if (!cpumask_empty(io_queue_mask))
> +		return group_mask_cpus_evenly(numgrps, io_queue_mask);
> +	else
> +		return group_possible_cpus_evenly(numgrps);
> +}

No need for an else after the return above.


