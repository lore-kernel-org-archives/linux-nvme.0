Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70F60A263A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Cu7JsaSu;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1bpAITcC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W6xma5eb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1bpAITcC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W6xma5eb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TD9v898UX3qF2ylvN4koKehtQeTz/HyOzZO9+Yk87D8=; b=Cu7JsaSu3Y6erQuO7EeR9eiML/
	c96kyPffRM4kWPp+Fy3MBvg+WhXnWJzMZL9B8XyKJ37AOICDQHtHQuzVcUYtN77S+jbPaSZZum4gQ
	nD99R8Jm28kyIwwIbSmsCIfGfLd1U1/dgc5gRmK40qZMCwk6dbYGHbMeUc9+WtYCPYXv6o+g9kpfW
	/m3cWVFzLv6lLqCYRfFgvyvEk9o7Ml/ZGtse8/+BvQTRAXFW1xTEWeTia34jhpzJSzaY3l222kXBD
	795VW//rZ7oqSmgu8gaWl2MWECelM7IiorfeVPU5Xw/Kms7l8v6uYOQ/SmKKz8AaKpD5W3ALkt7ZU
	s3+gIymw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBld-0000000A3X3-3mCi;
	Tue, 20 Oct 2026 15:28:45 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJBlX-0000000A3WZ-25rb
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 15:28:44 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA2BC21BD4;
	Tue, 20 Oct 2026 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792510117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9v898UX3qF2ylvN4koKehtQeTz/HyOzZO9+Yk87D8=;
	b=1bpAITcCb5f898dun/BD8wIgbqpZueKF+RIkk1lSsH7YSXbtgB81M8OqBTuUBImXNUAigH
	wVvaNVb0ikxAy3YF8LmkebHeEO13guL9G6cMW5FNwOCtIo79lT9d1uMz/SVXJn/ieB9Gxq
	ruQGY2HgVypvGlT6tkmCGXH6CHxiWqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792510117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9v898UX3qF2ylvN4koKehtQeTz/HyOzZO9+Yk87D8=;
	b=W6xma5ebx8od1FAK84AMNC3VmK9clUwX5y5sBCHcfO6t9oyZYXq5UjzWX+eC1rh6iVqEdj
	q2C6ZWNqUvBUX7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792510117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9v898UX3qF2ylvN4koKehtQeTz/HyOzZO9+Yk87D8=;
	b=1bpAITcCb5f898dun/BD8wIgbqpZueKF+RIkk1lSsH7YSXbtgB81M8OqBTuUBImXNUAigH
	wVvaNVb0ikxAy3YF8LmkebHeEO13guL9G6cMW5FNwOCtIo79lT9d1uMz/SVXJn/ieB9Gxq
	ruQGY2HgVypvGlT6tkmCGXH6CHxiWqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792510117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9v898UX3qF2ylvN4koKehtQeTz/HyOzZO9+Yk87D8=;
	b=W6xma5ebx8od1FAK84AMNC3VmK9clUwX5y5sBCHcfO6t9oyZYXq5UjzWX+eC1rh6iVqEdj
	q2C6ZWNqUvBUX7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94139136C6;
	Tue, 20 Oct 2026 15:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G/wkHKWI12rmfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 15:28:37 +0000
Date: Tue, 20 Oct 2026 17:28:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk, nilay@linux.ibm.com, sgogte@purestorage.com, 
	hare@kernel.org, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, 
	kiyer@crusoe.ai, ganbalagane@crusoe.ai, sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through
 sysfs
Message-ID: <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local>
References: <20261018010059.83120-1-saravanand@crusoe.ai>
 <20261018010059.83120-3-saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018010059.83120-3-saravanand@crusoe.ai>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_082839_688805_8D56927D 
X-CRM114-Status: GOOD (  21.49  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 06:00:59PM -0700, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
> 
> Expose the io_cpu in each I/O queue's directory
> 
>   /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
> 
> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. The attribute accepts a decimal
> cpu number, -1 or "unbound". A user assignment, unbound included, is
> marked in the queue flags, persists across reconnects and is never
> reselected by the driver. The read-only managed attribute reports 1
> while io_cpu is driver managed and 0 once the user assigned it. The
> accounting of nvme_tcp_cpu_queues applies regardless of who set the
> io_cpu.
> 
> A queue's directory is added when the queue is allocated and removed
> when it is freed, before the queue is torn down, so a sysfs store
> never runs on a freed queue. The queues directory is created before
> the I/O queues are set up in parallel. All io_cpu writes, from sysfs
> and from the driver, serialize with the accounting under
> nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
> The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since
> a sysfs store may move io_cpu in between.
> 
> nvme_tcp_free_queue() now clears NVME_TCP_Q_IO_CPU_SET and drops its
> count, because a queue can still be counted when it is freed. A sysfs
> store may have run after the queue stop, or the connect may have
> failed, and the setup error path frees such a queue without calling
> nvme_tcp_stop_queue(), where the count is normally dropped.
 
This looks good, just trying to wrap my head around with isolcpu (yeah,
doing a bit of work in that area makes me a paranoid).

I think it make sense to allow that the user can change queue CPU
pinning during runtime even with isolcpu enabled. And then the question
is should this be connected to cgroups?

