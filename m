Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7F6FF885E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLzx62aW805eauwVVnmFqUDVZFEezR2pdZJFPlN6XNw=; b=RuS6DHnw97Wi895wXz0Blxt4x3
	Mxq5XS3hzqi1GdvQkToaRZYFBWMUIyglV7pgedKM5fTIkds4Lxry28YTdibekDEYbHniBxPLVS7hq
	ySHC2wuRasffjhDI0TeX2B8FPspmUgApLIIwXmDQJY2KqxCd7EvlSqpvqruhFcVvPxmZwkOtjtx9H
	lVJwI8akJqMdR/3ptnJcTI4jvcyvyjC/AWz+dXLeYxuo8vXRRkKr9Jq77PJ8eEdYz9nzPuvTvUzs6
	15fRKkjdVEZGoRFXCAU6twHXq64eVjPe04Ll6GYTGRaG6NDXaRiLLCoVfV50aAK4eTpa6puZryWeG
	+hmzMjcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIBE-0000000Ga9b-1i83;
	Mon, 27 Apr 2026 09:23:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHIBB-0000000Ga9H-20qB
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:23:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E82B6A8F7;
	Mon, 27 Apr 2026 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLzx62aW805eauwVVnmFqUDVZFEezR2pdZJFPlN6XNw=;
	b=HQUxmkt/3VohZ/XS7lhBqBjgltwRmRtmEHx8RQ/5vS8R9bm+sFZPTkFXrzUFQKWQHg6jHA
	ijO77UXeQfWMV8agQAG7gPEm0WH7q8OgQfQWTgQ669Q1Y+ZXfucjIUAYACnTsIq9WBr8CY
	7Epxz2JTww5MzNcjn4i3la3tPMDUpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLzx62aW805eauwVVnmFqUDVZFEezR2pdZJFPlN6XNw=;
	b=UQiptPJ+trKi3PoIq81Cy6tQ66t2s24gfOjC1+9WLS6qVAgfRxrUzoYWe4yy/qWOF30Ma9
	LTKt4KrxJCQB7eCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777281779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLzx62aW805eauwVVnmFqUDVZFEezR2pdZJFPlN6XNw=;
	b=HQUxmkt/3VohZ/XS7lhBqBjgltwRmRtmEHx8RQ/5vS8R9bm+sFZPTkFXrzUFQKWQHg6jHA
	ijO77UXeQfWMV8agQAG7gPEm0WH7q8OgQfQWTgQ669Q1Y+ZXfucjIUAYACnTsIq9WBr8CY
	7Epxz2JTww5MzNcjn4i3la3tPMDUpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777281779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLzx62aW805eauwVVnmFqUDVZFEezR2pdZJFPlN6XNw=;
	b=UQiptPJ+trKi3PoIq81Cy6tQ66t2s24gfOjC1+9WLS6qVAgfRxrUzoYWe4yy/qWOF30Ma9
	LTKt4KrxJCQB7eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E4BB593B0;
	Mon, 27 Apr 2026 09:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CO5HIfMq72lnUQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 Apr 2026 09:22:59 +0000
Date: Mon, 27 Apr 2026 11:22:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com, 
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org, mlombard@arkamax.eu, 
	mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 5/8] nvme: use per controller timeout waits over
 depending on global default
Message-ID: <4be04295-1b86-4dc3-abee-7d59c6c67ae9@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-6-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-6-mlombard@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_022301_688706_09D5D631 
X-CRM114-Status: UNSURE (   8.32  )
X-CRM114-Notice: Please train this message.
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

On Fri, Apr 10, 2026 at 09:39:21AM +0200, Maurizio Lombardi wrote:
> @@ -5253,7 +5254,7 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
>  	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
>  				 srcu_read_lock_held(&ctrl->srcu)) {
>  		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
> -		if (timeout <= 0)
> +		if (!timeout)
>  			break;

I'd suggest to drop this change, as it doesn't really belong to the
change itself.

Rest looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

