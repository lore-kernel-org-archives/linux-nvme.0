Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DF5CA1013
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 07:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z3iORdkyQPwCpPLP7o4laiR1F+rqzx3WvY73dnkVN5c=; b=GWQy1MLOiSeBuFjcuTOqiyEEI0
	ejsFEih8srjHUJhfyWCAwXWGcRpJz8zeS+NoCt9Yku02boKrK0rtTlQNxiHKnEjcUr58A7Cqas1BG
	AxRwCHVJHeQIVd6Ka20sLLsvHuWRNgxpLmQi5Usuqw7KQw4NndZRFMEHnjKaBtezAWvjv6/I5vp28
	CqESfbBXtVJipPaRzANvyzhJ+gr+6BepNEJBwdcf6h2ZLdn1oLJ9WQO1xnwMir4ks1yzi+as/4IjR
	3zuN5wLImBLbmGCNVo0s/fBP8NYfGLzCtn8mOC8gQv2jvThUcum+9bVfgAlds+MvSNpl1Tdkyxjvs
	NlzzCkSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvWkH-0000000FVDy-1u1i;
	Mon, 08 Sep 2025 07:57:01 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvWQY-0000000FLFp-1x8j
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 07:36:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2887F24215;
	Mon,  8 Sep 2025 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757316995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3iORdkyQPwCpPLP7o4laiR1F+rqzx3WvY73dnkVN5c=;
	b=j12DB15xycT1y2h8zkiOsuAbNDHxZ34VelYF/VA7yd3A0HRjXv4sY0GVQonjUyMkEaSnTR
	x6RMcS5Kg5NYSrTQN9pNah/gnkV2wFFeUN59/T6Jdn5+KLSvneVrTwbwomHj5/KzQpQGYx
	2YFF6GkK7SAPf79oJA4j7HDoHL8NoLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757316995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3iORdkyQPwCpPLP7o4laiR1F+rqzx3WvY73dnkVN5c=;
	b=1STPvFqlIsD2EnCafT0BPj3XeX2imFQnh/uV+dg0VWNUEChSZv6AHBBJ13EFv50fQPZEvX
	JfVqwg7LOKfelNDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757316995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3iORdkyQPwCpPLP7o4laiR1F+rqzx3WvY73dnkVN5c=;
	b=j12DB15xycT1y2h8zkiOsuAbNDHxZ34VelYF/VA7yd3A0HRjXv4sY0GVQonjUyMkEaSnTR
	x6RMcS5Kg5NYSrTQN9pNah/gnkV2wFFeUN59/T6Jdn5+KLSvneVrTwbwomHj5/KzQpQGYx
	2YFF6GkK7SAPf79oJA4j7HDoHL8NoLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757316995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3iORdkyQPwCpPLP7o4laiR1F+rqzx3WvY73dnkVN5c=;
	b=1STPvFqlIsD2EnCafT0BPj3XeX2imFQnh/uV+dg0VWNUEChSZv6AHBBJ13EFv50fQPZEvX
	JfVqwg7LOKfelNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1587213869;
	Mon,  8 Sep 2025 07:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iptWBIOHvmjwRAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 08 Sep 2025 07:36:35 +0000
Date: Mon, 8 Sep 2025 09:36:34 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, storagedev@microchip.com, 
	virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <c9ef4fa6-99a4-46fd-8623-b8979556566e@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_003638_654931_CAAB8D83 
X-CRM114-Status: GOOD (  17.20  )
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

On Fri, Sep 05, 2025 at 04:59:56PM +0200, Daniel Wagner wrote:
>  void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  {
> -	const struct cpumask *masks;
> +	struct cpumask *masks __free(kfree) = NULL;
> +	const struct cpumask *constraint;
>  	unsigned int queue, cpu, nr_masks;
> +	cpumask_var_t active_hctx;
>  
> +	if (!zalloc_cpumask_var(&active_hctx, GFP_KERNEL))
> +		goto fallback;
> +

> +	free_cpumask_var(active_hctx);
> +
> +	return;
> +
> +free_fallback:
> +	free_cpumask_var(active_hctx);
> +
> +fallback:
> +	blk_mq_map_fallback(qmap);

I am not so happy that the cpumask_var_t and __free doesn't work to
together at this point due to the 'evil way' how cpumask_var_t is defined:

	ifdef CONFIG_CPUMASK_OFFSTACK
	typedef struct cpumask *cpumask_var_t;
	#else
	typedef struct cpumask cpumask_var_t[1];
	#endif /* CONFIG_CPUMASK_OFFSTACK */

In the previous version I used

	cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;

which resulted in a way cleaner code. Though the kernel test robot
complained with

      >> block/blk-mq-cpumap.c:155:16: error: array initializer must be an initializer list
           155 |         cpumask_var_t active_hctx __free(free_cpumask_var) = NULL;

I try to figure out if it's possible to get this somehow working with
some witchcraft (aka pre compiler magic).

