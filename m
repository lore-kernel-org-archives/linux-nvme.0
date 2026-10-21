Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E9606A332
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BuWOwF+A;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2DKp838h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+YSkjRbj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=; b=BuWOwF+AdwLu19uPYB+jBXty65
	R+YN4j0/wIoAWg/DypEVBHo9KS8QR3Oe06qmt2NstbMnD/6l9P79U8PfKPXPqGjV4wREMcD04oRkC
	ygOuYSuGKdfJvDF2qJBvf/Zuk4iGc5wYT6W/9iu/6tHqu2Ine7fpep4iZqL+EWWmkOSOCnoifstZv
	ED/R/uc7vgYXoU83p3uVjRGe1OZ3k6vpw5dDu7i8ICTaeVkJY2QecUost3pH4y3Flo5F3myz8Da8L
	OM2AUDuNlwaElwfKOfj66fnbeuFXb9pkFNSqdMaBei1jjxT2il78aQlSGn1zVecfH9jw3HT/vWBG9
	UsUJRo0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUEB-0000000BhpE-2Qsh;
	Wed, 21 Oct 2026 11:11:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUE9-0000000Bhoi-0YHL
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 11:11:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75BF81F799;
	Wed, 21 Oct 2026 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=2DKp838h55iWZtAoeCI3WZP/tbtdH69Fwhhl5snOhoo/SOvL3TPxNEB7kElvokkgG+kFMH
	dRdZN201sNExTcipJQflaHmiV6GJKQ55UmD7+lzYVcd0icuunWJunUswUzPBuKizecMJZx
	oImFJ5JvtScmceKTbnbyHQw3a7PtGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=+YSkjRbjIc3ICzHlctLiruKD0Aw4WtCCt1FOeWs6Wcaam8cuUt2KI0ECIFZ8cLajG6TuAU
	7XEJbLme4433DjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=2DKp838h55iWZtAoeCI3WZP/tbtdH69Fwhhl5snOhoo/SOvL3TPxNEB7kElvokkgG+kFMH
	dRdZN201sNExTcipJQflaHmiV6GJKQ55UmD7+lzYVcd0icuunWJunUswUzPBuKizecMJZx
	oImFJ5JvtScmceKTbnbyHQw3a7PtGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0j1drhlnlCtpxxLEzYakiDDyaGlUXaZ4daHm/zAbPc=;
	b=+YSkjRbjIc3ICzHlctLiruKD0Aw4WtCCt1FOeWs6Wcaam8cuUt2KI0ECIFZ8cLajG6TuAU
	7XEJbLme4433DjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D84613518;
	Wed, 21 Oct 2026 11:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TnWRBNud2GqWAQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:11:23 +0000
Message-ID: <e818bd40-2333-412c-800f-9bad6d6d7f6b@suse.de>
Date: Wed, 21 Oct 2026 13:11:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme-fabrics: reset io_queues before computing the
 queue mapping
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-3-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-3-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_041125_326605_C272DB18 
X-CRM114-Status: GOOD (  19.19  )
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> nvmf_set_io_queues only sets the io_queues entries of the queue types it
> hands out, but the array is reused on every reconnect.  When the
> controller grants fewer queues on a reconnect, stale entries survive and
> nvmf_map_queues maps CPUs to hardware contexts that don't exist anymore,
> which crashes blk_mq_map_swqueue with a NULL pointer dereference.  E.g.
> with nr_io_queues=8, nr_write_queues=8 and nr_poll_queues=8, 24 queues
> are mapped 8/8/8 (default/read/poll).  If the controller grants only 16
> queues on the reconnect, the poll map still starts at hardware context
> 16.
> 
> Clear the array before computing the new mapping.
> 
> Fixes: 6486199378a5 ("nvme-tcp: fix queue mapping when queue count is limited")
> Fixes: 5651cd3c4336 ("nvme-rdma: fix queue mapping when queue count is limited")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 59f823dfbbcc..571de549fbaf 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1125,6 +1125,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
>   			u32 io_queues[HCTX_MAX_TYPES])
>   {
> +	memset(io_queues, 0, sizeof(*io_queues) * HCTX_MAX_TYPES);
> +
>   	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
>   		/*
>   		 * separate read/write queues
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

