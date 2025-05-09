Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84FEC3ABC5
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nu9dJaM+tlFWqIyxUlK5LSPVjvjKt3pIbseYQlD56Ks=; b=YZ+bOa/odryrxVEI+WkgqrwcOb
	JQplwZhYR5dDQZDiQ3ocwuSHxX+SCTv6zjU0v8Ww1JKZJJuvQXQsThjS2jjaORQ8MyVbxS81awPhy
	T2WiQ7czZ2ilTiX3fri1V33mvFSJP6K5F/EtGf7BpbCcyJ10h+BiMgytfM+UUuQnHuQQL5CdXMXTa
	mIApdYXP3Gzx6bos1eot8Nqk+mNm71c6Whjk+jXjY4bWNCM1bxwjyl7E5ABzipOcBzGnQ5Ewvtmnq
	KQboV7oAeJf8bq3C0v5hqGNRY8DfTfyUL8RLbvxQzO3LqU0GUesjuViRSh+5r2CWjhGqKNtwIcag0
	75ybRh7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDDst-00000002HiN-3GmI;
	Fri, 09 May 2025 02:54:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDDsq-00000002Hhx-2tf0
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 02:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746759283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nu9dJaM+tlFWqIyxUlK5LSPVjvjKt3pIbseYQlD56Ks=;
	b=WzL0zrgGKd49vEmqQRSJT2+cN8PjtGkZWfLqFimpDt2Tz7gNilSF667ymmO8YUFhTgPuQO
	qsQeELosxaNoRCLtyJTDSanGxwce3X9wm1ehp03JDlVWk2S8jKaHM8SkM4BU0bW7cqS50L
	XV7+E/CfFrvDoEG768+K9NVAXZazEGI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-oiLQlf_9P1m4qOm9AvPOvA-1; Thu,
 08 May 2025 22:54:37 -0400
X-MC-Unique: oiLQlf_9P1m4qOm9AvPOvA-1
X-Mimecast-MFC-AGG-ID: oiLQlf_9P1m4qOm9AvPOvA_1746759274
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6A219560AB;
	Fri,  9 May 2025 02:54:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23A2119560B3;
	Fri,  9 May 2025 02:54:20 +0000 (UTC)
Date: Fri, 9 May 2025 10:54:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v6 9/9] blk-mq: prevent offlining hk CPU with associated
 online isolated CPUs
Message-ID: <aB1uV38QB_FErstt@fedora>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-9-9a53a870ca1f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-isolcpus-io-queues-v6-9-9a53a870ca1f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_195444_813018_234D02AC 
X-CRM114-Status: GOOD (  31.31  )
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

On Thu, Apr 24, 2025 at 08:19:48PM +0200, Daniel Wagner wrote:
> When isolcpus=io_queue is enabled, and the last housekeeping CPU for a
> given hctx would go offline, there would be no CPU left which handles
> the IOs. To prevent IO stalls, prevent offlining housekeeping CPUs which
> are still severing isolated CPUs..
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c2697db591091200cdb9f6e082e472b829701e4c..aff17673b773583dfb2b01cb2f5f010c456bd834 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3627,6 +3627,48 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>  	return data.has_rq;
>  }
>  
> +static bool blk_mq_hctx_check_isolcpus_online(struct blk_mq_hw_ctx *hctx, unsigned int cpu)
> +{
> +	const struct cpumask *hk_mask;
> +	int i;
> +
> +	if (!housekeeping_enabled(HK_TYPE_IO_QUEUE))
> +		return true;
> +
> +	hk_mask = housekeeping_cpumask(HK_TYPE_IO_QUEUE);
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
> +		 */
> +		if (cpumask_test_cpu(ctx->cpu, hk_mask) &&
> +		    cpu_online(ctx->cpu))
> +			break;
> +
> +		/*
> +		 * The context doesn't have any online housekeeping CPUs
> +		 * but there might be an online isolated CPU mapped to
> +		 * it.
> +		 */
> +		if (cpu_is_offline(ctx->cpu))
> +			continue;
> +
> +		pr_warn("%s: trying to offline hctx%d but there is still an online isolcpu CPU %d mapped to it\n",
> +			hctx->queue->disk->disk_name,
> +			hctx->queue_num, ctx->cpu);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
>  		unsigned int this_cpu)
>  {
> @@ -3647,7 +3689,7 @@ static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
>  
>  		/* this hctx has at least one online CPU */
>  		if (this_cpu != cpu)
> -			return true;
> +			return blk_mq_hctx_check_isolcpus_online(hctx, this_cpu);
>  	}
>  
>  	return false;
> @@ -3659,7 +3701,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  
>  	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
> -		return 0;
> +		return -EINVAL;

Here the logic looks wrong, it is fine to return 0 immediately if there are
more online CPUs for this hctx.

Looks you are trying for figuring out the last online & housekeeping cpu
meantime there are still online isolated cpus in this hctx, it could be more
readable by:


	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
		if (!can_offline_this_hk_cpu(cpu))
			return -EINVAL;
	} else {
		if (blk_mq_hctx_has_online_cpu(hctx, cpu))
			return 0;
	}

Another thing is that this way breaks cpu offline, you need to document
the behavior for 'isolcpus=io_queue' in
Documentation/admin-guide/kernel-parameters.rst. Otherwise, people may
complain it is one bug.

Thanks,
Ming


