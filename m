Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F94C27C53
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jun 2024 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icVtH+etts68S0EN591q+Bpe8+dNzmBAezhTgSof0rY=; b=isSkc7jItwlMIYTMshzpAtwc5j
	pnF6HiBDgJZEiqUtjTi7T0sPOzv2vACNAFyFIr96BC7ZWWS5W6feT41oct7fkwaGx/AufaA/fSt0W
	v8U/2vHY2nDRe9a4PHpZnFEnKNKAnRidEXLDOaIIQYfJJfYegHr4wLyfYgwPfvgkawXjaE6liIcSb
	CKH0OA7jvr7/VRT3yFql+p3nUylzd1jnPlfX1pRZ777GA2oOadyymjdm/XKu/r7R/QmigbQII+O0a
	tRGAGQaQ4SAORHiGK54Np9w39/PABUQIhPKGT5I9Wc95QRR5gLwQOpc95BRHQ8/jAcPbZEw/Dymib
	2WRVtxiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt51-0000000BQTC-2mn2;
	Sat, 22 Jun 2024 05:14:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKt4y-0000000BQSD-0BGn
	for linux-nvme@lists.infradead.org;
	Sat, 22 Jun 2024 05:14:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0838168CFE; Sat, 22 Jun 2024 07:14:21 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:14:20 +0200
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
Subject: Re: [PATCH 2/3] nvme-pci: limit queue count to housekeeping cpus
Message-ID: <20240622051420.GC11303@lst.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de> <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-isolcpus-io-queues-v1-2-8b169bf41083@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_221424_332656_EF5EC8F8 
X-CRM114-Status: GOOD (  16.55  )
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

> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9638b25fd521..43c039900ef6 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -11,10 +11,23 @@
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
>  #include <linux/group_cpus.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> +unsigned int blk_mq_num_possible_queues(void)
> +{
> +	const struct cpumask *io_queue_mask;
> +
> +	io_queue_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +	if (!cpumask_empty(io_queue_mask))
> +		return cpumask_weight(io_queue_mask);
> +
> +	return num_possible_cpus();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_num_possible_queues);

This should be split into a separate patch.  And it could really use
a kerneldoc comment.

> -	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
> +	return blk_mq_num_possible_queues() + dev->nr_write_queues + dev->nr_poll_queues;

Please avoid the overly long line here.

Otherwise this looks good to me.


