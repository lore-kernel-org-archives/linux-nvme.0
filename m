Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B3E7BD83
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=; b=hwm6EFfuB7m7LsYUfADcI16CUP
	TSXucpKIWuaOJTDQv6Y//chdhoIoS+az5tysCzLIDmxGINrYlERyQU2mBdYhPKemEOqcWuTLDS+Sj
	pN10bP7tppDoa1UX+v4S9gdB7hp7M8xu6ZqIAu4dBVwhlUkt6a//oGYaIZ4EqoZ4rt3akawkPkSgS
	0cJIz8lVQN6u/tUa2GI8H0mQ+x6SCtc8BcBOpPvfQTgcqAoMifj3JqE+w2b39BDeKSMc22j4RxFeG
	BovcWkCFK/+VZ22uhDmcfzMEYcuUFq2JVCxMa9bkvp0Rro8GTFMaf74ps9l/hkKS9HhARZMTp5aWQ
	tbGfoL4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvoq-00000006LVo-1K2u;
	Mon, 16 Feb 2026 10:27:08 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvon-00000006LPp-1Cnv
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 10:27:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 709F33E6EF;
	Mon, 16 Feb 2026 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771237611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=mDwJoE6lYGSqy7KgYWfcFgECanCDZk3awgJswbfWfXzGi59AklgDKjf9QW7RgloTdY1gP0
	jg/HuBnUpslZvoOSNWDe0fvUtP5PSEPPs1dl9qW4OibFT8DyTuAWsR3vbywH1v7zxcCmiT
	FU51Fbigzoq1wo/fqnFsTSuN+6PTjyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771237611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=5zJWdHoemC5WLO6iPVN83AklrTl41tBz+T3lk+62U+eCBTPwh373uShG+sfkVdNUVJzfil
	Ku810sqGtu8uucCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mDwJoE6l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5zJWdHoe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771237611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=mDwJoE6lYGSqy7KgYWfcFgECanCDZk3awgJswbfWfXzGi59AklgDKjf9QW7RgloTdY1gP0
	jg/HuBnUpslZvoOSNWDe0fvUtP5PSEPPs1dl9qW4OibFT8DyTuAWsR3vbywH1v7zxcCmiT
	FU51Fbigzoq1wo/fqnFsTSuN+6PTjyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771237611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jiR2ZjzsH+TbpZ8dWUKhjhEhCBp20SYV/pfGiHv004o=;
	b=5zJWdHoemC5WLO6iPVN83AklrTl41tBz+T3lk+62U+eCBTPwh373uShG+sfkVdNUVJzfil
	Ku810sqGtu8uucCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54E743EA64;
	Mon, 16 Feb 2026 10:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jqu0FOvwkmkONgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 16 Feb 2026 10:26:51 +0000
Date: Mon, 16 Feb 2026 11:26:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.19 kernel
Message-ID: <1a4f4064-8352-49c3-a7f5-3883c2c13025@flourine.local>
References: <aY7ZBfMjVIhe_wh3@shinmob>
 <6ad314f7-f3d2-495a-b1ef-a81a06498952@flourine.local>
 <f26001d6-062e-402b-8acd-46a737523e23@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26001d6-062e-402b-8acd-46a737523e23@nvidia.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 709F33E6EF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_022705_476919_57E51050 
X-CRM114-Status: GOOD (  13.71  )
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

Hi Chaitanya,

On Sat, Feb 14, 2026 at 09:19:47PM +0000, Chaitanya Kulkarni wrote:
> On 2/13/26 01:56, Daniel Wagner wrote:
> > nvmet_fc_target_assoc_free runs in the nvmet_wq context and calls
> >
> >    nvmet_fc_delete_target_queue
> >      nvmet_cq_put
> >        nvmet_cq_destroy
> >          nvmet_ctrl_put
> >           nvmet_ctrl_free
> >             flush_work(&ctrl->async_event_work);
> >             cancel_work_sync(&ctrl->fatal_err_work);
> >   
> > The async_event_work could be running on nvmet_wq. So this deadlock is
> > real. No idea how to fix it yet.
> >
> 
> Can following patch be the potential fix for above issue as well ?
> totally untested ...

Yes this should work. I was not so happy adding a workqueue for this but
after looking at nvme, this seems acceptable approach. Though, I'd make
nvmet follow the nvme and instead adding an AEN workqueue, rather have a
nvmet-reset-wq or nvmet_delete-wq.

Thanks,
Daniel

