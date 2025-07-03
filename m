Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4538EC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BcDHMkFTXoj37LpVYdwr2vQBaGqjqXSrgjGcPFlY/1I=; b=dDeKsXYfSSWS33hMh0uRpVyLuA
	cdqmM+K5CA65M1V1jZ9PCf1ocLk0nmciAH1EJ7fEZI2FfauFkd0kCB8Slsz2TILgqI4Vjb5kQq350
	OA0xQDCCma/KKONyv17b6WjRqA9/B4zoQ1MgG6aemSleD6tp32clzc1MC0ws0bZHJhMhr5p1Z9xrN
	lEW7mgKSlbNAjcWYLvhRv0duhNUvjCCPXpSz90wjWSFphoKYTvoSy8VULUkTlZSuCTvXiRSbTxE/k
	wVnwGup1+nbcBgGBv/KLHUcoS0GRVRBbFIUV21+sq7QTsY24VWpPBevykn0tBnc8Be40NOVOvGAKd
	8fxAnaZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDTe-0000000ANb8-1uAZ;
	Thu, 03 Jul 2025 06:31:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDRX-0000000AN7R-1T1F
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 06:29:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F78C2118E;
	Thu,  3 Jul 2025 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751524149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcDHMkFTXoj37LpVYdwr2vQBaGqjqXSrgjGcPFlY/1I=;
	b=jj+PhLlBlVvDqRRTPaeN5k8r08UZmVAy1fXewAadlcag4CAoMlfW1kafV/qiL5ZriHjPF4
	wO2Oe+5Z2uSps2wW5/12JVh2BUbYsVfvaSFIVFAGisdA8r86hnIjR0aQ5AUpE8EVZ5F8Kn
	KxL+eak+IwrujtWBDfBCCJxivZ6cljU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751524149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcDHMkFTXoj37LpVYdwr2vQBaGqjqXSrgjGcPFlY/1I=;
	b=bJyjhwV0u/KWb9wAglXK+TyaN4hPjvADakXvL/sB8WEORmmEm8ySxdlu4GvR4TWaKWGIE8
	M03RBrBQSTXzH0DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751524149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcDHMkFTXoj37LpVYdwr2vQBaGqjqXSrgjGcPFlY/1I=;
	b=jj+PhLlBlVvDqRRTPaeN5k8r08UZmVAy1fXewAadlcag4CAoMlfW1kafV/qiL5ZriHjPF4
	wO2Oe+5Z2uSps2wW5/12JVh2BUbYsVfvaSFIVFAGisdA8r86hnIjR0aQ5AUpE8EVZ5F8Kn
	KxL+eak+IwrujtWBDfBCCJxivZ6cljU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751524149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcDHMkFTXoj37LpVYdwr2vQBaGqjqXSrgjGcPFlY/1I=;
	b=bJyjhwV0u/KWb9wAglXK+TyaN4hPjvADakXvL/sB8WEORmmEm8ySxdlu4GvR4TWaKWGIE8
	M03RBrBQSTXzH0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C46861368E;
	Thu,  3 Jul 2025 06:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kt4nLTQjZmj6SAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 03 Jul 2025 06:29:08 +0000
Message-ID: <9c7f50c9-dd43-4b75-83ee-eac6a6ee2093@suse.de>
Date: Thu, 3 Jul 2025 08:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] blk-mq: add
 blk_mq_{online|possible}_queue_affinity
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Costa Shulyupin
 <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, storagedev@microchip.com,
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-3-557aa7eacce4@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250702-isolcpus-io-queues-v7-3-557aa7eacce4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_232911_534566_BF26D6DF 
X-CRM114-Status: GOOD (  22.86  )
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

On 7/2/25 18:33, Daniel Wagner wrote:
> Introduce blk_mq_{online|possible}_queue_affinity, which returns the
> queue-to-CPU mapping constraints defined by the block layer. This allows
> other subsystems (e.g., IRQ affinity setup) to respect block layer
> requirements.
> 
> It is necessary to provide versions for both the online and possible CPU
> masks because some drivers want to spread their I/O queues only across
> online CPUs, while others prefer to use all possible CPUs. And the mask
> used needs to match with the number of queues requested
> (see blk_num_{online|possible}_queues).
> 
Technically you are correct.
However, I do have the sneaking suspicion that most drivers just use
num_online_cpus() for convenience and to reduce the size of the
structures.
But I guess I'll comment on that in the patch modifying the drivers.

> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/blk-mq-cpumap.c  | 24 ++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 705da074ad6c7e88042296f21b739c6d686a72b6..8244ecf878358c0b8de84458dcd5100c2f360213 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -26,6 +26,30 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
>   	return min_not_zero(num, max_queues);
>   }
>   
> +/**
> + * blk_mq_possible_queue_affinity - Return block layer queue affinity
> + *
> + * Returns an affinity mask that represents the queue-to-CPU mapping
> + * requested by the block layer based on possible CPUs.
> + */
> +const struct cpumask *blk_mq_possible_queue_affinity(void)
> +{
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_possible_queue_affinity);
> +
> +/**
> + * blk_mq_online_queue_affinity - Return block layer queue affinity
> + *
> + * Returns an affinity mask that represents the queue-to-CPU mapping
> + * requested by the block layer based on online CPUs.
> + */
> +const struct cpumask *blk_mq_online_queue_affinity(void)
> +{
> +	return cpu_online_mask;
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_online_queue_affinity);
> +
>   /**
>    * blk_mq_num_possible_queues - Calc nr of queues for multiqueue devices
>    * @max_queues:	The maximum number of queues the hardware/driver
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 2a5a828f19a0ba6ff0812daf40eed67f0e12ada1..1144017dce47af82f9d010e42bfbf26fa4ddf33f 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -947,6 +947,8 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
>   void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
>   void blk_freeze_queue_start_non_owner(struct request_queue *q);
>   
> +const struct cpumask *blk_mq_possible_queue_affinity(void);
> +const struct cpumask *blk_mq_online_queue_affinity(void);
>   unsigned int blk_mq_num_possible_queues(unsigned int max_queues);
>   unsigned int blk_mq_num_online_queues(unsigned int max_queues);
>   void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

