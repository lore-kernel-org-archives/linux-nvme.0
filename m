Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCABCD342F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bOXabdlrFtpEZay26IE7xlK4R0wi7QCHtW/gPVcwG58=; b=sUM6+/tAlHZHL82EvOPcb9FURw
	2Yhqh/WlHLQVbvVFGzmocNOc843ADLQmz8zqyPcN6aDzKrtxcC58PJtusStUwW2SbWyqM/VvdA6xg
	MGhRS7+HJUzmAmnQlj0509K7lt2edOHeva7FNr/yF007HQc/d30GdttFcoy9H9zo6gkgVuNkcq87h
	WZv8AwJYlcZrDd5kwfLpMA/WfjMXVVCyVWX+hwtArGKmmwI2GVIYbmIYajgxkGITCOHgtTyQiGqiD
	OvKIL31BR0OYunoGruSqVIbz8SAXlPqCXsa9ZBq9BQMXtkukM6B7YKIgKQoR4VTEI93Kof+fqVF19
	r4lPW3iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOhQ-000000075Cq-3ycZ;
	Fri, 08 May 2026 17:09:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLOhN-000000075BJ-3RUB
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 17:09:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79EAC5CF76;
	Fri,  8 May 2026 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778260151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOXabdlrFtpEZay26IE7xlK4R0wi7QCHtW/gPVcwG58=;
	b=eo89XL5UP8E5AR1yGjlo9PQ6z6QxHNhGSAiQgSZu75PLd1Owj1Oq+29hbnQP4MEMao4zme
	6S0YWALTTmCyxDNwA6kqFAnPcvz1nCVlGZfYca48+okL7SvAoNJy5AGlx0MHc1AoAje6/7
	mrlswadlrO9Kyg/+6htW/D9SIX252fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778260151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOXabdlrFtpEZay26IE7xlK4R0wi7QCHtW/gPVcwG58=;
	b=WDQlC/qWGXPctvGG07Wr57TLhrsZQ8y8+NjCQ/nToVkCIt5z/Wu1HTjwUSMf+sTMYOdnSZ
	4OfCxfjQ8V9TgCAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eo89XL5U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WDQlC/qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778260151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOXabdlrFtpEZay26IE7xlK4R0wi7QCHtW/gPVcwG58=;
	b=eo89XL5UP8E5AR1yGjlo9PQ6z6QxHNhGSAiQgSZu75PLd1Owj1Oq+29hbnQP4MEMao4zme
	6S0YWALTTmCyxDNwA6kqFAnPcvz1nCVlGZfYca48+okL7SvAoNJy5AGlx0MHc1AoAje6/7
	mrlswadlrO9Kyg/+6htW/D9SIX252fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778260151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOXabdlrFtpEZay26IE7xlK4R0wi7QCHtW/gPVcwG58=;
	b=WDQlC/qWGXPctvGG07Wr57TLhrsZQ8y8+NjCQ/nToVkCIt5z/Wu1HTjwUSMf+sTMYOdnSZ
	4OfCxfjQ8V9TgCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66E6B593A7;
	Fri,  8 May 2026 17:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xk9zF7cY/mkOagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 08 May 2026 17:09:11 +0000
Date: Fri, 8 May 2026 19:09:06 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 8/9] nvmet-loop: do not alloc admin tag set during
 reset
Message-ID: <2cdd4383-0444-44ec-9659-502eb3fc905b@flourine.local>
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-9-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-9-mlombard@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 79EAC5CF76
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_100914_020830_7F34C44B 
X-CRM114-Status: GOOD (  12.53  )
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

On Fri, May 08, 2026 at 03:33:34PM +0200, Maurizio Lombardi wrote:
> Currently, resetting a loopback controller unconditionally invokes
> nvme_alloc_admin_tag_set() inside nvme_loop_configure_admin_queue().
> Doing so drops the old queue and allocates a new one. Consequently,
> this reverts the admin queue's timeout (q->rq_timeout) back to the
> module default (NVME_ADMIN_TIMEOUT), completely wiping out any custom
> timeout values the user may have configured via sysfs and potentially
> racing against the sysfs nvme_admin_timeout_store() function
> that may dereference the admin_q pointer during the RESETTING state.
> 
> Decouple the admin tag set lifecycle from the admin queue
> configuration and destruction paths, which are executed during resets;
> Specifically:
> 
> * Move nvme_alloc_admin_tag_set() into nvme_loop_create_ctrl() so it
>   is only allocated once during the initial controller creation.
> 
> * Defer the destruction of the admin tag set to
>   nvme_loop_delete_ctrl_host() and the terminal error-handling
>   paths of nvme_loop_reset_ctrl_work() and
>   nvme_loop_create_ctrl().
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

