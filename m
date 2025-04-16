Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F4CC369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGjmVfBW0zb8bGWxLI2Vu5wBXRbMMi1/rJPkJ81COBc=; b=cVkmyBZ00CDDDz4yA1vxlSv94M
	+yLhq/NaCk3h/vk1AfoniNOKz5+FFDVyvyDFLxh9qX7nv4nq+2d1sikPiEtV/FHM16BQPTgRk4VT8
	Z0zWdJXsElFTmtxpWMG/vS1X/Ed03/TATfny1yqt/5ESQZSjQRe5b9WMXUnz/B+XMR7vl8OKofpla
	zr8dsKVVHo/Id5/L2Rz95CqVSPxQcKAnUIdiM3v5ywPUsvsY9jmRfSss3ZmTF+naWpa87Iy9YZPmc
	lL8Mkl64Gzb8/cv5shfXuAwyu5cU4Z+5J6PTjNE1KVC1mcPFQdLq+b6bxffGCs7wl8JF0ptVWd0AI
	zZOypxCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u502f-000000098SI-3H9h;
	Wed, 16 Apr 2025 10:30:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4y9u-00000008pUZ-2UCI
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 08:30:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 077D3211A8;
	Wed, 16 Apr 2025 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744792213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGjmVfBW0zb8bGWxLI2Vu5wBXRbMMi1/rJPkJ81COBc=;
	b=tZb3WpLcz9OuIoilaKbuFZ4nnU7VulXxZgNfsUSfx+6+QFyNnbr+2ctfPsqXbOZE1xskki
	GA8wFkkTTF3ck2H8GfUiYV4qZ30WyekOe4NoSd77fmbHlgI9hs9dJ5KwmjM0WRbUefZKWK
	ZSUKXOl4PksIqggmoOAaH+E4zeRTecA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744792213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGjmVfBW0zb8bGWxLI2Vu5wBXRbMMi1/rJPkJ81COBc=;
	b=5hQ+JvO5PdKZZk0ZvnZa3KD0n3So+V9UzscM3Kih+RlqWKCINrxaXFgoX+yBep87/cpQuy
	Ww50slUk9Oip2OCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WECsaO2Z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0AMR5eQr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744792212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGjmVfBW0zb8bGWxLI2Vu5wBXRbMMi1/rJPkJ81COBc=;
	b=WECsaO2ZWkmNgUtUgzqfMkHJXdIR5rEXoJigk7WZ69cxK5q5jdhYTolLWuWlCgBenwt77W
	ZB0uZnkwFxkLVThPnzrauqfIqhpvxvLI00logClve4Btt/lloMmrDvM9wIuSCX89IInMBx
	DrNIfDV45bMgb7bseYXOXJguMJRQ6Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744792212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGjmVfBW0zb8bGWxLI2Vu5wBXRbMMi1/rJPkJ81COBc=;
	b=0AMR5eQrvs9wRaEWFK21lCqjZdY67Sdfoe1zEDuPeM0OyeOTVZ2SaX7OvL4+Z4K3sutrBT
	zjn9hJL3kovvu/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF09139A1;
	Wed, 16 Apr 2025 08:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9MOOJNq/2cNYAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 16 Apr 2025 08:30:11 +0000
Date: Wed, 16 Apr 2025 10:30:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <3dad09ce-151d-41fc-8137-56a931c4c224@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <20250416004016.GC78596-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416004016.GC78596-mkhalfella@purestorage.com>
X-Rspamd-Queue-Id: 077D3211A8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_013014_773695_763E295D 
X-CRM114-Status: GOOD (  18.89  )
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

On Tue, Apr 15, 2025 at 05:40:16PM -0700, Mohamed Khalfella wrote:
> On 2025-04-15 14:17:48 +0200, Daniel Wagner wrote:
> > Pasthrough commands should fail immediately. Userland is in charge here,
> > not the kernel. At least this what should happen here.
> 
> I see your point. Unless I am missing something these requests should be
> held equally to bio requests from multipath layer. Let us say app
> submitted write a request that got canceled immediately, how does the app
> know when it is safe to retry the write request?

Good question, but nothing new as far I can tell. If the kernel doesn't
start to retry passthru IO commands, we have to figure out how to pass
additional information to the userland.

> Holding requests like write until it is safe to be retried is the whole
> point of this work, right?

My first goal was to address the IO commands submitted via the block
layer. I didn't had the IO passthru interface on my radar. I agree,
getting the IO passthru path correct is also good idea.

Anyway, I don't have a lot of experience with the IO passthru interface.
A quick test to fitgure out what the status quo is: 'nvme read'
results in an EINTR or 'Resource temporarily unavailable' (EAGAIN or
EWOULDBLOCK) when a tcp connection between host and target is blocked
(*), though it comes from an admin command. It looks like I have to dive
into this a bit more.

(*) I think this might be the same problem as the systemd folks have
reported.

