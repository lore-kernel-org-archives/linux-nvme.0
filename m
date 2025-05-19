Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29026C3ABD8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FclusNN8jdMhdmhiqA4sn6OEhh99OIUVBTqe2l7FPTY=; b=j+iL84srgGfWLi/4vlPP1GcIHy
	R1FnzRseEDrmGot41L/B9DYvQOUCkp7UdzxXuvqFz3nIZBsuX/YL/OZOBua9GPnriOLSU+fweAbDC
	AXqT2tuSdkgfNB2Lr9N7jM5WECo4dfoXJoBamwwia2IrXNgJiNWxRuyeGzcEYVQc3apKs/ZIwTHvO
	zHqwjajhOvnGVZyYatl5Aj26u+MLPFYI3vrHx/wBJHnAwGNCdSNZ8ByTjao2yS3JnzTWm4e14brBF
	0uTh8hebyq/BS2ZM/SHVhiZ9HBAN1nrq5k7/yUUWnOnb5NyyEUiBkDWC6lfG/Lfr3mkQ5cJmpNLOX
	KMZekvDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxR8-00000008k2q-2yTM;
	Mon, 19 May 2025 10:09:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxMV-00000008j9F-35os
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 10:04:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9FA7202A3;
	Mon, 19 May 2025 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747649086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FclusNN8jdMhdmhiqA4sn6OEhh99OIUVBTqe2l7FPTY=;
	b=N+i7ZFr0sdJGNE1n58koWWi/ggdfSljPUeGsGxmzecLLZwLDLQzoIFxDzQtXC3liOxV8g9
	DKiWCowvhHM+8W7WJE1X0afZ6jD1QKuNmTIlqrsODApjwWJiYJD6seZ/V9rSXq9mqzVoyZ
	ThAyJtPXSs3Um93to4QUfWwjqVn7gdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747649086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FclusNN8jdMhdmhiqA4sn6OEhh99OIUVBTqe2l7FPTY=;
	b=EZ2s+eczyw7ohldTHj1H8v8FFPahCNQYKUkJ3PI9CLguSvfSBlIEW5F6uisiIzXn7D7aVv
	Cqn74PNRlrlbJdCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BqXJX0pl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JCtiO0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747649085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FclusNN8jdMhdmhiqA4sn6OEhh99OIUVBTqe2l7FPTY=;
	b=BqXJX0plkR9UUgGWgY5GQG0X0MrP4KQi653z++RZ0mDk4oM/r/zZ7O/ghJbuY9LKPP7uOg
	i2A9/FxGAa+ylTdaKmBKXfY8fkfEFcViBxXeynmeysvobfN3uBJU2wB8aJaWWX2SUS+PZM
	IYNuvirXQHn+N5XrGlNbEvT7H1avXqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747649085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FclusNN8jdMhdmhiqA4sn6OEhh99OIUVBTqe2l7FPTY=;
	b=JCtiO0D8Ithm2qo4L38/qF2YjZa+4nAIgDNIzxuQOROKVF/Q3cL1i6abodxsiPL/MHPW//
	SvHllumh65EgfkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972D413A30;
	Mon, 19 May 2025 10:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0mqbJD0CK2h2cgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 19 May 2025 10:04:45 +0000
Date: Mon, 19 May 2025 12:04:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-nvme@lists.infradead.org
Subject: Re: nvme-cli & json vs blktests
Message-ID: <c8ea015a-8b60-4ffc-a706-f7eb5b65042c@flourine.local>
References: <20250519054905.GA6156@lst.de>
 <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
 <20250519095642.GA21183@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519095642.GA21183@lst.de>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B9FA7202A3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,flourine.local:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_030447_921156_E76B0308 
X-CRM114-Status: GOOD (  18.00  )
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

On Mon, May 19, 2025 at 11:56:42AM +0200, Christoph Hellwig wrote:
> On Mon, May 19, 2025 at 11:51:47AM +0200, Daniel Wagner wrote:
> > On Mon, May 19, 2025 at 07:49:05AM +0200, Christoph Hellwig wrote:
> > > make the nvme-cli build a little less arcane?
> > 
> > There is no magic build into the meson/ninja build system. meson creates
> > the ninja build instruction which are fully hardcoded, thus it wont pick
> > up any newly installed libraries on automatically. Running meson with
> > 'setup --reconfigure' is a design choice of this build system.
> > 
> > I don't really see a problem with this approach.
> 
> The fact that a make clean is not clean enough to find newly installed
> dependencies is very unusual.

Okay, so the Makefile is not really working in your workflow as expected. I see
there are two targets 'clean' and 'purge'. I suppose it would make sense
to model the 'clean' target more what autotools  & co are doing. Really
wiping everything away. Let me fix this.

