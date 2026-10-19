Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708E606A31B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rx0oGUuH;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Hoq+mg0d;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rklic4C9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=a36yur6t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7H7DkTxC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKRI6mI2KZqXfxzglLghelJkGfZGDlX82MbaRfnXzr8=; b=rx0oGUuHSV6pOsIwKP3pZUL76W
	05M+9NN1pXzjNPDCG0yQSujb83hzHiNbFYVzxqjoE/v0/Cq5bD8b+Z9plCZwI9oHJ9PNrfMZkFFNO
	HHltqn2j42rbKVmT0vCxWLVkYqVV6WRIMWrXWF95s7Bb+U3+bpU5K01/myDbT/br4Y0P12DkufUNk
	DzmDpQ9fYAyeNGGClVHoV7RD4LHwEqKignv07km/WHvh2D1VFk5HnBOSkcg5VS8Gyz7OvB9GtO2+O
	gkVF8H/SsUZnwen9jWHR5z3W1yvSz/p1DNfiLGIsH5OxFcD759VOpqQ768EvLiKpRiB2+qryrU4bT
	78BJ27KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIr0R-000000084T0-3p5y;
	Mon, 19 Oct 2026 17:18:39 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIr0O-000000084SW-1qcv
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 17:18:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC9A1F44E;
	Mon, 19 Oct 2026 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792430314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKRI6mI2KZqXfxzglLghelJkGfZGDlX82MbaRfnXzr8=;
	b=Hoq+mg0d0ivPLnfyFGidZBndkxM1Uuw9R8USuZa9GmjI2O7MZxBlwyD9kQdSJprT72veLs
	qh+Y4DO3KyyRsGDoqG0zxtcdPTZia1a+6MBVOL/mjmlnBfCDlPVP4yW6Ib5wWuIy67CgyU
	q7yrbFu5qa8lpAlerMfKor80Ki3e2SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792430314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKRI6mI2KZqXfxzglLghelJkGfZGDlX82MbaRfnXzr8=;
	b=rklic4C9qfFt43HqNcaK1I0/ydEXPJxAbyS6dbFizQlfCbWKtRtGwsdZ+Hg0xeTR/LC8PA
	KSW+uic1mUelOJBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792430313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKRI6mI2KZqXfxzglLghelJkGfZGDlX82MbaRfnXzr8=;
	b=a36yur6tG2SmLT5S34heCEU8Fk+v8FImOovzwYzEhuWpJO2XvsBrcCZiEt5UZVY69+177y
	rWQqvp5M/k4++f0CUhhgGWCDOoqoasXQU8N4VwEMMQdgkbn8WbapD/0+cKitFX1KBadbB1
	5NuXU8l9KSOl6HXyUY7xtGnaeA8yaPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792430313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKRI6mI2KZqXfxzglLghelJkGfZGDlX82MbaRfnXzr8=;
	b=7H7DkTxCmXZ+/Q2ldBi2mcqmzuJsemtvoO5ufNpe0C4F8GW4/sxiHu1RGArpvBLr1Ui5jo
	7h4vyMnaFTPGiVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44FF0134B3;
	Mon, 19 Oct 2026 17:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FZHrB+lQ1mqYHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 Oct 2026 17:18:33 +0000
Date: Mon, 19 Oct 2026 19:18:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 07/18] nvme: Introduce FENCING and FENCED controller
 states
Message-ID: <ebc2064d-70d8-44c9-8230-5ba4b24cf5d9@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-8-mkhalfella@purestorage.com>
 <179242929827.3619480.8550407233438315193.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179242929827.3619480.8550407233438315193.b4-review@b4>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_101836_785164_DBA501E3 
X-CRM114-Status: GOOD (  13.22  )
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 07:01:38PM +0200, Daniel Wagner wrote:
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -542,6 +542,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
> >  	static const char *const state_name[] = {
> >  		[NVME_CTRL_NEW]		= "new",
> >  		[NVME_CTRL_LIVE]	= "live",
> > +		[NVME_CTRL_FENCING]	= "fencing",
> > +		[NVME_CTRL_FENCED]	= "fenced",
> >  		[NVME_CTRL_RESETTING]	= "resetting",
> >  		[NVME_CTRL_CONNECTING]	= "connecting",
> >  		[NVME_CTRL_DELETING]	= "deleting",
> 
> The ABI documentation needs to be updated.

And while you’re at it, what’s the impact on blktests? I can’t quite
recall what you presented during ALPSS regarding blktests. Is this
covered?

Keith, Christoph, and I are mostly concerned about this patch.
Experience tells us that anyone touching the state machine will
introduce regressions. Because of that, I’d really like to make sure the
upstream testing side is covered. I know you’ve run tests in your lab,
but we need test cases that everyone can execute in their own
environments, and blktests is the right vehicle for that.


