Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B6CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=; b=wkBuL1vLgmEkLnDRKsu4GKbWtr
	pWNeChOSCTHpEEvDGjn/Dg9ppZrLMpfFMyzoKyjjR6yksi5hKv6gy/R/lHbdqwHR/JLN5TcJrdVJM
	wXYDlzmaFf+6ye8RUx98VnYUzetuCBa87sFGTEL1GwtDSh2nbLHDWFsEqBLBYLv0OP/9rtKGAwJsl
	S/9J2uoOAhdI8K9XK4sfVxm0deWTU2Ffqk4cOTYYwxnPsdPwIikLw2bgEKmd956Shz8jcKwiodobg
	MHsxmC0Zk61eDaNS2Dkm3EJdSZo0hpgB+w1MuETEbI0X8jdRJ1diXzPkeyHAXAawRpkcrsUd3PDcI
	xSJG1ULA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGGCw-0000000BnES-3k5t;
	Tue, 04 Nov 2025 12:32:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGGCu-0000000BnDP-23CD
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 12:32:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CE22211C4;
	Tue,  4 Nov 2025 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762259533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=F+xV9AjO9XPdZA5jz8LCMXYMbKu7VBwEMEeOTiep5+gr5VDc8Xa+7WHIxANUWQnokeRt2v
	Vny0K4IjVgQf/PmJeSc/gORmKFKoyVUnODIa0dkl5o9mgDhXjVK3Cw+3t+xEdXYim1lTYi
	kcn6SLLUbVLB9buStWftglRh6Ob5X8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762259533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=PK9XYeO1rF9QoFyE9q6xtgX1Tm+agLFwoBKzziwBocJF+swkiDJkJU2vcg90tiKFzVSgrZ
	2VE4IXeq9SXuLEAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F+xV9AjO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PK9XYeO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762259533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=F+xV9AjO9XPdZA5jz8LCMXYMbKu7VBwEMEeOTiep5+gr5VDc8Xa+7WHIxANUWQnokeRt2v
	Vny0K4IjVgQf/PmJeSc/gORmKFKoyVUnODIa0dkl5o9mgDhXjVK3Cw+3t+xEdXYim1lTYi
	kcn6SLLUbVLB9buStWftglRh6Ob5X8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762259533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/c05mhQI2YpKSo54WAT+P1CruwJu+ENTqv7BMXPR4=;
	b=PK9XYeO1rF9QoFyE9q6xtgX1Tm+agLFwoBKzziwBocJF+swkiDJkJU2vcg90tiKFzVSgrZ
	2VE4IXeq9SXuLEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2D7213A31;
	Tue,  4 Nov 2025 12:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I79HOkzyCWnXVQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 04 Nov 2025 12:32:12 +0000
Date: Tue, 4 Nov 2025 13:32:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Justin Tee <justin.tee@broadcom.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
Message-ID: <bf2b3a79-4e6e-4572-aa96-c318cb496cda@flourine.local>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
 <20251028-nvmet-fcloop-fixes-v1-1-765427148613@kernel.org>
 <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accf6ad7-047b-48d0-b626-f3ef0facd649@suse.de>
X-Rspamd-Queue-Id: 0CE22211C4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,flourine.local:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_043216_683261_D82CB901 
X-CRM114-Status: GOOD (  17.22  )
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

On Tue, Nov 04, 2025 at 11:51:09AM +0100, Hannes Reinecke wrote:
> On 10/28/25 16:26, Daniel Wagner wrote:
> > nvme_fc_ctrl_put can acquire the rport lock when freeing the
> > ctrl object:
> > 
> > nvme_fc_ctrl_put
> >    nvme_fc_ctrl_free
> >      spin_lock_irqsave(rport->lock)
> > 
> > Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.
> > 
> > Signed-off-by: Daniel Wagner <wagi@kernel.org>
> > ---
> >   drivers/nvme/host/fc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index 03987f497a5b..2c0ea843ae57 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
> >   		if (ret)
> >   			/* leave the ctrl get reference */
> >   			break;
> > +		spin_unlock_irqrestore(&rport->lock, flags);
> >   		nvme_fc_ctrl_put(ctrl);
> > +		spin_lock_irqsave(&rport->lock, flags);
> >   	}
> >   	spin_unlock_irqrestore(&rport->lock, flags);
> > 
> In theory, yes.

I hit this in practice ;)

