Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A4C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/l2o6PbIvhGTxkfi6z3TuPhlSt81OUbkxBgnnsi/0U=; b=VnMUZPH1Iz63SA4dUUD3+j/s7w
	tZCiiay+C3SuQR27Gi6wMG707zptoAlB+aQk2WrK8eEquU/M+365tUOEPzhNRSsThvYBCmSF1IVmm
	Wc1KhyoDL9bFHLUtT/SkQXDayzFTj0+TSSWIGh+yg9Br2NG9Rh4rDrMK20bpHJAa5F8EHGIwQwGqs
	IaflwKO5ERHeu9obmjHlBvnTN1KL+UvRbYC9x8A17Lpi2OKKKfJzwPiCJVzrul2TDWkjH/2vlNoR7
	2m5rUSX/bfiHOPSRHjER2EMPrgzNNjzBZDqPBEDBPgWdNHsJrNPx7//R87cpGvVBdLNKaN71NWUUg
	FjSAWxow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9OCa-00000006N1n-3JbT;
	Mon, 28 Apr 2025 13:07:16 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Njf-00000006DS0-1vfd
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 12:37:24 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745843839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/l2o6PbIvhGTxkfi6z3TuPhlSt81OUbkxBgnnsi/0U=;
	b=pc0UgzqpiLeAwBOUf1EJA8/rnl6Ee7rR73sZp9CIU4LXS0xPWGeCeNAFS7PRI7DiiAw7vF
	wswDPHH2rRmdFjJdwWV+ZXaja72eKXMY9kZd8d7p3qh/cMwwsv8/NjtMcGj59xn+9HjxHV
	872egQZIYk5ea0etvvKZn4G9666sI23+Xts3+lqV8VqQOXDyM+3ruRNd6cFeST+rrsK1e/
	f2u2nyVSyrm5krrf2eiwmy8J4cetjFmFQj5M8wUMZiUax+mimWSfEOsYV/EtSy0AYZpwk5
	yyUl41OjCOc9Mk+MEDtZPM0Y+kZl7ecKdpClcF3eFKnnb4smrOZIw3HPpdBgtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745843839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/l2o6PbIvhGTxkfi6z3TuPhlSt81OUbkxBgnnsi/0U=;
	b=aZCuGCW55jbdINBj1Vh3BbucF7jCF4dyzI4t3VbS9xKnEXP3D87a5rE41TKPSqrP+IUt6M
	GlGSH2+4YXHzhsBQ==
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei
 <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Mel
 Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v6 1/9] lib/group_cpus: let group_cpu_evenly return
 number initialized masks
In-Reply-To: <20250424-isolcpus-io-queues-v6-1-9a53a870ca1f@kernel.org>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
 <20250424-isolcpus-io-queues-v6-1-9a53a870ca1f@kernel.org>
Date: Mon, 28 Apr 2025 14:37:19 +0200
Message-ID: <87ikmoqx6o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_053723_782092_F28735C8 
X-CRM114-Status: GOOD (  21.90  )
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

On Thu, Apr 24 2025 at 20:19, Daniel Wagner wrote:

"let group_cpu_evenly return number initialized masks' is not a
sentence.

  Let group_cpu_evenly() return the number of initialized masks

is actually parseable.

> group_cpu_evenly might allocated less groups then the requested:

group_cpu_evenly() might have .... then requested.

> group_cpu_evenly
>   __group_cpus_evenly
>     alloc_nodes_groups
>       # allocated total groups may be less than numgrps when
>       # active total CPU number is less then numgrps
>
> In this case, the caller will do an out of bound access because the
> caller assumes the masks returned has numgrps.
>
> Return the number of groups created so the caller can limit the access
> range accordingly.
>
> --- a/include/linux/group_cpus.h
> +++ b/include/linux/group_cpus.h
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/cpu.h>
>  
> -struct cpumask *group_cpus_evenly(unsigned int numgrps);
> +struct cpumask *group_cpus_evenly(unsigned int numgrps,
> +				  unsigned int *nummasks);

One line

>  #endif
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 44a4eba80315cc098ecfa366ca1d88483641b12a..d2aefab5eb2b929877ced43f48b6268098484bd7 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -70,20 +70,21 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  	 */
>  	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>  		unsigned int this_vecs = affd->set_size[i];
> +		unsigned int nr_masks;

  unsigned int nr_masks, this_vect = ....

>  		int j;

As yoou touch the loop anyway, move this into the for ()

> -		struct cpumask *result = group_cpus_evenly(this_vecs);
> +		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
>  
>  		if (!result) {
>  			kfree(masks);
>  			return NULL;
>  		}
>  
> -		for (j = 0; j < this_vecs; j++)

                for (int j = 0; ....)

> +		for (j = 0; j < nr_masks; j++)
>  			cpumask_copy(&masks[curvec + j].mask, &result[j]);
>  		kfree(result);
>  
> -		curvec += this_vecs;
> -		usedvecs += this_vecs;
> +		curvec += nr_masks;
> +		usedvecs += nr_masks;
>  	}
>  
>  	/* Fill out vectors at the end that don't need affinity */
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc13907ce9f211f479615d2e3c9154..016c6578a07616959470b47121459a16a1bc99e5 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -332,9 +332,11 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>  /**
>   * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>   * @numgrps: number of groups
> + * @nummasks: number of initialized cpumasks
>   *
>   * Return: cpumask array if successful, NULL otherwise. And each element
> - * includes CPUs assigned to this group
> + * includes CPUs assigned to this group. nummasks contains the number
> + * of initialized masks which can be less than numgrps.
>   *
>   * Try to put close CPUs from viewpoint of CPU and NUMA locality into
>   * same group, and run two-stage grouping:
> @@ -344,7 +346,8 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>   * We guarantee in the resulted grouping that all CPUs are covered, and
>   * no same CPU is assigned to multiple groups
>   */
> -struct cpumask *group_cpus_evenly(unsigned int numgrps)
> +struct cpumask *group_cpus_evenly(unsigned int numgrps,
> +				  unsigned int *nummasks)

No line break required.

>  {
>  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
> @@ -421,10 +424,12 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		kfree(masks);
>  		return NULL;
>  	}
> +	*nummasks = nr_present + nr_others;
>  	return masks;
>  }
>  #else /* CONFIG_SMP */
> -struct cpumask *group_cpus_evenly(unsigned int numgrps)
> +struct cpumask *group_cpus_evenly(unsigned int numgrps,
> +				  unsigned int *nummasks)

Ditto.

Other than that:

Acked-by: Thomas Gleixner <tglx@linutronix.de>

