Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570F6C3ABA3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVNPA+ism6eO1twaGGC0wYoAtWpjoYs69ia1kwgGGLU=; b=Jn6yocq4+1ZHHtJ+cxnYgb86TI
	6x1ZMGJnui1NPm1zyqShlwB78q13SGZaHNvFSaFiHsHoN2RTMK5CJ0eVlSt1rtd7jAhWHxk35F457
	Cjprgm1V1CNSliYSKV1VBdyMS8pLsnbbpxmf6fyIpK6u4o7nMeQ7UGYBDTJ4t8u8nuzJ0nO939Wcv
	3Sc8ZKb8MowakANAFDrebE6sxTElrMuhwsoaGWBtNowy5MAgZm278kns0maMelUFX/Isd8/sg7oj0
	OMBGFiMjFGPjhi/VGISCHx6UWUhAU7UouVk7jbjhFhx/dfphrSM0Qh10krzARgXWhXnq/Nx7TYlsz
	o/U/b43g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmWf-00000001JuM-3OtX;
	Fri, 02 May 2025 09:17:45 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAmI2-00000001H7g-2JeV
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 09:02:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94C371F385;
	Fri,  2 May 2025 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746176554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVNPA+ism6eO1twaGGC0wYoAtWpjoYs69ia1kwgGGLU=;
	b=yUW146MMasrlm83N6NIEsYDBbj6tYZvwOEPpHtdHgpBVDLJzjeAnNVJSlQMEVHm+hrfpsL
	k1mqS0d1H1wQU+m35od09mwRBINdpeKko/r8/cAgM9R7+dtEWDvkrW62vH35mjFDXhxch4
	9VGicv9OEnd06Hyf24WeYrBZk6WaaZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746176554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVNPA+ism6eO1twaGGC0wYoAtWpjoYs69ia1kwgGGLU=;
	b=MoqCbKWCkBeY+vfceBKxkOu95DYph9gdpAVcS0NJKkFS4Dj+Wt1uutP0493n6e3W5ScbLh
	eKPi9nrtVD20EpDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yUW146MM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MoqCbKWC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746176554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVNPA+ism6eO1twaGGC0wYoAtWpjoYs69ia1kwgGGLU=;
	b=yUW146MMasrlm83N6NIEsYDBbj6tYZvwOEPpHtdHgpBVDLJzjeAnNVJSlQMEVHm+hrfpsL
	k1mqS0d1H1wQU+m35od09mwRBINdpeKko/r8/cAgM9R7+dtEWDvkrW62vH35mjFDXhxch4
	9VGicv9OEnd06Hyf24WeYrBZk6WaaZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746176554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVNPA+ism6eO1twaGGC0wYoAtWpjoYs69ia1kwgGGLU=;
	b=MoqCbKWCkBeY+vfceBKxkOu95DYph9gdpAVcS0NJKkFS4Dj+Wt1uutP0493n6e3W5ScbLh
	eKPi9nrtVD20EpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B5613687;
	Fri,  2 May 2025 09:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fi4iGSqKFGhAUgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 02 May 2025 09:02:34 +0000
Date: Fri, 2 May 2025 11:02:29 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
Message-ID: <efc926be-25fd-4ba9-97c9-eebfe43107b5@flourine.local>
References: <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de>
 <aBEW4W40ZelIXfs2@kbusch-mbp>
 <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
 <aBEdkUky_-bfgISv@kbusch-mbp>
 <8121b8d6-2b30-4086-b2fb-bce354f203dc@flourine.local>
 <aBJJQoOBhaXj7P36@kbusch-mbp>
 <d8fa9332-9475-433e-a203-e376845dcc66@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8fa9332-9475-433e-a203-e376845dcc66@roeck-us.net>
X-Rspamd-Queue-Id: 94C371F385
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,roeck-us.net:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_020238_736166_F25A191D 
X-CRM114-Status: GOOD (  12.75  )
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

On Wed, Apr 30, 2025 at 09:12:30AM -0700, Guenter Roeck wrote:
> On 4/30/25 09:01, Keith Busch wrote:
> > If you send the simple fix as a formal patch, please add my review and
> > the "Fixes:" tag.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Please feel free to add mine as well:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Sorry for the delay, yesterday was a public holiday and way to nice
weather to do any work.

Just sent out the fix. Thanks for the review tags.

