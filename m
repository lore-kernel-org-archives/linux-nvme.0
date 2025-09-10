Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF0CA101F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQUAVcjXn7tf95scgh3pOPJD9865+15BngQtRr5ID5E=; b=El60vQAxWrdcvqnB3D0qkE61bF
	ZdqyvW1FvBPYDHHVkLBs1SUvW9sjSRZCBMr8askIJ5zG3txMxa4Si6emMrNpEZxnM22fe8SDVdjun
	Ha9r23btDeOoTwOqb2wrFbl4/HNEavPtZ0kLrzMR7J1GrEo0If8cJfgK9hRjL8O6ukpRsTUHTnR5W
	lt43JLsxMzKRmp70z4N/RSuQXsj70JUQGbhWGChGQJL2fiWShDofDVddytzpnO6Lw8Z2tVUy+K5DE
	hlBic0mfLmi8pREL/pr+p+ZjGDxNn8bMcyzP6vwRm96HCayyuqzpLw4BSwtYFYMkObaRCgQjJP+af
	Sie/8lpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwG62-0000000CszT-0dxj;
	Wed, 10 Sep 2025 08:22:30 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwG5z-0000000CsxH-3pgE
	for linux-nvme@lists.infradead.org;
	Wed, 10 Sep 2025 08:22:29 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757492546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQUAVcjXn7tf95scgh3pOPJD9865+15BngQtRr5ID5E=;
	b=4OgNlmQTqS4AyVDZHcTox0tlSaBwDkJEL/Ts7pkw/dx/M20Ltu0mrLteEBzdn9sJCVLD2y
	dfcDP2k/EfsDTMJe8iTDcOHbq2BngCcR1pbaFFCTimZtO0pqy4HziY964ELyL3VGhPzbuS
	I46WwDbecRUNZqYt1o8HVYCiswSpMka/TqCAedJJlSUhci4k9ImyLi3psTc+Rao3niCHBo
	mDNGZo71G7ZhUHWl7fzzx0tPbWfneJvCy34cNAAEOFdknyQqPsI0i8u+u8+b/E2q+kPo4k
	dVOmJyABT05U8tEgXNXEiJ9BjjvnFlL25g3XQ9eMAo54Isys05Y7C9zjDJj6tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757492546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQUAVcjXn7tf95scgh3pOPJD9865+15BngQtRr5ID5E=;
	b=k1RrGMx8UOcygrkA8B9pm+mc/YjWJfzFVvkuTYWUt4MA239Asn+1jaJhj5EpeHW+3neqBz
	3wzspqNtmL4AzyBg==
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei
 <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, Mel
 Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Aaron Tomlin
 <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev,
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v8 04/12] genirq/affinity: Add cpumask to struct
 irq_affinity
In-Reply-To: <20250905-isolcpus-io-queues-v8-4-885984c5daca@kernel.org>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-4-885984c5daca@kernel.org>
Date: Wed, 10 Sep 2025 10:22:25 +0200
Message-ID: <87jz26u37i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_012228_097248_B4163822 
X-CRM114-Status: GOOD (  20.19  )
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

On Fri, Sep 05 2025 at 16:59, Daniel Wagner wrote:
> Pass a cpumask to irq_create_affinity_masks as an additional constraint
> to consider when creating the affinity masks. This allows the caller to
> exclude specific CPUs, e.g., isolated CPUs (see the 'isolcpus' kernel
> command-line parameter).
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  include/linux/interrupt.h | 16 ++++++++++------
>  kernel/irq/affinity.c     | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 51b6484c049345c75816c4a63b4efa813f42f27b..b1a230953514da57e30e601727cd0e94796153d3 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -284,18 +284,22 @@ struct irq_affinity_notify {
>   * @nr_sets:		The number of interrupt sets for which affinity
>   *			spreading is required
>   * @set_size:		Array holding the size of each interrupt set
> + * @mask:		cpumask that constrains which CPUs to consider when
> + *			calculating the number and size of the interrupt sets

You surely couldn't come up with a less descriptive name for this
member, right?

> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4013e6ad2b2f1cb91de12bb428b3281105f7d23b..c68156f7847a7920103e39124676d06191304ef6 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -70,7 +70,13 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  	 */
>  	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>  		unsigned int nr_masks, this_vecs = affd->set_size[i];
> -		struct cpumask *result = group_cpus_evenly(this_vecs, &nr_masks);
> +		struct cpumask *result;
> +
> +		if (affd->mask)
> +			result = group_mask_cpus_evenly(this_vecs, affd->mask,
> +							&nr_masks);

Please get rid of this line break. You have 100 characters.


