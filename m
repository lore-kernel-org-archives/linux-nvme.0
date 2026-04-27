Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6A4FF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gnn3QGutdCUtQ7bF9chs7GttO7XwIegPQ7pxsYCFruc=; b=Ku7ZTRiRpB12luUiquVgpMf8Xp
	UK4vMjo5NQX6mizuOSTJYY4nyH2PSMVzhsDO9LXbRI6L4mzCvyGTDH5TUcWT7vq9zJwtLpVZ+ZDEQ
	+p6vFeWjk2wk7TlomqpKblzkeDoOVPIRJwmPTad+JhAm32mubL2ZSqym3lFhrQHD+ob2wevptTNEt
	/78D/69pS40cLKGwh1O2gz/lLW0hgKQgf8TctwdUW8iWhrklS98TyrvOuvnV6n/be6UOXCh6AA6LG
	hLPWITxieLuUE3/f/NW/OjZuBDPLIecRdGxl5QadHG+Jzuhu0XxyCvqmPzN35cwGhAYkJMtTbr+tN
	21loVDdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIXs-0000000GbiW-0mAm;
	Mon, 27 Apr 2026 09:46:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIXp-0000000Gbi4-2bVT
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:46:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3625BD75;
	Mon, 27 Apr 2026 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777283183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnn3QGutdCUtQ7bF9chs7GttO7XwIegPQ7pxsYCFruc=;
	b=Dronn3GUPy24lZBrHnstdl0gErjiZMWqJOuIBN6CbQy5XJ29A0c3gvHC07DRkSQDr/q19S
	BcMgtbRxvKNJEnPE8e81BOmvcckfY4ghhNuI6szbX5D04MCHRkCF24JX691/8FH5A0cYvF
	CgVn6m02jF4eAWDOrM9fRhHHEXHsoXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777283183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnn3QGutdCUtQ7bF9chs7GttO7XwIegPQ7pxsYCFruc=;
	b=YiOgAXwknzenqaJHYqghlBIHpC9sYRFRX/cElU7ER4gs9gqsHLo/Eqr9xE/806ojXXHFcx
	CahMRauKeLKOZzDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dronn3GU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YiOgAXwk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777283183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnn3QGutdCUtQ7bF9chs7GttO7XwIegPQ7pxsYCFruc=;
	b=Dronn3GUPy24lZBrHnstdl0gErjiZMWqJOuIBN6CbQy5XJ29A0c3gvHC07DRkSQDr/q19S
	BcMgtbRxvKNJEnPE8e81BOmvcckfY4ghhNuI6szbX5D04MCHRkCF24JX691/8FH5A0cYvF
	CgVn6m02jF4eAWDOrM9fRhHHEXHsoXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777283183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnn3QGutdCUtQ7bF9chs7GttO7XwIegPQ7pxsYCFruc=;
	b=YiOgAXwknzenqaJHYqghlBIHpC9sYRFRX/cElU7ER4gs9gqsHLo/Eqr9xE/806ojXXHFcx
	CahMRauKeLKOZzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BA78593B0;
	Mon, 27 Apr 2026 09:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2qhDEW8w72nNaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:46:23 +0000
Date: Mon, 27 Apr 2026 11:46:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
Message-ID: <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-8-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C3625BD75
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_024625_976853_F8D9C083 
X-CRM114-Status: GOOD (  12.78  )
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

On Fri, Apr 10, 2026 at 09:39:23AM +0200, Maurizio Lombardi wrote:
> @@ -375,12 +376,15 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>  	}
>  	ctrl->ctrl.queue_count = 1;
>  
> -	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
> -			&nvme_loop_admin_mq_ops,
> -			sizeof(struct nvme_loop_iod) +
> -			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
> -	if (error)
> -		goto out_free_sq;
> +	if (new) {
> +		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
> +				&ctrl->admin_tag_set,
> +				&nvme_loop_admin_mq_ops,
> +				sizeof(struct nvme_loop_iod) +
> +				NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
> +		if (error)
> +			goto out_free_sq;
> +	}
>  
>  	/* reset stopped state for the fresh admin queue */
>  	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
> @@ -415,7 +419,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>  	return error;
>  }

Personally, I am just not a big fan of conditional creation/removal of
resources controlled via a bool. If it's the cleanest solution fine with
me, but I wonder if here it wouldn't be cleaner to allocated the tagset
outside of nvme_loop_configure_admin_queue and obviously the same idea
for destroy.

Have you tried this approach, does it look too ugly?

