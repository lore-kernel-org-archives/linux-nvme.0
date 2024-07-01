Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0AC3065A
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=; b=25g5T1xbhadhcgpXFzeBXWKUZF
	Yeia4NYiM0omLjB6K4Gg5uHZXOXVFqq6FsqJ6QvVfSHqZiU79fBhEehub7CuzGHjrUgYcLC9ZRyW1
	PtDCloSs39JAcIrm1SOG8LTbbSEqSu5NX0lVcldF7wB8cSYsKMkV54Uf9aNRq/C/wtbKWNeDMIzZu
	qOrTpgYBFMfgqEb3OLY0Mssr8/5v9n0MRcmueXFzTw/jmKrVfmJZGH2tV2KT/TC1bVDRAETkVqJng
	C0URVEbpXY66K/o2+lf41u9WoQx+IwnAa1APJPXVntXkcvAUh1ojAeMpyMyNAs1WAxDH7/iBvWmyF
	ULAmbTbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB9U-00000001yOj-2xV8;
	Mon, 01 Jul 2024 07:08:40 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOB9Q-00000001yNQ-38tT
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 07:08:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 758D81FD10;
	Mon,  1 Jul 2024 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=E5D/5lA3GPdQFrm+DcB4lsbtZLBdLeBM+lNrcmDidhzEaUD1nAPrI6mkx4k8UDnqQ+RNcN
	N107auTvzRLKpKS89GFAldnYPZiwfiSK0XGA6trhJ5OtmT38wPUO6qY8zs4TlRko3hIKiU
	1rkvu1dE7fygT626EnUUn9ADQgKaXo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=yAHt4jjOMQ/N2PreKfsA3TRswfX1942nBBDfwFEYV3G30JmdIwg4pK3PrfHvpSXDyAbHQ/
	dgcATWCOD160+5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=E5D/5lA3GPdQFrm+DcB4lsbtZLBdLeBM+lNrcmDidhzEaUD1nAPrI6mkx4k8UDnqQ+RNcN
	N107auTvzRLKpKS89GFAldnYPZiwfiSK0XGA6trhJ5OtmT38wPUO6qY8zs4TlRko3hIKiU
	1rkvu1dE7fygT626EnUUn9ADQgKaXo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mf2P1vKclwSkkHmlpVTjjIq7zNNr2YdrgwLcDz6LPLA=;
	b=yAHt4jjOMQ/N2PreKfsA3TRswfX1942nBBDfwFEYV3G30JmdIwg4pK3PrfHvpSXDyAbHQ/
	dgcATWCOD160+5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CF4139C2;
	Mon,  1 Jul 2024 07:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GrByE/FVgmbqaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 01 Jul 2024 07:08:33 +0000
Date: Mon, 1 Jul 2024 09:08:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Christoph Hellwig <hch@lst.de>, Frederic Weisbecker <fweisbecker@suse.com>, 
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
	Sridhar Balaraman <sbalaraman@parallelwireless.com>, "brookxu.cn" <brookxu.cn@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoFgLxGXrk4VCR03@fedora>
X-Spamd-Result: default: False [-2.29 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_000836_961051_9B062664 
X-CRM114-Status: GOOD (  16.14  )
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

On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
> > Make group_cpus_evenly aware of isolcpus configuration and use the
> > housekeeping CPU mask as base for distributing the available CPUs into
> > groups.
> > 
> > Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> 
> isolated CPUs are actually handled when figuring out irq effective mask,
> so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
> patch from user viewpoint?

IO queues are allocated/spread on the isolated CPUs and if there is an
thread submitting IOs from an isolated CPU it will cause noise on the
isolated CPUs. The question is this a use case you need/want to support?
We have customers who are complaining that even with isolcpus provided
they still see IO noise on the isolated CPUs.

