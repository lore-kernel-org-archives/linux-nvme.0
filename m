Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6724DCDB47C
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Toa/su82adeuG0+DiD00KOzyOpuAML2e/37IP6S54U=; b=e16yLB70VcXYprn98lgpRgKcW6
	VC8pKTl07oz12fFGcFM2uczM2U7CNgF+hD3lEtBXZzUDC6t3JoxcTL5q3rToIC376vKg+aWi5diwZ
	v1/fTH4H7BXigwj0rO6NX1OKXzQihd2vvAyc8xaSijbZCCTRMSGowEXjWjvlRU/Zxx81SddqfN4C8
	+eh0uCjAeCr8aG+ohwLQVEDfJMreNuOMulKkLvBMl1NeHIYjeE6QjQoARVeLGum/L0TMl0ZlN2hXM
	rWR3zacvFKPIV+wbf9ENQWJvBfE+Z330mG4Iq+oty2k3KQNygXuDnEfPJI/m0eSQ78/HG7jhm4pY9
	ZefTRE3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcKKA-00000007Y3k-2d5w;
	Wed, 24 Jun 2026 09:55:14 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcKK6-00000007Y2a-1FGG
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 09:55:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3CED76190;
	Wed, 24 Jun 2026 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782294906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Toa/su82adeuG0+DiD00KOzyOpuAML2e/37IP6S54U=;
	b=wSSySn7LY+l7E9MclRpjdWO1lIpdy6/bXsiOMzAs4pHRaT9sMWRp7Gr5MnZodX0P21Ic+R
	EZ/ei9mkRkazCDQuLIUACSWznPx6HaLhtfD3OSNaCl9Ia9g6SJMtlnR1F3hTX4EDaigiTL
	st6fscch0HYD6bxAQgQTdgAgtuyHpZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782294906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Toa/su82adeuG0+DiD00KOzyOpuAML2e/37IP6S54U=;
	b=LMkdm/BxPx2r1ykbVWOR398bRlwO/VubGbK1uIpm68jBJkh13A19XiVkYhGq2qdHyLEmPh
	0TCz0IOrBv3GV5AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ITXn6DDs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WOr2CLGx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782294902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Toa/su82adeuG0+DiD00KOzyOpuAML2e/37IP6S54U=;
	b=ITXn6DDsUmOj4GgxwvDQA3ZVxpv/b12/lh2a18/9XcV8LHTYLOuOh1TP6LkFHiIH76B8n4
	54RRctWeMEei/PXw6gg3Isz2GxEyqC91d9Wv3EB6LGijR8xHOCH5SQP2mfVHgklOEp3nBh
	RvfNinW1od3OriC5jnDYRkzEUOiZI+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782294902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Toa/su82adeuG0+DiD00KOzyOpuAML2e/37IP6S54U=;
	b=WOr2CLGxPMt07+am3Q84S3YuczSzfo3BHOza0cCwe3qqkI+PIb0ocUeofZpCXveX1X6ts+
	2qpaXe5O5siYmEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA09F779A8;
	Wed, 24 Jun 2026 09:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uRYGKHapO2rQJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 24 Jun 2026 09:55:02 +0000
Date: Wed, 24 Jun 2026 11:55:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
Message-ID: <c9b1d8fd-7012-44a0-a975-947fc0e16fac@flourine.local>
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
 <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C3CED76190
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_025510_487612_C9437362 
X-CRM114-Status: GOOD (  16.56  )
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

On Wed, Jun 24, 2026 at 08:36:44AM +0100, John Garry wrote:
> On 24/06/2026 06:48, Guixin Liu wrote:
> > Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> > device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
> > current path state, including whether the path is enabled or disabled
> > with a specific reason.
> > 
> > Factor the path disable checks from nvme_path_is_disabled() into a new
> > nvme_path_get_state() helper that returns an enum nvme_path_state. This
> > keeps the path selection logic and sysfs reporting in sync, so any future
> > updates to the path disable criteria are automatically reflected in the
> > sysfs output.
> > 
> > Possible values:
> >    - "enabled (optimized)"     : ANA state is optimized
> >    - "enabled (non-optimized)" : ANA state is not optimized
> >    - "disabled (ctrl_down)"    : controller is not live
> >    - "disabled (ana_pending)"  : ANA state change pending
> >    - "disabled (ns_not_ready)" : namespace is not ready

I'd prefer to have a single string here instead of something we might need
to parse again. The sysfs docs says

  Mixing types, expressing multiple lines of data, and doing fancy
  formatting of data is heavily frowned upon. Doing these things may get
  you publicly humiliated and your code rewritten without notice.

Something like

  - optimized
  - non-optimized
  - ctrl-down
  - ana-pending
  - ns-no-ready

BTW, the docs on sysfs say, these interfaces should be documented also
in Documentation/ABI. So far we haven't done this for the nvme
subsystem. Should we start with it? 

