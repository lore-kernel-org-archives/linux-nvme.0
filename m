Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542CBE7718D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrgpeUSCINuG+hXn+0Y2FB+wWPZa+msRSyRLeDJujbs=; b=xJ89TeUbTSlII7UXLs2i4LEhvi
	IrBD8PZ9vZwdpAsMy1rEZ1yI/BbNItYz8fsDIRmDhewzK6/Bk0RPb5r83H7+wHLOvz+etHTRxpcEa
	pgJaGs/yn5br8GnnOm74BM34u2T8PAY7GZ8oZstB763he9j8UzYziH9zBstRpyDO/AI6uq1s9CMjD
	FEi2wuxYNeDC+R4qtPFxwBSS5aeAF7vZr9I/T6tk035SWmNco6b46zn6jjOYPdNc51mXJZTTxhstx
	pMaRQmn2j5yQljttAgvLnS2JpfbXYvaPtg30pRBGDL3idC70xcKOf9qmHmqaK4w4iCIsOfnfUJU+r
	Tm5HgkfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOItk-00000002EIS-2f4T;
	Thu, 19 Dec 2024 15:57:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOA12-00000000xtU-0OOn
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 06:28:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E31868BFE; Thu, 19 Dec 2024 07:28:02 +0100 (CET)
Date: Thu, 19 Dec 2024 07:28:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
Message-ID: <20241219062802.GC19782@lst.de>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org> <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_222808_276574_6BC67375 
X-CRM114-Status: GOOD (  28.11  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

On Tue, Dec 17, 2024 at 07:29:43PM +0100, Daniel Wagner wrote:
> When we offlining a hardware context which also serves isolcpus mapped
> to it, any IO issued by the isolcpus will stall as there is nothing
> which handles the interrupts etc.
> 
> This configuration/setup is not supported at this point thus just issue
> a warning.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index de15c0c76f874a2a863b05a23e0f3dba20cb6488..f9af0f5dd6aac8da855777acf2ffc61128f15a74 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3619,6 +3619,45 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> +static void blk_mq_hctx_check_isolcpus_online(struct blk_mq_hw_ctx *hctx, unsigned int cpu)

Please avoid the overly long line here.

> +{
> +	const struct cpumask *hk_mask;
> +	int i;
> +
> +	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
> +		return;
> +
> +	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
> +
> +	for (i = 0; i < hctx->nr_ctx; i++) {
> +		struct blk_mq_ctx *ctx = hctx->ctxs[i];
> +
> +		if (ctx->cpu == cpu)
> +			continue;
> +
> +		/*
> +		 * Check if this context has at least one online
> +		 * housekeeping CPU in this case the hardware context is
> +		 * usable.

But here you;re not even using up all 80 characters for the comment.


