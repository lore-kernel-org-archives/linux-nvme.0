Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61317CA101F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/CSSfN43nuBpCmvlSQv0g4m2YsMRqWgQtvSodhnH28=; b=lNvmpcVBJ1CepshPE6HAq106dW
	I63TbywIPKjWKRYzAlOIHfU05xL/pUR3Y/ZKrrXwgdgr9Mh3bth+2xmoCBnQTCfy03q/kJtNppIm5
	ol3XrQbBJYEZH6CbRdjDX4HLc/vbXdo0pjZJ7hJnqteqJRKxdH8iGFkjRqCSsOKGM3Jfm0+4nx6FD
	+edHriAMTViHVmj3EidDsbksCGw7qTp/5P+l6g8Wrz9aTFBW1VL7cCFlnmwImdsAupNv5KX/ISZyj
	YmQtnSbYwZkf7l0izqkQkNqoUWN6Y4h3lGKJlLlxFr0fqmZRLdy/FX3zJM1GJWnk87YYN4vLM1OVO
	Nuhtmfgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwzDB-00000007wfW-22OZ;
	Fri, 12 Sep 2025 08:32:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwzD8-00000007wdK-3qQz
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 08:32:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46C8C20706;
	Fri, 12 Sep 2025 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757665967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/CSSfN43nuBpCmvlSQv0g4m2YsMRqWgQtvSodhnH28=;
	b=NzGZs2VaUva7nAB6VbcEuZSvhBSVlcW4blbtBY6HNBMWWAXbae08r9qYs3v5z+GdRFYgY/
	VbeEpqO4pA7jByje53TP/rNV4Elzxv+SZjUQ0OFLzzAAZ+Kr/L3Bym88W7Dx4Ul2nVvL3l
	TyT0M91a3S/Kr9Dj+CvBgTFiBddEJYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757665967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/CSSfN43nuBpCmvlSQv0g4m2YsMRqWgQtvSodhnH28=;
	b=IJRvEf8MaAIKPa9ZL8mK7o1+fIpbj5bi9eT0ydLdxT6d/IYDCbkKoZdlcbLdgnxuO7SBlJ
	gjmRz1UNrH/tLXCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757665967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/CSSfN43nuBpCmvlSQv0g4m2YsMRqWgQtvSodhnH28=;
	b=NzGZs2VaUva7nAB6VbcEuZSvhBSVlcW4blbtBY6HNBMWWAXbae08r9qYs3v5z+GdRFYgY/
	VbeEpqO4pA7jByje53TP/rNV4Elzxv+SZjUQ0OFLzzAAZ+Kr/L3Bym88W7Dx4Ul2nVvL3l
	TyT0M91a3S/Kr9Dj+CvBgTFiBddEJYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757665967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/CSSfN43nuBpCmvlSQv0g4m2YsMRqWgQtvSodhnH28=;
	b=IJRvEf8MaAIKPa9ZL8mK7o1+fIpbj5bi9eT0ydLdxT6d/IYDCbkKoZdlcbLdgnxuO7SBlJ
	gjmRz1UNrH/tLXCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B4113869;
	Fri, 12 Sep 2025 08:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YkOaDK/aw2hKLgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 12 Sep 2025 08:32:47 +0000
Date: Fri, 12 Sep 2025 10:32:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, virtualization@lists.linux.dev, 
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v8 10/12] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <bc5ebdea-7091-4999-a021-ec2a65573aa0@flourine.local>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
 <20250905-isolcpus-io-queues-v8-10-885984c5daca@kernel.org>
 <ff66801c-f261-411d-bbbf-b386e013d096@suse.de>
 <d11a0c60-1b75-49ec-a2f8-7df402c4adf2@flourine.local>
 <87ms72u3at.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms72u3at.ffs@tglx>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL67935bhfdkbndpbo95z3ogoo)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_013251_101937_E2DD2F6C 
X-CRM114-Status: GOOD (  28.98  )
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

On Wed, Sep 10, 2025 at 10:20:26AM +0200, Thomas Gleixner wrote:
> On Mon, Sep 08 2025 at 09:26, Daniel Wagner wrote:
> > On Mon, Sep 08, 2025 at 08:13:31AM +0200, Hannes Reinecke wrote:
> >> >   const struct cpumask *blk_mq_online_queue_affinity(void)
> >> >   {
> >> > +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> >> > +		cpumask_and(&blk_hk_online_mask, cpu_online_mask,
> >> > +			    housekeeping_cpumask(HK_TYPE_IO_QUEUE));
> >> > +		return &blk_hk_online_mask;
> >> 
> >> Can you explain the use of 'blk_hk_online_mask'?
> >> Why is a static variable?
> >
> > The blk_mq_*_queue_affinity helpers return a const struct cpumask *, the
> > caller doesn't need to free the return value. Because cpumask_and needs
> > store its result somewhere, I opted for the global static variable.
> >
> >> To my untrained eye it's being recalculated every time one calls
> >> this function. And only the first invocation run on an empty mask,
> >> all subsequent ones see a populated mask.
> >
> > The cpu_online_mask might change over time, it's not a static bitmap.
> > Thus it's necessary to update the blk_hk_online_mask. Doing some sort of
> > caching is certainly possible. Given that we have plenty of cpumask
> > logic operation in the cpu_group_evenly code path later, I am not so
> > sure this really makes a huge difference.
> 
> Sure,  but none of this is serialized against CPU hotplug operations. So
> the resulting mask, which is handed into the spreading code can be
> concurrently modified. IOW it's not as const as the code claims.

Thanks for explaining.

In group_cpu_evenly:

	/*
	 * Make a local cache of 'cpu_present_mask', so the two stages
	 * spread can observe consistent 'cpu_present_mask' without holding
	 * cpu hotplug lock, then we can reduce deadlock risk with cpu
	 * hotplug code.
	 *
	 * Here CPU hotplug may happen when reading `cpu_present_mask`, and
	 * we can live with the case because it only affects that hotplug
	 * CPU is handled in the 1st or 2nd stage, and either way is correct
	 * from API user viewpoint since 2-stage spread is sort of
	 * optimization.
	 */
	cpumask_copy(npresmsk, data_race(cpu_present_mask));


0263f92fadbb ("lib/group_cpus.c: avoid acquiring cpu hotplug lock in
group_cpus_evenly"):

  group_cpus_evenly() could be part of storage driver's error handler, such
  as nvme driver, when may happen during CPU hotplug, in which storage queue
  has to drain its pending IOs because all CPUs associated with the queue
  are offline and the queue is becoming inactive.  And handling IO needs
  error handler to provide forward progress.

  Then deadlock is caused:

  1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
     handler is waiting for inflight IO

  2) error handler is waiting for CPU hotplug lock

  3) inflight IO can't be completed in blk-mq's CPU hotplug handler
     because error handling can't provide forward progress.

  Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
  in which two stage spreads are taken: 1) the 1st stage is over all present
  CPUs; 2) the end stage is over all other CPUs.

  Turns out the two stage spread just needs consistent 'cpu_present_mask',
  and remove the CPU hotplug lock by storing it into one local cache.  This
  way doesn't change correctness, because all CPUs are still covered.

This sounds like I should do something similar with cpu_online_mask.
Anyway, I'll work on this.

> How is this even remotely correct?

It isn't :( I did hotplug tests but obviously these were not really up
to the task. The kernel test bot gave me a pointer how I should test.

