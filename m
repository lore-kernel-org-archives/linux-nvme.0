Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800CCCC6B1D
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=; b=1IJSEmk9bPmESWIbMaQoOhZoey
	8vCM4XQh2AQeqOOx2NrS6s+GEL4VrQ40IlvBdrP6VrvOrQQf6i8iqyq1vMpS4NMXPUn5tOH9rHzD2
	si/IvzY7vm48Xs2B+p/iKnqoL1jhYheU0LFp075SVf3907BgLqRa6tXQ6/gv352pTqqZ8wU+KYEdx
	3cezGpJ09fcvPNjDQ5rCFzM2XiaVKWVJN8MvYHsQiacTpCqp+jTdRViUtgds2J5bqbIDSb4H1aDpG
	aiZ7A0qvCAyxifa6tU9hfiCMc6I3CQIlcR6Xy+EbSMP1WHsWvngqjiqQXZI+QM2vmX3c2K+QTaNHw
	TR/eu0Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyNF-0000000FU6O-4307;
	Wed, 14 Oct 2026 12:46:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyN7-0000000FU50-44Xj
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 12:46:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1441FB60;
	Wed, 14 Oct 2026 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Y8wy5yfdVq86Q5k04TxfBS38OWfohfpK1BVq6eZQXND0tTrbWUnl8uHBfdrIHynssv7VJb
	XIjQoRX+rRrnYYdB3mgqtIvomogrpVaVtKH+XnUmG2/T9Bjp+SsXS802R83YO7y9otUgld
	THgJSEN6Urr5x8gPNY50lA/E8DVa8bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Yrj976DB4rU9pA3E8wU7wCw9IFFFaX7mPxnvh4eSK1s8LcxoMa7Hr9f0zX43R9fT6qi6bV
	SWCSnsNkOTIbH9BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Y8wy5yfdVq86Q5k04TxfBS38OWfohfpK1BVq6eZQXND0tTrbWUnl8uHBfdrIHynssv7VJb
	XIjQoRX+rRrnYYdB3mgqtIvomogrpVaVtKH+XnUmG2/T9Bjp+SsXS802R83YO7y9otUgld
	THgJSEN6Urr5x8gPNY50lA/E8DVa8bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4yChObc0Pr5+TH+wCOECBsU64iiuVGH1brRjSQo7/o=;
	b=Yrj976DB4rU9pA3E8wU7wCw9IFFFaX7mPxnvh4eSK1s8LcxoMa7Hr9f0zX43R9fT6qi6bV
	SWCSnsNkOTIbH9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6D6A1368E;
	Wed, 14 Oct 2026 12:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4fQEGJd5z2oXDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 12:46:15 +0000
Date: Wed, 14 Oct 2026 14:46:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	Surabhi Gogte <sgogte@purestorage.com>, Hannes Reinecke <hare@kernel.org>, 
	Nilay Shroff <nilay@linux.ibm.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/5] nvme-tcp: initialize pf_cache_lock when allocating
 the controller
Message-ID: <93fdde74-b362-4b06-a08e-c5027bd5619d@flourine.local>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-1-355156be27b2@kernel.org>
 <20261014110804.VsqI0ZaP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014110804.VsqI0ZaP@linutronix.de>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:url]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_054618_155031_C20099F3 
X-CRM114-Status: GOOD (  13.78  )
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

On Wed, Oct 14, 2026 at 01:08:04PM +0200, Sebastian Andrzej Siewior wrote:
> > Initialize pf_cache_lock for all queues when allocating the controller
> > and keep it for the lifetime of the controller.
> > 
> > Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> 
> I only see 2a8513091d2f0 ("nvme-rdma: parallelize I/O queue allocation
> and startup"). That tcp commit is not in next-20261013.

The commit is in

https://git.infradead.org/?p=nvme.git;a=shortlog;h=refs/heads/nvme-7.4

but I missed the nvme-rdma version of it. It's about time to merge this
into common code.

Thanks,
Daniel

