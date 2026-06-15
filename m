Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9A9CD98C5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2026 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fY2EUZdDII3FaNno//LiZ4ewVTPk2PNYMOEnebwO9yI=; b=fYly5qXmz2iizXVJZ2T53TTnmB
	DKGo8OdF7o3kR35e4FncF84hmcQeHotC3yY6uITBeltwA2psTHeXJTqDBh2rTaEQ07JVtJ30dNeeW
	lU7aa+GEroRT+VCjrasf02na1LMh+oGCH6LMGR6VIOZUCrg/S0v4r/xts1DdJat/fbf3WQLbnJ32E
	VpLdFKHYWP6KEK3S7pxV0vQzWHP0jsL31bsWG2MBQ33u1cbRnmKvjkntwiseP5rXWLIRZwq8bKe1Y
	pS55rztRAkGblzHmPz412F+2X8wXDQ5GdJpmKU8R2JQGIfwGUOBI2T5btMvJQvecVZNdUZQaxqCoE
	ujChV/pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2BJ-0000000DpCF-2k0n;
	Mon, 15 Jun 2026 07:56:29 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ2BH-0000000DpBh-1sjE
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jun 2026 07:56:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1564775936;
	Mon, 15 Jun 2026 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781510183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY2EUZdDII3FaNno//LiZ4ewVTPk2PNYMOEnebwO9yI=;
	b=M6uhFFrCElDyCGDJSzzxiU09+xgjbuhMv6oD17hJt3WzTv0qGeqd1840EIusJZaDzKkcYw
	u268iOZmlwmWCNUbgMQBGaMba7a6KuxMB94++aK7WZxcYj99nTWGcfFi/RZNGDji8Fdo3P
	3XbElxw93+0CzXZAxTF5bef3O0WXxKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781510183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY2EUZdDII3FaNno//LiZ4ewVTPk2PNYMOEnebwO9yI=;
	b=ZylWdRbsPlGqmk6bYY1Uchle648MeNYMrl3xdvM9PG6iEkAmOdlWHYKsX53buhKVtZbY+C
	VQNpnibNl5fqHCAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M6uhFFrC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZylWdRbs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781510183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY2EUZdDII3FaNno//LiZ4ewVTPk2PNYMOEnebwO9yI=;
	b=M6uhFFrCElDyCGDJSzzxiU09+xgjbuhMv6oD17hJt3WzTv0qGeqd1840EIusJZaDzKkcYw
	u268iOZmlwmWCNUbgMQBGaMba7a6KuxMB94++aK7WZxcYj99nTWGcfFi/RZNGDji8Fdo3P
	3XbElxw93+0CzXZAxTF5bef3O0WXxKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781510183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY2EUZdDII3FaNno//LiZ4ewVTPk2PNYMOEnebwO9yI=;
	b=ZylWdRbsPlGqmk6bYY1Uchle648MeNYMrl3xdvM9PG6iEkAmOdlWHYKsX53buhKVtZbY+C
	VQNpnibNl5fqHCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02F62779A7;
	Mon, 15 Jun 2026 07:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIatOiawL2oUYAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Jun 2026 07:56:22 +0000
Date: Mon, 15 Jun 2026 09:56:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org, 
	mlombard@arkamax.eu
Subject: Re: [PATCH] nvme: fix crash and memory leak during invalid cdev
 teardown
Message-ID: <5a393a6c-371a-4c8f-8a90-6736907dccf4@flourine.local>
References: <20260605151048.354313-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605151048.354313-1-mlombard@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1564775936
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_005627_646732_926F95C1 
X-CRM114-Status: GOOD (  11.96  )
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

>  static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>  {
>  	int ret;
> +	char *name;
>  
>  	head->cdev_device.parent = &head->subsys->dev;
> -	ret = dev_set_name(&head->cdev_device, "ng%dn%d",
> -			   head->subsys->instance, head->instance);
> -	if (ret)
> -		return ret;
> -	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
> +	name = kasprintf(GFP_KERNEL, "ng%dn%d", head->subsys->instance,
> +			 head->instance);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ret = nvme_cdev_add(name, &head->cdev, &head->cdev_device,
>  			    &nvme_ns_head_chr_fops, THIS_MODULE);
> +	if (ret)
> +		dev_err(disk_to_dev(head->disk),
> +			"Unable to create the %s device", name);
> +	else
> +		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
> +
> +	kfree(name);
>  	return ret;
>  }

nvme_add_ns_head_cdev returns the error code but nvme_mpath_set_live
handle the return code. So we either don't need to return the error code
or we should do something in nvme_mpath_set_live with it.

