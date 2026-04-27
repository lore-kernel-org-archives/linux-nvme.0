Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD2DFF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syzL+NfjinYh51hpkgzfpIU6HhS/fUWSvJ4DCEFqBSw=; b=JoYHJwPyEfwEX82g/gLbG2nXam
	Oq3l0s00f1UVXqQ0BGm1i8yZ6e4e248TRozlYQrOsXdnknvF+PRMVHRFJ8bVXBL9qk7vTaGWbAv6W
	q4e47BnytzSpkCEp888i/X6w2mNN/lFe4HT+Ce8J8ZNqGxurURu1nA3UJ/7UUUYITwAwkiNv2tZoF
	DTTe1hus5njjZGzwLCGVStD64ubY/sitqCRwaImInhxpcIuSw8Kdk/ITZs/Lz3TvQ9D8r7wV/1N+f
	o8GFUTxTqzp0G+82Rii5vG70qrHdUzwEc0FPF0TrMVoOjWPMQR3QFSxU5QwQeI1zRGGz51H92MxXY
	8Kbb9mgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI82-0000000GZwB-3GSn;
	Mon, 27 Apr 2026 09:19:46 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI81-0000000GZvd-0AOX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:19:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2470A6A944;
	Mon, 27 Apr 2026 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syzL+NfjinYh51hpkgzfpIU6HhS/fUWSvJ4DCEFqBSw=;
	b=oXwqxRw+ZReua2z8BWztqk35wuuOx/OYRzLBqaccSedKFxg7PqhkWfJ9pVuRVbpmVq83yh
	9Zgzj/0cbqe2jogTMhF3eV28FqbRmF/QTPGDoR0h0mgRVFcUFUUcs/Vj0e5paYblvuM7vI
	ia+P8dikPGLdeUigT71Z5NjQwyoya9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syzL+NfjinYh51hpkgzfpIU6HhS/fUWSvJ4DCEFqBSw=;
	b=IVn37nJkm5EhBS1dWWWtHGuhE28LpRD4RAw5K5kqe/SrIWyluKda/zFQiHiYo0HvmkMr3o
	62/Gekcz69/l2lCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mRP0vvRX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pe51P6u4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syzL+NfjinYh51hpkgzfpIU6HhS/fUWSvJ4DCEFqBSw=;
	b=mRP0vvRXe7Sl+cfzIxeFLzVSz9idZKC6usLZqCw4nJ5KhgV5hKl+5/vUFcjlRoG0IJlBw0
	z9I0BICG/bBjg66VUH50afCne/gaLp6jhpVu4F02Is+GvgXS+EI+DVboqgPNXMSolSfm8z
	PWBP/QVVycuG+T+eXSm+0u66Cc+o8mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syzL+NfjinYh51hpkgzfpIU6HhS/fUWSvJ4DCEFqBSw=;
	b=Pe51P6u4CblmDy6+JovPsbZUs9lkz6D2r0p/pCX7000cpIsGhWL0hteza+ZV7DhMzIoXu9
	pZdQeU3uMyKS0MAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E5D5593B0;
	Mon, 27 Apr 2026 09:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u0JOAisq72mlTQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:19:39 +0000
Date: Mon, 27 Apr 2026 11:19:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org, mkhalfella@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <de1c7a7a-b786-4a03-a2c0-34a288e31c20@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-5-mlombard@redhat.com>
 <d776e448-461d-4888-a685-a9af79c61d9c@flourine.local>
 <DI3TM2S46GYN.38E7GIF26O7GD@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI3TM2S46GYN.38E7GIF26O7GD@arkamax.eu>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2470A6A944
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_021945_251634_F918FE91 
X-CRM114-Status: GOOD (  11.15  )
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

On Mon, Apr 27, 2026 at 11:13:43AM +0200, Maurizio Lombardi wrote:
> >> @@ -5136,6 +5137,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> >>  	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
> >>  	ctrl->ka_last_check_time = jiffies;
> >>  	ctrl->admin_timeout = NVME_ADMIN_TIMEOUT;
> >> +	ctrl->io_timeout = NVME_IO_TIMEOUT;
> >
> > Should this be initialized with the defaults from the module load time?
> 
> 
> Yes, note that NVME_IO_TIMEOUT is a macro that depends on the
> "nvme_io_timeout" module parameter set at load time.

Ah yes, didn't read the definition of NVME_IO_TIMEOUT. Sorry for the
noise.

The rest looks good to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

