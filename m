Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2440C5321D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpPA2xePRIQqaUBXQsMd6MiuiLe+ZBV13Z0jPB7LrAY=; b=jV5RDSgFExo54rKLDNnd8SL55x
	5kI1iMYSZxMq73rXij6DfTVIjZgzMtJrVZYkBquZFtWMjR09ZtnoXWIFXktR9D1zqeBF/EozyNyAz
	hpvY1kIwkoPMT79ld49qyDJbyvUr7OGJbQwCtx035R1pbHAjZdugfn31brEZWe9ztIRnSditcYvSY
	aRCyPM20YenVf2769SKoK3YYkYjYoFZp/uW2FfQopUm6tmtq99C1qlZNJUpAZDeLpVR9fsYkD4sjY
	UA8lttVsGx57RMUlkFV77v8kLI7hKMu5lblwyr52qv6BppUpU2IKf1eZ55mpeKRM9z+SioiauJQxE
	5B5kCf3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO3X-0000000FVkt-2Y9K;
	Fri, 23 Aug 2024 06:45:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shO2y-0000000FVYg-0vid
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:45:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88C66202D4;
	Fri, 23 Aug 2024 06:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpPA2xePRIQqaUBXQsMd6MiuiLe+ZBV13Z0jPB7LrAY=;
	b=toCawps5T7X1J3ShBAi2gpA3ksJuU9YwNUfx8Te+TaRFZIc/BN643FljTbQrfEX+a2kh1L
	k4ZD3I+AHBlNWcZHdGMdF7kQ7A1MBTu8K50rcKEHLZaiynVzhU17QU5yxDfxpx1bJy9+ML
	f7fwCl2QeaKL5fVZoYqCDPvjUtVEMJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpPA2xePRIQqaUBXQsMd6MiuiLe+ZBV13Z0jPB7LrAY=;
	b=Q6HwEErBNG7CDEFcfvSKYFDrgwsOpucKAS2QLKUewB6fabMtMfKeQskr9042dbQz6jJLL9
	ZPirK3avRt3VNmCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=toCawps5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q6HwEErB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724395518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpPA2xePRIQqaUBXQsMd6MiuiLe+ZBV13Z0jPB7LrAY=;
	b=toCawps5T7X1J3ShBAi2gpA3ksJuU9YwNUfx8Te+TaRFZIc/BN643FljTbQrfEX+a2kh1L
	k4ZD3I+AHBlNWcZHdGMdF7kQ7A1MBTu8K50rcKEHLZaiynVzhU17QU5yxDfxpx1bJy9+ML
	f7fwCl2QeaKL5fVZoYqCDPvjUtVEMJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724395518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QpPA2xePRIQqaUBXQsMd6MiuiLe+ZBV13Z0jPB7LrAY=;
	b=Q6HwEErBNG7CDEFcfvSKYFDrgwsOpucKAS2QLKUewB6fabMtMfKeQskr9042dbQz6jJLL9
	ZPirK3avRt3VNmCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC441333E;
	Fri, 23 Aug 2024 06:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qT2lGP4vyGY5awAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 06:45:18 +0000
Date: Fri, 23 Aug 2024 08:45:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 3/3] nvme: add test for controller rescan under I/O load
Message-ID: <9e199fd0-5767-4a63-930a-b08e89e4e354@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <20240822193814.106111-3-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822193814.106111-3-mwilck@suse.com>
X-Rspamd-Queue-Id: 88C66202D4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_234520_443322_492914C4 
X-CRM114-Status: UNSURE (   9.79  )
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

On Thu, Aug 22, 2024 at 09:38:14PM GMT, Martin Wilck wrote:
> Add a test that repeatedly rescans nvme controllers while doing IO
> on an nvme namespace connected to these controllers. The purpose
> of the test is to make sure that no I/O errors or data corruption
> occurs because of the rescan operations.

Could you elaborate why this tests is added? Does it test for a
regression, are there any patches for this? Or is it more let's ensure
this actually works?

The code looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

